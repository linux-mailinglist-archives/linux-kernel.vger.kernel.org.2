Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94A45A67D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhKWP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:27:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhKWP1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:27:15 -0500
Received: from zn.tnic (p200300ec2f13430015d1cfddfe801d3a.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:4300:15d1:cfdd:fe80:1d3a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F8801EC01B5;
        Tue, 23 Nov 2021 16:24:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637681046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vMW7f6dnsF7bawjgP9+1aDGr0cq0qI2aDRVsJuFs7X0=;
        b=HrNdzLA9fy4EXTptaUmG5dPGiXBdT6JmmcwBQVIgcntm1V1ExlQWGKeYy6mPYzBHUeZeSn
        Nkqf9tjlNndJGwQIadIEZV9vPRIDPgTvZuPD3tSuOuq4R6BXww589GcLftKo6CYjN/otZ6
        jATPU2Nv1z1upqzGIFtA8XlYUIoSSvE=
Date:   Tue, 23 Nov 2021 16:24:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com,
        tglx@linutronix.de, fam.zheng@bytedance.com
Subject: Re: [PATCH] x86/purgatory: provide config to disable purgatory
Message-ID: <YZ0HkaOiKfmgN8zl@zn.tnic>
References: <20211123150508.3397898-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123150508.3397898-1-usama.arif@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:05:08PM +0000, Usama Arif wrote:
> This can help in reducing boot time if purgatory is not needed
> as the sha256 digest of kexec segments is no longer calculated
> or verified if the config is disabled.

I'd prefer a commit message to say:

"Disable purgatory because of real-life use case X. With it disabled,
booting a second kernel is sped up by Y."

"Just because" and adding yet another config option is not worth the
effort, otherwise.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
