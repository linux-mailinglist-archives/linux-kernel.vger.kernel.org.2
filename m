Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5DD3A223F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFJCY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:24:56 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43595 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623291781; x=1654827781;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Es9Yc+nWfWOton6nJ7vBMxAfrCbSkpo/Lyn1fPbzP9g=;
  b=y9+tBMSuZhvIwb1QhqA2F3P1RzX3OTeVqSbhjcetmLVvp84sVXjbXlY3
   qp+iDarjU6rjI1hAhroPmvYHSzj3p3WmFJoebP6SPchoLJ8CqdrrgN2XV
   ydlIgCxPnrAaGBHtXOM2br5l/Duy4tRTL5sHbs96eEza/ast9DeOOU+7Y
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 Jun 2021 19:23:00 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2021 19:22:56 -0700
Received: from [10.111.160.165] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Jun
 2021 19:22:53 -0700
Subject: Re: [PATCH 21/39] irqdomain: Introduce irq_resolve_mapping()
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <kernel-team@android.com>
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-22-maz@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <cd57cdf8-0385-acc5-c971-666942351f57@quicinc.com>
Date:   Wed, 9 Jun 2021 22:22:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210520163751.27325-22-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/2021 12:37 PM, Marc Zyngier wrote:
> Rework irq_find_mapping() to return an irq_desc pointer, and
> rename the result to irq_resolve_mapping().
> 
> irq_find_mapping() is then rewritten in terms of ir_resolve_mapping().
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Marc, there is an use-after-free that "git blame" pointed to this commit. Any thoughts?

__irq_resolve_mapping+0x34c/0x360:
__irq_resolve_mapping at /usr/src/linux-next/kernel/irq/irqdomain.c:917

