Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24173C359E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhGJQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGJQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 12:48:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D0C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:45:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so30684050lfj.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LccKoa1zF1Ue87qbczvb+yg8Tc9aMl+Aop1Gel1Zx9c=;
        b=O2rBjXyzWsIJVf0JQAX3asSn1W5GsNf2YvRAj4999quiWviTiUb2LwFQTnmx7w7OD8
         Z186pcU6lv0FdMdCYP5TLYoKSpqifwnIMGHTAfITbnhSYPBdsALl5I8WaxIbE1GDLeNB
         UeAOwHMHcUI+qvE3Yy5tYxXcyNPm/x0yWofbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LccKoa1zF1Ue87qbczvb+yg8Tc9aMl+Aop1Gel1Zx9c=;
        b=TTUee6sJlKGmqbd2RXrunJfORyLS/9wHynBekpB74Gc1lEmDU/MDmPJvD1qX1wQNU0
         kiUELUDI2j4AXqE5s3z7gcZJCu0iyFvctNRJTzEI6DwenItIo9dV+qyTqakRdg+vQv3e
         JLY+YQNEc3H5P/htm71N0et7n8/HZynPsg9DXHAR42HMLnJhG5HX6c6APTA9nzxkoMPo
         jml/gIy571ZgNvSFxHD1Ar+m2xGljGMBUAYgxO6sr/B4Dwzyp/otJZCtNdxqcAyVnodX
         CH/87//hV3Hhd+tg+9hcmT4BrHsEvrU05wfPNoT7Ka+ZpE90075oLA6BEpB/slDedZQc
         6LmQ==
X-Gm-Message-State: AOAM530Oo+pQ/J4CY9qQJuHwz4LzEknUaS711LYD3ZtODtuHYWAt+g5W
        Ri6maRR9sAfhvjttK1FKHNVq+kKO8HNwKUAj
X-Google-Smtp-Source: ABdhPJxMmMeaLnmiewvJ9hxXxTtQUDU0Cx8oYeXpogJvj+XkXUftjnQqS6uB2uz3zjXkpot4WfBTuw==
X-Received: by 2002:a19:4907:: with SMTP id w7mr33387742lfa.136.1625935528967;
        Sat, 10 Jul 2021 09:45:28 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n16sm293763lfh.217.2021.07.10.09.45.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 09:45:28 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id a18so30581810lfs.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:45:28 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr3528712lfu.253.1625935527966;
 Sat, 10 Jul 2021 09:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210709234054.10288-1-olof@lixom.net> <20210709234054.10288-2-olof@lixom.net>
In-Reply-To: <20210709234054.10288-2-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Jul 2021 09:45:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2G+4K=wCnHBsiFX2HXH+zN5X_VhmMa9-RsFLL+xMFyg@mail.gmail.com>
Message-ID: <CAHk-=wg2G+4K=wCnHBsiFX2HXH+zN5X_VhmMa9-RsFLL+xMFyg@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: Devicetree material for 5.14
To:     Olof Johansson <olof@lixom.net>
Cc:     ARM SoC <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What?

My shortlog matches yours, but my diffstat isn't even close.

You show 554 commits, but then your diffstat as not a single file from
arch/arm*/boot/dts, and says:

On Fri, Jul 9, 2021 at 4:41 PM Olof Johansson <olof@lixom.net> wrote:
>
>  97 files changed, 8428 insertions(+), 5174 deletions(-)

while mine is very different indeed:

 552 files changed, 24060 insertions(+), 3691 deletions(-)

I suspect you got the diffstat from something else entirely, because
mine looks a lot more believable and matches the commits listed in the
shortlog a lot better..

              Linus
