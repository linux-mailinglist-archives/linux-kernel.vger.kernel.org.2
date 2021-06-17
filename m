Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB03AACF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFQHIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:08:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:06:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623913561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/us2VM6CSPxtFPwLATOF6WGu7jiGk1WUByzJFHHZFi8=;
        b=LAeKYy003ljsqgHWhHqeVAIEt1RBYV0jnHV0xHj5M7Lv5l9XiJ0KzkbFxAJCLMCxHJmV7g
        rNLr/1f8Phz2yKTsFsaoCgakvvWu6W183/Ge2YNJ51H7dlw42nFO5TR+HiKQJxcwiTlZzk
        UFqxTdCgT9lqZmQLgJZBdk7Yh+K/Dwm8oud6X7O3S3ZXfREKTMgWs7rJWtEIXdtr3H7wZv
        osGjoxpfqjgljMLAKDTwersZ+kY4uSqC9RQRpK3EMa5q5xnH12euNtAD1oai08Fk+wFMal
        cowLEWC6iZAuE+brEa6bWkfGMD9JwsaWiyXwOJtvVPPhXufsPSRN0ff+XHykFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623913561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/us2VM6CSPxtFPwLATOF6WGu7jiGk1WUByzJFHHZFi8=;
        b=Foww9Fg0Sq8QuDByyyaFVZf8qUQEEh7X9LFRN5HdCAcdZIyyV05DnX8d6ow1ZK4Nw9voKf
        XAikpJghNOpEOECQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 00/41] x86/fpu: Spring cleaning and PKRU sanitizing
In-Reply-To: <568af01e-db7c-8207-1de6-efaff318e2dc@intel.com>
References: <20210611161523.508908024@linutronix.de> <871r98vsjy.ffs@nanos.tec.linutronix.de> <568af01e-db7c-8207-1de6-efaff318e2dc@intel.com>
Date:   Thu, 17 Jun 2021 09:06:00 +0200
Message-ID: <8735thgecn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16 2021 at 13:55, Dave Hansen wrote:
> On 6/11/21 5:24 PM, Thomas Gleixner wrote:
>> Making the kernel to pretend that all of this is consistent under all
>> circumstances is a futile attempt to ignore reality.
>> 
>> This inconsistency can only be fixed in hardware/ucode. End of story.
>
> I agree with this.  If it's going to be fixed, the kernel simply doesn't
> have the tools to do it.  We either need new ISA or new hardware/ucode.
>
> I'm just not convinced it's worth fixing for PKRU.

Me neither.
