Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD1406CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhIJNZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhIJNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:25:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1594C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:24:38 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f070059e5c0f8ed8d1239.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:59e5:c0f8:ed8d:1239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFC3B1EC013E;
        Fri, 10 Sep 2021 15:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631280273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VwIDjvSAEZcyShtXbaCUqIqB8YqpksxdGrjyPfc0M+Q=;
        b=hWQszuVONK6ITVdzvuOgAbbDT+dwusyPMFU3IAHV4nF7XO6Q1ZyvCGljXrj8DbTyuJL9JT
        RNuywXZJukC67yctMwOl6naqV70fvD8tVlw77YitmSO9QnlRmkXaofBxv0/+wtAfMHnP/q
        MQLRWAZXu+MyXigyb/fZ5LcElOxaif0=
Date:   Fri, 10 Sep 2021 15:24:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2 0/2] x86/asm: avoid register pressure from
 static_cpu_has()
Message-ID: <YTtcjhrWS8e9VfWG@zn.tnic>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <20210909220818.417312-1-hpa@zytor.com>
 <YTsif1FeOEyFJnqc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTsif1FeOEyFJnqc@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:16:47AM +0200, Borislav Petkov wrote:
> Right, maybe I'm missing something but what is wrong with the immediate
> addressing variant, i.e., that thing:
> 
> 	testb  $0x8,0xffffffff89346eea
> 
> and you need to *force* %rip-relative?

To answer my own question after peterz asked: that hardcoded address
won't work with KASLR, ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
