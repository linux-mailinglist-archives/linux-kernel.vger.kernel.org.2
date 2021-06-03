Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C75C399A69
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCGFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:05:04 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43770 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:05:03 -0400
Received: by mail-qk1-f176.google.com with SMTP id r17so4896034qkp.10;
        Wed, 02 Jun 2021 23:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVGBSqEMWvho2HHHhcn8tJYFWMPyQsDHrSqOC/pMDus=;
        b=IBXfs6RvwlME9tLQ5hjQLVzuBZS2IzCpbKO/Cfg/gf54yiK7m47CiRdEiRFZDUfF6A
         92ZwKKSGkNKvkBoeCWiT6svOo0AgSXvAXABfFUv/RKq4c8RqHKChpAn3UO5yRcFF0YJj
         hDB/6kKVqUOAmfSzrHtqRTxSSfM++NCalWdg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVGBSqEMWvho2HHHhcn8tJYFWMPyQsDHrSqOC/pMDus=;
        b=nXiZbDkukkROCe6JJrdANs1TOMkRIqHx7zQso9dNebmD6aXATR3+ZwrX6AqUUBDAqc
         CveFa4agg2gQgf2bjtatcCZf2b1i0boHs7trONjOJlFtmY4m/kMTEhmwuE4uulE4206n
         szntFQf1n/s8gkU5hSyA/CyZ6rjxYdyQTSoeyagflujn5pyPcE5Ufm6Y/2swxW/egErO
         PB3xRG6QscuURMzdMJq8ULn8DhlMgKOd2Ql54aVdakZrYLJssv9ZfksHtAQ7VtR6ojiQ
         o2iqni0itbSR+Du+3+SYud3+IHBdWhdwagtjT4Y+GcYdhBHaGAhEexjW38PB7v9tV32Y
         NDZw==
X-Gm-Message-State: AOAM533N29339e//ifz+djXBCaiPupx4TnGlDEFNJJalICPxAPNr/kqX
        jU1ELG5A/ciOfzZsKFlFtZf5nOlg/IBB8T2V2kc=
X-Google-Smtp-Source: ABdhPJw/OThWUwK486H/0pNkThCivzv84ZpWEH1P9Vep0jbnQKir8Pp/quWobR1asuUH1GRm/ZyXjQu1xXQ4lnMxOFE=
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr30648908qkc.66.1622700139228;
 Wed, 02 Jun 2021 23:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210316085932.2601-1-troy_lee@aspeedtech.com>
 <CACPK8XeYtaLLWDMR8xZhERrQ_WCUJ2RM_JZmZNQ6oZSvgSDM_w@mail.gmail.com> <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
In-Reply-To: <CAGm54UHgQSMh8WLzRf7Swhv9mmzNBuEK6eKf9eX0ASp95hjARw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Jun 2021 06:02:07 +0000
Message-ID: <CACPK8XdgLP7XSH0Zkej87ynnKTbEUW+RUBiSMgDH1H-LD5VXhg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] ARM: dts: Fix 64MiB OpenBMC flash
 layout and aspeed-ast2600-evb.dts
To:     Lei Yu <yulei.sh@bytedance.com>,
        Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Troy Lee <troy_lee@aspeedtech.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>, leetroy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 at 07:35, Lei Yu <yulei.sh@bytedance.com> wrote:
>
> On Fri, Apr 16, 2021 at 11:03 AM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Tue, 16 Mar 2021 at 08:59, Troy Lee <troy_lee@aspeedtech.com> wrote:
> > >
> > > Aspeed AST2600 u-boot requires 600KiB+ flash space. Sharing the same
> > > openbmc-flash-layout-64.dtsi requires to resize the flash partition.
> > >
> > > The updated flash layout as follows:
> > > - u-boot: 896 KiB
> > > - u-boot-env: 128 KiB
> > > - kernel: 9MiB
> > > - rofs: 32 MiB
> > > - rwfs: 22 MiB
> >
> > Changing the 64MB layout will break the systems that are already using
> > this layout. I'll get the Bytedance people to chime in, as theirs is
> > the only system using this layout so far.
> >
> > John, Lei?
>
> Because the kernel's offset is updated, several other changes are required:
> 1. The related offsets, which is already sent to
> https://gerrit.openbmc-project.xyz/c/openbmc/meta-phosphor/+/39343
> 2. The u-boot patch to update the `bootm` address and make sure it
> only applies to the 64MiB layout.
>
> Without the above two changes, I would suggest holding the merge.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Just confirming that we are okay to go ahead with this change, as per
the discussion on the openbmc list[1].

[1] https://lore.kernel.org/openbmc/CACPK8XdVNXSfzDBPryjQh_4S0yU4Tp6VOOtju+L_DcfgHumPJw@mail.gmail.com/

Cheers,

Joel
