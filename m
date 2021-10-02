Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FD41FBD4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhJBMpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhJBMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:43:27 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864DC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 05:41:42 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id s137so5603364vke.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04UYSjv3XK8YYRLMS8EjOWE0RB+1RMIPFRsHVl219Qs=;
        b=DaYonGdjBK4EKI7vHbxdN2OToTFnnQA54syIJEtS455R2UFOsrH1ADw+Wa7W1K6UXx
         4jAQgYMtyroaQjRZppIJuDHi3Jf7LYu/uW8gxAr1l4Ie2/0tuwI7o307FD4moZtEFzV6
         PTDyhy8kIAdOu6sF8bnN3629QOZmVKPN9qnG+39W+K41hsUKfl5zjWqKfuA4jihn2mkW
         7yAho92MurfQRE5zj5gbB3eJMPSefHUA/gTz/2HxJO6zDfnkaVhmpduAVloaydi2XwDu
         u0B93rhXwOoGid3sPoQdjlap1nJzy86Cma9Pu9h520HqyYRQNlLemNxdpqWMnV4qom+/
         TiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04UYSjv3XK8YYRLMS8EjOWE0RB+1RMIPFRsHVl219Qs=;
        b=D7pZ2kXS/rMskfy+LFT4SIAF/Z3xdvbKgsU9gjZOUnUwYtsHqd6Gf35jmJwKRVSimY
         pcHLqjvTF+7/IfTLmD528I0q3qPvSOG5LX4CPSU2CCpA3NYne/sllIN8vhFajVtoIPUn
         oH63n3hg9K6rG58toD2QCJygQ5kKjQwbw6ABe4/iM0tH1IpoCdsT2r2OP1UTlulteo/7
         czjf089ctWCusx9i+eB2pNrMKFy8zCtir4NwlxAGIg1uAcN/q9bneA2OlU+Bl8gYJ7Z7
         w7qYx6fQVztEGU4yKahDVdhfpGBJHclY75lhd4zEsMpuHIdFKrZhQuNw4unBucVSnL+F
         UZLQ==
X-Gm-Message-State: AOAM533bEuW9XMzvAUcopxxI+NuNrdVAT+jfC273UOQpETO20gJcvmGE
        DRPGv+ZrDpA9deuTBL/o5c+ZYlMY9C8m+avLLa0PatjNmCY=
X-Google-Smtp-Source: ABdhPJxE7ik8qBFll0QqinI3oUDYidjD+3Llt+DxJqDcKWseb1Sj8nAwvmd5ZB4s7VpPyb7MZzOcbvPF3Ij5RVbinps=
X-Received: by 2002:a1f:2cd1:: with SMTP id s200mr10773292vks.3.1633178501242;
 Sat, 02 Oct 2021 05:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210916123138.3490474-1-chenhuacai@loongson.cn>
 <20210916123138.3490474-10-chenhuacai@loongson.cn> <87v92irq3y.wl-maz@kernel.org>
In-Reply-To: <87v92irq3y.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 20:41:29 +0800
Message-ID: <CAAhV-H5HZRZARosqcQoovg2mw9e4HbxoBFhRcX-etvM4SL5V3A@mail.gmail.com>
Subject: Re: [PATCH V5 09/10] irqchip: Add Loongson Extended I/O interrupt
 controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Fri, Oct 1, 2021 at 12:21 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 16 Sep 2021 13:31:37 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not compatible
