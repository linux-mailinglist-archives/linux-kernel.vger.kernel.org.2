Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E19322673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBWHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBWHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:38:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:37:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l18so1303644pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=u2B3IIIwkE3tgEdHTrqZs1u7oe4Q82f/4lKWEp4CuHk=;
        b=YG/IfjbXpTPsLkY//1Oq66u1FSpP8z6m6pLikJX/OBt2hLZFSnbhCOwKPzH9kHYpWk
         8Lulk03729p0ljUjIArcVFp7KKXyYs5PDtqmigRavM4Lef5Gna0DHqRvpFys+SBZzHJh
         UnqdD9exrv2WshbPxk0NU2X6/gg7Qv8Xuzltw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=u2B3IIIwkE3tgEdHTrqZs1u7oe4Q82f/4lKWEp4CuHk=;
        b=LB4ssWnx+eMMMwinbuYRJdGhghuXTWZEKIH55rYf7ccRP3XHRo/O9bFe2D+s1PdDD5
         52klcd1CbbcIsVaEGjqeT0/BYc5IMfD1AcD+wV2kM4QT5BfaochS8sTfxAprbDzxl5Sd
         u6zJ3/QG2IaSgdZhSIesPWCdrm773W0ApJp6NozpRCBSHvuUMomvxvIgcEvExGnQ32Tr
         RNyYMq4emViF+FTf7Tgqf4G46wwvtvpEB+zlF5yEuySZ0Ve5h/aJoP1/t7j31aeZjIHz
         1LdDzCuc4rX5v6Fi2L93zjWVkhv7lIYYdoeFtbgI3FBgf/kjXbR10r74FgAiJy8NHI7s
         sE0Q==
X-Gm-Message-State: AOAM533xak5ubRfzcQinmOz+PwyfoNXMa+2t4bbMznDDEZcDpJQ1VcYb
        TzfQU/EEFUc+McTGq92SysqYaw==
X-Google-Smtp-Source: ABdhPJwq6E7Y5lLL0pkr+fRs1hZCScUZO3u6xiQIT8tahHLwG7WQlsyJtQniukFlG4b2jpQGya0PYA==
X-Received: by 2002:a17:902:68:b029:e3:c8ea:a562 with SMTP id 95-20020a1709020068b02900e3c8eaa562mr18463103pla.23.1614065860847;
        Mon, 22 Feb 2021 23:37:40 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id 25sm22560084pfh.199.2021.02.22.23.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:37:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-4-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-4-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 03/13] arm64: dts: sc7280: Add basic dts/dtsi files for SC7280 soc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:37:38 -0800
Message-ID: <161406585892.1254594.9748953968478715173@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:40)
> Add initial device tree support for the SC7280 SoC and the IDP
> boards based on this SoC
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dt=
s/qcom/sc7280-idp.dts
> new file mode 100644
> index 0000000..428f863
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 IDP board device tree source

Is it capitalized or not capitalized for SC?

> + *
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280.dtsi"
> +
> +/ {
> +       model =3D "Qualcomm Technologies, Inc. SC7280 IDP platform";

Because it is capitalized here.
