Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1735E3799B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEJWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEJWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:10:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:09:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u25so3735291pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4FwpwaMuUuANGaPQWDopSvI7k5csPfbD8MU/lgahDDI=;
        b=iuMuoeuWicIOLyzGB/kjt6aaAMI+oAJlnNeISYpIrExhpPXP5qEuC6qG35wa6F0UxV
         btkK8hWKz+nJ5B1zjq+762ulqKqW82Yo56VUIUs3ZK64fw8jkt2TM5yThLm3wGeMxVFp
         8sQ3CngwGxn1xZfzBNdiODgxN/UgZMLKaAi70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FwpwaMuUuANGaPQWDopSvI7k5csPfbD8MU/lgahDDI=;
        b=DkujNBHlBUo0S8kawwObwnsCG5JlHj7Khj1w5NvCODuzLSc2tVgF51jlLTsH+VRPaX
         LdhK3B8VCWp5fq7lC+nacwScWCGbzpZ7Gim5GcHoPXhtGzwFuSh4qD3Fc7UKvxJFPPE6
         FIryreN/FtJ8WpEqak+arSvT1CfFBghthQHxvoMIFpp42CZLqHWbIFQ3D+eoDC4f2599
         h3VDacnxvoFYPX/45PlNbSpuN8i+HZ/CPc626G1isOQm99FIWg1NglizXzM2nvXefXLH
         JqpazXL2JImRFlfJfkUxfawwafpcRfjM18SaCO+Yg1aJaKkvPcxOgl4WQ6NU2UBZFiTS
         ja6Q==
X-Gm-Message-State: AOAM532RKxl7m0XYgB+1DHBmWUu+xEG/9SckumUoITCPWzCyuMQuKbxa
        sCefw33zUBOhQPj3uzZ6dLxf4Q==
X-Google-Smtp-Source: ABdhPJx3Dc2A7dOK7PUNQ1XWPvb1STB1rM7wLY6YKSriM98vZ/pZlznw2Xtl1k/y7TDGaeH/czPN0A==
X-Received: by 2002:a63:bf4e:: with SMTP id i14mr27543567pgo.277.1620684554087;
        Mon, 10 May 2021 15:09:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7sm11639588pjq.36.2021.05.10.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:09:13 -0700 (PDT)
Date:   Mon, 10 May 2021 15:09:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Saripalli, RK" <rsaripal@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <202105101508.BC6CC99FAD@keescook>
References: <20210505190923.276051-1-rsaripal@amd.com>
 <20210505190923.276051-2-rsaripal@amd.com>
 <87wnsamvaa.ffs@nanos.tec.linutronix.de>
 <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
 <87h7jagt7g.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7jagt7g.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:44:03PM +0200, Thomas Gleixner wrote:
> On Mon, May 10 2021 at 06:10, RK Saripalli wrote:
> > On 5/7/2021 10:13 AM, Thomas Gleixner wrote:
> >> What's wrong with just treating this in the same way in which we treat
> >> all other speculative vulnerabilities and provide a consistent picture
> >> to the user?
> >> 
> >> Something like the below. You get the idea.
> >
> > Thomas, thank you very much for the comments.
> >
> > I provided the links to the original patches which treat PSF similar to other
> > speculative vulnerabilities.
> >
> > Could you review them please?. The first patch is the cover letter.
> >
> > https://lore.kernel.org/lkml/20210406155004.230790-1-rsaripal@amd.com/
> > https://lore.kernel.org/lkml/20210406155004.230790-2-rsaripal@amd.com/
> > https://lore.kernel.org/lkml/20210406155004.230790-3-rsaripal@amd.com/
> > https://lore.kernel.org/lkml/20210406155004.230790-4-rsaripal@amd.com/
> > https://lore.kernel.org/lkml/20210406155004.230790-5-rsaripal@amd.com/
> > https://lore.kernel.org/lkml/20210406155004.230790-6-rsaripal@amd.com/
> 
> They are going into the right direction, i.e. detection and reporting.
> 
> Vs. mitigation control the question is whether we need the full
> machinery of prctl/seccomp and so forth especially under the aspect that
> the SSBD mitigation already covers the PSF issue.
> 
> So for the start a simple on/off might be good enough.
> 
> Kees, any opinions?

I agree: if PSF is a subset of SSBD, there's no need for the additional
machinery.

On a related topic, what happened to Andi's patch to switch the seccomp
defaults? I can't find it now...

-- 
Kees Cook
