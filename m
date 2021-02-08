Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027B33133AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhBHNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBHNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:48:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E0C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:48:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n6so4374623wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mNx2OEZE2HU1b2QNLXpDC6fHMy9szkj5oGpfBazya28=;
        b=jUZjYQLlGqEm/bYXsALBbQclRDXFKxfwG5naGKTWn9ga+IfwzfKmdgFtb4TGavVWmK
         48xYlVDZlPDni5Lr2lzKCPYbXzeYrfkEBbQyKT5wWPuJnzMLApUm7eOku7/bssyPVPSi
         FDX823R1BgOxgLi3AFloSDAUqC1Y5IwDMBsz/Vohp7ZYBYKooLVG8/RSzfXK3Xh383j4
         GURN9b+VdfZEPdwohmiwdJl/6BEvFUEVJpiL3Gt126oZQB3468+34J2Z+khzgiJFFeNX
         a3gWy33lNaj+cI4soLR7Jqhnp45XQyOxAaIyKr5WxwEVQarIzpuJ/ZEJG4jpWMrufo9A
         E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mNx2OEZE2HU1b2QNLXpDC6fHMy9szkj5oGpfBazya28=;
        b=uG6SBdBv2is+GmDTMIpH1P9X/Rl1xvxIKBm7DJAgSwrIH9qPs6Os1+QntlUBneXEmL
         Mq2CruVoufyrA67BcboqBTOHteT9TXEm8zmGo+9Oko2CvwLNsvUF2YyA9QN37UxN9ss9
         vF1IyUyFYngwxKxox5WHImNmRZCWRSBIoE6z/ND6V57oqnLeT6SOAQE3eWjOXSbMTJh/
         1eVo9vwgcbKwqfNFKwJ4BRRReLEeW6IOr2jm3kol3BgjYvNFrgLaN2e3Ej1FOlwxiNbl
         Xzsgs+HSCAjPTLkmKPy557bDn037BAG8DkH9WTYQPx7/gGNyUMD4FVc8ZfeK4re5t4dh
         kQQQ==
X-Gm-Message-State: AOAM533Ehu9iEtBNIJEL1YOfIQ37vTRCqiSCVLKTTrthOMcEbRRSnpZz
        vhaqWuIcNV4iSWWMgozZB9w5AlxgbMH45Q==
X-Google-Smtp-Source: ABdhPJwjmYhDuinB41hfbemCWcHuv3lwIsEtVvyheB2CfxeRuXT7iCvNhiwKpjvla44qT8FeULxctg==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr20269509wrl.344.1612792085140;
        Mon, 08 Feb 2021 05:48:05 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h14sm19122828wmq.39.2021.02.08.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 05:48:04 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:48:02 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] kdb: Simplify kdb commands registration
Message-ID: <20210208134802.tr7jzk27ja5chwgf@maple.lan>
References: <1611915427-3196-1-git-send-email-sumit.garg@linaro.org>
 <20210208094303.csu2kkyi25d7a25y@maple.lan>
 <CAFA6WYNDydeDg8J16tFC30=yXCDMeaMKOm0Jt-3yF5jUMCq0yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNDydeDg8J16tFC30=yXCDMeaMKOm0Jt-3yF5jUMCq0yQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 03:18:19PM +0530, Sumit Garg wrote:
> On Mon, 8 Feb 2021 at 15:13, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Jan 29, 2021 at 03:47:07PM +0530, Sumit Garg wrote:
> > > @@ -1011,25 +1005,17 @@ int kdb_parse(const char *cmdstr)
> > >               ++argv[0];
> > >       }
> > >
> > > -     for_each_kdbcmd(tp, i) {
> > > -             if (tp->cmd_name) {
> > > -                     /*
> > > -                      * If this command is allowed to be abbreviated,
> > > -                      * check to see if this is it.
> > > -                      */
> > > -
> > > -                     if (tp->cmd_minlen
> > > -                      && (strlen(argv[0]) <= tp->cmd_minlen)) {
> > > -                             if (strncmp(argv[0],
> > > -                                         tp->cmd_name,
> > > -                                         tp->cmd_minlen) == 0) {
> > > -                                     break;
> > > -                             }
> > > -                     }
> > > -
> > > -                     if (strcmp(argv[0], tp->cmd_name) == 0)
> > > +     list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> > > +             /*
> > > +              * If this command is allowed to be abbreviated,
> > > +              * check to see if this is it.
> > > +              */
> > > +             if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
> > > +                 (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
> > >                               break;
> >
> > Looks like you forgot to unindent this line.
> >
> > I will fix it up but... checkpatch would have found this.
> >
> 
> Ah, I missed to run checkpatch on v3. Thanks for fixing this up.

Unfortunately, it's not just checkpatch. This patch also causes a
large number of test suite regressions. In particular it looks like
kgdbwait does not work with this patch applied.

The problem occurs on multiple architectures all with
close-to-defconfig kernels. However to share one specific
failure, x86_64_defconfig plus the following is not bootable:

    ../scripts/config --enable DEBUG_INFO --enable DEBUG_FS \
      --enable KALLSYMS_ALL --enable MAGIC_SYSRQ --enable KGDB \
      --enable KGDB_TESTS --enable KGDB_KDB --enable KDB_KEYBOARD \
      --enable LKDTM

Try:

    qemu-system-x86_64 \
      -enable-kvm -m 1G -smp 2 -nographic
      -kernel arch/x86/boot/bzImage \
      -append "console=ttyS0,115200 kgdboc=ttyS0 kgdbwait"


Daniel.
