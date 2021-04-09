Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C778735A425
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhDIQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhDIQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:56:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D9C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:56:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g10so3034691plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rewoe3CU6NQhZHn3sKpNWMwFtGUPcxHkscQhvZ9rfgY=;
        b=FD20Y6/gmNZQlAQWsrniTXwDZhO/AZ3Ye/ZXFigtco4P5Y6Qe4xKgwzSaR9K6XCXPm
         /Gxerme/sOn8neqs/GhsiUBBfekgS902DMOEXoWrGpKAy+0avJ2KLZnwXhtztzBjP69B
         wPsd/lV6jNOfrak6CNHplcO/FYi5tPEcKwTyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rewoe3CU6NQhZHn3sKpNWMwFtGUPcxHkscQhvZ9rfgY=;
        b=MhNAnM2JgG4ps3F5TPJDzVDcffhE98oFvepbGltcJdJTWXzU39p3013+550v0n2h8x
         CBmteVGbVEB3TIZ7fFibuojenkY1h7ps5cATetD6z9JdHLCetIxlBZnpZKfNHMzXd0Bz
         fYRpEFW9jd951UuNDkW6FyCL1+2hJ+deVhD7fHaddM/dK+5883kz36YowKdqQ7h/v3fv
         Nk8b1fhZDyOJzAXx/NE0mqCGP1J35FINmcn4oGMm1IhB85EZh0dRuiVR7mGOy/wvwfMl
         MIba3Oja3VH9RA2V8lw0LB4cAwVQ7ohL4h3B7kFIWq/lsSViyLt/hCIq9EB4ITgDrjS/
         R6Xw==
X-Gm-Message-State: AOAM533B5mwc1m6/zPyPTbzQRKq63Pbmft5FyaUjDo0xDnTNfIr3Odgy
        OTC/vKJnm4B/w688EvbbprBC7X6jFXoXlw==
X-Google-Smtp-Source: ABdhPJzUc03geYAbLcQczqCE8qtvhv/bRTUXGG1B2mx1gKHENLWZsorD3aooPgWhugvVASb9R+cYrA==
X-Received: by 2002:a17:903:2281:b029:e9:f78:751c with SMTP id b1-20020a1709032281b02900e90f78751cmr13787318plh.19.1617987381289;
        Fri, 09 Apr 2021 09:56:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id j19sm2304895pfj.127.2021.04.09.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:56:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1617968779-28526-1-git-send-email-dikshita@codeaurora.org>
References: <1617968779-28526-1-git-send-email-dikshita@codeaurora.org>
Subject: Re: [PATCH v4] media: venus : hfi: add venus image info into smem
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, bjorn.andersson@linaro.org,
        Dikshita Agarwal <dikshita@codeaurora.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Fri, 09 Apr 2021 09:56:19 -0700
Message-ID: <161798737958.3790633.17357856004042185175@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dikshita Agarwal (2021-04-09 04:46:19)
> Fill fw version info into smem to be printed as part of
> soc info.
>=20
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> change since v3:
>  added dependency on QCOM_SMEM (Stephen)
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
