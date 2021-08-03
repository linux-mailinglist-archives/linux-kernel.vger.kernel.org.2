Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD103DE982
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhHCJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:11:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhHCJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:11:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627981848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0e1V83DRnq45barRIX7U2iw+ml0PmmTYTnV26l3rBs=;
        b=Sr1L1WEASFCJDmSXDlG25EL+i3yLIPl12I2e+V3smXaEutThh+bPh2DWnc5YPMN4Mz6MRU
        QMnHWj08zTCeAr6EyE3b9U7vb8TxLJ7UwTnuAdtAXbZtflicEeSiiqF2v9wOePuNunRlIZ
        OP3knmdsTqfuJCO/lIkie6WyAesMKfOaycCT7IVeRc4v68wwY6kShdWq7KfmOGv6wTeYbW
        NZMLaDnyHmUcsDKmv70Sa8CVGIh76MZMT8+BzrtMp9F4NJgR668uTsO3vzD2QpeVVhEv5Y
        B+LO1mhUKG5q9PvKOybhMUQUDrcVsVvRXoDPV1lM1/+yQka5F/+fm/MhOZtzlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627981848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0e1V83DRnq45barRIX7U2iw+ml0PmmTYTnV26l3rBs=;
        b=yVGSEp+Z9Na78B9pSd6QUS3mPmZNvWai0sTEbEOSVI5RnZ9Veu4xXr9DgDhd4WbKVaUwz2
        7reL1S+W3UxyebAw==
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 30/63] locking/spinlock: Provide RT variant
In-Reply-To: <20210803063217.2325-1-hdanton@sina.com>
References: <20210730135007.155909613@linutronix.de>
 <20210803063217.2325-1-hdanton@sina.com>
Date:   Tue, 03 Aug 2021 11:10:48 +0200
Message-ID: <874kc6rizr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2021 at 14:32, Hillf Danton wrote:
> On Fri, 30 Jul 2021 15:50:37 +0200
>> + *   The RT substitutions explicitly disable migration and take
>> + *   rcu_read_lock() across the lock held section.
>> + */
>
> My stupid question is how it works in scenarios like spinlock chain
>
> 	spin_lock(&foo->lock);
> 	spin_lock(&bar->lock);
> 	do something for foo and bar;
> 	spin_unlock(&bar->lock);
> 	spin_unlock(&foo->lock);
>
> with rcu read lock held across the lock protected section because rcu
> lock has preempt disabled and that will disallow scheduling while acquiring
> the inner lock.

If CONFIG_PREEMPT_RCU=y rcu_read_lock() does not disable
preemption. This is even true for !RT kernels with CONFIG_PREEMPT=y

Thanks,

        tglx


