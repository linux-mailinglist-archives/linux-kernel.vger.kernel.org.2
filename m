Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A2379A22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEJWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhEJWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:35:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D542CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:34:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so9868001plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9GhutQNehYBAmzOzGjF9GzKnWEwK9dadMDkrgc0W7xg=;
        b=mRR/P06sNQFUcyLyWrTzy7HSz9Fxt8KQr9qNoeo64i5SY7/iGcRMx2UOBfBKCD5Khz
         0+BvznE5OntLiU8EGOdqRYUh3fsWA/CjCWOnSzbn1LG1ig++laWccU2Yw0p8TkU71Pnr
         uayeESg+XGLKg5zSNQVaQ4d1z62KE8ruvXOOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GhutQNehYBAmzOzGjF9GzKnWEwK9dadMDkrgc0W7xg=;
        b=f0FpvXV6HDzaDs429NbVTI/a+p1zTPyia4oNodzH7iG2OW2ke5m6102zpaBiaHEFAQ
         kWs+ka55kD2Ssp7/ucIX1+2rwv6HQVrBd28GwdZ28eEmoXklgJAdaPES3WAZzk50ijQ7
         urDzodBJ/MLPq5VAabOatMrn/ntUMgUA4hoaLzXbmndnWjV6swmN7QAQg1w8ampE3yup
         9S9gZOpQGrn3ZV4PncgCUDqUThD6etJp19ru+IGN0en2o6ScEiWgfmiumUthiJoDKdYL
         1htXv7ll3xiJDzXbJ6ZnYFNnfEXXYIp6aqiL1hmzfJCwG/DyVsCjhYOqI+6iDu+/ntP7
         teeg==
X-Gm-Message-State: AOAM5335SG/Ribvjp76Ug0IbmE4wCrAt6TjbsDTinXZzR3Y4poPRboW1
        H3fVn/Z//sVcXhzzPr8ixfHT4A==
X-Google-Smtp-Source: ABdhPJwPWYuTN2gEq89932JSNP9P1Z1peRcGn4saXQbmOBlaiApbtMJLo06d24ozBxxNHQEFe9GSFA==
X-Received: by 2002:a17:90a:6e5:: with SMTP id k92mr1559175pjk.198.1620686043374;
        Mon, 10 May 2021 15:34:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18sm11863989pfa.39.2021.05.10.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 15:34:02 -0700 (PDT)
Date:   Mon, 10 May 2021 15:34:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Saripalli, RK" <rsaripal@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store
 Forwarding control.
Message-ID: <202105101529.F628137@keescook>
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

Ah-ha, found it. I misremembered the author. :)
https://lore.kernel.org/lkml/20201104235054.5678-1-aarcange@redhat.com/

Specifically these two patches:
https://lore.kernel.org/lkml/20201104235054.5678-1-aarcange@redhat.com/
https://lore.kernel.org/lkml/20201105001406.13005-2-aarcange@redhat.com/


And, Thomas, while I have your attention, I'd really like this to go in
for -rc2, if you can snag it:
https://lore.kernel.org/lkml/20210419231741.4084415-1-keescook@chromium.org/

:)

Thanks!

-- 
Kees Cook
