Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4842B0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhJMARI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhJMARH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:17:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E798C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:15:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y12so2782335eda.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k45RlmlAaGBhyanz62XVynKsrYMLkebENznbPDj5sVg=;
        b=PABXwIUguT5icS4wpRPu1JHzn9c0/tkhD/v57MEsnBL9F+9RgkYhRB/LS0h4zV5hsY
         8XYk5eOXwIQLYSoFc5XRn1CSuCzYDgsAcALBOQY70Ogy8leYEti4oUaZ8F79y8QfaUJB
         xmxiLlRDfq+WQgZ1rN4a8toZeh8JF9XVftR1lrIpl9Q1/qRl4KAuZIouWPgd07oUltP4
         iWU117MuoloJiuoIsDgxUUrM06h0+0xJWmPkfQTPRnH+X2d4uPmaveo6x+jLgdq/lLHf
         iT4f0dTtSchAWk3BajNapLVGMoLfJq3/WZkf/rqeT5sRszXV9rIK/eg03BZ1Ke3RESom
         LRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k45RlmlAaGBhyanz62XVynKsrYMLkebENznbPDj5sVg=;
        b=zBrrGgdMvVFVu8WsDSYJPdCz/7DC/59eNHa/95uxK6wmjJqgXBA8AQPnSpT4yJ0VVA
         DZllsKCurdVUNQCjU9EJzg47CSI03dENLq1bB2euU7IHFqNJ0hT0Vd+c/uPwgWqCvo0E
         y2sw2wW1hoidns7oVToa9kI13Q/dWqBzOHvBxS/GpAZZbDp9OAwGQlQlTKEHTBOQp9IX
         kKFawyh41JMQ2NHQId3/xjdEM8LBwYE6j26qKZ7k4zt8pxtsvuC/Do1Cw1SYbx3ccDEE
         c3+v8m4flnSXh0JZ9PJDXzm5CtX/kzYoaSfVOdy2vow68t9s6T4CVcDBR4PAiqJEZZBn
         DDFw==
X-Gm-Message-State: AOAM5333meqoeH8X3rKvDZXe3gCSwI/cRmGRY2V7uFsjwhBcqCNcANQ2
        rYrMnsffZcjcpwbLTz/U3BxkAucJfnXqxr6Usl4eaA58
X-Google-Smtp-Source: ABdhPJzXVKj8PQPYA7eRKaS1ZaXZbhjLzQsPW54s2aDQgexslT0oigZ3wST7XX/ySt1Uj33jnHu/e63NrYh8VqYYAiU=
X-Received: by 2002:a17:906:540f:: with SMTP id q15mr36921869ejo.189.1634084103683;
 Tue, 12 Oct 2021 17:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <1633518606-8298-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1633518606-8298-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 02:14:52 +0200
Message-ID: <CACRpkdZuJDPTi8dL-PpkTVe9VHVjvHGO_f_x5CbBCoTjN_wwBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pinctrl: uniphier: Introduce some features and NX1 support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:10 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> This series includes the patches to add audio pinmux settings for LD11/LD20/PXs3
> SoCs and basic pinmux settings for new UniPhier NX1 SoC. NX1 SoC also has
> the same kinds of pinmux settings as the other UniPhier SoCs.
>
> ---
> Change since v1:
> - Remove non-existent groups "usb2" and "usb3" in NX1 patch

This v2 patch set applied.

Rob's checker is complaining on patch 2 but that patch just adds
a compatible so the warnings must be old? Please look into them
anyways.

Yours,
Linus Walleij
