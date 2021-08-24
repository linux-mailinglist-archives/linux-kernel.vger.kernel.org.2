Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAFB3F62B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhHXQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhHXQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:35:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE3C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:34:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i28so46813966lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hrxRG57iUFkLUKVAMtcNr5HWWrkcKIlx/S6pK1RgzIo=;
        b=OHcdibhZBBnxCr1t0OYp2tDeFwDaTc27mSa2BYLLdrgMbnfEwebsteLylRujHb+n1/
         T+uGlAHzstidMEyovoNw+M7AwvgJw07VxTtLrjjGO2yX6X1FSgy5VantkzvGX6cHddKM
         WLcEub/WU1nXQLcqdU+iCGvZWrgCQc2iitI9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hrxRG57iUFkLUKVAMtcNr5HWWrkcKIlx/S6pK1RgzIo=;
        b=ZI1BJIVAXzwt94+XyQm3SY69DTnSAJHVmvjENgXypzfaXKGvhpy349QopEGChHbSVF
         miHF4cMn14zhiAfIlKV/NQkqwBjg9PsdUxZuFE+FyaoBAflCsvF4iAAZM3yhfchMGzo0
         yaIDls6BbmA8rMmKbR15mFT41WH9EQEN8EMccJbYErN+jS4gIHWnNlaiDObcYaDZpZDR
         vA3Bqm7ztRhshXfraRNPWYa1A/sJAaIJWKKqBUpDWscbcb4YOjrccUIcb7VsiFbJizch
         XbBLuS+iOS3FTHiI60Tq7hQGkE6Q95iVGlNPPW1nYpdmhGWxDHIzq9KhAZ89YBLL3VHP
         67+Q==
X-Gm-Message-State: AOAM5335RVbYcypRL15bp9jCkLlhdptZoQzeIOCGrim7Yo5vqPLpg6YW
        r8XjaiIxdFKG1csWvilFdxWJjqwkErKII4CB
X-Google-Smtp-Source: ABdhPJwEXd/EonpeHnqXXC6aJyxz8H2vZuItJrywXEDAB4CYCkR1TfTIFxzdJ6xgXcSWZEV4I5IDwQ==
X-Received: by 2002:a05:6512:5d0:: with SMTP id o16mr18968029lfo.158.1629822859703;
        Tue, 24 Aug 2021 09:34:19 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v1sm1831941ljb.44.2021.08.24.09.34.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:34:18 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id i28so38679542ljm.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:34:18 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr30214848ljw.465.1629822858510;
 Tue, 24 Aug 2021 09:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210824031648.GA2725@codemonkey.org.uk> <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk>
In-Reply-To: <20210824151943.GA386@codemonkey.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 09:34:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
Message-ID: <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
To:     Dave Jones <davej@codemonkey.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 8:19 AM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Tue, Aug 24, 2021 at 10:31:16AM +0200, Peter Zijlstra wrote:
>  >
>  > If you need DELAYACCT I'm thinking:
>  >
>  >   e4042ad49235 ("delayacct: Default disabled")
>  >
>  > and
>  >
>  >   0cd7c741f01d ("delayacct: Add sysctl to enable at runtime")
>
> That does sound more relevant. however, even after echo 1  > /proc/sys/kernel/task_delayacct,
> it still fails in the same way.

Hmm.

What happens if you boot with the 'delayacct' kernel parameter.

Even if you enable it at run-time, processes that have been started
before it was enabled won't actually have the 'tsk->delays'
allocation. So I'm not sure how effective the run-time thing is.

            Linus