[   52.773282][    C0] BUG: KASAN: use-after-free in __irq_resolve_mapping+0x34c/0x360
[   52.780946][    C0] Read of size 8 at addr ffff00005e8e4950 by task swapper/0/0
[   52.788256][    C0]
[   52.790441][    C0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.13.0-rc5-next-20210609+ #22
[   52.800181][    C0] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[   52.808706][    C0] Call trace:
[   52.811845][    C0]  dump_backtrace+0x0/0x3b8
[   52.816207][    C0]  show_stack+0x20/0x30
[   52.820217][    C0]  dump_stack_lvl+0x144/0x190
[   52.824749][    C0]  print_address_description.constprop.0+0x74/0x3c8
[   52.831191][    C0]  kasan_report+0x1f0/0x208
[   52.835548][    C0]  __asan_report_load8_noabort+0x34/0x60
[   52.841034][    C0]  __irq_resolve_mapping+0x34c/0x360
[   52.846171][    C0]  handle_domain_irq+0x88/0x168
[   52.850875][    C0]  gic_handle_irq+0x5c/0x150
[   52.855319][    C0]  call_on_irq_stack+0x28/0x50
[   52.859936][    C0]  do_interrupt_handler+0x80/0xa8
[   52.864813][    C0]  el1_interrupt+0x30/0x48
[   52.869083][    C0]  el1h_64_irq_handler+0x18/0x28
[   52.873874][    C0]  el1h_64_irq+0x74/0x78
[   52.877968][    C0]  cpuidle_enter_state+0x2a4/0xff0
[   52.882934][    C0]  cpuidle_enter+0x60/0xb0
[   52.887203][    C0]  call_cpuidle+0x44/0xc0
[   52.891385][    C0]  do_idle+0x36c/0x420
[   52.895306][    C0]  cpu_startup_entry+0x30/0x88
[   52.899923][    C0]  rest_init+0x380/0x4f0
[   52.904017][    C0]  arch_call_rest_init+0x18/0x24
[   52.908809][    C0]  start_kernel+0x3b4/0x3ec
[   52.913165][    C0]  __primary_switched+0xc0/0xc8
[   52.917869][    C0]
[   52.920051][    C0] Allocated by task 7:
[   52.923970][    C0]  kasan_save_stack+0x28/0x58
[   52.928500][    C0]  __kasan_kmalloc+0x8c/0xb0
[   52.932942][    C0]  kmem_cache_alloc_node_trace+0x288/0x3c8
[   52.938600][    C0]  __irq_domain_alloc_irqs+0x110/0x738
[   52.943911][    C0]  __msi_domain_alloc_irqs+0x1f8/0xc18
[   52.949221][    C0]  msi_domain_alloc_irqs+0x78/0xd0
[   52.954184][    C0]  pci_msi_setup_msi_irqs.isra.0+0x78/0xb8
[   52.959843][    C0]  __pci_enable_msix_range+0x5d8/0xc10
[   52.965152][    C0]  pci_alloc_irq_vectors_affinity+0x144/0x1e8
[   52.971069][    C0]  nvme_reset_work+0x338/0x2aa4 [nvme]
[   52.976391][    C0]  process_one_work+0x7e4/0x1998
[   52.981182][    C0]  worker_thread+0x334/0xad0
[   52.985623][    C0]  kthread+0x3ac/0x460
[   52.989545][    C0]  ret_from_fork+0x10/0x18
[   52.993813][    C0]
[   52.995995][    C0] Freed by task 7:
[   52.999567][    C0]  kasan_save_stack+0x28/0x58
[   53.004100][    C0]  kasan_set_track+0x28/0x40
[   53.008548][    C0]  kasan_set_free_info+0x28/0x50
[   53.013339][    C0]  __kasan_slab_free+0xfc/0x150
[   53.018042][    C0]  slab_free_freelist_hook+0x128/0x258
[   53.023353][    C0]  kfree+0x150/0x4c0
[   53.027100][    C0]  irq_domain_free_irq_data+0x94/0xe0
[   53.032323][    C0]  irq_domain_free_irqs+0x200/0x2d0
[   53.037373][    C0]  __msi_domain_free_irqs+0xbc/0x138
[   53.042509][    C0]  msi_domain_free_irqs+0x78/0xb8
[   53.047385][    C0]  free_msi_irqs+0x420/0x598
[   53.051827][    C0]  pci_disable_msix+0x250/0x330
[   53.056528][    C0]  pci_free_irq_vectors+0x20/0x38
[   53.061404][    C0]  nvme_reset_work+0x11dc/0x2aa4 [nvme]
[   53.066809][    C0]  process_one_work+0x7e4/0x1998
[   53.071599][    C0]  worker_thread+0x334/0xad0
[   53.076040][    C0]  kthread+0x3ac/0x460
[   53.079962][    C0]  ret_from_fork+0x10/0x18
[   53.084230][    C0]
[   53.086411][    C0] The buggy address belongs to the object at ffff00005e8e4940
[   53.086411][    C0]  which belongs to the cache kmalloc-64 of size 64
[   53.100141][    C0] The buggy address is located 16 bytes inside of
[   53.100141][    C0]  64-byte region [ffff00005e8e4940, ffff00005e8e4980)
[   53.113090][    C0] The buggy address belongs to the page:
[   53.118574][    C0] page:ffffffc00017a380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xde8e
[   53.128486][    C0] flags: 0x7ffff800000200(slab|node=0|zone=0|lastcpupid=0xfffff)
[   53.136059][    C0] raw: 007ffff800000200 ffffffc00211b648 ffffffc00211ec88 ffff0000129103c0
[   53.144494][    C0] raw: 0000000000000000 0000000001000100 00000001ffffffff 0000000000000000
[   53.152927][    C0] page dumped because: kasan: bad access detected
[   53.159189][    C0]
[   53.161371][    C0] Memory state around the buggy address:
[   53.166853][    C0]  ffff00005e8e4800: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[   53.174765][    C0]  ffff00005e8e4880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   53.182678][    C0] >ffff00005e8e4900: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
[   53.190590][    C0]                                                  ^
[   53.197114][    C0]  ffff00005e8e4980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   53.205027][    C0]  ffff00005e8e4a00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
[   53.212939][    C0] ==================================================================
[   53.220850][    C0] Disabling lock debugging due to kernel taint
[   53.226850][    C0] irq 320, desc: ffff000840982800, depth: 1, count: 0, unhandled: 0
[   53.234672][    C0] ->handle_irq():  ffff800010258d30, handle_bad_irq+0x0/0x570
[   53.241980][    C0] ->irq_data.chip(): ffff800018d20520, no_irq_chip+0x0/0x760
[   53.241988][    C0] ->action(): 0000000000000000


