Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90F341900C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhI0Hg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:36:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33362
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233175AbhI0Hgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:36:54 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DE7E4027C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632728111;
        bh=QW1BragpkRXGqpPQtCbMT32Uw58ORtzOcZAUH+jmJDY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZcLwETBzp2BCIXca5O0BNRVgk+AiclQeEhJD51jI/kDLed18r+clUUEg2SDKKI04k
         j510jMSX8g4hNPTljg1BJYOr7I9aIpSiiudTIBYJ/I+lWuCd1+REjSaVYFtHUUikx7
         uC9cu7W8IHK4RzvnV+CR3CzUR0Gynz/ZG6gaIDFtbqBMnYwnEvSYSF5wTEOlP4DA7C
         Npns8omYD30jlFHlxLElBDyBwToWMZwh6HkR9Et5npQKwKyUgsqgTBPHTG34HhsnA+
         t5Y4b9VbNik/h3dKch7unC123vJG3It1gtz4Te/dIA6KMpYiAqoZB3hdEVyx3n/Ywg
         8GKoWQuheG9Zw==
Received: by mail-ed1-f69.google.com with SMTP id c36-20020a509fa7000000b003da5a9e5d68so5957162edf.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW1BragpkRXGqpPQtCbMT32Uw58ORtzOcZAUH+jmJDY=;
        b=HGvLIsmkH/D965xyK/zEGm4JJMXisLmlWTxi0Sg+DwiPflSdTJzkqvsyYNg+EUpK5i
         4jOsjF9Mv8NTwfB6W1/STyhwwB+DbAPPJOOJl/06L1QG7YwCEOe5a2Rhbtv1zlPclBY/
         G4tfqq6pneb02xMrtIy3kV5suj3JKvpQFk9rUalsKcnC97BgWheDQ79mtX/0rQxMRk1N
         J1s1d0QjERFzPOOp8jlsColszVdy810d/lgh/9S6BQmiCo32y+Ijayu46rzuR8IPc7Xe
         8Of+Y/d/zgF/qQHZjbuXDWHFuXNp2Z26vcl/sxj35m9kZbo/emFYsXArXGTHEuq43R4I
         9zDg==
X-Gm-Message-State: AOAM532Dw07p3MnCBP1lebgL+jDkM3c4GIm+jYurPh8Tg1s2nOaxUuc/
        NKzWAENd0xGTmUcFhogHOF6nLU/rZhFK+UdHmdM2/P2PQtApBEozgbgQcA2vvr+oVhCokN658Wf
        y7jPIUmsbDKI82kLJeck4qSLdi4k2L0++dfbItdZdqcBTpXEzIbHGO4AQ3A==
X-Received: by 2002:a05:6402:21eb:: with SMTP id ce11mr6169673edb.153.1632728108028;
        Mon, 27 Sep 2021 00:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJw4wrJGwWTTWYy7m6jHnl15+/MkdfpdVxqxe1RSoKdBcPdtYUwYT3UnN/VqD+B1h1FwqdsxpK7taJ7DhKZqQ=
X-Received: by 2002:a05:6402:21eb:: with SMTP id ce11mr6169667edb.153.1632728107888;
 Mon, 27 Sep 2021 00:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210924091439.2561931-1-andreas@kemnade.info>
 <20210924091439.2561931-5-andreas@kemnade.info> <a5ec87f2-7e72-9c23-e13a-75498287b451@pengutronix.de>
 <20210926203314.7c187191@aktux>
In-Reply-To: <20210926203314.7c187191@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Mon, 27 Sep 2021 09:34:57 +0200
Message-ID: <CA+Eumj50L-bbVBX99Q-6y1-o_R58JvJFsStck+O2-18qJSUT1g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6sl: fix mmc compatibles
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <lst@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Sept 2021 at 20:33, Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Hi Ahmad,
>
> On Sun, 26 Sep 2021 08:54:35 +0200
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> > Hello Andreas,
> >
> > On 24.09.21 11:14, Andreas Kemnade wrote:
> > > Binding specification only allows one compatible here.
> >
> > This same change was NACKed by Lucas here:
> > https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
> >
> > I also think the schema should be fixed instead.
> >
> well, that argumentation makes sense. Feel free to drop this patch. I
> will not repost the series if it is just about dropping patches.

The argument of using a new DTB with an old kernel, therefore
prohibiting changes in new DTB, does not make that much sense, except
when caring about other systems which would like to directly reuse the
DTB... anyway it's not that important to fight over it.

Best regards,
Krzysztof
