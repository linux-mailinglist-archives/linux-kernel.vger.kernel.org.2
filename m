Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE693FD204
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhIAD4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232298AbhIAD4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A196861053;
        Wed,  1 Sep 2021 03:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630468557;
        bh=ldCoNwtBW/dHHryh+nhHaLiJK37ZQb2dSSbrKEOhVSM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G0R73+XD5LtDBlZqzy8YvkyOQRSBh2Z81rB8j7PoMJy988HnHt+/0tpnCwPLq0JoF
         Da7gyChlsEzURNfDht6bf1vzsOCjkAzDIc5l0E4g/5TlJ7BP84/18eTlntSLzYhDTm
         sqLzTWEq6wIIddEWdqq/r/9c7/ls++fGfGD2Ka9XBfffr8MxdYuXZVl27lDXB/mU5b
         X42rqxbcAXm0UiAW7tyZdl3xoLmPzTy7k8cXHVLzZTTkOUc63FWDxi/AJi8cKl//PC
         MhUJk2HPUdL+B96AovXDnjm8QZ1WrPTzokzEFjk/JYAvpRKc/Bf/5aT/dBRB83k1Ls
         fRANOXU6UpOww==
Message-ID: <4cf878fabb54719986c8255b9757d7990926f0be.camel@kernel.org>
Subject: Re: [PATCH v4 1/6] x86/sgx: Provide indication of life-cycle of EPC
 pages
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Sep 2021 06:55:54 +0300
In-Reply-To: <20210827195543.1667168-2-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> SGX EPC pages go through the following life cycle:
>=20
>         DIRTY ---> FREE ---> IN-USE --\
>                     ^                 |
>                     \-----------------/
>=20
> Recovery action for poison for a DIRTY or FREE page is simple. Just
> make sure never to allocate the page. IN-USE pages need some extra
> handling.
>=20
> It would be good to use the sgx_epc_page->owner field as an indicator
> of where an EPC page is currently in that cycle (owner !=3D NULL means
> the EPC page is IN-USE). But there is one caller, sgx_alloc_va_page(),
> that calls with NULL.
>=20
> Since there are multiple uses of the "owner" field with different types
> change the sgx_epc_page structure to define an anonymous union with
> each of the uses explicitly called out.
>=20
> Start epc_pages out with a non-NULL owner while they are in DIRTY state.
>=20
> Fix up the one holdout to provide a non-NULL owner.
>=20
> Refactor the allocation sequence so that changes to/from NULL
> value happen together with adding/removing the epc_page from
> a free list while the node->lock is held.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c  |  5 +++--
>  arch/x86/kernel/cpu/sgx/encl.h  |  2 +-
>  arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
>  arch/x86/kernel/cpu/sgx/main.c  | 23 ++++++++++++-----------
>  arch/x86/kernel/cpu/sgx/sgx.h   | 12 ++++++++----
>  5 files changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 001808e3901c..ad8c61933b0a 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -667,6 +667,7 @@ int sgx_encl_test_and_clear_young(struct mm_struct *m=
m,
> =20
>  /**
>   * sgx_alloc_va_page() - Allocate a Version Array (VA) page
> + * @va_page:	struct sgx_va_page connected to this VA page
>   *
>   * Allocate a free EPC page and convert it to a Version Array (VA) page.
>   *
> @@ -674,12 +675,12 @@ int sgx_encl_test_and_clear_young(struct mm_struct =
*mm,
>   *   a VA page,
>   *   -errno otherwise
>   */
> -struct sgx_epc_page *sgx_alloc_va_page(void)
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page)

Why not just=20

struct sgx_epc_page *sgx_alloc_va_page(void *owner)

