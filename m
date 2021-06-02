Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB89B398AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFBNdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFBNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:33:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45128C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 06:31:10 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i4so3874521ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNER4NQtwZ5xWdo+26Tmrkvw8GRzt+nxDgpp1wW+2Ts=;
        b=QxqPoJT3+KN4MMpNRXYccWtL45RfJt6GvLyC3rs+GlQu2BuPW/9us9JE3jwLiulAU/
         sWLYoHaC/44+yyrCfQg3i6XYqcwFC7bE1Dnf/Fj6UpGip1in5LcBwIwjrVflPXPDpXFW
         xCtKFN9ZMpOZL7KxXYAegOa6Rsid+p0bPrNv88V7Px3+0w2Di9Os78OPth0fgO5OcegR
         Uwn2b14dQUy719Sxrq7p06/Peq/hr3uiX5BKool8KsZ2E0nu0eLLghnDrFziXVWpRYCB
         1OnKHThVBLUgwpQthQSPDfKHzqLcjWcXmSDfr1LGahyaR7oqB5zs1tefhlZj8c6GxAii
         uvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNER4NQtwZ5xWdo+26Tmrkvw8GRzt+nxDgpp1wW+2Ts=;
        b=T88j1AW2CVDeXRmRQ4txuUdkcU+Fqqc2te0ADA9BNCBa92Cr8jN3rNnOWFMDV6WmPy
         ZJMoFJo2RNtTuDruhvwAEJrhi6A3CkJyp9puYstGOGGnWAdxq7DfLF1FOxLuzdUxXaBC
         xQRTc8BMCdNyd2Gi6sQ0zAT7/BGLymDa6DGKaIZUIf3/kwIo4ERGPB+SbYBrgP519dK+
         f4nrdEVLYFWlfQhxetCiRS4jjNT0DqUaCOX5+v8bYaKgHabHrILa+Og8TO9+Sab2EIFs
         M2PIin1Zt9574P1cgdPK8RjC737UYMhhLXg8Edz9cx/AWt/qnE1TgXYx7pi1RrKJK1gJ
         mpFg==
X-Gm-Message-State: AOAM5338CDP27gbm54kESAhBmjCdjkIGF9x2Gkfvrz+Uj5VPv+0CVCpS
        yhHKJtJPIFH40POcoVFP0sEeDUscXdSWU2mRM8u/kA==
X-Google-Smtp-Source: ABdhPJxQPDE2xGfYkRSOj4oxRSKoBW1LR7SjHN4xu3Y58xs2ZK6P1q/ByomauopvW4wJJYm8IrTmKibl1oFCNtpIUL8=
X-Received: by 2002:a25:8804:: with SMTP id c4mr47260792ybl.469.1622640669520;
 Wed, 02 Jun 2021 06:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210525045717.20652-1-navin@linumiz.com>
In-Reply-To: <20210525045717.20652-1-navin@linumiz.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 2 Jun 2021 15:30:58 +0200
Message-ID: <CAMpxmJWCcHYs1wkhqcdUdc74_mwdJOD7WwcDFwwCs3cp16+zRw@mail.gmail.com>
Subject: Re: [PATCH] gpio: 104-idio-16: Fix coding style issues
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 6:57 AM Navin Sankar Velliangiri
<navin@linumiz.com> wrote:
>
> Fixed multiple bare uses of 'unsigned' without int.
> Reported by checkpatch.
>
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> ---

Applied, thanks!

Bart
