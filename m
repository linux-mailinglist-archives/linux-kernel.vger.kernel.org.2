Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6A412D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352802AbhIUCzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244776AbhIUCbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:31:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB6C0610D1;
        Mon, 20 Sep 2021 13:13:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g8so65992321edt.7;
        Mon, 20 Sep 2021 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dR4/lhVHAxdBMrf2l8iqTQvZFTrPiPlWzRgao8asiJ0=;
        b=RTssrEulh4vN7Uct44nzZvDjnp0xgzT9LiRMxxKpbK5bDd1uBUKow+korSVQRu4jNV
         noiDkfqXgjpyHIemo0OeI4whzF5kenaHEt9ke/Gi5FUhpKcJ0YKKuBoz4VkpcclXXUDF
         oHsJWrj653aPWopqk4YJUPOlPPFoLhon41Maj6CaJ1/f7aibreShTOPPlgzr0f4q8cuc
         iP3P0F9dUuH/Mp8X+kpGGban5CBBaqtMcnZb0BD3aNu3A872lrraE64jqRWEi/kZWpMC
         Ge2epQ6EYQVICq58kQboozGnS4ZHy2/KA3cgDZ8Jui7tLv3l0GeHTTBZPDaZB/9uju8o
         2zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dR4/lhVHAxdBMrf2l8iqTQvZFTrPiPlWzRgao8asiJ0=;
        b=B9oaRvjAbhn3+0haLzStftg9xTFnXk7SYCg2LSnns8fvK62qdug76ay54VDWBu3pUp
         gLhEygjQVsCsmVKjuvw4g+TYCseoMe1BnvzHgi8A8pno3QxFoDHrpLRlyjTPPr276ttR
         gQs0TfAnewmVMessw1wjEQffASXl9ZFKQ3/8+xaLU6TZ6tyZcIVgL529pfrDInr8X4n6
         jH1LG6EEoD7A3yvuUtbEv8ZiiRrLTmXzxCvWXoXfrFWle4OCsv8OyS4Da81m3rEJA5p7
         rh8YwWV3u2U0Oq4MTVB4h5zpF+b+5EzZJpVa1E0ZLxCyIZZn030OeZn1JUcMXtfGfNXE
         O3RA==
X-Gm-Message-State: AOAM532xMHpTB2mS9FZ9IWzZbGMvcOL8opylvg9csK5ePf7Ds9tRapSd
        Du5iCyMFruvsvWPuRoY8C2XscYWNLlEOn/BipOU=
X-Google-Smtp-Source: ABdhPJykha88lAtEjDw4utgviMlQGet3s/RO4J57yPvYMCAZsM5108Hbq4yQWIlsQ1UQbrh9tNMJyBUyADjZ5mhbIoU=
X-Received: by 2002:aa7:c78f:: with SMTP id n15mr31252504eds.338.1632168804644;
 Mon, 20 Sep 2021 13:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210919202918.3556-1-linux.amoon@gmail.com>
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Sep 2021 22:13:13 +0200
Message-ID: <CAFBinCBK02mnf6nEGFi+ZLUX4irAHL720ujms8NJxRe_NZC6PQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Fix the pwm regulator supply properties
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 10:29 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Anand Moon (3):
>   arm64: dts: meson-g12a: Fix the pwm regulator supply properties
>   arm64: dts: meson-g12b: Fix the pwm regulator supply properties
>   arm64: dts: meson-sm1: Fix the pwm regulator supply properties
all three get my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for working on this!
I haven't runtime tested the patches but I expect that they will work
in the same way that the Meson8/8b/8m2 patches with the same change
did.

Neil, some of these boards are covered by Kernel CI.
I suggest queueing the patches in v5.16/dt64 and then seeing if
there's any feedback from the auto-builders.


Best regards,
Martin
