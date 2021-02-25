Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D0325720
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhBYTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbhBYTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:52:55 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA92C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:52:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o3so7291639oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ubftFICBe+xc2b6VsURDalW/YgMMEqag6pD4dPy9Cmk=;
        b=V4g3JeNbnXeiPdrtVQSaYRHzjTOncjyBfnOH1o31pN7qa8HwCmU2xTayjnmZ4zFs4g
         parcxDdm7uY2Ckg8WdE8nhgEa0ksJbGlCbQjIz1+7vtZDmYOBwxsxo4Nxe478LLusFWV
         294g4R/cH1FJlYsTQNBMmzNu3LvO5nIgE+6Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ubftFICBe+xc2b6VsURDalW/YgMMEqag6pD4dPy9Cmk=;
        b=fgvUf/BNRf9FKZsL4irNF0Tk8Z0ZeaNakU85myijnvWo3jxM0slVTdUSzqkVKzV+y6
         g+znuWt5tY9in8pKrojgBsxJ3U8cHPJJe4x9f1i5PPNSv4gC5KBtXe4d2PaDoRlRQsLD
         GgUmuwUA5qrDt/gTH6MPGghndKkinOTmZ7pOLZTnqXYidFKuYZlZmSHL5MahmvIDGHwa
         cJqV8RHqstAoY6qxiugZWlvTQmFRviLL03tKDY0YQ5DyYNyhiVi814FlG4Lsv2hl/ENY
         cditdsejmgP6gjKDTLQj8HX+dXVXHBZsoZpAqW5hkTJwmC23htCop+GZvFPCWptCLmu+
         C5jQ==
X-Gm-Message-State: AOAM531ShwO5bKx4UW2iuchCLQdMgHDkeVKr/rjc64dkIp1y3QzT+T25
        PxrvKHq1Ug/P5Wlk+fZEzSc2XiYyqCbY2w==
X-Google-Smtp-Source: ABdhPJxZl+EMCqOQe15CxSOuRIi5HkysaDzLib2jIeInqCJhPrGK1tbbURV3KCeOBZDlygJf+oL7Bw==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr19398pjb.166.1614282342610;
        Thu, 25 Feb 2021 11:45:42 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id n6sm7173925pfo.201.2021.02.25.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:45:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
References: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sc7180: trogdor: Add label to charger thermal zone
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Feb 2021 11:45:40 -0800
Message-ID: <161428234069.1254594.13177534882874278728@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-02-25 10:33:34)
> Some revisions of trogdor boards use a thermistor for the charger
> temperature which currently isn't supported by the PM6150 ADC
> driver. This results in bogus temperature readings. Add a label
> to the charger thermal zone to facilitate disabling of the thermal
> zone on affected boards.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
