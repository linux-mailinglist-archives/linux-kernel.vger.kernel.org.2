Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B130AF7D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232863AbhBASf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBASe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:34:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:34:18 -0800 (PST)
Date:   Mon, 1 Feb 2021 19:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612204456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrXoNIIRoVZb8LEo0V1EIPVbx61Np28eklIJiSkcXlM=;
        b=cpbk+qW8SNZpDl4CtSUY5OwUK3hgoiQL/bPaJBdzHoHMmTeA9D9n0s3FfEmyR7DQi+BZoG
        jCxFeoBCAExTUW/BNOQeU+ogeXS9ipqm2pg5KoixIUhz/ubsV916/QwA5H/GkEona0tv9v
        6EhJ/Gtsv9leASAULiMy/oANBGJ3J4ZvJGcgQ5W74Hpt/phVCm0+8I0IM25WjiQKS61WRK
        80lpXvhHFGmRxc3fBoECbEerT+aOL4+1ckcyEdNzyFo5OZKmDaJKLzPu9zAhwKFx0+aPV1
        MY9aiZbMP6ofYgJUwHQoLpYZZv0QtgIClfwS1w00iKYhIu3LztLQogQOtgKtAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612204456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrXoNIIRoVZb8LEo0V1EIPVbx61Np28eklIJiSkcXlM=;
        b=jAHvB9+6utCiJL0cZN46U5oeESVewPaE9CqOicIpVlgOIwquVlDVLgwyXfyRo8KrONY/v6
        JLLtq3DNYj0GweDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 v2] tracing: Merge irqflags + preempt counter.
Message-ID: <20210201183415.cg22s3mdwwofy5nx@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
 <20210201182345.xcdcxxpa2bysbgzc@linutronix.de>
 <20210201133210.2fabed06@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201133210.2fabed06@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01 13:32:10 [-0500], Steven Rostedt wrote:
> Hi!
Hi,

> I'll let you know if your patches have any issues, but expect to seem a
> "for-next" post this week (if all goes well!).

Thanks for the update.

> -- Steve

Sebastian
