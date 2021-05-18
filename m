Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3662386E32
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344902AbhERAQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344869AbhERAQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:16:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:15:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so11346084lfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgg2j889/fnQxfXmN+eFv5gIjFubNQa/eAl3dDOh+ds=;
        b=Bp9VYB6PwxuhIJzOCUSrybM0FKwQ8JUxWCIF/avC1m4QrdTpFTWCdytz2eHp8t8m1s
         gC2wypRqOHqNXR/mkO0+AFPjyQ5I+BEWaeT4AhPxrSSdE5w3YX6jYxFWfdPrE2iW4UMK
         IUe1aHEl4hZjvfepXrDFHELldTfNd0JclGmqaDSJHrO9lke0LjIMTGssuNLj9LkE8Tmu
         ScgSRAxpftGnFVwAw09wy7NEtglZSHsGLSMGEAC9OBz9YapNlOA19bp4ZeZD1ZpcVzVp
         Fjsxwua7Iqplp4fWhzLto0Nqhb76UMzSdkijURLg22WAbkynMmXL6FecFAJZKAUdivVO
         pHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgg2j889/fnQxfXmN+eFv5gIjFubNQa/eAl3dDOh+ds=;
        b=HSqqiBt5X8yqaOWQwuvS9R4NOhvw5l6wtWfenVaDKtWsh+Qlu/ItsUHPrbLpTvLnAm
         AbbaIAGOqq7VJSSQXCiw08nRETauPOoeo4YBznXt68wxYo3icJfDJU1SChWH1G4bULIU
         7u74RoIAhq1FdhF5z3Ciu+lB2S05wZjiA93BUybMsrtmIckXxKNLQV6lf2VplvjUi3l8
         4OMi/fG4NqtGuxsYUiNde++6eV5iB8UIt2rSAI4C1+IvIE1IBDuHFL34ULFQFDg+3VBj
         vLZHNDaLWflYaWxDI3qG/1RoSfIBmPE+5kAHyt4uCGOBpfrLKfmbdYv4XP42LcYJC3ZQ
         gWnw==
X-Gm-Message-State: AOAM532gmLl10ubNorLfPuZsR8bp7faCDerUYtIOTnXZdzd8pPU15S3n
        wQjIdEOfHk0cSjCt2mtpxvuf4GmLjoV0b2WWA6LPnw==
X-Google-Smtp-Source: ABdhPJwwHCxFUtvOlL30GYF5vmaju3im/FNIdvGILw4NTZ3a5EXdIs7CMHgX5t5LVL9V9nn61+GgPorVK5PQ0z/vtt0=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr1863131lfl.291.1621296928140;
 Mon, 17 May 2021 17:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210412230320.382885-1-sebastian.reichel@collabora.com> <20210412230320.382885-4-sebastian.reichel@collabora.com>
In-Reply-To: <20210412230320.382885-4-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 02:15:17 +0200
Message-ID: <CACRpkdYFQxzPYjmeZ_wZ-79fsR6tgY9OCcPHiyRO-kiJwd0TuA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: ux500: Rename gpio-controller node
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 1:03 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Rename the AB8500 gpio controller node from ab8500-gpio to
> ab8500-gpiocontroller, since -gpio is a common suffix for
> gpio consumers.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reluctantly applied, this is unorthodox but with the prefix I see
the syntactic problem.

Yours,
Linus Walleij
