Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B771739317D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhE0OyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhE0OyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:54:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B932C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:52:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w15so1164961ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbLxZVInwYy3qEUPV3OX+LQ3zzJzdzfdzUhZD/Ue/bg=;
        b=IXaIB0Nni2fs5B9gNNEfAvL6rmSOEETjRJ/6oEyfVHXghb3kgUg5GcpBXZZ5o+QqOb
         BpYowFocYox4Dq6gQqpolGYEgPeDGD4jrOSe0QOLHDyAV4kDhyfhux5IrYQR/3p5pdou
         a7EIH9Yl/4mrlSnTAoRB+GkwaCFAc0hZyOr1XCIIpjv8ki7NI5biYt7unOV5aZD4J6AE
         GUDpKQZVA1zZutLCkh2ESBMk5MbJz1w8dAMr+VWqPAAYVFPlKHwXu4Hk4xQizJXbrKwB
         gRQ2ILP4/A8czIxl+WoMxXeqvspc+DZTiol3sw7MQvPNITxf4Mch+I3XKX7NNkNuqQaS
         8ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbLxZVInwYy3qEUPV3OX+LQ3zzJzdzfdzUhZD/Ue/bg=;
        b=WNUm7b6T845iKP4Ihu1HiSj18wKsN0Sq3UteGu22818A2Mzi6gYuoe8TGkJwUo0NIY
         8xwcxR7ZQJ3kQIfuioOLZWHz9u24FbpkSMKIEZYbbZ8MtElaxDY5wLpnK6YyeVTyIisU
         fHnffAXnuBjmNA1yWO6SOvM0nmpYS5EgU3FC3L/zx8TGZKbH3579fqO6Qvi7Z2EQq+hN
         T3Hx066+lKKRlVgLkXV2OjPcIk/EJ9F9JFQhzXpkfdp89vnEatxXZuz5LcGxX6CNQQVE
         2SlzUgr7h8TU1MkgqNC/qWoxXrYgsymHWEU4igVbQYS/bVJMAV6/1o8XgydMfaS/Vmg7
         0DTQ==
X-Gm-Message-State: AOAM532e0lqvv8Jh8CLOGP9MxyophEwjOTYe7xwF6zh+MARFSgEyJlAm
        nSATUlik0TlyJQFdi7+qXH6A7oj62TJNMyhZvt6C+Q==
X-Google-Smtp-Source: ABdhPJyOpPFO04F64d5pjW8QNYZ4e/HRx7gpPeHxd/mRVrxX7uKsLF7S1bM0/fx10bKuhTzUYcQo7VOPcuN/I7RO4+w=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr2978367lji.273.1622127163004;
 Thu, 27 May 2021 07:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210519162409.3755679-1-fparent@baylibre.com> <20210519162409.3755679-3-fparent@baylibre.com>
In-Reply-To: <20210519162409.3755679-3-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 16:52:32 +0200
Message-ID: <CACRpkdbQtBYMU80dXB3n179QQqpD5Cp7_q0MgEX264EeP_G-8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: mediatek: add support for mt8365 SoC
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        mkorpershoek@baylibre.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 6:24 PM Fabien Parent <fparent@baylibre.com> wrote:

> Add pinctrl driver for MT8365 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Patch applied.

Yours,
Linus Walleij