>  {
>  	struct sgx_epc_page *epc_page;
>  	int ret;
> =20
> -	epc_page =3D sgx_alloc_epc_page(NULL, true);
> +	epc_page =3D sgx_alloc_epc_page(va_page, true);

epc_page =3D sgx_alloc_epc_page(owner, true);

>  	if (IS_ERR(epc_page))
>  		return ERR_CAST(epc_page);

This function does not do anything with the internals of struct sgx_va_page=
.

> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/enc=
l.h
> index fec43ca65065..3d12dbeae14a 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -111,7 +111,7 @@ void sgx_encl_put_backing(struct sgx_backing *backing=
, bool do_write);
>  int sgx_encl_test_and_clear_young(struct mm_struct *mm,
>  				  struct sgx_encl_page *page);
> =20
> -struct sgx_epc_page *sgx_alloc_va_page(void);
> +struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page);
>  unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
>  void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
>  bool sgx_va_page_full(struct sgx_va_page *va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index 83df20e3e633..655ce0bb069d 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -30,7 +30,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_enc=
l *encl)
>  		if (!va_page)
>  			return ERR_PTR(-ENOMEM);
> =20
> -		va_page->epc_page =3D sgx_alloc_va_page();
> +		va_page->epc_page =3D sgx_alloc_va_page(va_page);
>  		if (IS_ERR(va_page->epc_page)) {
>  			err =3D ERR_CAST(va_page->epc_page);
>  			kfree(va_page);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 63d3de02bbcc..4a5b51d16133 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -457,7 +457,7 @@ static bool __init sgx_page_reclaimer_init(void)
>  	return true;
>  }
> =20
> -static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
> +static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(void *private=
, int nid)
>  {
>  	struct sgx_numa_node *node =3D &sgx_numa_nodes[nid];
>  	struct sgx_epc_page *page =3D NULL;
> @@ -471,6 +471,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from=
_node(int nid)
> =20
>  	page =3D list_first_entry(&node->free_page_list, struct sgx_epc_page, l=
ist);
>  	list_del_init(&page->list);
> +	page->private =3D private;
>  	sgx_nr_free_pages--;
> =20
>  	spin_unlock(&node->lock);
> @@ -480,6 +481,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from=
_node(int nid)
> =20
>  /**
>   * __sgx_alloc_epc_page() - Allocate an EPC page
> + * @owner:	the owner of the EPC page
>   *
>   * Iterate through NUMA nodes and reserve ia free EPC page to the caller=
. Start
>   * from the NUMA node, where the caller is executing.
> @@ -488,14 +490,14 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_fr=
om_node(int nid)
>   * - an EPC page:	A borrowed EPC pages were available.
>   * - NULL:		Out of EPC pages.
>   */
> -struct sgx_epc_page *__sgx_alloc_epc_page(void)
> +struct sgx_epc_page *__sgx_alloc_epc_page(void *private)
>  {
>  	struct sgx_epc_page *page;
>  	int nid_of_current =3D numa_node_id();
>  	int nid =3D nid_of_current;
> =20
>  	if (node_isset(nid_of_current, sgx_numa_mask)) {
> -		page =3D __sgx_alloc_epc_page_from_node(nid_of_current);
> +		page =3D __sgx_alloc_epc_page_from_node(private, nid_of_current);
>  		if (page)
>  			return page;
>  	}
> @@ -506,7 +508,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  		if (nid =3D=3D nid_of_current)
>  			break;
> =20
> -		page =3D __sgx_alloc_epc_page_from_node(nid);
> +		page =3D __sgx_alloc_epc_page_from_node(private, nid);
>  		if (page)
>  			return page;
>  	}
> @@ -559,7 +561,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *=
page)
> =20
>  /**
>   * sgx_alloc_epc_page() - Allocate an EPC page
> - * @owner:	the owner of the EPC page
> + * @private:	per-caller private data
>   * @reclaim:	reclaim pages if necessary
>   *
>   * Iterate through EPC sections and borrow a free EPC page to the caller=
. When a
> @@ -574,16 +576,14 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page=
 *page)
>   *   an EPC page,
>   *   -errno on error
>   */
> -struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
> +struct sgx_epc_page *sgx_alloc_epc_page(void *private, bool reclaim)
>  {
>  	struct sgx_epc_page *page;
> =20
>  	for ( ; ; ) {
> -		page =3D __sgx_alloc_epc_page();
> -		if (!IS_ERR(page)) {
> -			page->owner =3D owner;
> +		page =3D __sgx_alloc_epc_page(private);
> +		if (!IS_ERR(page))
>  			break;
> -		}
> =20
>  		if (list_empty(&sgx_active_page_list))
>  			return ERR_PTR(-ENOMEM);
> @@ -624,6 +624,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
> =20
>  	spin_lock(&node->lock);
> =20
> +	page->private =3D NULL;
>  	list_add_tail(&page->list, &node->free_page_list);
>  	sgx_nr_free_pages++;
> =20
> @@ -652,7 +653,7 @@ static bool __init sgx_setup_epc_section(u64 phys_add=
r, u64 size,
>  	for (i =3D 0; i < nr_pages; i++) {
>  		section->pages[i].section =3D index;
>  		section->pages[i].flags =3D 0;
> -		section->pages[i].owner =3D NULL;
> +		section->pages[i].private =3D "dirty";

#define DIRTY ((void *)-1)

section->pages[i].owner =3D DIRTY;


>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
> =20
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.=
h
> index 4628acec0009..8b1be10a46f6 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -28,8 +28,12 @@
> =20
>  struct sgx_epc_page {
>  	unsigned int section;
> -	unsigned int flags;
> -	struct sgx_encl_page *owner;
> +	int flags;
> +	union {
> +		void *private;
> +		struct sgx_encl_page *owner;
> +		struct sgx_encl_page *vepc;
> +	};


Why not just keep it as void *owner, and cast it as seen
appropriate?

>  	struct list_head list;
>  };
> =20
> @@ -77,12 +81,12 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_=
epc_page *page)
>  	return section->virt_addr + index * PAGE_SIZE;
>  }
> =20
> -struct sgx_epc_page *__sgx_alloc_epc_page(void);
> +struct sgx_epc_page *__sgx_alloc_epc_page(void *private);
>  void sgx_free_epc_page(struct sgx_epc_page *page);
> =20
>  void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
>  int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
> -struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
> +struct sgx_epc_page *sgx_alloc_epc_page(void *private, bool reclaim);
> =20
>  #ifdef CONFIG_X86_SGX_KVM
>  int __init sgx_vepc_init(void);


/Jarkko

