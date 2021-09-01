Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935CB3FD25C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 06:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhIAEbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 00:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhIAEbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 00:31:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA92560FC0;
        Wed,  1 Sep 2021 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630470610;
        bh=6Pd7NVaPvTBHVJ+6pPfix/RK4uk0493kPdeAJvIYMRQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qeTmQuaFI8KshseRv4i7205ktGPr6zI29DnTJGUEjjHasILmX8ohSdHtco2BGBhNO
         EkAcq0k3oqTl3V9BY4I3lJ+yZxzJ1hjzq0+npcp5AOIEGGAdtDvGU1Kpj5+I9Zk4XU
         2P5j63wt2bQnbRssOV8Ci5/sylCgOn9by54lvuVpsE7kJoJRVCKc5UBgCl5QuVghII
         8ZgUty/bGmDth4xJCNYusfFWZqR+K51rO0XwHVJz+gyp9majpihH2s3JPv36BW1GKF
         G2ku5trPglLbX3wFx4DGDLlmfd4CNJ/E7G1T7KOIRvVGzLvBucfvD1atnjs46RUjBH
         Hv4sCjAgudlIw==
Message-ID: <9a74226ba3f76474c934cf366fc621cc933fbfbb.camel@kernel.org>
Subject: Re: [PATCH v4 2/6] x86/sgx: Add infrastructure to identify SGX EPC
 pages
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Sep 2021 07:30:07 +0300
In-Reply-To: <20210827195543.1667168-3-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 12:55 -0700, Tony Luck wrote:
> X86 machine check architecture reports a physical address when there
> is a memory error. Handling that error requires a method to determine
> whether the physical address reported is in any of the areas reserved
> for EPC pages by BIOS.
>=20
> SGX EPC pages do not have Linux "struct page" associated with them.
>=20
> Keep track of the mapping from ranges of EPC pages to the sections
> that contain them using an xarray.
>=20
> Create a function sgx_is_epc_page() that simply reports whether an addres=
s
> is an EPC page for use elsewhere in the kernel. The ACPI error injection
> code needs this function and is typically built as a module, so export it=
.
>=20
> Note that sgx_is_epc_page() will be slower than other similar "what type
> is this page" functions that can simply check bits in the "struct page".
> If there is some future performance critical user of this function it
> may need to be implemented in a more efficient way.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 10 ++++++++++
>  arch/x86/kernel/cpu/sgx/sgx.h  |  1 +
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 4a5b51d16133..261f81b3f8af 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -20,6 +20,7 @@ struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SEC=
TIONS];
>  static int sgx_nr_epc_sections;
>  static struct task_struct *ksgxd_tsk;
>  static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
> +static DEFINE_XARRAY(epc_page_ranges);

Maybe we could just call this "sgx_epc_address_space"?

/Jarkko

