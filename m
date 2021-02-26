Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7032670E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhBZSp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBZSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:45:53 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1035C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:45:06 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so6750884pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4hDbemyw0HDex76Hp+5hflo0c5crmBoyAwM2bUl3AVc=;
        b=HAyiI6JBL04RTZTPFOsONaE8F5JHgIEVyKqWeQuW0CaK76LWjKAKIEt2HPeacIKZIl
         ErD974IQtIlAQ4K8zEpmtwJlYkcsnZybDjI4Kk/CYgh4RCqfXn7MVCZ8QjlG4fnHXDC7
         zqYPZPgvOLrWYjcRIudHgr6xqZ+vQ2ITPqA3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4hDbemyw0HDex76Hp+5hflo0c5crmBoyAwM2bUl3AVc=;
        b=VbrQ711dMKTzMfO/W/48mHc8+e+1X3rVM2BpdehQHbuUNWU8yVxS9cbizGJ8VyYyan
         XLNgz9G6c3t23LGcFo7odEgqqZKgWF5pOVDMAYFyWHPwMqmoxgpfeLGYw8CsaY/znqrr
         5f4YHxfI3Cipv3jFErK5EgztFzE8fVuK9pjGZsn5wFq5euulLAt4fFhL9vgpzRbOThD4
         gnwGrYmuCzww6LPfhg2xdajoT4BNBNtJjp5Pb/HbpUe5mrj4AGt3H5HfcNP0I0xJyLSy
         ps4a9yTO9Vu5NGoFQn6RmKU3kEOViHHlXTKyjgY/POHv2ibtiiXlXTMtuk1w1JgS9RQR
         MHWA==
X-Gm-Message-State: AOAM533GUhiqaHwTwswdCn5KnhnMYsxAEg7Z2gGz8cDVnjDCvXT0vNuN
        SaYbUhaOXeprlShicieG/0kxxQ==
X-Google-Smtp-Source: ABdhPJyStxZ0/YWglvC7Art5F0mB7qtsccNWckgQDuHCF01MwhTiWNQKyRpE/pYs8XWUnjbDDjD3gQ==
X-Received: by 2002:a62:43:0:b029:1cd:2de2:5a24 with SMTP id 64-20020a6200430000b02901cd2de25a24mr4576595pfa.27.1614365106146;
        Fri, 26 Feb 2021 10:45:06 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e8bb:5726:f58b:4e37])
        by smtp.gmail.com with ESMTPSA id r123sm10329986pfc.211.2021.02.26.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 10:45:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225141022.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
References: <20210225221310.1939599-1-dianders@chromium.org> <20210225141022.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
Subject: Re: [PATCH 13/13] arm64: dts: qcom: Add sc7180-lazor-coachz skus
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Fri, 26 Feb 2021 10:45:04 -0800
Message-ID: <161436510419.1254594.15131518424468767659@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-02-25 14:13:10)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/a=
rm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> new file mode 100644
> index 000000000000..5def9953d82b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -0,0 +1,249 @@
[...]
> +
> +/*
> + * There's no SAR sensor, so i2c5 is re-purposed.  We leave the
> + * proximity@28 node under i2c5 (from trogdor.dtsi) since it's "disabled"
> + * and doesn't hurt.
> + */
> +i2c_wlc: &i2c5 {
> +       /* Currently not connected to anything; see b/168652326 */
> +};

Can we remove this? As far as I know this will always be this way and
thus doesn't provide anything meaningful to leave this bug comment here
that doesn't work for people.

> +
> +&i2c7 {
> +       status =3D "disabled";
> +};
