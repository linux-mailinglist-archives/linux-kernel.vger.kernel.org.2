Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5617455701
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244632AbhKRIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbhKRIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:34:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:31:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so23302533edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeMUwfD9fqjO01UjxP7eilCSbZ8phxHK2UIfLtNxFHo=;
        b=e32qX9GdTA8hdP6g8tyNvQarviZsUM4tS51oCl1ZzjzCZHLujmZAFH9SC7VsaG6Hcy
         w/kyAIAiNNC7gdPlpOioqPQ82U/32/29ZrnEGkgWWHOvf1tb+LvNv8ef7rbtWzl7ju2P
         gwIESEK9FdRYyjdGynAhRLda82VUzCcTPk5koykan9GsJgWt446hjT1uYnwNEAQydQFx
         DHF0KE6Q7jeGpuSq0swnVx4MdY4KLFxUqq8FIHy8y+RHfSIELy4M67FCH/e2BIiBLD6M
         9uCztAdDmna8AKkdddpvFttBcQ1bNCgybUBh0con8DKCtGd8dzdyvb+YrvM2GYHQyu7t
         3VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeMUwfD9fqjO01UjxP7eilCSbZ8phxHK2UIfLtNxFHo=;
        b=Nr1yI9bAOoFfCmzllT5riZ4hJaFCo9fBK9TKFeoNRHlCO/CW9SlieKE2+znlWxOv0A
         qX+2pig2bGFvtuhT1rswvVL5KPBHS40tDz9legeypfitkdh+a144JA8floLgDBzQmhRj
         fluyAD2KJNBczUoWyBk90iLdWnq04WpXhy2XGuSJFkkijtPV1r20+AN6z/Vl7gqxyLcL
         yu5RDFCjY8I5IviAjGj09A6q4fbjL9dkeowliPmUXUdnFmJrP8V4qtbz7iunin4vSrqw
         2lfx2hFm/7gUu6tVGQsYYG6xwZkWHrjwQP2fJQuoqMSBjEc41Wsi8d6r1YwqGmzlq29w
         forw==
X-Gm-Message-State: AOAM533qMgGodZLp0t6deltiOZz58OPhpvVb0Twk3oGlX+aV05faomfR
        swXo+fHim/OSZODohZ4Xq9E=
X-Google-Smtp-Source: ABdhPJzMJG0mgBhXkaGLQDWUnV9sc2gaNAsDNAWDDugSp/svER3/x1qdvL/KFFk07Vzz4O2skm5/1w==
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr8538893edq.370.1637224269892;
        Thu, 18 Nov 2021 00:31:09 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id jg32sm1055175ejc.43.2021.11.18.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:31:09 -0800 (PST)
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
Date:   Thu, 18 Nov 2021 09:31:06 +0100
Message-ID: <77983591.hkYTjcaLry@localhost.localdomain>
In-Reply-To: <df266c83-88df-4d1a-5c7e-ea0214f3de3b@i-love.sakura.ne.jp>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <YZTDY/h8HcEkq7mO@kroah.com> <df266c83-88df-4d1a-5c7e-ea0214f3de3b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 17, 2021 11:51:13 AM CET Tetsuo Handa wrote:
> On 2021/11/17 17:54, Greg Kroah-Hartman wrote:
> > Great, you have a reproducer, so you should be able to duplicate this
> > locally to figure out what is really happening here.
>
> Until commit ac751efa6a0d70f2 ("console: rename acquire/release_console_sem() to
> console_lock/unlock()"), do_con_write() was surely designed to be able to sleep.
> 
> > $ git blame ac751efa6a0d7~1 drivers/tty/vt/vt.c
>
> [...]
> 
> Until that commit, n_hdlc_send_frames() was prepared for being interrupted by signal
> while sleeping.
> 
> $ git blame ac751efa6a0d7~1 drivers/tty/n_hdlc.c
>
> [...]
>
> But as of commit c545b66c6922b002 ("tty: Serialize tcflow() with other tty flow
> control changes"), start_tty() was already holding spinlock.

Hi Tetsuo,

Actually, we don't care of start_tty(). It's not in the path that triggers sleeping in atomic bug.
According to Syzbot report and to my ftrace analysis it's __start_tty() that is called by 
n_tty_ioctl_helper(), and it is this function that acquires a spinlock and disables interrupts. 

I must admit that I've never used git-blame and I'm not sure to understand what you did here :(

Have you had a chance to read my analysis?
 
> $ git blame c545b66c6922b002~1 drivers/tty/tty_io.c
>
> [...]
> 
> Actually, it is commit f9e053dcfc02b0ad ("tty: Serialize tty flow control changes
> with flow_lock") that started calling tty->ops->start(tty) from atomic context.
> 
> $ git blame f9e053dcfc02b~1 drivers/tty/tty_io.c
>
> [...]
> 
> Therefore, I think that bisection will reach f9e053dcfc02b0ad, and I guess that
> this bug was not noticed simply because little people tested n_hdlc driver.
> 
> Well, how to fix? Introduce a new flag for indicating "starting" state (like drivers/block/loop.c uses Lo_* state) ?

I think this is not the correct fix, but I might very well be wrong...

Can you please reply to my last email (the one with the ftrace analysis)?
In the last lines I proposed two alternative solutions, what about them?

Thanks,

Fabio




