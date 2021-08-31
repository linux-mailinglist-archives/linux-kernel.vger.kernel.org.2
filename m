Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91BE3FCCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhHaRxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbhHaRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C7C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t19so518150ejr.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ze2Aqq27Af2fdeKR1i1zDXmwW93VCnlnbimVWDec3Bk=;
        b=tsSSUC5OcHXYQ8cJ4PJU/vnhXr4i82TGMPCQfv04vaeGnyoRU1jUplRNQEuouJx6DE
         u4kOckyysKNqxISDGjQ1KMzqYZLlby6WchdkE15Irg+m0On1VPMuamVg65W6EaWrrG1w
         oC3/2CvkehvN6YfJZvAEqfH12DgpMBZUTfJiuhocUDsfIrMLt1v8Qbf1xcXDbRn+PGIf
         1RKrneYfx83nTnC/JtxnwYTJkerXxolNSVjjC0T31C9gHOsCtXcjcY1RxunFX30vV3Nl
         GR9IsZrt2UuFjEbivtYPA7ml5aFwZQYvlEQoMj9ctDmk9VG8HrwuD0jUO1ZjKhO3xaBv
         TJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ze2Aqq27Af2fdeKR1i1zDXmwW93VCnlnbimVWDec3Bk=;
        b=J1Tj/zFjPLBxLMvM8EBkhRDGg63fAnKvAZdTK5sTK9SaR6DA4Stvzwrg4O4ODC0XH8
         nBk6QonfuT2nmCqtl3g7bOvk5Gbt8WaF8Ek+MudlLT6ctwgyXLP7hc29C+fjazdgpuXc
         xsTuiHVrR65r8DGDuWy3mfhU57Mvc2dxA+IlhgWhQiaq9QmGb5jiMOkBWoeZFTjdf4T+
         nOKpAuQQSUJKnUX+w/wr1cXbZUW9k8iP4+GO928sAgZdmkqIh+pP6m/hXMD3o0sdGBik
         b1lG7Uweibhf9Wblj8+2sat7iZW5QcZ1x6dalYZPBwp4/g4sQk8IGYAZqj5OhAqd4uki
         YDSQ==
X-Gm-Message-State: AOAM531iqUCirZoRDkT9Xwmiml7bq01Jx6gjB6QDwgPe8MTJl0mnxgz3
        U0rjYtTYhy28jzsajMSsIZe+Ho9qn8C1nxNDV7yE0w==
X-Google-Smtp-Source: ABdhPJxYT20tQB02iDN9/k3Plact2Ft0ubhn8cVXSwFM8bwVHKSEStY4OftEVGC73GRzPySKVTnhWcDniO1zhUfREXI=
X-Received: by 2002:a17:907:92c:: with SMTP id au12mr32605562ejc.523.1630432362026;
 Tue, 31 Aug 2021 10:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210717000345.2345429-1-willmcvicker@google.com>
In-Reply-To: <20210717000345.2345429-1-willmcvicker@google.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Tue, 31 Aug 2021 10:52:26 -0700
Message-ID: <CABYd82aOKn0wsCWS6K2kPZ9zho1nkRPKq941g6Z-V4fKZD+jiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi: set fwnode when a mipi_dsi_device is registered
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'd like to send a reminder for a review on this patch.

Thanks,
Will


On Fri, Jul 16, 2021 at 5:03 PM Will McVicker <willmcvicker@google.com> wrote:
>
> This allows the fw_devlink feature to work across mipi_dsi bus devices too.
> This feature avoids unnecessary probe deferrals of mipi_dsi devices, defers
> consumers of mipi_dsi devices till the mipi_dsi devices probe, and allows
> mipi_dsi drivers to implement sync_state() callbacks.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> v2:
>  Thanks Saravana for the comments! I updated the commit message and added your
>  reviewed-by.
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 5dd475e82995..469d56cf2a50 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -222,6 +222,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>         }
>
>         dsi->dev.of_node = info->node;
> +       dsi->dev.fwnode = of_fwnode_handle(info->node);
>         dsi->channel = info->channel;
>         strlcpy(dsi->name, info->type, sizeof(dsi->name));
>
> --
> 2.32.0.402.g57bb445576-goog
>
