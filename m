Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F1E392177
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhEZU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEZU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:28:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3286C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:26:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s19so2797926oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=l48jC3erVA2+3dsNyPrwjVQi4loUlksxzkUCOK7XbBY=;
        b=KkO4x62ipqLrd1vB/3ZYMOoeF6E0oF8Toceds26PSo6RX0C4IJxsuSHLQtScA5IUve
         xxSogbqN2ttnf503Xc5rqVGuGPwYC3l3mdyAYFaFHzhnNIugTpleG4bgQP9FVupa+gG3
         4nQahMZ4ccd9OEegpeReNeb3M2nCo32/bYG4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=l48jC3erVA2+3dsNyPrwjVQi4loUlksxzkUCOK7XbBY=;
        b=uHSE2uUiwhH5hRVmugOIrdTcA96AoeQJqGrGDTGgej2ulNsSY6xaye0D2CvfoTO+nL
         95CWOA6wPg02Byag49g4WCOapyfYVpW7024WUa7rjFBh27xlACj5r9cB+zxtTTNLWZha
         T99D3zpHijf6Rkf+xmsLWAck4ZFOyNPKy4jyhgEeFCc9SUwopJafOVLsrAie1xR7P35N
         0xOqky3D09lrIhzF0/s94N0kA1XWvbGk10GsY6LpW/1MR4yM5J2IVVTEQjHyBw4Hu3va
         oXN4NRETYSdedF5vZUbkKi0ybTLOmfVKNYqXPeRxAlSV4TKWQH2fWFjPHcmML9WBzWwU
         48vQ==
X-Gm-Message-State: AOAM531XfByktIArnswV6yZm8FThjz0OdLs0kPIjMyNzTJ+gtB6JCVVw
        QANvmUtG7n9ocdeo6Un2H+BGrPdXwqA4Qjj3yDIzlQ==
X-Google-Smtp-Source: ABdhPJxqrw0FFEVLVjFne4yQD7bjJsI0jl4IHyHVIGIutGLKyBUZOBMKCKTW55HPplbIm8j1D9R31kxOtPaT3/KMfS4=
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr3308962oiv.166.1622060807146;
 Wed, 26 May 2021 13:26:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 16:26:46 -0400
MIME-Version: 1.0
In-Reply-To: <20210526034500.954219-1-gwendal@chromium.org>
References: <20210526034500.954219-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 16:26:46 -0400
Message-ID: <CAE-0n53Z1D5JH3zQD7q9_SZhJXnDjxpY68zHjFeLfDcCnhiTcQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec_dev: Load lightbar module only present
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gwendal Grignou (2021-05-25 20:45:00)
> The pixel lightbar is only present on chromebook pixel (link), pixel 2
> and pixel C. For the latter two, the EC reports its presence.
> Instead of always loading the lightbar driver on all chromebook, only
> load it when reported by the EC or Link device.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
