Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E44508D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKOPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbhKOPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:46:52 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEDC0613B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:43:56 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n66so35549242oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 07:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CF0FJoDWOcoxyaIsOvJ8EB0JBh4HH+xggneHi65Nur8=;
        b=jgm2lSQvJGUhoiTZeMOcb0CVBcH9fDAcd3uLgIT3uxYhEdsUTrGs04sFn9a/PNQdiz
         1920PeXPR/7kBwDJRSbCQDEVwTx/MAB7IfH2/csYcNw48ATtLjVgpuU8lElBXOUFLUVS
         gDlRJi1a0YJS4XfJRNhsHKpnGwTUi/AaGxm7T3tJfJvSVG72/0Z1r16HEKY05gnEhUP+
         gyfPq1vm+R6qDV2iDopSP5Pqup9mqNOfrUXyeYYeX6TSukS443ZC4NhMaZXJ0AplepXK
         1tze14FWiemrJA2Nj6JiDX/E7qQaqI11oxirb6YiF5DeNTxap8C0D1RXjDGPMS1t/IE6
         njww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CF0FJoDWOcoxyaIsOvJ8EB0JBh4HH+xggneHi65Nur8=;
        b=rlvkL1Wb2U5mERJSayQ4wedfO00UF48ASbVZUauZs+IZTehdOExSR3m2lT+e/DbnDQ
         3OeBn+2QDPeiz5KGObivGWVE4rx8xe0uSQSloTK64DWsMgxUHuFtvwDeNqajCmYbMqhu
         UbM3mYQMulHZM+QbZM1pdCbFnL+BntmKlixUy3UpJNpg76p/HzAL3ELC7VXDFvAhsF2J
         gMuSsRRlX9d1E0bsX07XvI59+t1Neps7yNRaOeLI7nBHu6jBparl9ALquVd9nI0y0FT1
         YUtHQCZZuBxjK90EWbFnXD2JQN/7WCtsf+xqkf0HA7z052mLKTFl1nMg/DWxGrLxAaBr
         HvsA==
X-Gm-Message-State: AOAM5333dDt1PSjGFHTLMxW77VRKTGC1tQDcxfMAU7z80afOjpZ/n4QV
        Gd4rUEZgH2OIXdILVWotNwRls1XRo8GgLeINJvZUSFsQLu4=
X-Google-Smtp-Source: ABdhPJy/qNFNuE1tDibvbioZ0nHH4qB6k0p2uckGZU36eqzCLSt7XAhj4qUFfTUi+4VTuYREyd1ff1/AEzs98s3hWB4=
X-Received: by 2002:aca:3f87:: with SMTP id m129mr45850737oia.5.1636991036198;
 Mon, 15 Nov 2021 07:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20211114105657.b57pjojiv72iopg5@fastboi.localdomain>
In-Reply-To: <20211114105657.b57pjojiv72iopg5@fastboi.localdomain>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Nov 2021 10:43:44 -0500
Message-ID: <CADnq5_NF++xE6Jj32Wy2ZGALo4pOGt3yTCoj5HU37tKO3Ce=Fg@mail.gmail.com>
Subject: Re: Backlight control broken on UM325 (OLED) on 5.15 (bisected)
To:     =?UTF-8?Q?Samuel_=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Roman Li <Roman.Li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 2:35 AM Samuel =C4=8Cavoj <samuel@cavoj.net> wrote:
>
> Hello,
>
> the backlight control no longer works on my ASUS UM325 (Ryzen 5700U)
> OLED laptop. I have bisected the breakage to commit 7fd13baeb7a3a48.
>
>     commit 7fd13baeb7a3a48cae12c36c52f06bf4e9e7d728 (HEAD, refs/bisect/ba=
d)
>     Author: Alex Deucher <alexander.deucher@amd.com>
>     Date:   Thu Jul 8 16:31:10 2021 -0400
>
>         drm/amdgpu/display: add support for multiple backlights
>
>         On platforms that support multiple backlights, register
>         each one separately.  This lets us manage them independently
>         rather than registering a single backlight and applying the
>         same settings to both.
>
>         v2: fix typo:
>         Reported-by: kernel test robot <lkp@intel.com>
>
>         Reviewed-by: Roman Li <Roman.Li@amd.com>
>         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> I have encountered another user with the same issue on reddit[0].
>
> The node in /sys/class/backlight exists, writing to it just does
> nothing. I would be glad to help debugging the issue. Thank you very
> much.

That patch adds support for systems with multiple backlights.  Do you
have multiple backlight devices now?  If so, does the other one work?

Can you also try this patch?

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4811b0faafd9..67163c9d49e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -854,8 +854,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
                if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
                        struct amdgpu_display_manager *dm =3D &adev->dm;
-                       if (dm->backlight_dev[0])
-                               atif->bd =3D dm->backlight_dev[0];
+                       if (dm->backlight_dev[1])
+                               atif->bd =3D dm->backlight_dev[1];
 #endif
                } else {
                        struct drm_encoder *tmp;


Alex

>
> Regards,
> Samuel =C4=8Cavoj
>
> [0]: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_t=
o_linux_515_my_brightness/