> ---
>  include/linux/irqdomain.h | 18 +++++++++++++++---
>  kernel/irq/irqdomain.c    | 22 ++++++++++++++--------
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 2b696c9bcaaf..189f559fb26c 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -31,7 +31,8 @@
>  #define _LINUX_IRQDOMAIN_H
>  
>  #include <linux/types.h>
> -#include <linux/irqhandler.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
>  #include <linux/of.h>
>  #include <linux/mutex.h>
>  #include <linux/radix-tree.h>
> @@ -401,13 +402,24 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
>  	return irq_create_mapping_affinity(host, hwirq, NULL);
>  }
>  
> +extern struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
> +					    irq_hw_number_t hwirq);
> +
>  /**
>   * irq_find_mapping() - Find a linux irq from a hw irq number.
>   * @domain: domain owning this hardware interrupt
>   * @hwirq: hardware irq number in that domain space
>   */
> -extern unsigned int irq_find_mapping(struct irq_domain *host,
> -				     irq_hw_number_t hwirq);
> +static inline unsigned int irq_find_mapping(struct irq_domain *domain,
> +					    irq_hw_number_t hwirq)
> +{
> +	struct irq_desc *desc = irq_resolve_mapping(domain, hwirq);
> +
> +	if (unlikely(!desc))
> +		return 0;
> +
> +	return irq_desc_get_irq(desc);
> +}
>  
>  static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
>  					     irq_hw_number_t hwirq)
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8e55bb8c3073..13a3021e9370 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -876,29 +876,32 @@ void irq_dispose_mapping(unsigned int virq)
>  EXPORT_SYMBOL_GPL(irq_dispose_mapping);
>  
>  /**
> - * irq_find_mapping() - Find a linux irq from a hw irq number.
> + * irq_resolve_mapping() - Find a linux irq from a hw irq number.
>   * @domain: domain owning this hardware interrupt
>   * @hwirq: hardware irq number in that domain space
> + *
> + * Returns the interrupt descriptor.
>   */
> -unsigned int irq_find_mapping(struct irq_domain *domain,
> -			      irq_hw_number_t hwirq)
> +struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
> +				     irq_hw_number_t hwirq)
>  {
> +	struct irq_desc *desc = NULL;
>  	struct irq_data *data;
>  
>  	/* Look for default domain if necessary */
>  	if (domain == NULL)
>  		domain = irq_default_domain;
>  	if (domain == NULL)
> -		return 0;
> +		return desc;
>  
>  	if (irq_domain_is_nomap(domain)) {
>  		if (hwirq < domain->revmap_size) {
>  			data = irq_domain_get_irq_data(domain, hwirq);
>  			if (data && data->hwirq == hwirq)
> -				return hwirq;
> +				desc = irq_data_to_desc(data);
>  		}
>  
> -		return 0;
> +		return desc;
>  	}
>  
>  	rcu_read_lock();
> @@ -907,10 +910,13 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
>  		data = rcu_dereference(domain->revmap[hwirq]);
>  	else
>  		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
> +
> +	if (likely(data))
> +		desc = irq_data_to_desc(data);
>  	rcu_read_unlock();
> -	return data ? data->irq : 0;
> +	return desc;
>  }
> -EXPORT_SYMBOL_GPL(irq_find_mapping);
> +EXPORT_SYMBOL_GPL(irq_resolve_mapping);
>  
>  /**
>   * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
> 
