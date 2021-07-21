Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7B3D19E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGUWA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGUWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:00:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE7C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:41:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so3558613otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=8tFkveikWGKHyoMJpaY3v9EmW9OHfpk/4+Rv8pSLhaw=;
        b=VSje6LWppRrx41vMaJH8+az7aeUTBbPPEmHq2CfO0WLP1LmVI48yuoLFKY8ummLolh
         MTW6XiUtEh6dc7mP5cTDNdk5DzLc+hmxu142zujZynzE6jYN8aqkm+kNKx7ZCMj/vZux
         SU20wbkOWK9sYoGRkbWnhwHYHDJIoGo5qgOkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=8tFkveikWGKHyoMJpaY3v9EmW9OHfpk/4+Rv8pSLhaw=;
        b=s6yp9WzMQrELqCdgflh+kxHW/UZEbGimT05QqTTuLmVoHZb8pBJjurGGytiEUWaofl
         ahFgdxjf/VfABbMCL7p7pixYTeuHYQ+4tLy7W8/t+rUkq1uO4zodoDY/Ca36EFNKuYo8
         UjR7B9VPoCwsnSt+T+zzDKsk0sgKF/CjIG29w0503xO9QHFsJea8U5GpwU6UiMaZWLzz
         0PPldm7G+qNCRUSkC1cixRLSu9jF6UIIGGuy8YvBZ3WP4Thbs8+L9woWFbD/wPYpkxUL
         Tg2kdINA4YW9YrA3t+bYJ/60mARipu7I8u3QBWj/nsOO5prw7G7sWUtS7QVZvTnNcXHW
         gzHA==
X-Gm-Message-State: AOAM532LMG6Yoxz+BBwBFApFEw454qkQxhnpCVBX2oiWKoFULO5LY5Mq
        1AuLqAmRSOu+k9DP5VHFF15CNAgFGcsxsMbhn9JB/Q==
X-Google-Smtp-Source: ABdhPJwwtgsrtyqzBuj1DRjgsHKLLxHFhAJV/T2ZW12VgttzYji/bsI5Wgec8BIoUSxqV9yPHYFOb7uz+/+23sbio8Y=
X-Received: by 2002:a9d:650e:: with SMTP id i14mr27568157otl.233.1626907290064;
 Wed, 21 Jul 2021 15:41:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 22:41:29 +0000
MIME-Version: 1.0
In-Reply-To: <1624365748-24224-4-git-send-email-rajeevny@codeaurora.org>
References: <1624365748-24224-1-git-send-email-rajeevny@codeaurora.org> <1624365748-24224-4-git-send-email-rajeevny@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 22:41:29 +0000
Message-ID: <CAE-0n501_+htzvSp6pgMxxUaWMeZ7qLSKN1fXNWbNX1kwyYgTg@mail.gmail.com>
Subject: Re: [v2 3/3] drm/msm/dsi: Add DSI support for SC7280
To:     Rajeev Nandan <rajeevny@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        robh+dt@kernel.org, robh@kernel.org, abhinavk@codeaurora.org,
        kalyan_t@codeaurora.org, mkrishn@codeaurora.org, jonathan@marek.ca,
        dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajeev Nandan (2021-06-22 05:42:28)
> Add support for v2.5.0 DSI block in the SC7280 SoC.
>
> Signed-off-by: Rajeev Nandan <rajeevny@codeaurora.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
