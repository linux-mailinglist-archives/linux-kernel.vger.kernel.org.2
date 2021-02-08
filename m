Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2C312F32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhBHKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhBHK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:28:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC29C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:28:03 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id j5so1113953pgb.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTp7udRkA3dd9a95DV07tgoiccHtwyBSjPKDtzZunfo=;
        b=e0Tn0I9XipZXByn0gqAsbWHGHwvggsizgJKiSlTjUCw6e26/D4lxqNzturp76cfDzY
         aPf72M1s2NE+7EZu81q/TMpPlh6nHZ6YJVgginoB8q6iubUk/4eEqN39psNOdFb3qQUL
         6nX+swa3yUsWz++0cCXzfXFw44RFcrxfJ4vjVug4PC1zOe0bLnvjQXkdYmkWXbyDth6X
         r3Cxbxe+fYEvLjMk+KmOhnpYYScKA/PgBRTr1V17mcoOM3ZaugAO2poZljsOZiRfPHn1
         ZYcphn3COqjQ0aR0PQnaLBgJ5KUjRQN8MF9LyOrliQCmgkW79IgQR8ZWaou0AA0rLzp9
         p57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTp7udRkA3dd9a95DV07tgoiccHtwyBSjPKDtzZunfo=;
        b=NFLwkgdqOpxz8ndb21oOXOWaqhdlGxsmn4q73Aa7yXsjxtx9Wn8UnVC7Kqso6duzUp
         WPZii20gmzT/M6BaACVsGtRk0Djp4GDCz6zA7jt7Z80Bx7vLtxoqDP5ALMTUJ3OEuRfT
         FtkcVMSEy6hRso77kyeafn48N8Wh5N963YOS2fx7cI+fyctN8wYG7r8HZa8+c8FW2jta
         NUWv9ou5J/MBXtDPPqdZXOGtxe6nlpstZzozYS8JFU8+5/RnLeANwHHcXthf1P/CGJ6w
         vOfZ6+XioXAZLSNXlXJq973oPfbj7c3rz7oqU9k4/8lw/ncFHjbJ1qXcLBpewFU61kfn
         LE/g==
X-Gm-Message-State: AOAM531qtyTd1X2PFethb+pKCgfIiq17/X5Lc0xYdiykvu6k7gZHTBIT
        gXO6KEX46C3I+ukh+r3Ml5j5ItXFvExLK4abmQ4gbg==
X-Google-Smtp-Source: ABdhPJxB34MNMwiU8/Kb3s3oSCJIPktd60uCekFOnvb0yo//2g/M2/R4HDZA4Ujeew57zrKclcJII8arYrvBJ52Hd8Q=
X-Received: by 2002:a65:654e:: with SMTP id a14mr16656393pgw.265.1612780083089;
 Mon, 08 Feb 2021 02:28:03 -0800 (PST)
MIME-Version: 1.0
References: <1612689000-64577-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612689000-64577-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 8 Feb 2021 11:27:51 +0100
Message-ID: <CAG3jFytz7p+3g_tboutC2qCNeNqZnTUJcn-cH-5TAmaWaCPByQ@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: convert sysfs sprintf/snprintf family to sysfs_emit
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jiapeng,

Thanks for the patch. Feel free to add my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Sun, 7 Feb 2021 at 10:12, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/bridge/lontium-lt9611uxc.c:858:8-16: WARNING: use
> scnprintf or sprintf.
>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index fee2795..3cac16d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -855,7 +855,7 @@ static ssize_t lt9611uxc_firmware_show(struct device *dev, struct device_attribu
>  {
>         struct lt9611uxc *lt9611uxc = dev_get_drvdata(dev);
>
> -       return snprintf(buf, PAGE_SIZE, "%02x\n", lt9611uxc->fw_version);
> +       return sysfs_emit(buf, "%02x\n", lt9611uxc->fw_version);
>  }
>
>  static DEVICE_ATTR_RW(lt9611uxc_firmware);
> --
> 1.8.3.1
>
