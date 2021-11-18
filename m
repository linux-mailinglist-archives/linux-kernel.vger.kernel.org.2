Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C145582D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbhKRJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbhKRJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:41:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFDC061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:38:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so24291422edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jA5Sozi5oYO1BZC2ZueqGW4ScLb2yo/Eb+YJoK727bk=;
        b=AeiddrX4/+3R7flwsiNzXgE5s3GEwuj/MoCNan8cr02QtLnzsaoESrl0AKP9WezR4m
         PpZOT4ggZ4mQrmZ8Re91vdinteGEW9xskUi95fMlfpOyGlFHAG4KhZBH2JcbOEFQ7YWa
         gBkjoLkWElIHLTe4fHsbZ90JwwY+i5LSWY9CTms68RzHCwLRCoKoWqLtfhEhQQCo9d0w
         7mNSLWcLwxeThXIlgmwVqzFI2LZHDVcaYOL64AlhON1Gwa0o/lbh2Xuqej49B8xvWHh7
         80LMpT6SH3NbtdrxCL38wk2bveT0Ft0bQy7frp+/wKGfFtZt1C5kBYnYeyaYO2YLQb7m
         t40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jA5Sozi5oYO1BZC2ZueqGW4ScLb2yo/Eb+YJoK727bk=;
        b=oHW1rTMUumoUxgeX1nH6vVSd7xsHeDVvYU3EikJOGV+dQy6wqwBpAc7eX9K3RIzdlo
         BF4nkDw94rrUYfeqejQjieMvC9Pw9SAqVHJakZHao2/z2PhunzS4fqfgrNemH/G8qDe3
         DqmwuMILf89J+DytHnI2jD+TJpJi3Du+3y+lK4iF7v3UCUlx82HhmqsyUUL36SBG6M/2
         go8xbRzf21PZuZBP+JeFMuFUHgAhaHh4TRm2+iabBnPnM/AYLc8sCZB7RhM/C1U7MIkZ
         mCFATJvoavJZGVJ154LArHZwHFHB4QDJJecR9HCwARcaQcnNCNauSTjmABfDG2pISV1G
         cl4A==
X-Gm-Message-State: AOAM530Quk8whN5v16yUVvi6/OmFO711tjzyfsmDlXHGxdhOMp/iBb6X
        LXvcPtEf0zZRNvnmvWjqdcM=
X-Google-Smtp-Source: ABdhPJzfIye8IZI7el8CHTUJ+nyNLDHn8PHh+dRD7n4DJN48e86UuASpTMnR92jvPK07EsH+iCTxfA==
X-Received: by 2002:aa7:d652:: with SMTP id v18mr9534884edr.68.1637228301283;
        Thu, 18 Nov 2021 01:38:21 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id hc10sm1028280ejc.99.2021.11.18.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 01:38:20 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Thu, 18 Nov 2021 10:38:19 +0100
Message-ID: <1825634.Qa45DEmgBM@localhost.localdomain>
In-Reply-To: <77983591.hkYTjcaLry@localhost.localdomain>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <df266c83-88df-4d1a-5c7e-ea0214f3de3b@i-love.sakura.ne.jp> <77983591.hkYTjcaLry@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 18, 2021 9:31:06 AM CET Fabio M. De Francesco wrote:
> On Wednesday, November 17, 2021 11:51:13 AM CET Tetsuo Handa wrote:
> > On 2021/11/17 17:54, Greg Kroah-Hartman wrote:
> > > Great, you have a reproducer, so you should be able to duplicate this
> > > locally to figure out what is really happening here.
> >
> > Until commit ac751efa6a0d70f2 ("console: rename acquire/release_console_sem() to
> > console_lock/unlock()"), do_con_write() was surely designed to be able to sleep.
> > 
> > > $ git blame ac751efa6a0d7~1 drivers/tty/vt/vt.c
> >
> > [...]
> > 
> > Until that commit, n_hdlc_send_frames() was prepared for being interrupted by signal
> > while sleeping.
> > 
> > $ git blame ac751efa6a0d7~1 drivers/tty/n_hdlc.c
> >
> > [...]
> >
> > But as of commit c545b66c6922b002 ("tty: Serialize tcflow() with other tty flow
> > control changes"), start_tty() was already holding spinlock.
> 
> Hi Tetsuo,
> 
> Actually, we don't care of start_tty(). It's not in the path that triggers sleeping in atomic bug.
> According to Syzbot report and to my ftrace analysis it's __start_tty() that is called by 
> n_tty_ioctl_helper(), and it is this function that acquires a spinlock and disables interrupts. 
> 
> I must admit that I've never used git-blame and I'm not sure to understand what you did here :(

I've had a chance to look both at commit c545b66c6922 and f9e053dcfc02. They are so strictly 
related (same code. same author, same date) that I'm not anymore sure of which is to blame.

However, at this moment I'm scarcely interested in figuring out which one actually is responsible 
for this issue.

What I know is that this issue is _real_ and that it should be fixed some way.

> Have you had a chance to read my analysis?
>  
> > $ git blame c545b66c6922b002~1 drivers/tty/tty_io.c
> >
> > [...]
> > 
> > Actually, it is commit f9e053dcfc02b0ad ("tty: Serialize tty flow control changes
> > with flow_lock") that started calling tty->ops->start(tty) from atomic context.
> > 
> > $ git blame f9e053dcfc02b~1 drivers/tty/tty_io.c
> >
> > [...]
> > 
> > Therefore, I think that bisection will reach f9e053dcfc02b0ad, and I guess that
> > this bug was not noticed simply because little people tested n_hdlc driver.
> > 
> > Well, how to fix? Introduce a new flag for indicating "starting" state (like drivers/block/loop.c uses Lo_* state) ?
> 
> I think this is not the correct fix, but I might very well be wrong...

I've read (again) the code that you mentioned. I've changed my mind about it.
Now I think that a flag like that could be useful if there are no other means to
lock __start_tty() and __stop_tty() critical sections.

Thanks,

Fabio

> Can you please reply to my last email (the one with the ftrace analysis)?
> In the last lines I proposed two alternative solutions, what about them?
> 
> Thanks,
> 
> Fabio
> 
> 
> 
> 
> 




