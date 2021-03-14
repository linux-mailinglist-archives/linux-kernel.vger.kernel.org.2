Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE1933A49D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhCNL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 07:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbhCNL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 07:57:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324DF64EBE;
        Sun, 14 Mar 2021 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615723044;
        bh=t/BNalSuzRKSzSA72RQli7xkdl80DqHHcPCdt2tmIQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYMn9NXmVzfllukrCnMGQHyFa16uphV1nT4GGsfIKYBSENnUjnShvJZTS7fekzKIy
         8sVZI3/uBC9/yv1PennV99gMOPddcMrFnil3LvOEnRckEb2TUE0UHnWUKrQv87AR8c
         YLIjnYfobiGmSXh3LJp3cchOe/c/OgDehdcDpaUYEVXVIhbgXr30bCyR5S91vzQjEm
         3CYPDIpGRgdZQdYrPiVcQnHXZPAUFrb4HPt4YM+iG9Qu7n+xwMk4qrHO7C7vmjy0e7
         u/y5DFTKgpjr6t4/yPGLvWP5LN4D0bo2/9p/Qm1QS9pZ95nZL3QvuDCVXSIM6aQxgf
         o209RJ7eOkwsg==
Date:   Sun, 14 Mar 2021 13:56:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] x86/sgx: Add a basic NUMA allocation scheme to
 sgx_alloc_epc_page()
Message-ID: <YE36C4osHaOp2OGY@kernel.org>
References: <20210313160119.1318533-1-jarkko@kernel.org>
 <20210313160119.1318533-4-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313160119.1318533-4-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 06:01:19PM +0200, Jarkko Sakkinen wrote:
> Background
> ==========
> 
> EPC section is covered by one or more SRAT entries that are associated with
> one and only one PXM (NUMA node). The motivation behind this patch is to
> provide basic elements of building allocation scheme based on this premise.
> 
> Just like normal RAM, enclave memory (EPC) should be covered by entries
> in the ACPI SRAT table.  These entries allow each EPC section to be
> associated with a NUMA node.
> 
> Use this information to implement a simple NUMA-aware allocator for
> enclave memory.
> 
> Solution
> ========
> 
> Use phys_to_target_node() to associate each NUMA node with the EPC
> sections contained within its range. In sgx_alloc_epc_page(), first try
> to allocate from the NUMA node, where the CPU is executing. If that
> fails, allocate from other nodes, iterating them from the current node
> in order.
> 
> Other
> =====
> 
> NUMA_KEEP_MEMINFO dependency is required for phys_to_target_node().
> 
> Link: https://lore.kernel.org/lkml/158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

We *can* have also epc_page->node by:

- Considering the first section as the EPC of that node.
- Printing a warning if more sections hit the same node, and
  ignoring them.
- Merging sgx_numa_node and sgx_epc_section

I think this would be a decent idea. I think it's a sane assumption that
a node has a single EPC section, but it's good to have that warning just
in case.

I did not want to do this into this version because it's faster for me
to refactor into this assumption than revert back.

/Jarkko

