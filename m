Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1C42D4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJNIaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:30:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00731C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:28:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c72004cd8e1678c0b16c3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:4cd8:e167:8c0b:16c3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FE331EC03EA;
        Thu, 14 Oct 2021 10:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634200080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+xlMsCTXETwM/qF1Rivq8W06GWg5T4rziG9VXU3Gh2E=;
        b=Hc6lZ/42+NquxuBUcHzIl2hPxgube6aDBEijG4v7jekL/7qqQa/QH2WwZXdyr4sVgriEfA
        bBFeqt92PFctlKIpvdemvTGjk0oLkYcaz9OOfDejbYgKSUcnAVoIrrE7GsZcHIQe7huf6k
        BkxHJZ9N15gSYIEMbBh3Xfo9nOMbrrQ=
Date:   Thu, 14 Oct 2021 10:28:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp
 check
Message-ID: <YWfqEIaCKOwSWGHF@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
 <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:36:14PM -0500, Noah Goldstein wrote:
> Ping2

Why?

The original patch which added this abomination:

2f7726f95557 ("x86/fpu: Track AVX-512 usage of tasks")

says already:

 the tracking mechanism is imprecise and can theoretically miss AVX-512
 usage during context switch. But it has been measured to be precise
 enough to be useful under real-world workloads like tensorflow and
 linpack.

 If higher precision is required, suggest user space tools to use the
 PMU-based mechanisms in combination.

and as you've noticed, the high 16 regs would cause a false positive
too.

So what is the actual real-life use case for this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
