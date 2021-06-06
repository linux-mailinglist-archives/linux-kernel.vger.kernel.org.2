Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C939D208
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 00:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFFWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 18:53:29 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:43722 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFFWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 18:53:28 -0400
Received: by mail-lf1-f42.google.com with SMTP id n12so15984732lft.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HiD5HhosM/emrEAZdYOI7Gyss6pcG+u5xu0k8IYo/s=;
        b=livSg6TPBfB6EwkqK26GA5esocsahxpk9Ws4GoILwWOPBp2A6PiTejz1uQQnv1Ukbe
         l28jrxgjtvs6ugRUUpaaQITCCGMHzJYg4DS9mUYiS1ZpBFmc/V9iwhkhvAJs6VGeCz9g
         9MRQkZ0EVpBBI9XmBXkr1rk8GnW3srMoAWjO8Q3qiQ0oxaAJj//yWlrhfZ9Jx4Tnsalk
         o4f/TPInvfDSfcT5/7PO2+BPKskOJmI1U6pvlKKLOnEp1XZ+ZmhlhhH73M2K9AIbCfgb
         aNoej8BCXxLFa9E7HhCa1TrHoE0fATpePVUY2k+gLWU+ixKN/6k9LRDESe8Dg6kZLMH2
         t5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HiD5HhosM/emrEAZdYOI7Gyss6pcG+u5xu0k8IYo/s=;
        b=B7DkN17PAlZgs2c0zxHha/DeRhNnjMlNEdRvDBVjsNRvDPxYYEACMNu+R7HxPfZjbm
         J2QkOoMTF24o5tOMzW/Wj6qZwuP1W3V/9hnyAVm7Gw/ccZgwSCzEne3OPZ0WZeC+zl/A
         dQ0zwAfzDbXL+XqpDRjtfC3l1iOu7XKHOSKhCIhXGy8HJdsiowTeqXw23KfO/61A40yU
         +g7Is2Xy+RM394mUD+mZOt4gO5QnINDQMuPP84k39s0/wBk3Sb6HGnVKu8oV/cYEVatO
         tAqhAG/jJnO2LgCJH5UJscfoTdMTna9IojucO4XYFMW91Wuz/oaRvLFyUV+uaaJv+OiK
         UnkA==
X-Gm-Message-State: AOAM531afUoEJHgg7H9jJy1tUIidtvnnGHLmGXNVPkKNHe9bUPyyfIs5
        HBA8PqOHdM1tiY3OY0LFyVP/NghcUThi6CtPIOzCRQ==
X-Google-Smtp-Source: ABdhPJxS6LPwuFoRiie241fNnwRDTKf9/sDPiCKNe2Q6490BW6AvfGX/NDaSl1qkxJm0Tmk6frP3noZZ8DSbdR96gNY=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr9665431lfr.649.1623019823537;
 Sun, 06 Jun 2021 15:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622648507.git.mchehab+huawei@kernel.org> <0d437806f3f8d2c930656872be482820ef1c2301.1622648507.git.mchehab+huawei@kernel.org>
In-Reply-To: <0d437806f3f8d2c930656872be482820ef1c2301.1622648507.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 00:50:12 +0200
Message-ID: <CACRpkdYPtOWSLFDDhx-Z5DYO+_JfKGxvuvjYALB8w90=wmkGuA@mail.gmail.com>
Subject: Re: [PATCH 08/12] MAINTAINERS: update faraday,ftrtc010.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 5:43 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> renamed: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
> to: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