> > with old MIPS-based Loongson) support. This patch add Loongson Extended
> > I/O CPU interrupt controller support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/Kconfig                |  10 +
> >  drivers/irqchip/Makefile               |   1 +
> >  drivers/irqchip/irq-loongson-eiointc.c | 373 +++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h             |   1 +
> >  4 files changed, 385 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 443c3a7a0cc1..aff08ad824c9 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -547,6 +547,16 @@ config LOONGSON_LIOINTC
> >       help
> >         Support for the Loongson Local I/O Interrupt Controller.
> >
> > +config LOONGSON_EIOINTC
> > +     bool "Loongson Extend I/O Interrupt Controller"
> > +     depends on LOONGARCH
> > +     depends on MACH_LOONGSON64
> > +     default MACH_LOONGSON64
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select GENERIC_IRQ_CHIP
> > +     help
> > +       Support for the Loongson3 Extend I/O Interrupt Vector Controller.
> > +
> >  config LOONGSON_HTPIC
> >       bool "Loongson3 HyperTransport PIC Controller"
> >       depends on (MACH_LOONGSON64 && MIPS)
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 4e34eebe180b..eb3fdc6fe808 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_SCI_INTA_IRQCHIP) += irq-ti-sci-inta.o
> >  obj-$(CONFIG_TI_PRUSS_INTC)          += irq-pruss-intc.o
> >  obj-$(CONFIG_IRQ_LOONGARCH_CPU)              += irq-loongarch-cpu.o
> >  obj-$(CONFIG_LOONGSON_LIOINTC)               += irq-loongson-liointc.o
> > +obj-$(CONFIG_LOONGSON_EIOINTC)               += irq-loongson-eiointc.o
> >  obj-$(CONFIG_LOONGSON_HTPIC)         += irq-loongson-htpic.o
> >  obj-$(CONFIG_LOONGSON_HTVEC)         += irq-loongson-htvec.o
> >  obj-$(CONFIG_LOONGSON_PCH_PIC)               += irq-loongson-pch-pic.o
> > diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> > new file mode 100644
> > index 000000000000..353c91ea5ad2
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-loongson-eiointc.c
> > @@ -0,0 +1,373 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Loongson Extend I/O Interrupt Controller support
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +
> > +#define pr_fmt(fmt) "eiointc: " fmt
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/syscore_ops.h>
> > +
> > +#define EIOINTC_REG_NODEMAP  0x14a0
> > +#define EIOINTC_REG_IPMAP    0x14c0
> > +#define EIOINTC_REG_ENABLE   0x1600
> > +#define EIOINTC_REG_BOUNCE   0x1680
> > +#define EIOINTC_REG_ISR              0x1800
> > +#define EIOINTC_REG_ROUTE    0x1c00
> > +
> > +#define VEC_REG_COUNT                4
> > +#define VEC_COUNT_PER_REG    64
> > +#define VEC_COUNT            (VEC_REG_COUNT * VEC_COUNT_PER_REG)
> > +#define VEC_REG_IDX(irq_id)  ((irq_id) / VEC_COUNT_PER_REG)
> > +#define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
> > +#define EIOINTC_DEF_ENABLE   0xffffffff
> > +
> > +static int nr_pics;
> > +
> > +struct eiointc_priv {
> > +     u32                     node;
> > +     nodemask_t              node_map;
> > +     cpumask_t               cpuspan_map;
> > +     struct fwnode_handle    *domain_handle;
> > +     struct irq_domain       *eiointc_domain;
> > +};
> > +
> > +struct eiointc_priv *eiointc_priv[2];
> > +
> > +int eiointc_get_node(int id)
> > +{
> > +     return eiointc_priv[id]->node;
> > +}
>
> Why aren't these static?
Emm, eiointc_priv should be static, but eiointc_get_node() is used by arch code.

