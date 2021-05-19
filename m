Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632F389933
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhESWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhESWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:19:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F52EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:18:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621462677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nV6NgUefo2nH7QxJaek8cK1eUXir75HyDeTG1bZBI4c=;
        b=4BxRXUahXEvWlIcUn5wtii5rXwtCFtgSh7N/mMZgCSn78IjK453Pr0x3rjhXkTaPLYnKeS
        2k+eeTr8PmuBo2rRPfZWZD8iy//BiSrAPAblk0mdSIFJTDC+Zdn/Oihu9nmujqxOFKTd/z
        jtapjrCZwODjpn0xkf9r8cE2iS5IBCIvYaW+JPdYKdZkYwPJGbtJt2SJLnrN8hdylYSwrV
        ZMbviaMuwwSAB4clEnQEM6cn+kj+Osfed3vE5bVgZGSfIRCNzQ+Dx5BHTOTnslwCOEB7o+
        iTwlCAzyc8JDDzNovTJHanpzpU+/NsA8nyLOp25HRn/WwtCdI6FRj40fMpSMag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621462677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nV6NgUefo2nH7QxJaek8cK1eUXir75HyDeTG1bZBI4c=;
        b=gZlX0znP4Jz4LBkn2jni9cQc3Aw8KRper/BTkDgKt0k4V7t8brq0uhPHLli9ExaurS0C8W
        qP3btf2SnbLjkEAQ==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
In-Reply-To: <20210519212154.511983-2-hpa@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com> <20210519212154.511983-2-hpa@zytor.com>
Date:   Thu, 20 May 2021 00:17:57 +0200
Message-ID: <87bl96cqqy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19 2021 at 14:21, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> The x86 architecture supports up to 32 trap vectors. Add that constant
> to <asm/trapnr.h>.

Where is that actually used?

Thanks,

        tglx
