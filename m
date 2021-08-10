Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADBF3E5C55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhHJNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:55:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbhHJNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:55:18 -0400
Date:   Tue, 10 Aug 2021 15:54:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628603694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAm8+J0PoLsg3z7wkOQ5GEdMzf4ynZW7cGFbgngHFV0=;
        b=J8PVTxzmJS5zZvpLsrS4epEgaNpTWyri3l/p4h/m6X7s7jBW1RqzolQ8g+Sy0ilRsu9SIJ
        wdWRW6Ceq+BfnuSdeIig37kKfbsZErxTVaMB9Oq9diqsc4+iD0nWYAPMOhdpZLY1vg8TVK
        8c12zS1AGv9hQg9NRKxSig7v4C2tzvVAEYGLtTvNlHzAYpfJTsUF9LFOhUCYgv7iTJfHBD
        sMKmFtQjmupOBBbduA4yu/7rT2KxkzwThuUqZ/J7B8ipV/D+kWsCO9ABNM/kHk5OpFHJhW
        BpPj4FA6n5Uk0XKjZQ53sa4PYwn6eAXpb0LtxG+HHwIYgOkAPx71vnPA/80e5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628603694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAm8+J0PoLsg3z7wkOQ5GEdMzf4ynZW7cGFbgngHFV0=;
        b=wFRPF9vvb/EoGELIPU2LuoMzg35guhpd2aHt0hFLXhWJ89rAwpmN9VmScw7kUZ50LgfNdi
        SpBmHVvV46pANIAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [SPLAT 1/3] arm_pmu: Sleeping spinlocks down
 armpmu_alloc_atomic()
Message-ID: <20210810135453.roczkohgm2lzhg66@linutronix.de>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210810134127.1394269-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-10 14:41:25 [+0100], Valentin Schneider wrote:
> [    4.172817] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35

Would it work to allocate the memory upfront and invoke the HP callback
via smp_function_call()? That is implemented via the hp-callback. It is
invoked after all CPUs are up. There is one "memory allocation" per
"node". This does not change during runtime, right?

Sebastian
