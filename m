Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9463B3E91CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHKMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHKMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:46:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E6C061765;
        Wed, 11 Aug 2021 05:45:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628685950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCpkyCL2jL7bhg6eDjuKk/Kf51Pu5Hl+bvd9h/wak9g=;
        b=W7p88CPKZqsvxAK3Hj+47LAftzdOpWUZdHscB2I7/9tLPrdSGcyUlfri8AFRn9fv2JFdtk
        tCeBRnkTUXP8bacEUysZXBanzvriSj9RVcyUkockpIEZFpPqxnh3yCHIBfFwQtOCKvP2yH
        a21k+s+K+khlW0lDUsHpwE+VA7ieze7SW6XG7RlzvIhf8ZDhL6Hr57RyVDeg5pjPKEN0MR
        X7cTE3V1+/fKnxzclHhckROQFitQk5QaAwnGpXNHUIwEkDzMYfiLF4vo0FvMdawwLmUdFB
        CBVTizNeYVUERCZ28yQxNqen6TC/TeWzsT1zK5DEZZx6pZNZco4i+Y7yZo7DGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628685950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCpkyCL2jL7bhg6eDjuKk/Kf51Pu5Hl+bvd9h/wak9g=;
        b=B6s0W/HvX6BNStkRgBQYBwonNVXZaP2U1nnC3GEybT2kFFi23Xa7PF/0ApW8LXpgcRa56F
        A+XqT0/g/0+sriAw==
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        vincent.donnefort@arm.com, valentin.schneider@arm.com,
        peterz@infradead.org, mingo@kernel.org, rdunlap@infradead.org
Subject: Re: + kernel-cpuc-eliminate-all-kernel-doc-warnings.patch added to
 -mm tree
In-Reply-To: <20210811043016.-ahQ6%akpm@linux-foundation.org>
References: <20210811043016.-ahQ6%akpm@linux-foundation.org>
Date:   Wed, 11 Aug 2021 14:45:49 +0200
Message-ID: <874kbwp2te.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2021 at 21:30, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: kernel/cpu.c: eliminate all kernel-doc warnings
> has been added to the -mm tree.  Its filename is
>      kernel-cpuc-eliminate-all-kernel-doc-warnings.patch

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=smp/core&id=11bc021d1fbaaa1a6e7b92d6631faa875dd40b7d
