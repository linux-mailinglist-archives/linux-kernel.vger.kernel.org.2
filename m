Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5766F393A54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhE1Ai5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhE1Aix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:38:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB59C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:37:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o8so3203608ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EJyL230sUGJ7FYl8bAskFfDImHioVidSIkfFtVBm5k=;
        b=QWC+LnGn2/j6JHDZA0b+m4Pn12Zdge4U29CwEBpr60R+aPGYkL5NRw0IbwuZLFLMOq
         hLu2SlfKLvUZacIP0khm/XRtrGHxL3XEPPhr4WClSZc76Pt8PGrm/xCIf/RAePSyya54
         w/7X5YmoCKlP3swqK+TWxvEiw67JCtX8J2Jecstbq3oSszUDse+PXxAXcBvqxpevSd9O
         fakPPnt6XUCMB/+prpyH87uEfvvQZtO006Vq1ao7gNJQDh8t5DxFSvlevNLgacClwEhE
         td1uhIXAEKRe/v96dK3ZOMMPIG+VHX/Su1rHXXhxuu8PpB9018bWvqU3uznc7/8a3lxZ
         EBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EJyL230sUGJ7FYl8bAskFfDImHioVidSIkfFtVBm5k=;
        b=uKxg6uFogVDr39UQdkP2Tsq14EZP4lvDWt/1kymPMMML75NCdlCLbvmLai6+MDVPEz
         L/c6UONh6ki8l1esUEk2PUueGs2i4mgnARj0nfHSJlUpXbLa4wqGY6m3Xoi6aZdr93hJ
         3jbBt7aS7yV45ZIFVxZ6na8w/RnzTubfr9ACrRJRc+UhGtzdD7RhJXmWR0qcDIdUGFAk
         ozqAASUEFUHZU2fxniDbzueiWZIcY2WdlW7ibC+cncpgr8btYbm+rZaD9/RgigmiBn3A
         yNpJlgOAqxyj5biRnec3dqdTNB0p3bmgS1GmAGHVaJpibWElYirG9zOIqedZd98xIZP2
         gDWQ==
X-Gm-Message-State: AOAM530GRyKNht7b9TO7JunF83MDdNN/PXyIDZ9YFy06rhnfwm9k6XEj
        h+RjoIRRlkbS7P7TqbCUow+h3aC6aDWSrnBaCrZh2g==
X-Google-Smtp-Source: ABdhPJzZ6qTV/8JeZnOkzC/1UQEdStXm+k6vCIGjQI9iYGwZP4fJJ3eLK9d6xGFJwMAB/GPG7O4UWGNRWe8oEWK+O3g=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr4530166ljt.200.1622162237391;
 Thu, 27 May 2021 17:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120539.3267145-1-robert.marko@sartura.hr> <20210524120539.3267145-2-robert.marko@sartura.hr>
In-Reply-To: <20210524120539.3267145-2-robert.marko@sartura.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 02:37:06 +0200
Message-ID: <CACRpkdbB8JrSGrGpwdoL=H+ZBuQm=a+Za3c7pip9foMKhey03g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: Add Delta TN48M CPLD GPIO driver
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 2:05 PM Robert Marko <robert.marko@sartura.hr> wrote:

> Delta TN48M CPLD is used as a GPIO expander for the SFP GPIOs.
>
> It is a mix of input only and output only pins.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Looks really good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
