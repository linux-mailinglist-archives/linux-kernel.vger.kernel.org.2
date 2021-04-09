Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D157E35A7C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhDIUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIUTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:19:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:19:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0be100a8e90a67ff2fdfe0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:a8e9:a67:ff2f:dfe0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87E261EC0402;
        Fri,  9 Apr 2021 22:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617999565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1GiJOX0Gl/8KHVrhl2oRx1wpfXOmRHeV7lAk5gotfA8=;
        b=eSTW+Y1GjOgkKRLNjSzlnaFLyItDdd138JllthDrujqNRZG2Zp6J5ZrywKTNf8/rtQKzJd
        ToH2aKEogrAmDKctxa00F84huxpG/b81pZf/sYm87zna5HmSyDwMUXyQORee89+KU1L5g8
        SuiedlH/z0kfVBOYHyNIkLXcBSRkuUU=
Date:   Fri, 9 Apr 2021 22:19:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/5] x86/cpufeatures: Define feature bits to support
 mitigation of PSF
Message-ID: <20210409201924.GJ15567@zn.tnic>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210406155004.230790-2-rsaripal@amd.com>
 <20210409174134.GH15567@zn.tnic>
 <cc5476c9-fe4e-6b4c-d323-37b90237b32b@amd.com>
 <20210409193929.GI15567@zn.tnic>
 <9dea10b1-bbac-3ed2-6255-8453570d857e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dea10b1-bbac-3ed2-6255-8453570d857e@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:45:23PM -0500, Saripalli, RK wrote:
> Yes, these options should be fine for now.
> Like you said, if we get the need to add prctl and seccomp, I can always do that later.
> 
> What do you think auto should default to?. 
> In SSBD case, I believe auto defaults to prctl or seccomp.
> Since we will not have that here, we should choose something for auto.

Or not add it yet. Just have "on" and "off" for now.

Which begs the question should this be controllable by the mitigations=
switch too?

I wanna say, let's have people evaluate and play with it first and
we can add it to that switch later. As long as we don't change the
user-visible controls - if anything we'll be extending them later,
potentially - we should be fine usage-wise and from user visibility POV.

> All the other mitigation x86 mitigation code goes into kernel/cpu/bugs.c.
> I think psf_cmdline() or equivalent also belongs there and not in kernel/cpu/amd.c.

It being AMD-specific, it can dwell in amd.c initially.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
