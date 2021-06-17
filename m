Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D453A3AB406
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFQMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhFQMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:52:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:50:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623934198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJCHG5L9FgcmNBqUbBknyuX+5QElRmpUfzjgyYF9gyY=;
        b=oSEnYthPEl43ABFCdQvzF1Rf5VwwdPwSocJCdG42Rm8GGVeVBcmdSOkq2wv4fzV1qiQ04+
        8VESBPDTKL9IlZ/g/GH4FlIcx/Pq6fwIPAKQPHEJXRn01i/hqHU0tsVf7z0ADsM9Qm4G/D
        FH880b5PsfAwMT6uq03pcJVI7jGo9xb20ydSlOHyZl7RzM7ETchVA7DfK/moX1cY7eG/pF
        RpRu5FHEwnToUeKp2a/Xblxe5njl03wid16k5MG7VsaB0PL3chbT5rBlfQQ3XPL76fcDcP
        Ck8jrdW932uIg+yRu/Lob3IeCRTCYu9znuxsTxtvc6321DSiQniTbjWak6Ncvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623934198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJCHG5L9FgcmNBqUbBknyuX+5QElRmpUfzjgyYF9gyY=;
        b=DEvihgDSVs1ZKcpHwmMVYVZ6gLGRRwAx8LkvXJ6k3k7igiidjIGpmm4tBhvk6FRk0e5Unf
        yuaH6iAw3YSjaeDg==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 20/52] x86/fpu: Cleanup arch_set_user_pkey_access()
In-Reply-To: <YMs+cwXZGrEf2gI/@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155355.744726133@linutronix.de> <YMs+cwXZGrEf2gI/@zn.tnic>
Date:   Thu, 17 Jun 2021 14:49:58 +0200
Message-ID: <87pmwkfyfd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17 2021 at 14:22, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 05:44:28PM +0200, Thomas Gleixner wrote:
>>  	/*
>>  	 * This check implies XSAVE support.  OSPKE only gets
>
> There's a boot_cpu_has() check
>
> <--- here
>
> Might wanna convert it to cpu_feature_enabled(), while at it.

There's a later patch which cleans up the whole cpu feature mess of
OSPKE. That takes care of it.
