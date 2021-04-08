Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11277358E44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhDHUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:23:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1031C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 13:23:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i190so2669098pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z3faoKTmut0b+H791nuk4RfV65azdQNFfXkzkcIwqc0=;
        b=WRM0NK6ahXYlnABx14y7wNAK3ARCzvs0N/LziWW63jFcLOiDNLmHoTPnoSvXx0213d
         pR3G6T0GwBHwUs6TmBDWUgy5YbuWK4Bs00EXAk4qPHrn5x+53iHoJebQDf/qydGaOuy4
         r/2+W3hXp0YpWxEGMPVQb+PgZJIRZiSUSgZWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z3faoKTmut0b+H791nuk4RfV65azdQNFfXkzkcIwqc0=;
        b=C9Beg+uqMPsvhKVUgpghgLO2ideXELQ4oKLVpTd4Kjk/AdJW3F2re3+q44HbMtrSak
         +DSi307+BFAaPFaGvkwvUVcsaMGAzLy1SYJ3DU3OGkHqkkc3lFlkbcaDIKyJDykGq0nx
         fFYGn/eRr5svzU1s5muKQpFCawRQ6Jv0JrVzYY4C772kL3MaTLRBDQ7KJWoip6P5T9fo
         Qoes6CSyQI6aMgb5CdPNzLSpdNCiYYgeBbXnz6K5owW7wHMkyHydU7R4pGIGtb22vbpG
         WjV0LQwTWauB25KxF3Ke6ILy17NsSXKm8uryZ6PHRy96EVuCWr7y6PIF/Xh8vneQNCaz
         sjVA==
X-Gm-Message-State: AOAM532BEKfH7Lhllqvs7CBYh57cSEYgh8tpMATcIU3Jhe/prZkul+m1
        2cGmGceDTp48I9Zfqnc2Y3x89Q==
X-Google-Smtp-Source: ABdhPJwikjY5mYNumVBeOvl9nb1vrSmCejkIvfWzfM9oyVhjxY6mmboeM4PRRBSUW/bImmTkznfG1Q==
X-Received: by 2002:a63:3244:: with SMTP id y65mr10002081pgy.197.1617913388148;
        Thu, 08 Apr 2021 13:23:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h19sm283747pfc.172.2021.04.08.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:23:07 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:23:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Singh, Balbir" <sblbir@amazon.com>, tglx@linutronix.de
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Message-ID: <202104081319.DAB1D817@keescook>
References: <20210108121056.21940-1-sblbir@amazon.com>
 <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread necromancy*
https://lore.kernel.org/lkml/20210108121056.21940-1-sblbir@amazon.com/

On Mon, Jan 25, 2021 at 09:27:38AM +0000, Singh, Balbir wrote:
> On Fri, 2021-01-08 at 23:10 +1100, Balbir Singh wrote:
> > Implement a mechanism that allows tasks to conditionally flush
> > their L1D cache (mitigation mechanism suggested in [2]). The previous
> > posts of these patches were sent for inclusion (see [3]) and were not
> > included due to the concern for the need for additional checks,
> > those checks were:
> > 
> > 1. Implement this mechanism only for CPUs affected by the L1TF bug
> > 2. Disable the software fallback
> > 3. Provide an override to enable this mechanism
> > 4. Be SMT aware in the implementation
> > [...]
> Ping on any review comments? Suggested refactoring?

Hi!

I'd still really like to see this -- it's a big hammer, but that's the
point for cases where some new flaw appears and we can point to the
toolbox and say "you can mitigate it with this while you wait for new
kernel/CPU."

Any further thoughts from x86 maintainers? This seems like it addressed
all of tglx's review comments.

-- 
Kees Cook
