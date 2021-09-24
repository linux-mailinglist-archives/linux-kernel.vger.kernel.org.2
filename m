Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756DF417182
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbhIXMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:10:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbhIXMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:10:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632485331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBUHTNr0sCPxkBiTM2SkIyDC24mPjzNNzFCj27YDFMU=;
        b=lx6uytudcp0xd/4w8tORhQm6wFFb9F0vYhX34CIpAjqTNkEndcxY3JGtQntf2xOiJDLJdV
        hSKxoWbbTmJz7Bpp7vDBUXMdvneK00gZtsLtSAGzxE2Nbfbz74qml5P1JT7MyQW0Fb1hrZ
        A/lGUcR50kOu/jvgOvpmf/QcexiAROT/OmRHk31TlaKbdqwQPuGr3qrR0lutUmaov45Qez
        admV9fVIY0z3SEx9AoLRJBHo5aCn8hNGEn9mRDFFYvzbFT+zDoObS3fZAVm0MBssKcPlQI
        1PK8c578h8ND1hUzNeLSXd4CKqdun60nrrQ310WtEnnD5b6p1ch3swgdl4kc2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632485331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBUHTNr0sCPxkBiTM2SkIyDC24mPjzNNzFCj27YDFMU=;
        b=4n7ArgCxkJXLSq4ISErp2O0BC9f9yksbARwk8NCmVGD2Q7dm7tZqeEEgBlWb8xYHQsfCwj
        9Cn+bMRMSlCqyHAQ==
To:     maninder1.s@samsung.com, "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Chung-Ki Woo <chungki0201.woo@samsung.com>
Subject: Re: [Issue] timer callback registered with mod_timer is getting
 called beforetime
In-Reply-To: <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
References: <CGME20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
 <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
Date:   Fri, 24 Sep 2021 14:08:50 +0200
Message-ID: <87mto2dvl9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24 2021 at 12:23, Maninder Singh wrote:
?
> As we checekd code if CPU responsible for updating jiffies value(lets
> say CPU0) has interrupts disabled for 60 ms and in mean time other
> CPU(CPU1) registers new timer for (jiffies + x) value. its callback
> will be called before time.

So you run some stuff for 60ms with interrupts disabled and now you are
asking what's wrong?

The answer is simply: Keeping interrupts disabled for 60ms is wrong.

Anything else is just a symptom.

Thanks,

        tglx

