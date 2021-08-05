Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326AF3E1D67
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbhHEUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhHEUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 16:38:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC2C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 13:37:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so4581021wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z88e2PTu699EGNWBXDBXADLwRqUTJVwIqeZ2BUPAK6Y=;
        b=rIZ9LcL9Vj8tRxEQTdutAeodqAoWHwSe9Yd+Seu42fijyVy14gbCz/0yTn8Ag0Wc8S
         qxezv7Jd170LhbEqn7KT5REe71IyHarY1rwAVgna+1I8OtMgNRJUpzvJf+zdz/Y6Yzyc
         kFWXMecB5H+ov+7NaF0sjvmIO5vqI8sCpDBVAk/yS+ztZCmbwf/beDIQXOXxA8ZiDQtf
         Mt3nbKLtvB2N+YaRUJSo1kaKM6HgKttgmlkzXTPbrcaZVGWVZy1M5Tntet9Y9oE7hyVr
         T9kH6MdeNHeBTwABFLwqYe6Ae8NI+gXVdCLqDQtHWktOKNB3PfMf+65gJ4Dpi9I2TeC4
         iQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z88e2PTu699EGNWBXDBXADLwRqUTJVwIqeZ2BUPAK6Y=;
        b=s3kDi5V7J9gSlblE8url18JXOHtx35pqSq0og5FVK68pF01WnrQrQ1AmwcizJuK/cf
         zL+80VQ+PWfNBEV48M/62lDKFuxm6tYE2e/xjrWILLJKQG3MzSizxQp+yzc6p1NTz7hT
         yWDdfdpliQ3AzgzWM79nLrVWwOdPCN/4FrT6XbwXEjA+eUM0vMQ2awwxaYC8V65kNUpw
         bH3/dycBBnpg6v9WF7dM4a3Wn3JVjDads1lNeYyaVEKHG5qkEkYDJz4nrc4M9fDTFmai
         E0iB+ESVE9xCqcgkKSynErxFYgrXbS2WOIDd7NtoU7iFIDcfTlw6EQPOo8kvS2imu3sP
         qxGg==
X-Gm-Message-State: AOAM533QsFCnYfEXboByF/ENWR3Sej2UCs/NYTo+fdANDB082KbG1zjr
        7M0g1UgBKGpyQiKeGCB039A=
X-Google-Smtp-Source: ABdhPJz5z0n2u0xYOCUL1KUYREtPDXYSQXVHiOIyab3KPOc7WG6YmipEznV9l/TA/028qkJSEexFLg==
X-Received: by 2002:a05:600c:1ca7:: with SMTP id k39mr17582753wms.115.1628195866702;
        Thu, 05 Aug 2021 13:37:46 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id y4sm6547939wmi.22.2021.08.05.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 13:37:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     ple@baylibre.com, narmstrong@baylibre.com, a.hajda@samsung.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH v1] drm: bridge: it66121: Check drm_bridge_attach retval
Date:   Thu, 05 Aug 2021 22:37:45 +0200
Message-ID: <3283765.IqGz30O6Nz@kista>
In-Reply-To: <20210805185039.402178-1-robert.foss@linaro.org>
References: <20210805185039.402178-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne =C4=8Detrtek, 05. avgust 2021 ob 20:50:39 CEST je Robert Foss napisal(a=
):
> The return value of drm_bridge_attach() is ignored during
> the it66121_bridge_attach() call, which is incorrect.
>=20
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


