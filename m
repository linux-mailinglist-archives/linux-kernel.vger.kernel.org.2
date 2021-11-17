Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF19454190
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 08:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhKQHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 02:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhKQHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 02:05:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C646C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:02:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so6288703eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 23:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJWfAEgu0pQC3A1Z1UTZZbcpyQ16AQ5GBOg7mhh3CuY=;
        b=KroIMxSug9NQJDIh8ZZmHlT+OaiLpqR928NqgMhgjjE37UA6y+HOXfB3W6RDMN0n4G
         YC09HzTAnsqMzAkxqkIhoZTi3xUUEd5thHmjw43rtKpVveUxC5NiBp+wnRZkUSNRjMyJ
         8zG/TbOufibVLzvFZET5x32bzkbaBxPSvy2UUy4w87nGlJsy30WCfiS0IjqQ05c1A4BS
         NU07AKUZECYxZAT/yqvjGDXgoEWzEFMoIXrdacGIJmtjT6yD/U0tDzmUtELBZZ1m1aLR
         7ce1yByWMOhSFmVHEU/foMMfXC60G6u9UtbhAGK+V3sspgbrwfGRdnWMR2Lsmx0gw1IT
         3fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJWfAEgu0pQC3A1Z1UTZZbcpyQ16AQ5GBOg7mhh3CuY=;
        b=AJSdyTx9QmIIS889VcY6t2mm2kSg0Zx4g0R3Cp0B0KOvCYyMqGKfSOwPNoJjZkkuV4
         aHiRzT0CCMDr2f3wplXRYnhm/LrhgFP6xMml/7+D0M1xmBC3rgYfKEpx7T42Nk9F/t5m
         nM2BDx3TDJ9/I3iV3vegL2FA3w+nbyd5vBb56BzoDrNQ5lcj04jaXIhXrU2cybHt6beV
         tFAro8AIT60OSEXWKMAZ54JCCKPd5wR5Gtn9Xs7IO2Q9IrCId6AIBeC59P814cuk2ARl
         F+TiFuHwFJcrFkoNcWUBNvH4go3xm1LbMURZLUYkA13qZhGTZWVssb6fr2N4frsk7VSR
         u/8w==
X-Gm-Message-State: AOAM531AsEqYVQc5vEkCAFxQWH859+8hfR+UF0u1I+3ocFmRRi1NU/pl
        2gaQb/FidxDLliMsQd2Xj50=
X-Google-Smtp-Source: ABdhPJx2JpA/+TK+km6sR9R3gwBY9OsLrKbBYt2DdYD1XmdIS0gCEl8k7mxzJANngTQO2S/VKfLX0w==
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr18628479edb.191.1637132573872;
        Tue, 16 Nov 2021 23:02:53 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id qk13sm9585271ejc.3.2021.11.16.23.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 23:02:52 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Wed, 17 Nov 2021 08:02:42 +0100
Message-ID: <2063032.8CZl0nWAlc@localhost.localdomain>
In-Reply-To: <f68adf33-4a98-ac4b-fe07-ac4909eeefff@i-love.sakura.ne.jp>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <f68adf33-4a98-ac4b-fe07-ac4909eeefff@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 17, 2021 2:55:44 AM CET Tetsuo Handa wrote:
> On 2021/11/16 23:49, Fabio M. De Francesco wrote:
> > -	if (in_interrupt())
> > +	if (!preemptible())
> >  		return count;
> 
> preemptible() is "an unconditional 0" if CONFIG_PREEMPT_COUNT=n .
> Is preemptible() really what we want? ;-) 
> 
Greg K-H made me notice that Linux has had this code for many years and no 
one has ever found problems with it, therefore, whatever triggered Syzbot 
must be recent changes up in the calls chain.

This reported bug must be better investigated because there is a high 
probability that the "real" issue is somewhere else.

Unfortunately, as I replied to Greg, I know very little of tty/vt so I'll 
take time to understand the relevant documentation and the related code.

For instance, I don't know why we need to disable IRQs with spin_lock_irq() 
up in the call chain in n_tty_ioctl_helper(). Would a "normal" spin_lock() be 
enough? Otherwise, what about spin_lock_bh()?

Do we really need to disable IRQs?

Aside from the reasoning reported above, for a moment let's speculate on the 
remote possibility that this bugs are in do_con_write() and 
con_flush_chars()...

When I asked Syzbot to run a test on my diff, the code was different than 
what you see in this patch. 

Marco Elver had proposed this "if (!preemptible()) return <something>;". I 
didn't even know of that macro, so I proposed to open code the equivalent 
implementation that Linux uses if CONFIG_PREEMPT_COUNT=y.

The end result, applying De Morgan's law on his proposal, was "if 
((preempt_count() || irqs_disabled()) return <something>;".

Now, out of curiosity, if Greg's argument (with which I agree in full) was 
not brought to my attention, what would happen by using that test if we have 
kernels compiled with CONFIG_PREEMPT_COUNT=n (as it is in your example)?

I'd appreciate if you have time and want to answer my last question and 
(possibly) also the one about using spin_lock() or spin_lock_bh() in 
n_tty_ioctl_helper().

@Greg, the same two questions are for you, if you have time and want to  
kindly help :)

Thanks to you all,

Fabio M. De Francesco



