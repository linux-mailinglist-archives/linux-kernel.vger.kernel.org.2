Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201E03F2D42
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHTNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHTNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:40:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC368C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 06:39:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f10so5939765lfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHPtVkG/qNC2knQenIKiI0shbpxzWHyJ8ctsh+yhyBI=;
        b=wuMrNQ/Z8K+j8N2EopCNSeUwp3q35E+YBzmrIGpg4QzFWLRwLrQ+3s3kbTax6ZARqq
         MiZH9msbqI5q3w8bkGphm4ep4Co8RojNUh2U2nc2dDFOIR4R5mcJoOVOPQOknOQMc3R8
         LNqsBohMpip4CovrVE6/Zhg1K32kD4fyI0hAFzozjTMIl4uwOdnQptiuvLuGQeZ4rz6c
         8/jhJDhJkr4/o68Skcgu6xi9cW+J5zxx7a7QfbXickGmx0Hm6J5DdOWhJ+YJ245Io+oH
         /tpV1YwnQGEAIcIrQTDCXzdOPB5tmyBw6QuhIUjQsd7AtEWvK53h04xJmA4RvXC063Jz
         8eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHPtVkG/qNC2knQenIKiI0shbpxzWHyJ8ctsh+yhyBI=;
        b=c3sSeX5as1bHb+UV0yRt7rqjmat0YVvSvu8MK0s8z7XCMTtf+E7kxGafgmvTVH9ugz
         IUeE0RM1W/sQX7jKsXHNYJYkBh63JaGquDOlnOxo9HLTg8JLrggBpNimdQck/xLkDlF+
         VSpSR8gUnhtWwM/xLu/O7qXMhnmHDUgedEN7llrKi0lgH3xdQJ+pb7sUIJnZAFC6MZxx
         tuwqvAyrwISYOXYq01eefNqs4uKYxe61P3rfxaBOFdTIf0fX/QojLzUn9aJh0bXuEgzO
         RrIOITRbuCLuXDZOTsg6KV6GvR9drnXNIc6Z/BnMNUEUMRXLoZCvuqFELEOAllz4Kf0/
         jHTQ==
X-Gm-Message-State: AOAM531KaFLm7OBRcpxXgaXjyehUjXwTiVAB8NK9gkhM8fTnnd9T52Nt
        P73p862okiq3+W4i/uGQpz9WLDUqAh8k5FP6ijwvNg==
X-Google-Smtp-Source: ABdhPJzWezA8Z2Im0fwU9tluiumZk3ahPA4XmWO6Kl7rbjwfRQ+V5EIIQ3rhUBR1/q99jtfTre7lrN8vHe5hgsAb/C8=
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr14669230lfr.465.1629466793019;
 Fri, 20 Aug 2021 06:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org> <e997cca5-e6d4-1aac-4e0c-de15d7664a1b@linaro.org>
In-Reply-To: <e997cca5-e6d4-1aac-4e0c-de15d7664a1b@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Aug 2021 15:39:41 +0200
Message-ID: <CACRpkdYh6E+gCihouapFYX33U-ccJk7DF1oHax5vUS2CiqDOrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:53 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/07/2021 00:44, Linus Walleij wrote:
> > Make sure we check that the right interrupt occurred before
> > calling the event handler for timer 1. Report spurious IRQs
> > as IRQ_NONE.
>
> Does it not mean there is something wrong with the initial setup ?

No it is not occurring. This is just to protect against ordinary
spurious interrupts (return from sleep glitches in electronics,
quantum effects...)

Yours,
Linus Walleij
