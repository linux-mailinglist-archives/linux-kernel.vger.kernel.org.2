Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D556346B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhCWVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhCWVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:47:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:47:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616536072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pe5BvbgFzE+YcvxOPzo66cIEToVGogi9SuCxc3L+cjE=;
        b=dpLX6jjO99L8SIMPHbfRKEhL29QySbO2Ux2kV9SHlwRM/UfjZt1SERQ82J62yJQ97EGYpV
        U89WwcNd9PNTZCKMo/hVbLgFvKV+qc2dXXIwUN3zjlO92H0aLbaSvGX2VqtdHRNmOA21cx
        QBdsX7+OExyXIRGMKA0lWmKmh4gxxzXtfP1m5WgJL8SdrO7N0HYTiwAEpAwwV4NlGBaAxq
        3sCrcro4BhIR5OY86zqPKtsZYgYCubdAkm5YyUSZCdOmass/zzS13U5RN6jdY6+GjaG7Z2
        RQMDT8nYttcpdFbBQZzHkDzl96jyk7LYYqxQhrHtysmXKM/nbjfQrV76T76U7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616536072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pe5BvbgFzE+YcvxOPzo66cIEToVGogi9SuCxc3L+cjE=;
        b=MYTcCi5disQ6Qr+3kz2oejowDiM2gLdgTCdOPFq0hN/Vi7DC9jmiu5nbSGXzOu44DaWWIf
        SUeQRvjSmPxU1+CQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 00/14] locking/rtmutex: Spring cleaning
In-Reply-To: <20210323213019.217008708@linutronix.de>
References: <20210323213019.217008708@linutronix.de>
Date:   Tue, 23 Mar 2021 22:47:52 +0100
Message-ID: <87pmzpbkzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23 2021 at 22:30, Thomas Gleixner wrote:
> While working on the rtmutex related RT bits we noticed quite some
> inconsistencies and bitrot in the rtmutex code.

Sorry, forgot to mention that this is based on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core

and also available from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rtmutex

as a combo.

Thanks,

 	tglx
