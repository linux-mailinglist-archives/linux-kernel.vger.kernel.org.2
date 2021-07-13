Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7473C72D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhGMPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbhGMPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:13:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04CC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:10:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so25672075wro.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccVY0wCgTs5TXR//31Go1dN/0eihaDgl7hSzcu1KrSo=;
        b=UkdSHwacQ3plM3u3pH8mvBtHXjUG6BjKxsW9wykYRUo8TMgOcACEM4ZNrwYRh1grhL
         LH5NrJb4WpZK6FbVUpMb9kd4eyDdexx0S3bkho9dxBKA3qvnxwlrWAp7DafMqCWnStMJ
         6dEOgko/45tAofxskHm37lTPwdhXGyIvvPNGyGeb+17cyLkZJ43wYSx76Jq9BVY0YWz4
         6KQ3nvMPMAFFD+Kdl7IMk8G87asdaYDPHNm5B5B3D5KiOKbwUOgH/boEQWs59nfQH7fU
         PumH+jFL9BOoyfNfLDcFnEtjFQnc1jZbBZP+VgaUydk6YC7Zhh61ju0xI8h4QQ6QP2HE
         qdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccVY0wCgTs5TXR//31Go1dN/0eihaDgl7hSzcu1KrSo=;
        b=FolBHvQwjt5ur9zMeytS+rP9Om15GtzMJ7rpQBy1CUXQbkwpUHq8Zn/71nuk45Vvvr
         NnIcTF9+PhM04/uYcNvbQQaoj5ba+bpAjEY3ZTTvFFKjlIeaXLc6GVD1e6ETCeldSzz7
         SaaHFkITc/qOnLPFrYimc93cazsIaOL1f3oTXLPZ35sxr6+GhfMh50A+z4a9C2P/f87B
         uWPLEOmxnTdXMU4utk7AW8QSEjIXrbuEdw0iJrp1O5cZzx1C6YsjXouMXYn48cCxOfz7
         MF57NxWopqA/YqbeWXFbMwu2+rsokWR4TpeyIYyxb/LvtQtP82SOIT1wlyK0QHs69vdB
         BG9w==
X-Gm-Message-State: AOAM531sRHzuHCFD1aaPNIM/niCYlKqpNz70QRtnsTTkqmzkKiPSZKnZ
        chDci08XyHJeEEth4EKSChVjWA==
X-Google-Smtp-Source: ABdhPJzb/XWyYmuq03TFlvNVBnQieIXH3H7Kne0EI7KaadBgGq/cwOHSL4U4N5RweLFDSZ5/H1rGyw==
X-Received: by 2002:adf:e488:: with SMTP id i8mr6411373wrm.285.1626189036529;
        Tue, 13 Jul 2021 08:10:36 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t9sm17689573wrq.92.2021.07.13.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:10:34 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:10:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] kdb: Get rid of custom debug heap allocator
Message-ID: <20210713151032.hvsbufswijxt6uxk@maple.lan>
References: <20210708122447.3880803-1-sumit.garg@linaro.org>
 <CAD=FV=UhL32e7spQjr38Lwng0D7mUK+R7iGnmBah=tXzzXsO5g@mail.gmail.com>
 <CAFA6WYN4gMv9Hkuq=3v_UKg+Y1OvFfbOqgZxt7yGSd2RnVBdJw@mail.gmail.com>
 <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X9w_eY9cSkJLsF57bqL=FQFNcybG+P6tYT5mWTnG3TJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 06:45:52AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 13, 2021 at 4:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > > >  int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> > > >  {
> > > >         int ret = 0;
> > > >         unsigned long symbolsize = 0;
> > > >         unsigned long offset = 0;
> > > > -#define knt1_size 128          /* must be >= kallsyms table size */
> > > > -       char *knt1 = NULL;
> > > > +       static char namebuf[KSYM_NAME_LEN];
> > >
> > > I guess this also ends up fixing a bug too, right? My greps show that
> > > "KSYM_NAME_LEN" is 512
> >
> > I can see "KSYM_NAME_LEN" defined as 128 here [1]. Are you looking at
> > any other header file?
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kallsyms.h#n18
> 
> Ah ha, it's recent! See commit f2f6175186f4 ("kallsyms: increase
> maximum kernel symbol length to 512")

Ineed. So recent that I think it hasn't been merged to mainline yet!

This patch is part of the rust patch set. IIUC it is in linux-next for
wider testing but I'd be surprised if it gets merged to mainline anytime
soon (and even more amazed if it is merged without being rebased and
given a new hash value ;-) ).


Daniel.
