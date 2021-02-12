Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170A3319C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBLKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhBLKYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:24:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E5DE64E6B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613125454;
        bh=rsyxiyXEStA1NzE8F0H4skp7YOk0UzIm/LohaGf/oLU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JwBtMN8MAfJ8nKAIkByBAOCPj6pcr7RruhfJTyEUHG7CepUL5iMy6JC1ClUL7tIsi
         QntkiDtkQqBKQtCHOwwF+uLzcxU1LkJmglnxgH07SVVK5gqn/QC248KuXCgwtqDfUm
         YOmh4SoRiHawtxhcfoux8O7hqTLnl6c/ahSlewySpj4P7oh1msW1sGRE6f0GXwQKLB
         MmhyT/i5LIwXbDF7/1ZzxrzuL21QQJBexxmWIEjtM5mj7+oecb4OsBKJdhp1Etv1vx
         OStS+Cj6UpWHbAJkscroolgSTGDfgK0uChFmJ90tSU5h7buejcuhVxt6kkNiBvwzgw
         Xcj0UiVC9ndyw==
Received: by mail-oi1-f178.google.com with SMTP id i3so9472959oif.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:24:14 -0800 (PST)
X-Gm-Message-State: AOAM530zO5IdUh6Y8PHroOUzND1P0Ro/vZYo5pzkynVHQqXmq8i9g/hF
        1Nxgyk5mZQ6keuaPuuNqk1GwCoTTY8FOJ9apF0k=
X-Google-Smtp-Source: ABdhPJy3d7jIom3IbdQc3mDyFarOjs4dmuOvs4iILRyA51KoBTQ8n8m8b5rQAGfOyfIC1fblA9zmSgFmkY49VIhNC94=
X-Received: by 2002:aca:d908:: with SMTP id q8mr1263674oig.67.1613125453629;
 Fri, 12 Feb 2021 02:24:13 -0800 (PST)
MIME-Version: 1.0
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-3-git-send-email-mihai.carabas@oracle.com> <YCZV4ZNgvP0GfjVF@kroah.com>
In-Reply-To: <YCZV4ZNgvP0GfjVF@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 11:23:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3SSeh4opA_EQ+ka-0aY3-LxgyS1Oa5Gfb3GyXOg_6qnw@mail.gmail.com>
Message-ID: <CAK8P3a3SSeh4opA_EQ+ka-0aY3-LxgyS1Oa5Gfb3GyXOg_6qnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] misc/pvpanic: add PCI driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:18 AM Greg KH <gregkh@linuxfoundation.org> wrote:
le
> > @@ -1,2 +1,4 @@
> >  obj-$(CONFIG_PVPANIC_MMIO)   += pvpanic-mmio.o
> >  pvpanic-mmio-objs := pvpanic-common.o mmio.o
> > +obj-$(CONFIG_PVPANIC_PCI)    += pvpanic-pci.o
> > +pvpanic-pci-objs := pvpanic-common.o pci.o
>
> So you now have the pvpanic-common.o file linked into both modules at
> the same time?  What happens if they are both loaded?
>
> This feels really broken...

Loading them as two modules should work, but this will probably lead to
a link failure if one of the two drivers is built-in and the other one is
a loadable module.

The usual way to fix this is to make the common part a separate module
with exported symbols for the probe/release functions and built
based on CONFIG_PVPANIC, which then needs to be a tristate
symbol again.

      Arnd