>
> > +
> > +static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode, nodemask_t *node_map)
> > +{
> > +     int node, cpu_node, route_node;
> > +     unsigned char coremap[MAX_NUMNODES];
> > +     uint32_t pos_off, data, data_byte, data_mask;
> > +
> > +     pos_off = pos & ~3;
> > +     data_byte = pos & 3;
> > +     data_mask = ~BIT_MASK(data_byte) & 0xf;
> > +
> > +     memset(coremap, 0, sizeof(unsigned char) * MAX_NUMNODES);
> > +
> > +     /* Calculate node and coremap of target irq */
> > +     cpu_node = cpu_to_node(cpu);
> > +     coremap[cpu_node] |= (1 << (topology_core_id(cpu)));
>
> BIT()?
OK, thanks.

>
> > +
> > +     for_each_online_node(node) {
> > +             if (!node_isset(node, *node_map))
> > +                     continue;
> > +
> > +             /* Node 0 is in charge of inter-node interrupt dispatch */
> > +             route_node = (node == mnode) ? cpu_node : node;
> > +             data = ((coremap[node] | (route_node << 4)) << (data_byte * 8));
> > +             csr_any_send(EIOINTC_REG_ROUTE + pos_off, data, data_mask, node);
> > +     }
> > +}
> > +
> > +static DEFINE_SPINLOCK(affinity_lock);
> > +
> > +static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
> > +{
> > +     unsigned int cpu;
> > +     unsigned long flags;
> > +     uint32_t vector, pos_off;
> > +     struct cpumask intersect_affinity;
> > +     struct eiointc_priv *priv = (struct eiointc_priv *)d->domain->host_data;
>
> Drop the cast.
OK, thanks.

>
> > +
> > +     if (!IS_ENABLED(CONFIG_SMP))
> > +             return -EPERM;
> > +
> > +     spin_lock_irqsave(&affinity_lock, flags);
>
> This must be a raw spinlock.
OK, thanks.

>
> > +
> > +     cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
> > +     cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
> > +
> > +     if (cpumask_empty(&intersect_affinity)) {
> > +             spin_unlock_irqrestore(&affinity_lock, flags);
> > +             return -EINVAL;
> > +     }
> > +     cpu = cpumask_first(&intersect_affinity);
> > +
> > +     /*
> > +      * Control interrupt enable or disalbe through cpu 0
> > +      * which is reponsible for dispatching interrupts.
> > +      */
> > +     if (!d->parent_data)
> > +             vector = d->hwirq;
> > +     else
> > +             vector = d->parent_data->hwirq;
> > +
> > +     pos_off = vector >> 5;
> > +
> > +     csr_any_send(EIOINTC_REG_ENABLE + (pos_off << 2),
> > +                  EIOINTC_DEF_ENABLE & (~((1 << (vector & 0x1F)))), 0x0, 0);
> > +     eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
> > +     csr_any_send(EIOINTC_REG_ENABLE + (pos_off << 2), EIOINTC_DEF_ENABLE, 0x0, 0);
>
> These bit shifts are undecipherable. At the very least, explain what
> this is doing.
OK, this will be improved.

>
> > +
> > +     irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +     spin_unlock_irqrestore(&affinity_lock, flags);
> > +
> > +     return IRQ_SET_MASK_OK;
> > +}
> > +
> > +static int eiointc_index(int node)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < nr_pics; i++) {
> > +             if (node_isset(node, eiointc_priv[i]->node_map))
> > +                     return i;
> > +     }
> > +
> > +     return -1;
> > +}
> > +
> > +static int eiointc_router_init(unsigned int cpu)
> > +{
> > +     int i, bit;
> > +     uint32_t data;
> > +     uint32_t node = cpu_to_node(cpu);
> > +     uint32_t index = eiointc_index(node);
> > +
> > +     if (index < 0) {
> > +             pr_err("Error: invalid nodemap!\n");
> > +             return -1;
> > +     }
> > +
> > +     if (cpu == cpumask_first(cpumask_of_node(node))) {
> > +             eiointc_enable();
> > +
> > +             for (i = 0; i < VEC_COUNT / 32; i++) {
> > +                     data = (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
> > +                     iocsr_writel(data, EIOINTC_REG_NODEMAP + i * 4);
> > +             }
> > +
> > +             for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
> > +                     bit = BIT(1 + index); /* Route to IP[1 + index] */
> > +                     data = bit | (bit << 8) | (bit << 16) | (bit << 24);
> > +                     iocsr_writel(data, EIOINTC_REG_IPMAP + i * 4);
> > +             }
> > +
> > +             for (i = 0; i < VEC_COUNT / 4; i++) {
> > +                     /* Route to Node-0 Core-0 */
> > +                     if (index == 0)
> > +                             bit = BIT(cpu_logical_map(0));
> > +                     else
> > +                             bit = (eiointc_priv[index]->node << 4) | 1;
> > +
> > +                     data = bit | (bit << 8) | (bit << 16) | (bit << 24);
> > +                     iocsr_writel(data, EIOINTC_REG_ROUTE + i * 4);
> > +             }
> > +
> > +             for (i = 0; i < VEC_COUNT / 32; i++) {
> > +                     data = 0xffffffff;
> > +                     iocsr_writel(data, EIOINTC_REG_ENABLE + i * 4);
> > +                     iocsr_writel(data, EIOINTC_REG_BOUNCE + i * 4);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void eiointc_irq_dispatch(struct irq_desc *desc)
> > +{
> > +     int i;
> > +     u64 pending;
> > +     bool handled = false;
> > +     struct irq_chip *chip = irq_desc_get_chip(desc);
> > +     struct eiointc_priv *priv = irq_desc_get_handler_data(desc);
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     for (i = 0; i < VEC_REG_COUNT; i++) {
> > +             pending = iocsr_readq(EIOINTC_REG_ISR + (i << 3));
> > +             iocsr_writeq(pending, EIOINTC_REG_ISR + (i << 3));
> > +             while (pending) {
> > +                     int bit = __ffs(pending);
> > +                     int irq = bit + VEC_COUNT_PER_REG * i;
> > +
> > +                     generic_handle_domain_irq(priv->eiointc_domain, irq);
> > +                     pending &= ~BIT(bit);
> > +                     handled = true;
> > +             }
> > +     }
> > +
> > +     if (!handled)
> > +             spurious_interrupt();
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void eiointc_ack_irq(struct irq_data *d)
> > +{
> > +}
> > +
> > +static void eiointc_mask_irq(struct irq_data *d)
> > +{
> > +}
> > +
> > +static void eiointc_unmask_irq(struct irq_data *d)
> > +{
> > +}
> > +
> > +static struct irq_chip eiointc_irq_chip = {
> > +     .name                   = "EIOINTC",
> > +     .irq_ack                = eiointc_ack_irq,
> > +     .irq_mask               = eiointc_mask_irq,
> > +     .irq_unmask             = eiointc_unmask_irq,
> > +     .irq_set_affinity       = eiointc_set_irq_affinity,
>
> If this is only routing interrupts, why isn't this a hierarchical
> interrupt controller that passes all the callbacks directly to the
> parent?
OK, this will be improved.

>
> > +};
> > +
> > +static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > +                             unsigned int nr_irqs, void *arg)
> > +{
> > +     int ret;
> > +     unsigned int i, type;
> > +     unsigned long hwirq = 0;
> > +     struct eiointc *priv = domain->host_data;
> > +
> > +     ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc_irq_chip,
> > +                                     priv, handle_edge_irq, NULL, NULL);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void eiointc_domain_free(struct irq_domain *domain, unsigned int virq,
> > +                             unsigned int nr_irqs)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < nr_irqs; i++) {
> > +             struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
> > +
> > +             irq_set_handler(virq + i, NULL);
> > +             irq_domain_reset_irq_data(d);
> > +     }
> > +}
> > +
> > +static const struct irq_domain_ops eiointc_domain_ops = {
> > +     .translate      = irq_domain_translate_onecell,
> > +     .alloc          = eiointc_domain_alloc,
> > +     .free           = eiointc_domain_free,
> > +};
> > +
> > +static int eiointc_suspend(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static bool is_eiointc_irq(struct irq_data *irq_data)
> > +{
> > +     int i;
> > +     struct irq_domain *parent;
> > +
> > +     for (parent = irq_data->domain; parent; parent = parent->parent) {
> > +             for (i = 0; i < nr_pics; i++) {
> > +                     if (parent == eiointc_priv[i]->eiointc_domain)
> > +                             return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void eiointc_resume(void)
> > +{
> > +     int i;
> > +     struct irq_desc *desc;
> > +     struct irq_data *irq_data;
> > +
> > +     eiointc_router_init(0);
> > +
> > +     for (i = 0; i < NR_IRQS; i++) {
>
> No. Never.
>
> > +             desc = irq_to_desc(i);
> > +             if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
> > +                     irq_data = &desc->irq_data;
> > +                     if (!is_eiointc_irq(irq_data))
> > +                             continue;
> > +
> > +                     eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
> > +             }
>
> If you need to restore some state, track the interrupts that actually
> matter. But this is... just not on.
OK, let me try to improve.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
