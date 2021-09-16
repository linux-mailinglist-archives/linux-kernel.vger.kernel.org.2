Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A440ED58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhIPWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbhIPWcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:32:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3272C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:30:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so24619349lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrYe7lt2sflYjFwHUoeOnD3YR4njHBLZd1RXl5PI8E4=;
        b=mAiiP8Q2SmeVhvh6uHUOEIvZpL1iCoMmJn9rO5+lVN/XZDwHvgB3s9rO9JPMH0KUES
         YhZZjS8S/ilIbI2CEpAd1NFM1WGLizKSD0Y3vKdlXdtqSgIRp17DHrYwAhCQGHARAgod
         xbC6TnH65FMdwvQA/4cADF86FrR99WHUECrpj7/haGDD4rU0mgJjetsdlqqazdXLCkoB
         RuvAlxJRFomaMfFzu2tunCEFtPA83KAOmiT5lD7XgaTWGaIM1l3yp34KBmidb6x8kU16
         LFj1y74SpEUuGwuxpHFFA2MdctZplNPAvep3eN1lSZ5hdiLAf4hWQ3fI9b3s/fSQcG/j
         tySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrYe7lt2sflYjFwHUoeOnD3YR4njHBLZd1RXl5PI8E4=;
        b=AAdEoAkXDjk2Adgsbn1Y8gDhsoj2Fg9Yj+wfeJ+WMenL8FH/2mcdjqWp1EwoDTJo1I
         32lvV6B/7pAd9DibkcQK+vjPu84Zlk1KHRBVNgNi2S5MbvtKMgju+UY/yFGbLFwLuMUQ
         Ep4xoiBlpJCoj56ZtjwRF/FKm5NeCx/h/unfjPchxus+z4ykYH6N73fB3xgnMAXpDp74
         RaR2zGxp8DfgMuODAApXNm9KPMzgnXsC8o8HvzbbaACbx8EYsGcpAeJopPkMatnNt/E4
         Q53LR9m0pxccMBpg5XVHXBRsWxbF6GYJAEuwnc8870Qcj4hrUczTi4e1CR6walpwAas+
         AcAg==
X-Gm-Message-State: AOAM530UcAkvtKxVkQCLnUDZ6fJvF/gd5oQ0l5rzafhr7rlP45iHP9lX
        bRMPPH55yMQeVysNPie5rLkiOlblE4wq+Zphsnf0bOGSi8ox8Q==
X-Google-Smtp-Source: ABdhPJwm7ukVso2CVtclSuv0fUI6kYQMDpfOTIleiqg9oEFbmAfWsdCImK4EtWCrQD6hB1GsQZYTSSx0Au3UXPV7cII=
X-Received: by 2002:a2e:4c19:: with SMTP id z25mr553008lja.145.1631831443281;
 Thu, 16 Sep 2021 15:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210916153156.14098-1-caihuoqing@baidu.com>
In-Reply-To: <20210916153156.14098-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:30:32 +0200
Message-ID: <CACRpkdau6wCjmeQeFuadsyhi_XZQ6AATYw1okSBMOYbCoGkmCA@mail.gmail.com>
Subject: Re: [PATCH] Input: cyttsp - Make use of the helper function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

On Thu, Sep 16, 2021 at 5:32 PM Cai Huoqing <caihuoqing@baidu.com> wrote:

>         if (IS_ERR(ts->reset_gpio)) {
>                 error = PTR_ERR(ts->reset_gpio);
> -               dev_err(dev, "Failed to request reset gpio, error %d\n", error);
> +               dev_err_probe(dev, error, "Failed to request reset gpio\n");
>                 return ERR_PTR(error);

In this case you're supposed to do

return dev_err_probe(dev, error, "Failed to request reset gpio\n");

Yours,
Linus Walleij
