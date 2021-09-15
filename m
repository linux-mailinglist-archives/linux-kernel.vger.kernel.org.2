Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7C40CCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhIOSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhIOSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:43:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:42:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k4so8135889lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJ46yNZedpI+wkzb9wsbjujLref1FzkKQaXKuIRt51c=;
        b=IT1Y5U2ktJo7w9Wg5bowIJJPlhgNhDRPAoHbs2He2eZsAtxlwgVrbfsjQFCw5gxROM
         O5iIJg0MQClA71qDpgmmkp88nEwt2ZQZ/lLLA22UvQcJUR11PZHw3hsCz0ve7UVZcW2e
         j/fpK1p7cnjudgj+yOCsHtVB509FWO6PRw7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJ46yNZedpI+wkzb9wsbjujLref1FzkKQaXKuIRt51c=;
        b=nle7WtgK/HFWZFOsu3M9Tp9zJChnI3sgKsLdq5f6ddKjT7QKCngYe7Xd21IT9jRxzh
         cdY3nVV/J8rIFA56I/uTfc1ftmWLPfHzyvJ45DYC7rqakrXToZPYDOTYobPCKGdpyF9f
         PwhuEycT2wW4/NYxWPQBxSb49Jvlki82wkBtMA32dfQdQDY8oRQISOh8qHQGXr43vWzI
         Gz7wPm5TGpLOn0O6HOSHFwdfrquoXDhDSqi7v31KuHHyg84fAAPjsZKyqzdNYyreg7tj
         nARMDA76vA5lDQyQGWf3waAqnj2szR7rRjahNaZmxqQnmgLhSCX3PhFuBKJT2/FkAY1p
         m6Cw==
X-Gm-Message-State: AOAM5301pGCTboOFXieVxnzvLLkzC7G8fCOwL6vd7XiUan+0HnLIKXaK
        P0ce5E7X1KyMB0nzMQJDQKacqx9g3Egi19kVJIs=
X-Google-Smtp-Source: ABdhPJzi+rvMwDSF/MWQLB+xdBARZmdb9rIt5x2+sNvkDO2NySp/sOnkQO1PcE/nD9owUVg5vEFEXw==
X-Received: by 2002:ac2:58ce:: with SMTP id u14mr1027832lfo.59.1631731319797;
        Wed, 15 Sep 2021 11:41:59 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d15sm54736lfn.220.2021.09.15.11.41.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:41:59 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id bq5so8106640lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:41:59 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr1258092ljg.31.1631731318838;
 Wed, 15 Sep 2021 11:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <1631693373201133@kroah.com> <87ilz1pwaq.fsf@wylie.me.uk> <20210915183152.GA22415@lothringen>
In-Reply-To: <20210915183152.GA22415@lothringen>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 11:41:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiiqmy1jE0i9EYkCiE+KNHDTJQVktczZgyJwqL-okRgA@mail.gmail.com>
Message-ID: <CAHk-=wgiiqmy1jE0i9EYkCiE+KNHDTJQVktczZgyJwqL-okRgA@mail.gmail.com>
Subject: Re: Regression in posix-cpu-timers.c (was Re: Linux 5.14.4)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Alan J. Wylie" <alan@wylie.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:31 AM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Right, this should fix the issue: https://lore.kernel.org/lkml/20210913145332.232023-1-frederic@kernel.org/

Hmm.

Can you explain why the fix isn't just to revert that original commit?

It looks like the only real difference is that now it does *extra
work* with all that tick_nohz_dep_set_signal().

Isn't it easier to just leave any old timer ticking, and not do the
extra work until it expires and you notice "ok, it's not important"?

IOW, that original commit explicitly broke the only case it changed -
the timer being disabled.  So why isn't it just reverted? What is it
that kleeps us wanting to do the extra work for the disabled timer
case?

As long as it's fixed, I'm all ok with this, but I'm looking at the
commit message for that broken commit, and I'm looking at the commit
message for the fix, and I'm not seeing an actual _explanation_ for
this churn.

               Linus
