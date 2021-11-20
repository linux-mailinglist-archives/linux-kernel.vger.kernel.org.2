Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E84457F02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 16:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhKTPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 10:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKTPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 10:42:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E24C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 07:38:57 -0800 (PST)
Date:   Sat, 20 Nov 2021 16:38:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637422733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tN5ewJXCTjSGUReagubKGCJLhvuBKJYqaDvPT1VNFOI=;
        b=4SyIPFeK829pDm7i2PCi2ZoP/lvst4CRlxeHjRue6Ic7r6bRscv8SfWQ6NK22+5GLZpfFM
        Ux1FmmFNMLAaJFBeq6Ebgh9eoSd9o7STBEkqyHg1FClknQNTX4O9CZFrH8VV4WqhIBkrMJ
        /l0R45/A0ezjfSwCsQ1XHP/pdGt8/yhuFJJDC93O1slBJZHPfZfXkvZeExa/7y+zkXhr6g
        y7CPTr69vjiuczGY8JnRTJSW8Bwm7tILWv3AoKl7e+iKBm32yVhAZ8R0dZEN0xKVpBi2di
        GaERnEIfZUqCNZuYKSsjLTHcsMyTbV51sRIIU8YpiUde2L6sPcPt0K8yezQp3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637422733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tN5ewJXCTjSGUReagubKGCJLhvuBKJYqaDvPT1VNFOI=;
        b=4O9QxPt532dRQWlj8Mvx7yKTc4XvdDajTAE31D2w0W4fIFVIR5bBvO7l93R/PVPFsbZF9J
        kEuzXcdsy1aa66BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 7/9] locking/rwlocks: introduce write_lock_nested
Message-ID: <20211120153851.bhxg6xclqagovqiy@linutronix.de>
References: <20211115185909.3949505-1-minchan@kernel.org>
 <20211115185909.3949505-8-minchan@kernel.org>
 <20211119103516.24uhxrkdcy4vq25k@linutronix.de>
 <YZfrMTAXV56HFWJY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZfrMTAXV56HFWJY@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-19 10:21:37 [-0800], Minchan Kim wrote:
> > #define rt_write_lock_nested(lock, subclass)     rt_write_lock(((void)(subclass), (lock)))
> 
> Guess you meant #define write_lock_nested.

indeed, yes.

> I should have Cced you. Thanks for the catch.
> If it's fine, Andrew, could you fold it?

You are welcome. I tested the series in my RT queue and it works.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Thank you.

Sebastian
