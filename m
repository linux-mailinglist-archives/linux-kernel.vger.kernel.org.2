Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76E3F0D33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhHRVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:17:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49794 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhHRVRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:17:02 -0400
Received: from zn.tnic (p200300ec2f0cc300211c4a214c0dafe3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:211c:4a21:4c0d:afe3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6457A1EC0531;
        Wed, 18 Aug 2021 23:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629321382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5Jw2kveDM2SS417lKpAjkrYFkktjHudu0c3Pm4p+Ug=;
        b=ZeMrARehJ4AK3R7C1saPV0z1UTEX4Z1L8FiiKkoziQ0IyqBl6C8djhhQQlUTb8Wq1DDLQu
        v+vanzbI0Oychv942XP4xdS3vVQSolVGUv20vOhpy/tO4cOP6xLVOj8mwxt4iLbbDsg5Ln
        KRGv6lFNMWq/mj1JKhx6oNToojfzoAs=
Date:   Wed, 18 Aug 2021 23:17:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YR14zq2LaExjhFR+@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5>
 <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 08:43:50PM +0000, Bae, Chang Seok wrote:
> Maybe I’m missing something, but I wonder what’s the difference
> from reading XCR0.

Wny, because adding another prctl() is too damn hard?

What if this modus operandi of features userspace can use with kernel
assistance but need an explicit request and are off otherwise, gets
extended beyond XSAVE-managed features?

You would wish then that you had defined a

	prctl(GET_FEATURES_WITH_KERNEL_ASSISTANCE);

at the time...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
