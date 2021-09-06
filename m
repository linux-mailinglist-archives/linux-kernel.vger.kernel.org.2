Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2A401CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbhIFOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:04:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbhIFOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:04:17 -0400
Date:   Mon, 6 Sep 2021 16:03:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630936991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V82Uwpv3QOioP6iJmT2eLZCDplcvuz7zEcrKt238Yak=;
        b=KSGdMI0L3H6fqJW1XOUMrFFJDYbApvVawSA3GOIM9qRyAoSXTlAyqwwaahBMPD5pJNI0sy
        VC05QUyjGWi9BnVxvSxxvleHkGTWSro2WJezT3BEWIlcj6S2c+kaStoF3mcuQ2iDr5x6yt
        ZgbA+UnTdhKyeSkef4Q+thKUKXfEqRW/lakeGu5XditdT2LIk4plSBuEh3/ZKObqY0f/hg
        3n+ms8Lle9ygta2kRZrAHYZiOyl9XFrjWM3soFTCwnNOQSLqaZFVlnVCi9Dnm8IZr2iLaH
        fHLUtUb9qvERfg/8JQAAbNWL9bDUKWbsPzrchZo2FamhKJeNn3csbZ76ZR9zkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630936991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V82Uwpv3QOioP6iJmT2eLZCDplcvuz7zEcrKt238Yak=;
        b=j+G5bVkaqjZXJs3YWO2DNVWe8eMgMAIr0mpkWqMF6Zlg5TpD6ChvYhj8Kf0oOY82UcRDOp
        1XaEQXcT78NV1iDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210906140309.oqru7oeozakq6bjc@linutronix.de>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
 <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
 <20210906134820.GA3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906134820.GA3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-06 14:48:20 [+0100], Mel Gorman wrote:
> Does that answer your question?

Yes, completely. Thank you.

Sebastian
