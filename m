Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25FA39C064
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFDT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:27:35 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:41575 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFDT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:27:33 -0400
Received: by mail-io1-f46.google.com with SMTP id p66so9394731iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3arXY3Iq0Fx3qKjwqpP6enbStCHFC2viArbJLk+gG4=;
        b=KL8HzrlALh6cM6GjOSSchK4iJtooFOlCyIW+t+cN/hfUCT3crtKc5d+nn+U4oJ85C7
         6cPt8MdIJgVcdCbheM2RstyYaQRazt0+1HBK5krcnQ3JXz1qjZlKvc3InCwq8ewndo7H
         Ju0fm9u9B97rgmc3e3b6XO5DT0kLdyIXwFGpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3arXY3Iq0Fx3qKjwqpP6enbStCHFC2viArbJLk+gG4=;
        b=rLigFONu5Zhpkf1prddNXxCdV0aTYV9/hiYlbOWjszq+j8+E4g1c6t5Re0IzRifhRt
         5A4Dx8BIiLTQAlgBCvZf2lpH/btMQ9zFzfGdkSDUDlhogJbFJQ+FW3cBDPaqGjZ5BYee
         awp/qa4eM2cUNBJKxcOU+vW5mR1FyTD6t6UGz1ZsuAId0WmOE3ABoJo/GKwkQq0oTe/5
         /fCWPwZkHgWbtRXobVVnA4EhDENEc7csPBAZ55p6l04cnJ8x9YYJbMzrlbQrfDzfNWcg
         hvCwCI051x/6zaTIGM51pW/2goOvBYGhet1xeNkGzIhPzgiFCh39MLsvw1T3cUeWBI88
         TCSg==
X-Gm-Message-State: AOAM532tlfOkN6lWm2IigGoNPwOzhrlfJuitexdDRuhjpM/61MXdqsp1
        WB23iI5LpHS7sIIraj5GdWCpjECKxs1WoA==
X-Google-Smtp-Source: ABdhPJzIhrEitOpqGSaQkko8kzEIr7dasFf7vCFwahzOrlAdz+2u4fGe/IYIyQ9pEZAmPtsxCQERLg==
X-Received: by 2002:a05:6602:2215:: with SMTP id n21mr5042939ion.80.1622834675098;
        Fri, 04 Jun 2021 12:24:35 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id a22sm2876393iot.37.2021.06.04.12.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:24:34 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id b9so9914020ilr.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:24:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:de9:: with SMTP id m9mr5380481ilj.89.1622834673935;
 Fri, 04 Jun 2021 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092638.985694-1-ribalda@chromium.org> <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn0D+1R2QHZYRVV@hirez.programming.kicks-ass.net>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 4 Jun 2021 21:24:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
Message-ID: <CANiDSCu4Brz7FZX5oa57kNLG9h_1EASX=bdQij4+apg0ZwW8QA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Do not set a variable unless it will be used
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On Fri, 4 Jun 2021 at 11:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 04, 2021 at 11:26:38AM +0200, Ricardo Ribalda wrote:
> > clang-13 triggers the following warning:
> >
> > bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
> >         u64 len = 0;
> >
> > This patch sets the value to len only if it will be used afterwards.
>
> My vote would be to kill that warning, what absolute shite.

My knowledge of llvm codebase is close to NULL, so it is much easier
for me to "fix" the code.

I would assume that the static analyser has found a magic condition
where the previous if always returns false, and has managed to
"optimize" the code.





-- 
Ricardo Ribalda
