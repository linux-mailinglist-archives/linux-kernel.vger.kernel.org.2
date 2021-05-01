Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF63704CF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEAB7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEAB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:59:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:58:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i13so368087pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yVa38kJPC+cK1H2CrwZPR6KXx0sym2UwEQNGXo2MV9k=;
        b=LouRuo1KhG5HfKIE18SSLzzyAiL6qq08DRIzJ2RKnYPIofDPinrzzMlcc4/KlT2b8s
         KHy0OJ0QHBKlaxhq72uCdxEHcSm4TjjMIprzqGyb1d3j3gf4fVsVXFif2kDsUzrPqkeF
         RACajck1q5OcLlEnKBweAMw/2jDAw1NONEBH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yVa38kJPC+cK1H2CrwZPR6KXx0sym2UwEQNGXo2MV9k=;
        b=bjjDFx5N9S2+3gSSMkB+VIUx/c04cRK+gHCgAz2LRxiZu/2E92Dm5k5U392EmRjGv0
         WrFLuYAZ4kedf5lln/LaiUSyrDmha6R23aJI7P1pJ0B/wbM3x2va0tL4+mucE8a1h6tA
         YvRW1csvnmId8LJNTBuC4q74q85K4ysNIWvXd5CCA01vSvAYlOJrMAcD3sTeaEsGDq43
         IN2XyPM52jnwH2EJ6sMJjyYG/x2/gJCsNs+XQsRIMWlhOoJr4cVCVSjLgHZQbzSgYXzk
         H61yQPmCTOi14aEG+ZJ5HcdCdGXEqKKF2I+NGCNONWTEe893wHGJ3YuavoKH2Otx6eaH
         TuZw==
X-Gm-Message-State: AOAM531JMrKAwOXOMXUEY+TVMn9DiajuR/VgXtQyxaJO9B1ysoYIzU5E
        2jRA9lbbKj3dyQxNRCq/wFIF1g==
X-Google-Smtp-Source: ABdhPJwsJWJrJdg0SGvIuKRDkm1rsOTTCGC7m82O1elQFz0E4yHPLMvoc2lCerKHsvpWvgxopmZcCg==
X-Received: by 2002:a63:5503:: with SMTP id j3mr7371724pgb.256.1619834295062;
        Fri, 30 Apr 2021 18:58:15 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id x38sm3241502pfu.22.2021.04.30.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 18:58:14 -0700 (PDT)
Date:   Sat, 1 May 2021 10:58:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 0/5] media: uvcvideo: implement UVC 1.5 ROI
Message-ID: <YIy1suAHDrArv8fz@google.com>
References: <20210430112611.475039-1-senozhatsky@chromium.org>
 <8a175117-d142-9265-65ee-43302bb82444@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a175117-d142-9265-65ee-43302bb82444@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On (21/04/30 14:49), Hans Verkuil wrote:
> Hi Sergey,
> 
> On 30/04/2021 13:26, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > 	This patch set implements UVC 1.5 ROI using v4l2_selection API.
> 
> Is the selection API the right approach for this? Wouldn't it make
> sense to use controls instead?

[..]

> If this was discussed before, then can you give a me pointer to that discussion?
> I couldn't find anything for that, but I didn't look very long for it :-)

I believe Tomasz raised this question over IRC back in the days and there
was no clear conclusion at the end: selection API vs control - 50/50 split.
After internal discussions we decided to go with the selection API.

> In any case, it doesn't really feel like it is the right API for this job.

Well, we pass a rectangle to the driver. The driver already knows what
to do with some of those rectangles, we teach it to handle one more. So
we don't introduce anything new, but use the existing API instead.