> ---
> 
> v4:
> * Cycle nodes instead of a global page list, starting from the node
>   of the current thread.
> * Documented NUMA_KEEP_MEMINFO dependency to the commit message.
> * Added NUMA node pointer to struct sgx_epc_section. EPC page should
>   reference to a section, since potentially a node could have multiple
>   sections (Intel SDM does not say anything explicit about this).
>   This the safest play.
> * Remove nodes_clear(sgx_numa_node_mask).
> * Appended Dave's additions to the commit message for the background
>   section.
> 
>  arch/x86/Kconfig               |   1 +
>  arch/x86/kernel/cpu/sgx/main.c | 117 ++++++++++++++++++++-------------
>  arch/x86/kernel/cpu/sgx/sgx.h  |  16 +++--
>  3 files changed, 84 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 513895af8ee7..3e6152a8dd2b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1930,6 +1930,7 @@ config X86_SGX
>  	depends on CRYPTO_SHA256=y
>  	select SRCU
>  	select MMU_NOTIFIER
> +	select NUMA_KEEP_MEMINFO if NUMA
>  	help
>  	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
>  	  that can be used by applications to set aside private regions of code
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index cb4561444b96..3b524a1361d6 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -18,14 +18,23 @@ static int sgx_nr_epc_sections;
>  static struct task_struct *ksgxd_tsk;
>  static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
>  
> -/*
> - * These variables are part of the state of the reclaimer, and must be accessed
> - * with sgx_reclaimer_lock acquired.
> - */
> +/* The reclaimer lock protected variables prepend the lock. */
>  static LIST_HEAD(sgx_active_page_list);
> -
>  static DEFINE_SPINLOCK(sgx_reclaimer_lock);
>  
> +/* The free page list lock protected variables prepend the lock. */
> +static unsigned long sgx_nr_free_pages;
> +
> +/* Nodes with one or more EPC sections. */
> +static nodemask_t sgx_numa_mask;
> +
> +/*
> + * Array with one list_head for each possible NUMA node.  Each
> + * list contains all the sgx_epc_section's which are on that
> + * node.
> + */
> +static struct sgx_numa_node *sgx_numa_nodes;
> +
>  /*
>   * When the driver initialized, EPC pages go first here, as they could be
>   * initialized to an active enclave, on kexec entry.
> @@ -352,21 +361,9 @@ static void sgx_reclaim_pages(void)
>  	}
>  }
>  
> -static unsigned long sgx_nr_free_pages(void)
> -{
> -	unsigned long cnt = 0;
> -	int i;
> -
> -	for (i = 0; i < sgx_nr_epc_sections; i++)
> -		cnt += sgx_epc_sections[i].free_cnt;
> -
> -	return cnt;
> -}
> -
>  static bool sgx_should_reclaim(unsigned long watermark)
>  {
> -	return sgx_nr_free_pages() < watermark &&
> -	       !list_empty(&sgx_active_page_list);
> +	return sgx_nr_free_pages < watermark && !list_empty(&sgx_active_page_list);
>  }
>  
>  static int ksgxd(void *p)
> @@ -443,50 +440,63 @@ static bool __init sgx_page_reclaimer_init(void)
>  	return true;
>  }
>  
> -static struct sgx_epc_page *__sgx_alloc_epc_page_from_section(struct sgx_epc_section *section)
> +static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
>  {
> -	struct sgx_epc_page *page;
> +	struct sgx_numa_node *node = &sgx_numa_nodes[nid];
> +	struct sgx_epc_page *page = NULL;
> +
> +	if (!node_isset(nid, sgx_numa_mask))
> +		return NULL;
>  
> -	spin_lock(&section->lock);
> +	spin_lock(&node->lock);
>  
> -	if (list_empty(&section->page_list)) {
> -		spin_unlock(&section->lock);
> +	if (list_empty(&node->free_page_list)) {
> +		spin_unlock(&node->lock);
>  		return NULL;
>  	}
>  
> -	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
> +	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
>  	list_del_init(&page->list);
> -	section->free_cnt--;
> +	sgx_nr_free_pages--;
> +
> +	spin_unlock(&node->lock);
>  
> -	spin_unlock(&section->lock);
>  	return page;
>  }
>  
>  /**
>   * __sgx_alloc_epc_page() - Allocate an EPC page
>   *
> - * Iterate through EPC sections and borrow a free EPC page to the caller. When a
> - * page is no longer needed it must be released with sgx_free_epc_page().
> + * Iterate through NUMA nodes and borrow a free EPC page to the caller. When a
> + * page is no longer needed it must be released with sgx_free_epc_page(). Start
> + * from the NUMA node, where the caller is executing.
>   *
>   * Return:
> - *   an EPC page,
> - *   -errno on error
> + * - an EPC page:	Free EPC pages were available.
> + * - ERR_PTR(-ENOMEM):	Run out of EPC pages.
>   */
>  struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  {
> -	struct sgx_epc_section *section;
>  	struct sgx_epc_page *page;
> -	int i;
> +	int nid = numa_node_id();
>  
> -	for (i = 0; i < sgx_nr_epc_sections; i++) {
> -		section = &sgx_epc_sections[i];
> +	/* Try to allocate EPC from the current node, first: */
> +	page = __sgx_alloc_epc_page_from_node(nid);
> +	if (page)
> +		return page;
>  
> -		page = __sgx_alloc_epc_page_from_section(section);
> +	/* Then, go through the other nodes: */
> +	while (true) {
> +		nid = next_node_in(nid, sgx_numa_mask);
> +		if (nid == numa_node_id())
> +			break;
> +
> +		page = __sgx_alloc_epc_page_from_node(nid);
>  		if (page)
> -			return page;
> +			break;
>  	}
>  
> -	return ERR_PTR(-ENOMEM);
> +	return page;
>  }
>  
>  /**
> @@ -592,6 +602,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
>  void sgx_free_epc_page(struct sgx_epc_page *page)
>  {
>  	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
> +	struct sgx_numa_node *node = section->node;
>  	int ret;
>  
>  	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
> @@ -600,10 +611,12 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
>  	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
>  		return;
>  
> -	spin_lock(&section->lock);
> -	list_add_tail(&page->list, &section->page_list);
> -	section->free_cnt++;
> -	spin_unlock(&section->lock);
> +	spin_lock(&node->lock);
> +
> +	list_add_tail(&page->list, &node->free_page_list);
> +	sgx_nr_free_pages++;
> +
> +	spin_unlock(&node->lock);
>  }
>  
>  static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
> @@ -624,8 +637,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  	}
>  
>  	section->phys_addr = phys_addr;
> -	spin_lock_init(&section->lock);
> -	INIT_LIST_HEAD(&section->page_list);
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		section->pages[i].section = index;
> @@ -634,7 +645,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
>  		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
>  	}
>  
> -	section->free_cnt = nr_pages;
> +	sgx_nr_free_pages += nr_pages;
>  	return true;
>  }
>  
> @@ -653,8 +664,11 @@ static bool __init sgx_page_cache_init(void)
>  {
>  	u32 eax, ebx, ecx, edx, type;
>  	u64 pa, size;
> +	int nid;
>  	int i;
>  
> +	sgx_numa_nodes = kmalloc_array(num_possible_nodes(), sizeof(*sgx_numa_nodes), GFP_KERNEL);
> +
>  	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
>  		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, &ebx, &ecx, &edx);
>  
> @@ -677,6 +691,21 @@ static bool __init sgx_page_cache_init(void)
>  			break;
>  		}
>  
> +		nid = numa_map_to_online_node(phys_to_target_node(pa));
> +		if (nid == NUMA_NO_NODE) {
> +			/* The physical address is already printed above. */
> +			pr_warn(FW_BUG "Unable to map EPC section to online node. Fallback to the NUMA node 0.\n");
> +			nid = 0;
> +		}
> +
> +		if (!node_isset(nid, sgx_numa_mask)) {
> +			spin_lock_init(&sgx_numa_nodes[nid].lock);
> +			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
> +			node_set(nid, sgx_numa_mask);
> +		}
> +
> +		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
> +
>  		sgx_nr_epc_sections++;
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
> index bc8af0428640..653af8ca1a25 100644
> --- a/arch/x86/kernel/cpu/sgx/sgx.h
> +++ b/arch/x86/kernel/cpu/sgx/sgx.h
> @@ -29,22 +29,26 @@ struct sgx_epc_page {
>  	struct list_head list;
>  };
>  
> +/*
> + * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
> + * the free page list local to the node is stored here.
> + */
> +struct sgx_numa_node {
> +	struct list_head free_page_list;
> +	spinlock_t lock;
> +};
> +
>  /*
>   * The firmware can define multiple chunks of EPC to the different areas of the
>   * physical memory e.g. for memory areas of the each node. This structure is
>   * used to store EPC pages for one EPC section and virtual memory area where
>   * the pages have been mapped.
> - *
> - * 'lock' must be held before accessing 'page_list' or 'free_cnt'.
>   */
>  struct sgx_epc_section {
>  	unsigned long phys_addr;
>  	void *virt_addr;
>  	struct sgx_epc_page *pages;
> -
> -	spinlock_t lock;
> -	struct list_head page_list;
> -	unsigned long free_cnt;
> +	struct sgx_numa_node *node;
>  };
>  
>  extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
> -- 
> 2.30.2
> 
