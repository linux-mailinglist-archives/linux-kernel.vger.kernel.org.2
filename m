Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D379DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhEKDe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:34:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36531 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhEKDey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:34:54 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lgJ9X-0006Ik-PA
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 03:33:47 +0000
Received: by mail-lj1-f198.google.com with SMTP id v4-20020a2e96040000b02900ce9d1504b5so10166998ljh.16
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSs6wGkqCeP3e2X7oXR6Znw5oiB9jcI2Zxhz3FUpuYs=;
        b=eXXNhFfPr75afsNnrLTzTru8dT6oIf0tpz5fFRrc+KkX8us2eJnQe7MdxH7N7bgHSQ
         t6eEyliXkQ0R83eM93mCG9623rfIoTEqZAoVQrGuqSzqPjHL9G9BpJMJ4wEui7mGxb0y
         MRJL9WtE7855CWcar1YKlAiFIVR61Lzm3IIXXOkhxnSQ1tF0P0KwmHCJXGFx9y242vAm
         ASOQUtcciQkSCatz77kPnty+R2y7BX8Dyjsc/la/pAVaUGvkm1trTpR5Cw8vtpvqF1yf
         Db/XN/SY/JKjjtzI/p4egNYud+JppTbXRKzPT/7MYmKoA3G3No2eCwlIaEaj8HFJWeiv
         fUXA==
X-Gm-Message-State: AOAM532NWBp8dW9maoYt8mtof/LP+joZEmBpTg4q9IdGhpO4D6HjjnAj
        tPArC9VGomDtIGhgZm2VhdXPZfbaCqIhzMzhcJ9sZEwqQpQLoFXaZKvUqAK6UMS3urbClXpIGzq
        1yT6N0QjgmBFyw9Aq3ygc5CcRNf14zXIIT6ELbejnoIKViyLKTVRhTTA7Dg==
X-Received: by 2002:ac2:5fc9:: with SMTP id q9mr19797836lfg.290.1620704027216;
        Mon, 10 May 2021 20:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP91Z8IW8EkWCaYE8EiEizLo10auyoxnofDLFvVJpbYoM/pbeICOSGgXCP8irVnTkBCxZQjTKfX4gt3OIYbS8=
X-Received: by 2002:ac2:5fc9:: with SMTP id q9mr19797820lfg.290.1620704026948;
 Mon, 10 May 2021 20:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131252.531935-1-kai.heng.feng@canonical.com> <CAAd53p5rtZW_yqV2S77g34Dv9m9941yoBM6a_6fAvKpEuzXJ9g@mail.gmail.com>
In-Reply-To: <CAAd53p5rtZW_yqV2S77g34Dv9m9941yoBM6a_6fAvKpEuzXJ9g@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 11 May 2021 11:33:34 +0800
Message-ID: <CAAd53p52C9TQz_zOPE-ySqfKbRNFo0MPzq7E3p_8mAwF_g0VjQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 4:57 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Thu, Apr 1, 2021 at 9:12 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> > can't get the BAR it needs:
> > [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> > [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> > ...
> > [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> > [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> > [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> >
> > However, the root bus has two contiguous regions that can contain the
> > child resource requested.
> >
> > Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> > for host bridges, since host bridge don't have _SRS. So do that
> > accordingly to make child resource can be contained. This change makes
> > the graphics works on the system in question.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A gentle ping...

Another gentle ping...

>
> > ---
> > v2:
> >  - Coalesce all contiguous regresion in pci_register_host_bridge(), if
> >    conditions are met.
> >
> >  drivers/pci/probe.c | 49 +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 953f15abc850..3607ce7402b4 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/hypervisor.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/list_sort.h>
> >  #include "pci.h"
> >
> >  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> > @@ -874,14 +875,30 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >         dev_set_msi_domain(&bus->dev, d);
> >  }
> >
> > +static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
> > +{
> > +       struct resource_entry *entry1, *entry2;
> > +
> > +       entry1 = container_of(a, struct resource_entry, node);
> > +       entry2 = container_of(b, struct resource_entry, node);
> > +
> > +       if (entry1->res->flags != entry2->res->flags)
> > +               return entry1->res->flags > entry2->res->flags;
> > +
> > +       if (entry1->offset != entry2->offset)
> > +               return entry1->offset > entry2->offset;
> > +
> > +       return entry1->res->start > entry2->res->start;
> > +}
> > +
> >  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  {
> >         struct device *parent = bridge->dev.parent;
> > -       struct resource_entry *window, *n;
> > +       struct resource_entry *window, *next, *n;
> >         struct pci_bus *bus, *b;
> > -       resource_size_t offset;
> > +       resource_size_t offset, next_offset;
> >         LIST_HEAD(resources);
> > -       struct resource *res;
> > +       struct resource *res, *next_res;
> >         char addr[64], *fmt;
> >         const char *name;
> >         int err;
> > @@ -959,11 +976,35 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >         if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> >                 dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> >
> > +       /* Sort and coalesce contiguous windows */
> > +       list_sort(NULL, &resources, res_cmp);
> > +       resource_list_for_each_entry_safe(window, n, &resources) {
> > +               if (list_is_last(&window->node, &resources))
> > +                       break;
> > +
> > +               next = list_next_entry(window, node);
> > +               offset = window->offset;
> > +               res = window->res;
> > +               next_offset = next->offset;
> > +               next_res = next->res;
> > +
> > +               if (res->flags != next_res->flags || offset != next_offset)
> > +                       continue;
> > +
> > +               if (res->end + 1 == next_res->start) {
> > +                       next_res->start = res->start;
> > +                       res->flags = res->start = res->end = 0;
> > +               }
> > +       }
> > +
> >         /* Add initial resources to the bus */
> >         resource_list_for_each_entry_safe(window, n, &resources) {
> > -               list_move_tail(&window->node, &bridge->windows);
> >                 offset = window->offset;
> >                 res = window->res;
> > +               if (!res->end)
> > +                       continue;
> > +
> > +               list_move_tail(&window->node, &bridge->windows);
> >
> >                 if (res->flags & IORESOURCE_BUS)
> >                         pci_bus_insert_busn_res(bus, bus->number, res->end);
> > --
> > 2.30.2
> >
