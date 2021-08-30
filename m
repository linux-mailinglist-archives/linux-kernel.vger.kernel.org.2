Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2C3FB918
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhH3Pin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbhH3Pim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:38:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA24C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:37:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j12so26574435ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIIbyNFm6uAxY2ulelSJovl0s2CWQEA/iTPi87yZ7eI=;
        b=SLtGna46KPBLHDE+LwMFLuDQfRQlieKDw/m8Se+2ECaRl/B0+nETa4ivV9HSQmiHW7
         yqhsVRmPjGnu867Xs7PmGnTqA2bVgwctjKsdYV8AYcP4BiqwJyA7oMBbMxFlSVhyHB5G
         mA0+Q38shHzACfWr4KUi0Wd1kM0EKxc9q4T+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIIbyNFm6uAxY2ulelSJovl0s2CWQEA/iTPi87yZ7eI=;
        b=szldhd/lw1cUUmvD4KmSBzOI6OgRMUHIA8QCoDa0DTwWRPwkRn2uWMV2tJp1s6ClDF
         arFLKGPeMYy2QLKbTkKp01nmYubrGxD7IE28DGH3aJm75gI+4M/wRP3oWCRLPX7Nda0L
         LtkqbDPkqfYCtS2M8KSDowQmydziMryJ2bMIPeVOwTsu27EofO4RVuDGdrBlE7pJl1SK
         4rqFxxCypdLjZrxrUBbpozMQWqu2ASJYMbyg3MC5SJWb9lJRW//LSLbKB/JWwJ4sm6je
         NkhON6nRL/IKJru7C73n+fYN3RJ3xL5pZBF0/Oc9H13FAgTVWcW+CAtfFDJBDke7C0+r
         phpA==
X-Gm-Message-State: AOAM530qSvaR9fVjn/wh469xkWAxN39r0jfqth5O3y3BJ+Pm38Kd8BmP
        TC0OBi0J+vuTpAcEZwb/yuMZqFh6tRMajpL+
X-Google-Smtp-Source: ABdhPJzMHla97jod25d5G7taXvESqnHsC/jH0S9vHJvvqudW2e+bvuuprk9eou4HhxRaQODczZgTSA==
X-Received: by 2002:a2e:9d47:: with SMTP id y7mr21093980ljj.408.1630337866842;
        Mon, 30 Aug 2021 08:37:46 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s9sm1859661ljp.34.2021.08.30.08.37.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:37:46 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z2so32131059lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:37:46 -0700 (PDT)
X-Received: by 2002:a05:6512:1053:: with SMTP id c19mr5357234lfb.201.1630337866133;
 Mon, 30 Aug 2021 08:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <YSydL0q8iaUfkphg@schwarzgerat.orthanc> <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
 <YSysHCQyN+brJLEj@schwarzgerat.orthanc> <CAHk-=wg6-HbEPEC6-Fz0kqnHsB4nZryWi5TEZEN=NCWzBtg4iw@mail.gmail.com>
In-Reply-To: <CAHk-=wg6-HbEPEC6-Fz0kqnHsB4nZryWi5TEZEN=NCWzBtg4iw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Aug 2021 08:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjqVuOL-0Ar85dapyU=jiVWASQnzoyxv=wL7ZEOwFUUw@mail.gmail.com>
Message-ID: <CAHk-=whjqVuOL-0Ar85dapyU=jiVWASQnzoyxv=wL7ZEOwFUUw@mail.gmail.com>
Subject: Re: [PATCH] console: consume APC, DM, DCS
To:     nick black <dankamongmen@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 8:31 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've applied the patch as-is since I'm starting my merge window work
> with "random patches in my queue".

Side note: it would have been nice to see "v2: whitespace changes" or
something in the patch description, below the "---" that cuts off the
commit message.

I had your previous patch version pending, and had to check what had
changed in the re-send.

               Linus
