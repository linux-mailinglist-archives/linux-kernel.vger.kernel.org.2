Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92E1379A02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhEJWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhEJWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:25:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56737C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:24:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u25so3760436pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+mh725yIUtYYOJWyWKBZZGohhQapyMCbceBHpcyi3s=;
        b=BV7FbteezdN0qg5Kvm+qQ30InqPTQwfexHQ93icSnJ4OIKYj9f2aRwopTOpbTaUDCH
         VCiGDCspzjXjlBGb1Ar9PoEn1/P1TuRNI3zUKg6SulqsY3z+ek1VCV8O5/UAiYsoHJTR
         qvo0IeUAt3q5VMZsDXD3jC2WG4Mcf9UWp0g84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+mh725yIUtYYOJWyWKBZZGohhQapyMCbceBHpcyi3s=;
        b=C/1GqwyDeUR16OhgL/4D56iEK8mgdn96MyIwA9iVW5vnetdqsFszcvCesm5EcUYHFy
         CVzkwozlhIU1k4vcgmvPg+PJLavzxQpHxo190BRfkdh9fBedbQwAp2kIPoiajCtand4O
         8l8VNhX1/oGBUTHr4c50AMbn2UanEwLNPrh5BzqI4SDs842xpQ79+Bks0NQu1dpK//cp
         coPbNtyfC4ie0wlJtOx0SRN0cGMGiuiQG3xfztlIfYPdspnjTidWq9XkGxHJDTDzDeRY
         IJxBXcq3JsbU38//ocd19ni3c7EXVL4DHc6NyHsGoVd5afojcMvG5FMYdaefcNESZEst
         JCTg==
X-Gm-Message-State: AOAM532EpV1up+WcJvOtW3JXc53d33lim3yD1NZwcGcEttu0v7piIhEe
        eCUn7SSqrvk7NLVopjBbes1wpg==
X-Google-Smtp-Source: ABdhPJy+TRl5aBjNmyjjDntF/JE7l7PZlvLVxZ5SOiYuM+PXsLxtOHOX0luy+jMYpfQGa0LT1IIlKw==
X-Received: by 2002:a65:48cd:: with SMTP id o13mr27291390pgs.249.1620685484925;
        Mon, 10 May 2021 15:24:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w23sm7090150pfn.63.2021.05.10.15.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:24:44 -0700 (PDT)
Date:   Mon, 10 May 2021 15:24:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Saripalli, RK" <rsaripal@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <202105101524.3B76F77AB@keescook>
References: <20210505190923.276051-1-rsaripal@amd.com>
 <20210505190923.276051-2-rsaripal@amd.com>
 <87wnsamvaa.ffs@nanos.tec.linutronix.de>
 <d134cbb1-a8a5-161a-1927-2a04df6b4b4a@amd.com>
 <87h7jagt7g.ffs@nanos.tec.linutronix.de>
 <202105101508.BC6CC99FAD@keescook>
 <878s4mgrqz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s4mgrqz.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:15:32AM +0200, Thomas Gleixner wrote:
> On Mon, May 10 2021 at 15:09, Kees Cook wrote:
> > On Mon, May 10, 2021 at 11:44:03PM +0200, Thomas Gleixner wrote:
> >> Kees, any opinions?
> >
> > I agree: if PSF is a subset of SSBD, there's no need for the additional
> > machinery.
> >
> > On a related topic, what happened to Andi's patch to switch the seccomp
> > defaults? I can't find it now...
> 
> You mean this one:
> 
>   https://lore.kernel.org/r/20200312231222.81861-1-andi@firstfloor.org
> 
> If so, then it has lacks a follow up.

I swear there was a follow-up to this. I will try to find it again.

-- 
Kees Cook
