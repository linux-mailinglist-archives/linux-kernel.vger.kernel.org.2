Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8F3E43BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHIKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhHIKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:19:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 03:18:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628504320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcLoIG3HGYk//UUYYRZEh/brzBYA8yS/UBc0wd4yoLw=;
        b=Nqb0TyHf9m8AFz3BhgMa4hJNlf2wNv3qXL+nk0e6Di8YjuRMnM6TQI0BomlPLAs5FyaW9n
        0eOVL+AX2+6GKVAjXeON4G9bY7iO1hOyHPljFf7OyNxchZZJPwEn7CFL2wNgMMQgVj+yW4
        lWKUos9t5eAnwvEkNh3DM5E0uRiEl/bO4hkU+a6feVhqaHtuAVd9EcrxRDTt8/yJw6nrSJ
        J/iVIDX9V8Mw4y+fHQYDwQWybd7knyK+u1tT6HGq0RTfqJZgUsC2POclVSjjyX+ndcYl3L
        U0XnNUZ32MKLU+/DwAsPVuu+afZWdEOD+cKUtElistQdfV/2lXOYVTwIb20lhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628504320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcLoIG3HGYk//UUYYRZEh/brzBYA8yS/UBc0wd4yoLw=;
        b=bYSoL7Xm9kZ9+5HdvQNGqzKvbI68F69CkBoObsBfKgqbmiDmGq+ny8EIlCp9wMPo0qZFLM
        OmPi5Jxumm0E01CA==
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 15/64] rtmutex: Provide rt_mutex_base_is_locked()
In-Reply-To: <20210808204116.rckeqq7hu4ofbitg@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153953.683678014@linutronix.de>
 <20210808204116.rckeqq7hu4ofbitg@offworld>
Date:   Mon, 09 Aug 2021 12:18:39 +0200
Message-ID: <87fsviudj4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08 2021 at 13:41, Davidlohr Bueso wrote:
>>+/**
>>+ * rt_mutex_base_is_locked - is the rtmutex locked
>>+ * @lock: the mutex to be queried
>>+ *
>>+ * Returns true if the mutex is locked, false if unlocked.
>>+ */
>>+static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
>>+{
>>+	return lock->owner != NULL;
>
> Does this want to be READ_ONCE()? While not a big deal because
> it's ultimately only used by drm debugging, I don't see any harm
> in avoiding potential tearing.

Makes sense.
