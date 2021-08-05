Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6312A3E109E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbhHEIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbhHEIzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:55:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4056C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 01:54:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628153691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXMXkb4mqVmF23Xi/rg6KEeycFTZgGmjVtC8KIvAYGU=;
        b=K5BHfS04Wv8CYuzFihlNWWxEK/29uU8MYU2RQceZhdNXAmYgdRCCkxcpeKLTpGHR5y1rlu
        nowVWZXh1Nf1JMguj57KBht/4I2UL0ooOKSa40wBwTWQBgqDOG5GtBVILd3BtJ1QYvpNVh
        bskCu77DWKziVVJvbTt/2bJhQkrxU6eGwZ6fl7usRynTQn+gUngpfsSFziSeh72X7DbXRb
        OlveMFEVX8QegCCL1YlS5aADRzykLJvouiO+Qesy5LkTitwJoKZlFcGgDN9kFv8S1Y+BmR
        m0A+XOAuuc4ynhJsmDPDU3lACXtUo6WqZRAs407A+y4MVHpj9ZYl3E5J5GX76g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628153691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXMXkb4mqVmF23Xi/rg6KEeycFTZgGmjVtC8KIvAYGU=;
        b=prAh1bTut8ioHIt1yIW+zm7m1tg+RgvZUaJnzghvZucXQjb0tqMXnq+TYbPN0QNV87L1l8
        ShqkxoLD89x5HHDg==
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
Subject: Re: [patch 22/63] locking/spinlock: Split the lock types header
In-Reply-To: <977ef5db-17b4-646d-cbb8-b0ca301b55ea@redhat.com>
References: <20210730135007.155909613@linutronix.de>
 <20210730135206.416779376@linutronix.de>
 <977ef5db-17b4-646d-cbb8-b0ca301b55ea@redhat.com>
Date:   Thu, 05 Aug 2021 10:54:50 +0200
Message-ID: <87sfzo1db9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2021 at 17:17, Waiman Long wrote:
> On 7/30/21 9:50 AM, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>   
>
> Most of the code in spinlock_types.h are moved into 
> spinlock_types_raw.h. However, macros like SPINLOCK_MAGIC and those that 
> followed are not removed from spinlock_types.h in this patch leading to 
> the same set of macro definitions in two different files. Should we 
> eliminate the duplicate macro definitions either from spinlock_types.h 
> or from spinlock_types_raw.h?

Right you are.
