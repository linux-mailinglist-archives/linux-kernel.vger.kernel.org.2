Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDB30685E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhA1AHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhA1AHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:07:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51920C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 16:06:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611792380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8wQs09UxnIAmjkNJYFTvqoZyZzqz9vFMoRAGLU2pUY=;
        b=PrDorPv8xSDZ+KmnFtt1+Tr8fBbhrZ/zimEIAbpJNu5wcdidAnLI13JUSBLb5NUUQQ8nWn
        cetHbjKqkCYXTBvUmN0Q8pcZocP27C7BUik9pHfuUFWQVZ7OzutB32W9qeXFsVmHwvH5qJ
        QDjP/FT3FYhqaoPrz2n9g/LD/beeuknktw04JUsXZ0fCp5u752U1EQahYBZjUkUSSoTzsh
        cvhyXu14YFdZL7zBvrEnAi/1bq5qQLp2eEn6EM8lUcdR7UlIDh/vAo8xmNG9aLdyAWsL9d
        1pJpQXd9Q+GU5cXGMA7iod+HVbVJ7n3ESqxwS3S1iv+GK5N+y5mMcLSK40Edcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611792380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8wQs09UxnIAmjkNJYFTvqoZyZzqz9vFMoRAGLU2pUY=;
        b=k+8j1nMwbBXmLiWcxrgrgtHJ9XwN26Un8X7D+ib+Pl63S6R8/o5n25cwjQaphJSCSjtcSJ
        NRz9wP4M2jMICcAg==
To:     Liu Chao <liuchao173@huawei.com>, linux-kernel@vger.kernel.org
Cc:     hushiyuan@huawei.com, hewenliang4@huawei.com,
        Ming Lei <ming.lei@redhat.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] genirq: Limit irq_calc_affinity_vectors to housekeeping CPUs
In-Reply-To: <20210122084746.3407372-1-liuchao173@huawei.com>
References: <20210122084746.3407372-1-liuchao173@huawei.com>
Date:   Thu, 28 Jan 2021 01:06:20 +0100
Message-ID: <87ft2mdiwz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liu,

On Fri, Jan 22 2021 at 08:47, Liu Chao wrote:
> Replace the cpumask used in irq_calc_affinity_vectors from all possible
> CPUs to only housekeeping CPUs.
>
> When we have isolated CPUs used by real-time tasks, IRQs will be move to
> housekeeping CPUs.

No.

> If there are too many IRQ vectors, moving the all to housekeeping CPUs may
> exceed per-CPU vector limits. For example, when I only have two
> housekeeping CPUs, there are dozens of IRQs on two CPUs, but actually one
> IRQ per housekeeping CPU is enough.

This does not make any sense.

Assumed a system has 256 possible CPUs and the device allows 256 queues
then each possible CPU will have ONE queue and ONE associated
interrupt. Nothing will change the affinity of any of those interrupts
ever.

The only way how the housekeeping mask interacts with multiqueue
affinities is when there are less queues and therefore less interrupts
than CPUs which means that one queue and it's interrupt is associated to
multiple CPUs. So the resulting affinity mask might spawn housekeeping
and isolated CPUs. When the affinity is set up for the interrupt in
hardware then the selection logic which choses a target CPU based on the
interrupt affinity mask will prefer the housekeeping CPUs and avoid the
isolated ones. But that does not cause vector exhaustion except you have
more devices than vectors.

So for a single multiqueue device a housekeeping CPU will not have more
than one managed queue interrupt ever.

I'm not understanding which problem are you trying to solve.

Thanks,

        tglx
