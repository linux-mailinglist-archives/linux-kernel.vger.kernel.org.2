Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C23144D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBIAYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBIAYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:24:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A431C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 16:23:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x136so4221675pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nFM0MlsDfR8VM4PPVEkKIEyXxD9NGa9iDMVral5Ujo8=;
        b=npSBDIqz3idVStJ+6xsbWqKf9jUNdMt6yrfVNgMf2tGtLpgBGTKPD6cdw9z57kt4gk
         blAeLIZ01h/gXsj5zXy8nhb21YSi2HWO42o9tGZumUirlyod4KJyhCBedGNtY0Wf5WYs
         myXPhMcRSL9MFPO/FWgac/cElFOjVYw5/9d6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nFM0MlsDfR8VM4PPVEkKIEyXxD9NGa9iDMVral5Ujo8=;
        b=TcN2jK/AnJiKWhDJF5+PiGg1LYPiCN/mOvjbcBlLw5qO9TGrXKE7PgSJ7E5AH1XwL6
         7CeAroSpcujI80Q9r/TqeUcxsoFunkZU1ZAoeggb0iFMQb4cixQPZ2TBfebhVWpmTIb9
         Zn0y7/cJsElSW5OBWR+jFXBSPYUO/MvTsWEqmeF43YurfYAKcQ2j4iim4vPEyLiGHqP1
         1GYaajcoskYA1ajUesxJahOSgblmrPCb4zAgt8Sq7bJxJ6wYUUSec6p3wp20AAeiwBst
         CLvh0/S7pYmH5DujLImhw9Rtkp/zUdM2Vm4gUijRs59tgrSenKqzwXe9klQdForuA3n8
         yZWg==
X-Gm-Message-State: AOAM5325n5oOqwMyd/LeRIL0zu3hbcySZZ7WbR1MS/gRNjt0VimzDM6i
        C1OizC5HAb6+lo7jGk3/BhFafA==
X-Google-Smtp-Source: ABdhPJzDQylLd8Wa/D58PdqAO8x2PtLWn0kpNxxwKnpo1/LYbFGRFjqZR+cWKihjhhWuFNVIHT8clw==
X-Received: by 2002:a62:5fc3:0:b029:1bf:34c4:a128 with SMTP id t186-20020a625fc30000b02901bf34c4a128mr19887537pfb.38.1612830214698;
        Mon, 08 Feb 2021 16:23:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:751a:ba0b:8918:c305])
        by smtp.gmail.com with ESMTPSA id 194sm17431307pfu.165.2021.02.08.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:23:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1612448508-9179-2-git-send-email-mkshah@codeaurora.org>
References: <1612448508-9179-1-git-send-email-mkshah@codeaurora.org> <1612448508-9179-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v6 1/4] dt-bindings: Introduce SoC sleep stats bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Mon, 08 Feb 2021 16:23:32 -0800
Message-ID: <161283021256.76967.600110253862291436@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-02-04 06:21:45)
> +
> +description:
> +  Always On Processor/Resource Power Manager maintains statistics of the=
 SoC
> +  sleep modes involving powering down of the rails and oscillator clock.
> +
> +  Statistics includes SoC sleep mode type, number of times low power mod=
e were
> +  entered, time of last entry, time of last exit and accumulated sleep d=
uration.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpmh-sleep-stats
> +      - qcom,rpm-sleep-stats
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    rpmh-sleep-stats@c3f0000 {
> +      compatible =3D "qcom,rpmh-sleep-stats";
> +      reg =3D <0 0x0c3f0000 0 0x400>;
> +    };

Maybe it should just be another reg property of the rpmh or rpm node?
Then the rpmh driver can create the stats "device" at driver probe time,
or just roll it into the same thing. It looks pretty weird to have a
device in DT for this given that it's not really hardware, more like a
place that the processor writes some stuff about what's going on in the
SoC related to power management.=20

> +  # Example of rpm sleep stats
> +  - |
> +    rpm-sleep-stats@4690000 {
> +      compatible =3D "qcom,rpm-sleep-stats";
> +      reg =3D <0 0x04690000 0 0x400>;
> +    };
> +...
