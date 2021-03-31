Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF153509D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhCaVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhCaVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:54:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB98C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:54:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a12so6638958pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtsfbkg65ln578BueP2qKUJ2W4TVYylDnpFNvn0AmZY=;
        b=lFIjHUpJ6J2bChkAW6VFomn72sxkplIQywWFLHMael4kNCA63jvDhP8bxintcnt5bw
         KQBjDW0tdgan1Mw+ew9YOivDWjvq1y/RLhovgps8HPve8vSaz1UqvITEKhuq5UCgL/Wz
         NM80b1+1PpQm7Vs1o0Fx6Yx2NIh0Uno3lLAkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtsfbkg65ln578BueP2qKUJ2W4TVYylDnpFNvn0AmZY=;
        b=DwLHlKGZO+Ul7X9Cd47Dx52RpaA2uDg1sl6jcu2GI1UrK2SOV1OzguCSFkSH57ofWQ
         w0Z6zUE/4UDNtY4zH3qvXUxVBr2PoILIRHSpFn900rNsZI/uJ4O6l3RSX40flQqkxni2
         TdsGWOxZ0yiR7t799HON0SAeGT4oHUCxSke85vCt/ZregEm37I7Oe0aGlTOUA1L+5kAB
         AvMZsNUylVjhBg2Hgm+mxHlq916xm/AToLSIv6aRWpvJTmvLr1XbzOO/IRsKGojnyd9p
         ziWnOrOqNgRZcJbEGsFg0lYXTI6yEm4v7CzTAM2+OisAnq1O8xWJdM1/WlKxbGwcJrwV
         sSxA==
X-Gm-Message-State: AOAM532Xf6JFwIpYUdyMQWuRPoh5TwPMXvpxLfjykHOSRHPtoXbTnEcB
        AvoGLkRBF5ryCzELnagQDGTrhQ==
X-Google-Smtp-Source: ABdhPJy+ITLzRDWVQZ4QLokxo3xwGBU2j8b+z7YKdSsnEN/k5kQuDOdpvQny/ml71yhjeB4NsIqJiQ==
X-Received: by 2002:a05:6a00:22c6:b029:201:1166:fdad with SMTP id f6-20020a056a0022c6b02902011166fdadmr4839743pfj.58.1617227698663;
        Wed, 31 Mar 2021 14:54:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm3199222pfl.191.2021.03.31.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:54:58 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:54:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202103311453.A840B7FC5@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <87im5769op.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im5769op.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:53:26AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 30 2021 at 13:57, Kees Cook wrote:
> > +/*
> > + * Do not use this anywhere else in the kernel. This is used here because
> > + * it provides an arch-agnostic way to grow the stack with correct
> > + * alignment. Also, since this use is being explicitly masked to a max of
> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> > + * "VLAs" in Documentation/process/deprecated.rst
> > + * The asm statement is designed to convince the compiler to keep the
> > + * allocation around even after "ptr" goes out of scope.
> 
> Nit. That explanation of "ptr" might be better placed right at the
> add_random...() macro.

Ah, yes! Fixed in v9.

> Other than that.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you for the reviews!

Do you want to take this via -tip (and leave off the arm64 patch until
it is acked), or would you rather it go via arm64? (I've sent v9 now...)

-- 
Kees Cook
