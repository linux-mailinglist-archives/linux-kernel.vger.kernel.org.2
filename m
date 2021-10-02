Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2962A41FE53
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhJBV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhJBV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64714C061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 14:54:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633211684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC9kg6NXUREEeF0ZhGl0iRTpIXSRRucrcfoyN4mrzwY=;
        b=CnAGhaU2YPIuwxXK9Z6TQfaudnNuqiif//mgGE0Lor99m/xT2FOo0/jQoR17kpVl8WTkoT
        o2i7HuKZbrp5fVp6X++yNipUFORXpzZhSr+Yju9Fblu4ATkF3pSHHPvhvlhs5eutiJ/Jd7
        1DH2c1QaDcsFLUrHYcK/RsUouFaE99auHR+vs+Rf6P5Xrd3va9BK1E2BqrtvBY9y3R6yJE
        +pz7xub9T9WLrM9+xmo/n5zlx7YG7xpDhlBCNtHuDdMSpucvXafKThFxXBZOLlpDxtZfGS
        aFYPHTIqxlaIDX6FJF409UXowaPpE2PhVvpFb5pCp98fFMKP/tN24iBhZw5Fqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633211684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC9kg6NXUREEeF0ZhGl0iRTpIXSRRucrcfoyN4mrzwY=;
        b=hUcJA3UJ4q9yrS/rztfeB/flJdD4WxlROGojyz6rCslHXOOv6KzdeK7cQS8VnLDsbB9Ubx
        edANSBJ397PNZ4Cg==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
Date:   Sat, 02 Oct 2021 23:54:44 +0200
Message-ID: <87mtnrgkij.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chang,

On Fri, Oct 01 2021 at 15:36, Chang S. Bae wrote:
> The patches are built on top of the recent upstream x86 FPU changes [13].

which does not apply on:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

because the relentless x86 folks changed the FPU code some more...

You should know the drill by now.

Thanks,

        tglx
