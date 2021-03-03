Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C432BBE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhCCNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349152AbhCCIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:19 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3690C061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:15:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o38so15773728pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yxtjvYxwDy4QE6Dxinrti9jwWy07tpYM7l9TcN6U+8g=;
        b=MmrvzVtR0M6TwxORPSEh1fanMfMLuLHK5C/5xOU8rM9MIe9rSxGB8TiPLqtbU/iSfh
         uP0Usy3stBdrpCcHEwuQPRe/bNkreZzxJSarS1/Er83PKsemJT/6hzww7jK9B5kyMbaF
         YxD6WIfc2gndaCnQWzQ/DUpODlzqYjaZSHHjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yxtjvYxwDy4QE6Dxinrti9jwWy07tpYM7l9TcN6U+8g=;
        b=Oq+RxIEa5bYatI8hW9wg30pL8hGINPTRg3CmZzX2W2o1Am4oXx+Ep/nZH9G5LcVUWi
         evuqJ9jsTkQdO3HzpI1vEIxX+X8Ouj1dcZFZk8FPhwySVkW/Y0XZJBJFakhL4Ig63kzP
         YXh+7mYIhFkMDq1pPi671Xp1TUk+ITus1z/vZRJMdpu8ANzOB4SCSo/hE7i2/kr/A4DF
         M4W13SkXEzF9pFm1Wq2IxrFd1wQ2MPos3LSwEKafXmxGwjX9Qy4zpoa4MTNWNBvcVBDF
         JQPfxCQTOmT6iC/PBIx5IJ5xyWHy+gHO6Ce2NZ7LkyKGCZ6U2prus8hn4lg6tknO0u3h
         NReA==
X-Gm-Message-State: AOAM531vTnWQC2a7aVHVX5biY5Dj3e+kZPbg7mnHcrcLhu54oD+Grrv5
        DTJ8goL/wDp1GKUx8GuJ/N+y4Q==
X-Google-Smtp-Source: ABdhPJxJnDjMV2wBxqXJjG8jbkCxT9roJWz31W135Tjh+1Br6PFc9zDDqBxVABO/lLd+1KEz7kAJgA==
X-Received: by 2002:a62:2bd4:0:b029:1ed:6a87:e115 with SMTP id r203-20020a622bd40000b02901ed6a87e115mr2075541pfr.30.1614759338279;
        Wed, 03 Mar 2021 00:15:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id h5sm22523337pgv.87.2021.03.03.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:15:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.7.Ifd7b86f826b18410eada75758a7bca1eebfa336d@changeid>
Subject: Re: [PATCH v2 07/13] arm64: dts: qcom: sc7180-trogdor: Remove fp control pins in prep for coachz
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:15:36 -0800
Message-ID: <161475933637.1478170.1640462611497475852@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:31)
> From: Alexandru M Stan <amstan@chromium.org>
>=20
> Removed the pinctrl and pin{mux,conf} for the control pins because:
> 1. The only need for them is for userspace control via flash_fp_mcu
> 2. cros-ec doesn't know what to do with them, and even if it did,
>    it would interfere with flash_fp_mcu at the most inopportune times
>=20
> Since we're not using hogs, we rely on AP firmware to set all the
> control pins correctly.
>=20
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> [dianders: adjusted since coachz isn't upstream yet]
> Reviewed-by; Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
