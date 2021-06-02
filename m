Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3203398EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhFBPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhFBPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:43:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:41:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622648513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2R/UCIsrDhh39+Ps2UcS5DyYiLCBXjWWE+/H8f4DC8=;
        b=JljiYd4pdDGsNSjgvLifiJZVUMvL6lIjEDi8hMIA98wmrPFM/PfvJyfbw6nskGxKyRhjwC
        9GBx7akslaM7Rf0uYG9uk5T8bAJ6To7ucmH3YKfpGdpACK/5wDvhjH6+ptp/Gh5i15f48X
        TWK3+ILN8ghc95FR4uWLG8hZ9uW7lJLGcfdSJrYJSBj7MdjwO7Gv4zdZAKaGyxNgUSQW+r
        +BwRjaM75QVz0fPcNcW9xYIF49MiX4QlTgF7QFWJTxvgWCQSYoxQgPdKWFvoqjW6nd2kQ9
        BLhq7FaeELxYlZ5wFlK/me/2tTLwSVN9AV6h1gEoYvFyUovRTkU62FkM4yVNSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622648513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u2R/UCIsrDhh39+Ps2UcS5DyYiLCBXjWWE+/H8f4DC8=;
        b=CxqOAb0efk8lcQdFRImWxc1FSeq5vhydfws55McceX6RffxB6GzGub2fNb/zvnihn7E6KF
        8RMwfSROWaBPbEBQ==
To:     houdek.ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/4] Move userspace syscall dispatch outside of common entry
In-Reply-To: <20210529081620.164422-2-Houdek.Ryan@fex-emu.org>
References: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org> <20210529081620.164422-2-Houdek.Ryan@fex-emu.org>
Date:   Wed, 02 Jun 2021 17:41:53 +0200
Message-ID: <871r9k1dfi.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29 2021 at 01:16, houdek ryan wrote:
> From: Ryan Houdek <Houdek.Ryan@fex-emu.org>
>
> This will allow other architectures to support userspace syscall
> dispatch without supporting the syscall common entry.

NAK.

This is in common entry on purpose and won't go anywhere else. The every
arch has it's own broken entry code ordering mess needs to go away and
not proliferated further.

Move ARM to common entry first.

Thanks,

        tglx
