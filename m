Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27D3977CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhFAQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhFAQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:16:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A160EC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:14:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e1so2875770pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HnyeiFGGaM1+1pZ7M3NiT7LE1UhO/QICF92CFaIJJ4s=;
        b=lxTcsSXC8WaRn4itmjpibCtk+TgTlO9fZHzUgi371vg3lej7TxV83SPMYxbtl52eXB
         7E+kkcJyOdDaG6ArydsaOGjTPi6ImuxjRzF8Tz3HFW58WSoD+qvxvRq11rskjqDiT2HZ
         tSUCNpEN9qYo08Cv6jAKuiu+AKN5HT1jASEJdJTMWUspRQTRCJy5wd1AStcELidWGvEw
         RzMBRfSXdOdqSjdxO93GHCzDkR8OjJLluR/Rl+hydWyGot7KcKeYoFGk5aooE1fUWQp7
         Yq85q1XowM7InIu13pZaSPDZxjsaihmeeDMFKpl2rxa8CoO/kkyA9UlD3AkdP9pvoZP4
         uNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HnyeiFGGaM1+1pZ7M3NiT7LE1UhO/QICF92CFaIJJ4s=;
        b=VaCl1fSPts7nMdSMSNmUMsj0LtxxHsZ52/JZKSQjMOj49+btUie0rMYWrFmkEyh4St
         OmJf+B2eRzzfJOsBLwqSI/NYMXYg5v+Q3ci85diuDgtc5vA0G7I02ogDpypE6LSm4ZlG
         BO6dstustYpPhMfDP37b0Ft6KBGRQNpdaeDSz7GjrnGKbHqnXn1j4Df1tPpN6+Uc0X+T
         pZksFOyJSHeljYltMOwQP17KkwaqYW3FWoHTOxo6cmSbDz/6GbL7BRgGwktAfg6qFv26
         k/SB9eCeaf2Uc19ffkOLToTUyeecPKKhr/iiVZX8/33PAoHIkve9gCtjwjM3eiS26kA3
         kDjA==
X-Gm-Message-State: AOAM533SLHauzeKr1FPnyXpYzUzemANBc92RUqYcxJwco/lPRZwX3ZJf
        GMc+a6DGcrUX5NG9qRNiKqIijg==
X-Google-Smtp-Source: ABdhPJymgNGA7XMkvK8yrNNyGR+rN2EEGFDcV9XRM/bv9x954aq4gFoBA7mIygVlIrtgZJaoY3YP3g==
X-Received: by 2002:a17:902:9006:b029:107:394a:387 with SMTP id a6-20020a1709029006b0290107394a0387mr6125645plp.35.1622564066892;
        Tue, 01 Jun 2021 09:14:26 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t5sm2458443pfe.116.2021.06.01.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:14:26 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:14:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pu Wen <puwen@hygon.cn>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, joro@8bytes.org, thomas.lendacky@amd.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        sashal@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/sev: Check whether SEV or SME is supported first
Message-ID: <YLZc3sFKSjpd2yPS@google.com>
References: <20210526072424.22453-1-puwen@hygon.cn>
 <YK6E5NnmRpYYDMTA@google.com>
 <905ecd90-54d2-35f1-c8ab-c123d8a3d9a0@hygon.cn>
 <YLSuRBzM6piigP8t@suse.de>
 <e1ad087e-a951-4128-923e-867a8b38ecec@hygon.cn>
 <YLZGuTYXDin2K9wx@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLZGuTYXDin2K9wx@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021, Borislav Petkov wrote:
> On Mon, May 31, 2021 at 10:56:50PM +0800, Pu Wen wrote:
> > Thanks for your suggestion, I'll try to set up early #GP handler to fix
> > the problem.
> 
> Why? AFAICT, you only need to return early in sme_enable() if CPUID is
> not "AuthenticAMD". Just do that please.

I don't think that would suffice, presumably MSR_AMD64_SEV doesn't exist on older
AMD CPUs either.  E.g. there's no mention of MSR 0xC001_0131 in the dev's guide
from 2015[*].

I also don't see the point in checking the vendor string.  A malicious hypervisor
can lie about CPUID.0x0 just as easily as it can lie about CPUID.0x8000001f, so
for SEV the options are to either trust the hypervisor or eat #GPs on RDMSR for
non-SEV CPUs.  If we go with "trust the hypervisor", then the original patch of
hoisting the CPUID.0x8000001f check up is simpler than checking the vendor string.


[*] https://www.amd.com/system/files/TechDocs/48751_16h_bkdg.pdf
