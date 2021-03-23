Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B07346BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhCWWFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhCWWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:05:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D06C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 15:05:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616537105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXf5WUmojrg88+CJmOpOyboq0UbIXmFs5CbuNmtgNGM=;
        b=hlDrqnffsH3YFWvkyzwcJvfqjVxXO7w9BayVKHnnHrjMHyyv2h8/+jWuVNcR2JbYZxweGL
        q4cZ/0r3aUzypmIFuZMq1BM9YSFVROKyxZH87kudtolJ6Tj1eiDIzhgv2iK5nG8C1DFZkB
        dQ7TYf0YgOzjtBgNPJavI4HgTcx2pB0H/gADmy6SxdONIqcZIYIT34pRP3qUA8NB6wUjOx
        E680dU9ocWEod8c6jc2j0e04qnSPYYLVuUYEULK41AUBgLgIWQNlK9daSe2dTocADXeLfs
        DZzD6JBZ2rPJxo/dx7R+oJdEZjfA8bxSj4Dqmi5zpDHNaRZMEQaPgDwAoKen/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616537105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXf5WUmojrg88+CJmOpOyboq0UbIXmFs5CbuNmtgNGM=;
        b=jFydoT97EXiTFw8wuYXZAGfJ9l2zCXgYG9PurUJ9fjZfwsnB/fsOfv9kOdlHvQm3jeQKU4
        8XQG2aC/lE6QoPCQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 12/14] locking/rtmutex: Consolidate the fast/slowpath invocation
In-Reply-To: <20210323213708.699640478@linutronix.de>
References: <20210323213019.217008708@linutronix.de> <20210323213708.699640478@linutronix.de>
Date:   Tue, 23 Mar 2021 23:05:04 +0100
Message-ID: <87mtutbk6n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23 2021 at 22:30, Thomas Gleixner wrote:

Ignore this one. I shot myself in the foot....
