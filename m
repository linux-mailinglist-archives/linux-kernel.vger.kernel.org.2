Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3C3F2417
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhHTATV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHTATN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:19:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71DC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 17:18:35 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m193so15551266ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxqVyTwHe6/RPArmls1kDyHsamw5A75hUDWTGog34ak=;
        b=H8unLXT6f25qYtnNzgH+s0MZByT5XLjJI+h0JthIvCchv1BK79DZv1/926JwsFhuHj
         CUeXWYyUPAWxmeBT0gkP+Pbc8CM0FTIlHwpLVpiqn8V3y8S4dz6i2+Lyrj4C29EG2r0R
         +dtddq7SiKkmiy1PKXF+s+rCfcgDs76KgEtb6Bfd9ohg5yPjrBsGqzJFBP1hmp0bSPUs
         +ZohUlsUw7OAIGNBhkQWuzUcq6LHmSVFV0nmMKkYEwMe0gifLq/E5ixH1P++I9iBWL+p
         VcR6A6frB/uZCMAfvdLiH0KLxk4ugGSfKDQriL0tXbPtV+UdvRcTkGqBWDsR136waAHT
         VC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxqVyTwHe6/RPArmls1kDyHsamw5A75hUDWTGog34ak=;
        b=KJtLgwbZLZTKt0aEeWZclcFt2P2+JZgk27vBJlwtAsJegHbi3ln9Gu9HR0GkETPt+5
         hUcjVXm5TDlTjJ/1c8cS3a+21Dv/3S433MDY6WSIenD6gRKyrrLuHPizRvL/QGbo4kNc
         aXzqH2Ho+3B65RNUfnm5Wt42EFBDtRmWG35b7L22z9+A/82wtWYVWfPhcpXFyXPGJMun
         /Wnug4nrxy9E97OW8H7PfkEBI+/1hGM4AKqGd7KUC/boHRDjsSjEP/GY2Vbdc2zzUWCI
         y/VqAipfU5dWKAaiw5047GwGJXQPDVunGvdo7xmUcBJ3MErF2StDQD9JywUEHDoAKprB
         8eNw==
X-Gm-Message-State: AOAM5339pRpaDbj6YJJaBQEFHIuvMpMzBgUotGh0fkgDMpbhKWIaQ4zl
        YOl6bTJ4xzIKwwjMNPZ/jWgOraS3jci0I9x+588U0A==
X-Google-Smtp-Source: ABdhPJyGSqEnK739eYv9WH0HsV2wTQXq6ky87cnyy8U07pJujYILTRKzM95ReC7nt2L5zEfXroz3sdUDdQfrAHtsg+Q=
X-Received: by 2002:a25:1506:: with SMTP id 6mr21318398ybv.153.1629418713639;
 Thu, 19 Aug 2021 17:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123309.039845339@infradead.org>
 <20210817151542.GA1665@asgard.redhat.com> <YRvbS5ypWhcsBzzU@hirez.programming.kicks-ass.net>
 <20210817231734.GA4449@asgard.redhat.com> <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
In-Reply-To: <YR473ZGeKqMs6kw+@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 19 Aug 2021 17:18:22 -0700
Message-ID: <CABk29Ns9s5Nr25qVPtOxABchMk1BFqOb1wpEXhQpF8=jpgqAFQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Fix Core-wide rq->lock for uninitialized CPUs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>, ldv@strace.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Aug 19, 2021 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> -       /* shared state */
> +       /* shared state -- careful with sched_core_cpu_deactivate() */

Could also throw these fields into a wrapping struct. Either way seems fine.

Reviewed-by: Josh Don <joshdon@google.com>
