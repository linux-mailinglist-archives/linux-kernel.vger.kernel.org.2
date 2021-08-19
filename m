Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014073F14AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhHSIAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhHSIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:00:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B241C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:00:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f6a004ea6615b49afdf70.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:6a00:4ea6:615b:49af:df70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC7211EC053B;
        Thu, 19 Aug 2021 10:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629360002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qnhA5cmtkd6svGydZQuQmhOhtjiS6e2nB/ckrDMGzMY=;
        b=rSdcwANU4JhC026Wfi1ElMwS1Lt13JctmcOb7HmrOu0VhLwSeoYClbV4C5q8l5M1WC9o67
        LG7U5o9ngVNiAdVinjaf/8ouR6vbPVSNvCdxg78/pkmdmk0k4UONI7UGEhuf/01OPutK/i
        xRFqEoICV8EiDPaZ6wN92UmqvTEQkQo=
Date:   Thu, 19 Aug 2021 10:00:41 +0200
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
Message-ID: <YR4PqVytqEwFV7X9@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5>
 <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
 <YR14zq2LaExjhFR+@zn.tnic>
 <FC0176FB-32CD-4E7D-8AC7-17452E40FDFE@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FC0176FB-32CD-4E7D-8AC7-17452E40FDFE@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 09:37:58PM +0000, Bae, Chang Seok wrote:
> What if it never happens? It will be just the same as XGETBV(0). I
> think on the flip side there is also a benefit of maintaining a simple
> API as possible.

Dude, why are you still pointlessly harping on this?

How is adding adding another trivial prctl which will be simply
forwarding XCR0 for now, making the API more complex?

If you don't wanna do it just say so - someone else will.

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
