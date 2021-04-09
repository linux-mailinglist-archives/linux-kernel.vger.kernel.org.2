Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113543598BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhDIJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhDIJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:07:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6BFC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 02:07:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0be10048f842a34b65c796.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:48f8:42a3:4b65:c796])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C85051EC030D;
        Fri,  9 Apr 2021 11:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617959262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t4PipJRxNW7hV1bpmymrmsyDv4ybS5qWPJmGY6G7EJE=;
        b=FBkJARK9rCDTs5NBsSLfh6Wu+49wcFoDH2A4YmlxuR2VeJom3CVtMIi8dewAyAlWzZJVQj
        eoaI0CZHYs/5GtJmaKJuCKG5EKj1X+obM4udvKwEFvtFuFlaWnlnKd7MqNWcOnBVx/jF6N
        2WJtu14wnh8Bi50ZxNn2tMfV0vgCkP8=
Date:   Fri, 9 Apr 2021 11:07:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Saripalli, RK" <rsaripal@amd.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
Message-ID: <20210409090746.GB15567@zn.tnic>
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210407223905.5dqgzdaibvgq7jeq@treble>
 <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:56:47AM -0500, Saripalli, RK wrote:
> It is possible most applications have been reviewed and scrubbed for
> SSB-type attacks but PSF-type issues may not have been looked at yet.
> This may be one of the cases where SSB is enabled but PSF is disabled
> until the application(s) are scrubbed for the same.

Right, and for that I think we could do a slimmer version of the psfd=
toggle - no prctl and seccomp stuff - just the cmdline disable thing to
keep this simpler.

Btw "psfd=" is maybe too short and cryptic. It would probably be more
user-friendly if it were called:

predict_store_fwd={on,off,...}

or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
