Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28A93E1C49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhHETRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbhHETRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:17:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE6C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:17:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j77so10818219ybj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1oBE/JZctwvY9/E3kDE8FEQNmppbr9cSRzTu7YvZ0Y=;
        b=rZfImNjUA9T5kYuCxueswObm20x0VPHWXchNYL365Azxq1gGu1PAXgS3u43OZdHt63
         L3YrcUzdcNpaMRl45/HmLLPPq80TpJFwS9qo1+nP7gblD72Qw40IZSkxJhXw4nS0Ubla
         0HvcfnDlKReBLGi7dVJ8KZbFx+PtPOXOG1x+XqaQW/tr6SENJtnAcOJtlt1b08ANYuTR
         t+x/AhkkIRluEZUVwP1CD7gse/Y5rzHvAx2m5AWMPWgKltQxYCQRr6rOaX0T+CLfDv+g
         3KZXQNdHM7U8uc/AIwd/fyQFeoxrK8ld3tHAVQaL/rf2sMUWRy0GwA5w6EIemnLSnKOT
         8KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1oBE/JZctwvY9/E3kDE8FEQNmppbr9cSRzTu7YvZ0Y=;
        b=bJz+fa9aevTqbj1/4cEUapf8+mF1Ln/+qOhTev/rMOdnExhdayKHDkMy7qTBqwRNQA
         pKDoW/6SjavFLmCO21GeFO5lqMTYvOdX4b4AP4H69t84XGB33d8cevtDWsjQLH0r5oYN
         3Jnh7BcIM2PTIBHOQK/qjWAhHN3V+5s583Zn989ktLADX5A8tOCXZ0ja+N0KwQkQl+aq
         zxZfRCBlDca3FtJ1R6abqHmOQfoEq2QhMvTyBXWV29nT7UfFQsL3lUF1JhLfs2hb65tl
         rHVKEaAO5aHY+DtwisAOCHxp5XgVOn5IACJwgxIDcSJO1GHJ3iPvKG9GPFRqeKPHmxV+
         9lrg==
X-Gm-Message-State: AOAM530fsqvkYXDrKjBgcX6c3VH9UiO5GnxsES/dTFAOOqJpR69yaZfP
        XWJf7Yb3q5rlaMoxsJYFJSWEOPNNApgPLouRx7F5Vw==
X-Google-Smtp-Source: ABdhPJzEJr19LH8WK0U19g0Yr7jCDdGqOaGwS1PQYJwN+sYLUCJZhrl+cK4j5kR6Igy8OtSgXgk+Sqbbi3+WJsaIfIw=
X-Received: by 2002:a25:2d50:: with SMTP id s16mr253020ybe.469.1628191051550;
 Thu, 05 Aug 2021 12:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <CAMpxmJXfUterUdaGHOJT5hwcVJ+3cqgSQVdp-6Atuyyo36FxfQ@mail.gmail.com>
 <20210723031615.GA10457@aspeedtech.com> <CAMpxmJU4jN-hpNYPLHLbjx4uZ6vDqcyuMVQXhHg1BWXOqyS22A@mail.gmail.com>
 <58256e8f-6c9a-4ad4-b51e-4048b6feb42a@www.fastmail.com> <CACPK8XdfisvSzr3uWYmfd+u1UtM5+cyMBMvcDZJ+jQ38A1BSXg@mail.gmail.com>
In-Reply-To: <CACPK8XdfisvSzr3uWYmfd+u1UtM5+cyMBMvcDZJ+jQ38A1BSXg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Aug 2021 21:17:20 +0200
Message-ID: <CAMpxmJVHEj12D0RsV51YnKeD9OZUZzve2--pM9vWbBSZdrz7dA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] ASPEED sgpio driver enhancement.
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 7:58 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 3 Aug 2021 at 04:49, Andrew Jeffery <andrew@aj.id.au> wrote:
> > On Fri, 23 Jul 2021, at 17:00, Bartosz Golaszewski wrote:
> > > Joel, Andrew: can I take the GPIO patches through the GPIO tree and
> > > you'll take the ARM patches separately into v5.15?
> >
> > I think that should be okay. I'll poke Joel.
>
> Yes, that's fine. I have merged the first four patches into the aspeed tree.
>
> Cheers,
>
> Joel

Thanks, I applied patches 5-9 to the GPIO tree.

Bart
