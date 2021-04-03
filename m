Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49CA3532F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhDCH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhDCH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:29:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B4C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:29:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3250313wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LtTu1b2JZJZec31h8A1xaVmHs2JPp+yjJ40dMGS0r00=;
        b=OsP27Ok3/htF3ya8dYOTaYDDhKODS/FiQlEehDzecnZKj6m3FpbHNi4aZpVDqwkSHc
         V5WoZvXhw37Y9d5PYUlLDoyR9Xojw4iMMiI2raR3B/JzImlYrX1AYFLzrToe8UB+ctOa
         gYFAQ/NkZFci2KhFQJd0/PAtYyQzHN5wRXtR4DyNIqoh112FccHWEcWW22rKNNHOBllf
         2+r9qxSTmwIax+KkoURKCqdWUSAGhldhD/VULj4arAgSCLg7ihtC7i2CFvL5eTcfx/v9
         bVJsc8relQDl2/SiQeL7dgKtkYlkKXjfvlZrLILGXQ2/coj95X+k38DGy/pzFL/mxbdq
         BSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LtTu1b2JZJZec31h8A1xaVmHs2JPp+yjJ40dMGS0r00=;
        b=JjHzMEnZimAD+Jx9ouLCnNdaOmI5jrO39ciJg5WWxyyzLgf0OYOQDDeuT9TO5KFGGn
         Dd1wlMubQXquf9uSNupkapsfCCS6+XFsbOq/5XaUsnZ8l9soHF/5PnG2Y1docS+psHwR
         lt91VO+TBGxHIJxNFClXrd1IXI+cktbt+gGtpITbuq2RdQh/hbi09aYB5p/CO5j16/Fl
         20Q5qT48wct6u4gwr8NEu6mEliiQKSQ9Ou/em6zkS6v4UvVRcp4MydQrU6D8e+k3/9qc
         U15RyD4ZwgXkRPVNu7garC9AemXBWR4rwAwo4bNXo90mrwmIR7rNMv2VF2VT07/rF6yN
         BdQQ==
X-Gm-Message-State: AOAM531Bm1tMLkaZejNAou98GotQRNzTFYgb2Hdpb+F7dIS2j7lXge5J
        1SRTPUD0Ij5e3DYjbNe+q1c=
X-Google-Smtp-Source: ABdhPJyYJLVXxNYaO8mcSfq8VC+cBI1QVEJd/KTGnZpaioplFSKYIef4I+1IQNmg7WhY4E3+V/5AoA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr15793943wmc.91.1617434977336;
        Sat, 03 Apr 2021 00:29:37 -0700 (PDT)
Received: from agape.jhs ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id e9sm1940509wrv.92.2021.04.03.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:29:37 -0700 (PDT)
Date:   Sat, 3 Apr 2021 09:29:34 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] staging: rtl8723bs: remove all RT_TRACE logs in
 core/rtw_wlan_util.c
Message-ID: <20210403072933.GA1563@agape.jhs>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
 <34bf6cdc7bdf5c64d47cb3525897970644de7052.1617356821.git.fabioaiuto83@gmail.com>
 <2014e0fc141d73d907c781ca31c822c96d3a7c47.camel@perches.com>
 <20210402125127.GB1420@agape.jhs>
 <c845d8ea7d0d8e7a613471edb53d780d660142a9.camel@perches.com>
 <20210402174003.GA1399@agape.jhs>
 <906c8d899a3840afab1e624736b44292eacc6c97.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <906c8d899a3840afab1e624736b44292eacc6c97.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:37:17AM -0700, Joe Perches wrote:
> On Fri, 2021-04-02 at 19:40 +0200, Fabio Aiuto wrote:
> > On Fri, Apr 02, 2021 at 08:20:17AM -0700, Joe Perches wrote:
> > > On Fri, 2021-04-02 at 14:51 +0200, Fabio Aiuto wrote:
> > > > On Fri, Apr 02, 2021 at 03:37:57AM -0700, Joe Perches wrote:
> > > > > On Fri, 2021-04-02 at 12:01 +0200, Fabio Aiuto wrote:
> > > > > > remove all RT_TRACE logs
> > > > > > 
> > > > > > fix patch-related checkpatch issues
> []
> > > > > Lastly, another suggestion would be to just submit a single patch
> > > > > removing _ALL_ the RT_TRACE uses not intermixing various other cleanups
> > > > > with the series and then do those other cleanups.
> > > > > 
> > > > > Using a coccinelle script like:
> > > > > 
> > > > > $ cat RT_TRACE.cocci
> > > > > @@
> > > > > expression a, b, c;
> > > > > @@
> > > > > 
> > > > > -	RT_TRACE(a, b, (c));
> > > > > 
> > > > > $ spatch -sp-file RT_TRACE.cocci drivers/staging/rtl8723bs/
> > > > > 
> > > > > And then clean up the various bits you think are inappropriately done.
> []
> > > > thank you Joe, I tried with (RT_TRACE.cocci in parent folder)
> > > > 
> > > > user@host:~/src/git/kernels/staging$ spatch -sp-file ../RT_TRACE.cocci drivers/staging/rtl8723bs/
> > > > init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> > > > 0 files match
> > > 
> > > Likely you are running the script on the tree after you have
> > > applied all your patches.
> > > 
> > > Try running the cocci script on a fresh copy of -next.
> > > 
> > > Using the script and adding the script in the commit message helps
> > > others to verify that the changes you make do not have any other effect.
> > > 
> > > $ cat RT_TRACE.cocci
> > > @@
> > > expression a, b, c;
> > > @@
> > > 
> > > -	RT_TRACE(a, b, (c));
> > > 
> > > $ git checkout next-20210401
> > > $ spatch -sp-file RT_TRACE.cocci --in-place --no-show-diff --very-quiet drivers/staging/rtl8723bs/
> > > 31 files match
> > > $ git diff --stat -p
> > >  drivers/staging/rtl8723bs/core/rtw_cmd.c          |  34 +------
> []
> > >  28 files changed, 19 insertions(+), 935 deletions(-)
> []
> > thank you Joe, this mail is so precious ;)
> 
> I'm not quite sure what you mean by that but you quoted
> nearly 200k of the previous email.

you gave me good advice

> 
> Please remember to trim your replies.
> 
> 

got it, thank you

regards,

fabio
