Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73C238CE09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhEUTRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235748AbhEUTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621624582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NM9RRRkodr6aZSYSHCjBSRNeYjgk1EB6pEubMwSkZ4Q=;
        b=bDl5VYr16dFqr7+xAo5D8YE46vCA8k5LC+2eJIjAfrFwMQo1ruVjjwTTyyDNrZFhPIh1Xu
        HpIqXngT6m3GMa/YMkWGrdrIBwtELGObI9yEfTg5LK5L+L/QHkxzhe3oET8E6TwhhzY3yf
        P3EdDZTSeoyLS56S/WMLFIr06pERTFg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-N_CFzKi6PQeVUGzc8uP7Gw-1; Fri, 21 May 2021 15:16:21 -0400
X-MC-Unique: N_CFzKi6PQeVUGzc8uP7Gw-1
Received: by mail-qt1-f198.google.com with SMTP id v13-20020ac8578d0000b02901e4f5d48831so16298032qta.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NM9RRRkodr6aZSYSHCjBSRNeYjgk1EB6pEubMwSkZ4Q=;
        b=JmNwz2ykCCVFuqiRe4WM6Yqiz2F5VRuNKShC2BItUbjgenNYQc/3E3BtKrAANeKZ5/
         +vkoRUJF9CHMshzWyg7O3d9UIDWipjC2JtYjozmB/a5eznzOqkygqXH+SKN4eVW2ANQS
         JMRsug7PBeFhw5xRNbSElKRN7zAtt1NVD1Y6bRk/ohJ3k+AJRXp6fAbH4uBOYZ0Xcpl+
         X0P/sqJP5+hRM+VZb2t1ucJE7FScKS0x8UKHWF0kwtawpIF2SvgMTBR8ahsTDs20U7am
         hddrRUYMa3g2QYzBm4woBhn+oZFbTI6vLYRP4ICpZKUyEwz5XltccHhNcusA6Tdp0kxk
         E+dg==
X-Gm-Message-State: AOAM532nFv9qOJbVWx4T1Ucb/MQQ06sD9e/5LBofa2b7cOqe3YU/cflI
        PwSQOPKiWlrO8Oko1dam+ioSkqPOXl+jRTAxMezU/TRr7840z9MekXtrWt9uTYfA6UXFD/R8vIM
        IVS6jJ2hIY/wSg6zF72ijtzMH
X-Received: by 2002:ac8:7d4c:: with SMTP id h12mr13171130qtb.130.1621624580603;
        Fri, 21 May 2021 12:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/AxR5/vGQaVvvOLN4V3Hm0lhLDxLsaGyXvxTwBIQiN8NOkrJ4IY8ylrPj8PFks7thayLIJw==
X-Received: by 2002:ac8:7d4c:: with SMTP id h12mr13171107qtb.130.1621624580364;
        Fri, 21 May 2021 12:16:20 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id f19sm5736116qkg.70.2021.05.21.12.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:16:19 -0700 (PDT)
Date:   Fri, 21 May 2021 14:16:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        ardb@kernel.org, jthierry@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, jmorris@namei.org, pasha.tatashin@soleen.com,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] arm64: Introduce stack trace reliability
 checks in the unwinder
Message-ID: <20210521191608.f24sldzhpg3hyq32@treble>
References: <20210516040018.128105-1-madvenka@linux.microsoft.com>
 <20210516040018.128105-2-madvenka@linux.microsoft.com>
 <20210521161117.GB5825@sirena.org.uk>
 <a2a32666-c27e-3a0f-06b2-b7a2baa7e0f1@linux.microsoft.com>
 <20210521174242.GD5825@sirena.org.uk>
 <26c33633-029e-6374-16e6-e9418099da95@linux.microsoft.com>
 <20210521175318.GF5825@sirena.org.uk>
 <20210521184817.envdg232b2aeyprt@treble>
 <74d12457-7590-bca2-d1ce-5ff82d7ab0d8@linux.microsoft.com>
 <20210521191140.4aezpvm2kruztufi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210521191140.4aezpvm2kruztufi@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:11:45PM -0500, Josh Poimboeuf wrote:
> On Fri, May 21, 2021 at 01:59:16PM -0500, Madhavan T. Venkataraman wrote:
> > 
> > 
> > On 5/21/21 1:48 PM, Josh Poimboeuf wrote:
> > > On Fri, May 21, 2021 at 06:53:18PM +0100, Mark Brown wrote:
> > >> On Fri, May 21, 2021 at 12:47:13PM -0500, Madhavan T. Venkataraman wrote:
> > >>> On 5/21/21 12:42 PM, Mark Brown wrote:
> > >>
> > >>>> Like I say we may come up with some use for the flag in error cases in
> > >>>> future so I'm not opposed to keeping the accounting there.
> > >>
> > >>> So, should I leave it the way it is now? Or should I not set reliable = false
> > >>> for errors? Which one do you prefer?
> > >>
> > >>> Josh,
> > >>
> > >>> Are you OK with not flagging reliable = false for errors in unwind_frame()?
> > >>
> > >> I think it's fine to leave it as it is.
> > > 
> > > Either way works for me, but if you remove those 'reliable = false'
> > > statements for stack corruption then, IIRC, the caller would still have
> > > some confusion between the end of stack error (-ENOENT) and the other
> > > errors (-EINVAL).
> > > 
> > 
> > I will leave it the way it is. That is, I will do reliable = false on errors
> > like you suggested.
> > 
> > > So the caller would have to know that -ENOENT really means success.
> > > Which, to me, seems kind of flaky.
> > > 
> > 
> > Actually, that is why -ENOENT was introduced - to indicate successful
> > stack trace termination. A return value of 0 is for continuing with
> > the stack trace. A non-zero value is for terminating the stack trace.
> > 
> > So, either we return a positive value (say 1) to indicate successful
> > termination. Or, we return -ENOENT to say no more stack frames left.
> > I guess -ENOENT was chosen.
> 
> I see.  So it's a tri-state return value, and frame->reliable is
> intended to be a private interface not checked by the callers.

Or is frame->reliable supposed to be checked after all?  Looking at the
code again, I'm not sure.

Either way it would be good to document the interface more clearly in a
comment above the function.

-- 
Josh

