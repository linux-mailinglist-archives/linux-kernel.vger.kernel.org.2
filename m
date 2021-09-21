Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8382D413D56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhIUWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhIUWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:09:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:07:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c7so2785167qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmNoREXEsTQk/U8Gj8hxJgkwpIFQVacQIWPFX9WwIhE=;
        b=BmvKqba0wk3fHOJkzodZkWkwcRiEGryCgimWoPwoR/3fuUIA+dSginnReDiVPyee7m
         d0wKi27PG+BRcSjcBjJGq+L+WHKcqjtrvpWTSmYtPhmc8evGnsfH/85hixjGh0cAWjdh
         GtyZsqwLpWRGBoTJ8GV2gLHI8D56ItDf8ldGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmNoREXEsTQk/U8Gj8hxJgkwpIFQVacQIWPFX9WwIhE=;
        b=FXcgCEyOvOCH19p2mIdXLwDV2glbYlVETI/BJwSxAGSDwCtbz/Q5gBrPh19sla7hX+
         4MbgefW9GNhTd1Dnm04f3b2aOfuSFGUFJS8ha3/0pAwg4JjS1qtAMTOgR3COPBdkJ6Fi
         al4lgHe8NHKCyftoJ2I2SCVA8ZY7cRMLi7EtwtE+u0MIO332lIv6ClD0b7X1Dg5bFKXu
         3SE5YTgy2TsNIZ8bXLbufGs9X49g7lKssaadKvuynUsb6xlpUDIIwz6u6sgAHzn9SsmL
         oSeyzIevRBNKmv1PlmP7CwkKfiH2TDSetpwb0Bf+KQ+GzHQbDzS/p+y0jQNCLpGbMBDH
         f0tA==
X-Gm-Message-State: AOAM5317UaYmpYx3HPNQBkit5zm042/NGT9Lx5CGs9sZF7PuBXITBKW+
        ONATt/EdjSdXxXZPjeoSOyc8WMWuPBbMT4pWNUsSVziESWETAA==
X-Google-Smtp-Source: ABdhPJyq8q/2GRWoSd9IVWD2qjnKGMJZedg7wb9//OSKY3U1RobmMvJLmjUnkfW/rF/kZo95fKOmy8XVlElLbOkvjc8=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr41652428ybj.504.1632262057588;
 Tue, 21 Sep 2021 15:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR10MB2986A960E859A744FDC3875ABCDE9@DM6PR10MB2986.namprd10.prod.outlook.com>
In-Reply-To: <DM6PR10MB2986A960E859A744FDC3875ABCDE9@DM6PR10MB2986.namprd10.prod.outlook.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 21 Sep 2021 15:07:25 -0700
Message-ID: <CAODwPW-bbHp3Nxbr9VRt0hZMX0xRnwbGb07PS=8uysXEKFs61w@mail.gmail.com>
Subject: Re: [SPECIFICATION RFC v3] The firmware and bootloader log specification
To:     Alec Brown <alec.r.brown@oracle.com>
Cc:     "coreboot@coreboot.org" <coreboot@coreboot.org>,
        "grub-devel@gnu.org" <grub-devel@gnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "systemd-devel@lists.freedesktop.org" 
        <systemd-devel@lists.freedesktop.org>,
        "trenchboot-devel@googlegroups.com" 
        <trenchboot-devel@googlegroups.com>,
        "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Aleksandr Burmashev <alexander.burmashev@oracle.com>,
        "allen.cryptic@gmail.com" <allen.cryptic@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "btrotter@gmail.com" <btrotter@gmail.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "dpsmith@apertussolutions.com" <dpsmith@apertussolutions.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "hun@n-dimensional.de" <hun@n-dimensional.de>,
        "james.dutton@gmail.com" <james.dutton@gmail.com>,
        "javierm@redhat.com" <javierm@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jwerner@chromium.org" <jwerner@chromium.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "lukasz.hawrylko@intel.com" <lukasz.hawrylko@intel.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "mtottenh@akamai.com" <mtottenh@akamai.com>,
        "nico.h@gmx.de" <nico.h@gmx.de>,
        "phcoder@gmail.com" <phcoder@gmail.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "sjg@chromium.org" <sjg@chromium.org>,
        "trini@konsulko.com" <trini@konsulko.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        "ulrich.windl@rz.uni-regensburg.de" 
        <ulrich.windl@rz.uni-regensburg.de>,
        "wvervoorn@eltan.com" <wvervoorn@eltan.com>,
        "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
        "rharwood@redhat.com" <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since it doesn't seem possible to have each boot component using the same log
> format, we added a log_format and log_phys_addr fields to give flexibility in
> how logs are stored. An example of a different log format that can be used is
> the cbmem_console log format used by coreboot:

I am not exactly sure how you expect this interoperability you seem to
be suggesting here to work. Are you saying that your bf_log_header can
sometimes point to the bf_log_buffer structure you define, and
sometimes to a coreboot CBMEM console buffer? But that's a completely
different format that requires a different reader implementation, how
is that supposed to work? If this proposal is just "we define a
wrapper structure that points to everyone's custom firmware log
implementation", then I don't really see the point (the only benefit
still left then might be discovery of the log buffer, but that's the
part you leave open in your design while all those other
implementations already have working discovery mechanisms of their own
anyway).

For the other structures you have defined, the same feedback that I
think was already mentioned on the last iteration of this thread still
applies: it seems incredibly bloated for a simple firmware logging
mechanism. You have a whooping 24+n bytes of overhead *per line* which
probably comes out to somewhere between 30-50% of total space wasted
on overhead for the average log buffer. I guess there are just
fundamentally different opinions on how featureful a firmware log
mechanism needs to be so we're probably not gonna find a format that
makes everyone happy here, but at least for the coreboot project I see
little reason for us to implement something like this when we already
have a well-working existing solution with tooling and wideranged
support.
