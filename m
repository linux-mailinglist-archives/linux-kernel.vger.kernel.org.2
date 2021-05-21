Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6838CE03
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhEUTNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230339AbhEUTNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621624309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz98kMsw+FzS8L01GR0w0EVxwdrTPL2Z/BYSCEvqIsc=;
        b=AgTjYRoCXt+viQH/qJRJYb9PrKJ06CJGgGIhtBqsK8q8VhawEmjDV2u5K4GusoDVeoBwOE
        xPi0Clnc2Lk0Xe/KoTf9J9NRHyB64Vau5T3hq16Nvy21QZDV9BR9gqeClhE3Y1f5sW5Omy
        owQj/lBmyHCW0j0JDYV0nbgr12rfYE8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-wu2WDvsuOwSUHD5-CynVtg-1; Fri, 21 May 2021 15:11:45 -0400
X-MC-Unique: wu2WDvsuOwSUHD5-CynVtg-1
Received: by mail-qv1-f70.google.com with SMTP id e15-20020a0caa4f0000b02901eedbb09299so16431496qvb.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nz98kMsw+FzS8L01GR0w0EVxwdrTPL2Z/BYSCEvqIsc=;
        b=lNq57mjtI+0RDEZgEG9YMnRng8DRp+O25/e4M7cjtqL+5/cXJX3M9BMntImP2QRuPY
         kI0DcMH1nwpY6uPBosU7FjJLJ8eqKIaNdRQNm4n+FC9B589Ey8+aaQGB/2yfJSTP+QQW
         x2W0MiaTy8DIUgw1dOm39T2GTGW8zc5tLrWPB8JkSvpNF+ReRiiNeINzxmeBY7GxtJij
         vlC4zGEELlKDClXgBiu6Hznpys5Hd8AYNc1aVMWLxp/VorNjKw82uuljSGKw+hEyBSui
         DWkSjMtSVdGr8GKmh8hIQhU1nJsLTIr1443Dqw6pYWWuFhMM7wYTHl3HtAA2qGUfpVKo
         WK2w==
X-Gm-Message-State: AOAM530X3xh84okt/bGCxH+Z8VDc0mnJt+RkiWqgqUoEG1B1Jeu9VVq0
        VzF+wVyQTCvibWfZ0m15JEdLZJR+msq4LoiErtmsX7eUaIPEkuQEAF8p2COw+KPqdf9twD5R9jy
        gYx4sCDoSWpOOMrGTzpV9ZJ4s
X-Received: by 2002:ad4:5281:: with SMTP id v1mr14776333qvr.56.1621624305393;
        Fri, 21 May 2021 12:11:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjZKT1phiUkfEYMYpJ5BVtH7F+86BAqoH6+mVzJaZJ5h4g+DjOWLKk81axhj747gk8xhKokw==
X-Received: by 2002:ad4:5281:: with SMTP id v1mr14776295qvr.56.1621624305075;
        Fri, 21 May 2021 12:11:45 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id a27sm3922191qtn.97.2021.05.21.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:11:44 -0700 (PDT)
Date:   Fri, 21 May 2021 14:11:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        ardb@kernel.org, jthierry@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, jmorris@namei.org, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] arm64: Introduce stack trace reliability
 checks in the unwinder
Message-ID: <20210521191140.4aezpvm2kruztufi@treble>
References: <68eeda61b3e9579d65698a884b26c8632025e503>
 <20210516040018.128105-1-madvenka@linux.microsoft.com>
 <20210516040018.128105-2-madvenka@linux.microsoft.com>
 <20210521161117.GB5825@sirena.org.uk>
 <a2a32666-c27e-3a0f-06b2-b7a2baa7e0f1@linux.microsoft.com>
 <20210521174242.GD5825@sirena.org.uk>
 <26c33633-029e-6374-16e6-e9418099da95@linux.microsoft.com>
 <20210521175318.GF5825@sirena.org.uk>
 <20210521184817.envdg232b2aeyprt@treble>
 <74d12457-7590-bca2-d1ce-5ff82d7ab0d8@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74d12457-7590-bca2-d1ce-5ff82d7ab0d8@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 01:59:16PM -0500, Madhavan T. Venkataraman wrote:
> 
> 
> On 5/21/21 1:48 PM, Josh Poimboeuf wrote:
> > On Fri, May 21, 2021 at 06:53:18PM +0100, Mark Brown wrote:
> >> On Fri, May 21, 2021 at 12:47:13PM -0500, Madhavan T. Venkataraman wrote:
> >>> On 5/21/21 12:42 PM, Mark Brown wrote:
> >>
> >>>> Like I say we may come up with some use for the flag in error cases in
> >>>> future so I'm not opposed to keeping the accounting there.
> >>
> >>> So, should I leave it the way it is now? Or should I not set reliable = false
> >>> for errors? Which one do you prefer?
> >>
> >>> Josh,
> >>
> >>> Are you OK with not flagging reliable = false for errors in unwind_frame()?
> >>
> >> I think it's fine to leave it as it is.
> > 
> > Either way works for me, but if you remove those 'reliable = false'
> > statements for stack corruption then, IIRC, the caller would still have
> > some confusion between the end of stack error (-ENOENT) and the other
> > errors (-EINVAL).
> > 
> 
> I will leave it the way it is. That is, I will do reliable = false on errors
> like you suggested.
> 
> > So the caller would have to know that -ENOENT really means success.
> > Which, to me, seems kind of flaky.
> > 
> 
> Actually, that is why -ENOENT was introduced - to indicate successful
> stack trace termination. A return value of 0 is for continuing with
> the stack trace. A non-zero value is for terminating the stack trace.
> 
> So, either we return a positive value (say 1) to indicate successful
> termination. Or, we return -ENOENT to say no more stack frames left.
> I guess -ENOENT was chosen.

I see.  So it's a tri-state return value, and frame->reliable is
intended to be a private interface not checked by the callers.

That makes sense, and probably fine, it's just perhaps a bit nonstandard
compared to most Linux interfaces.

-- 
Josh

