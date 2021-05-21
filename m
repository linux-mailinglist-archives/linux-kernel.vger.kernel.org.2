Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5738C589
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhEULT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhEULTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:19:20 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB76C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:17:57 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso4491449oop.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcIp8WA1WHrJEqMIlaVs2ij19F6h1FeNiLm8T3GjEDY=;
        b=gFmVEQZvD+AQHMdUJsoBv5RTf3kX2ozOsQ823fwsAf3l6XUyw97ke6ACIhTPJKpBgh
         wW9mdj6xBW9Aezn1Mzr+2ehoSfa27rNt5CGgwMz29mEoI4kptCCYhxnwOhTAdw5MlKZJ
         hl/Vvobs56pvLesJ9xjlrYHVK4njrrcGWDkBP0o7mryY2zfOzCab22xSH2X6p5SCDH1d
         2uUQ0lUt0PltMWGXkqOQwRUDnHdY7aX2wWwJOuaO6XWNCU3PFTAiZfDRAoYV8FjRhHU5
         hpWGlwDegjoE4JaCzJY5K7RBY3lu7LGkASVYncb5IR2I1J+V9qAxv1CpRW2SrrKd7Aqo
         g+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcIp8WA1WHrJEqMIlaVs2ij19F6h1FeNiLm8T3GjEDY=;
        b=MPZ7CN7v9hZ//CAUtwvyntVf+3y12bdLPYT3TJmIKCSKeUkGBNzYLt7yIEWJDFZFHh
         RDCU2pmRj5Kv4xfMc8CVD7EaLaq4lltN55ZNz+wkOLQgjFdEQOTh4fwu5pvC89Vp3qew
         71QlEEwwg1lxP2NDTV3rGmucTnJD5YnXdaPD/erfr34JIkdd7dUUww5667fYDgdvFbuE
         aHHpbD6mc3muXdVAJDlRlop8r2ud7/7KZB76dnFQGocyiMkw3afTYBg57eb8ftZ9+0Br
         vjG22kiw0wwSpqVoarwtaFosR/TTo3nv1gENIDvgID+Jh9Tj5b1/6kOD3yeKCvIFtQ0w
         5HqQ==
X-Gm-Message-State: AOAM532bX6d/Nm5ZJ2eyYQ50AbfxMGMuDjZn8uYOnF25HRhdye6XrXdL
        ueUfkanBAVhJ14d3eMcSYGfQBCTlD1vX+UyzELmVJQ==
X-Google-Smtp-Source: ABdhPJw8SJYXkQFKjdyvexxkcKn4vgnDN+xTtCy93UoM3eGHgFr6VjCvHqXfF8ZFZBoC62/obPHq3PSJt/HRt1kic/Q=
X-Received: by 2002:a4a:cf15:: with SMTP id l21mr6404487oos.36.1621595876593;
 Fri, 21 May 2021 04:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210521083209.3740269-1-elver@google.com> <20210521093715.1813-1-hdanton@sina.com>
In-Reply-To: <20210521093715.1813-1-hdanton@sina.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 21 May 2021 13:17:44 +0200
Message-ID: <CANpmjNMD58SJPeVnKrx1=mXoudPZFs+HoCsVujYomCtZ5K+DKQ@mail.gmail.com>
Subject: Re: [PATCH] kfence: use TASK_IDLE when awaiting allocation
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mel Gorman <mgorman@suse.de>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 at 11:37, Hillf Danton <hdanton@sina.com> wrote:
> On Fri, 21 May 2021 10:32:09 +0200 Marco Elver wrote:
> >Since wait_event() uses TASK_UNINTERRUPTIBLE by default, waiting for an
> >allocation counts towards load. However, for KFENCE, this does not make
> >any sense, since there is no busy work we're awaiting.
>
> Because of a blocking wq callback, kfence_timer should be queued on a
> unbound workqueue in the first place. Feel free to add a followup to
> replace system_power_efficient_wq with system_unbound_wq if it makes
> sense to you that kfence behaves as correctly as expected independent of
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT given "system_power_efficient_wq is
> identical to system_wq if 'wq_power_efficient' is disabled."

Thanks for pointing it out -- I think this makes sense, let's just use
the unbound wq unconditionally. Since it's independent of this patch,
I've sent it separately:
https://lkml.kernel.org/r/20210521111630.472579-1-elver@google.com
