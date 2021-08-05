Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6153E1099
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhHEIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHEIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:54:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49982C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:54:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628153650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3TzT5Xwpxi37WowC0BuHdZzU0mUOig+vMjN/xwaVU0=;
        b=ebmhGlMzaB2mPzw/QImcGBOvLwi635wvVaHBq80/ALry07PbjYIOJDQb4xZe8K8DzXQmTq
        IVZMAwllA3JbgwC/LR3I1Y54nCcqzMmk2maVBkgtGbGUp/cCG8psuWj0eHisMoAKOfz7lV
        aFWRE0iXtOsFlcrqs2TiMHfFGVdeBnZjEVCDnXxgIBVXT8qxvX6GMfth9CQgw3KPnTxgud
        mjzuwdf3R0Y5FsSlctK+zRTKx8o0AYXOJKNxRqd8HRON4X7uaJSlF/AU9GQDx6iIFFSmuu
        MP1K3fW/QsGy5gi1ZEm4e7kf0m1S5vG/gnVdyB9woNanzGwwB16T2akM/BIV9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628153650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3TzT5Xwpxi37WowC0BuHdZzU0mUOig+vMjN/xwaVU0=;
        b=4D8pXTVuZ4HEkQY31RMyDxdGxCJ+6iMUln82cb2U20t8MBofeoapboyfaPaT9eZchJcRM6
        3mY5dlMxM/ydexCA==
To:     Waiman Long <llong@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
In-Reply-To: <4fa5ec01-ff09-16f3-e1d6-42431036f554@redhat.com>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.865728220@linutronix.de>
 <4fa5ec01-ff09-16f3-e1d6-42431036f554@redhat.com>
Date:   Thu, 05 Aug 2021 10:54:10 +0200
Message-ID: <87v94k1dcd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2021 at 19:34, Waiman Long wrote:
> On 7/30/21 9:50 AM, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> + *   missed.
>> + *
>> + * - Non RT spin/rw_locks disable preemption and evtl. interrupts.
>
> "evtl."?

German abbreviation for eventually. Let me make that understandable for
non .de folks.

Thanks,

        tglx
