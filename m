Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4D37BE26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhELNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhELNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:24:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA2C061574;
        Wed, 12 May 2021 06:23:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z13so33735853lft.1;
        Wed, 12 May 2021 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dZf25B7PrcC5btIzPiyCOxEBOCUjDdttHGfzzRBXB44=;
        b=MF67KVxxL2gx2lb1u4ESiqGbwR5YszwIbURCYAMviB4v2O5X0cob8KD/E6mtTINQNj
         qhatrWPMAqVv7hObkScjsWoekxxqqZyXx0usmT8d3AGBJuOIIDGra3TD6zYHhSARuotk
         2LagRKHwfKhV32z2kFT2Byam9ZycdeadCwkOG46E+kDjEO5Y0g/dgnsdZr9dAXwI2nAo
         FOVBlg35+/5lwf/SYQGGOaVm/6K+WCugn3T+V13KmJGIsxflZ8SdRfCwVBqJv1u+9yqN
         NovICJWPF73ynvZ6S7c3uFCJ2IwA2YqPWcFynjgfGYzfleKdKkcwXSArd1L7n5EDhBiI
         UHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dZf25B7PrcC5btIzPiyCOxEBOCUjDdttHGfzzRBXB44=;
        b=t9pm8TQbvM8LvVorA0cqSwEgF1wpdtbQkm/8A6LikhgORiki7xkfUElSGbxEsDOiO4
         qSNBI4JbSRwUfg05kD3IoBKizmz8EGesDxNyoh9+d0yOyM+ydvuK6E0G/AVpwjqtqeZA
         CC0XOdAtR3e/rhxhXHCpJbrtcbmrPICq1Px47WXYz8pwhqYNd5hUFzVo6SiyWnf+NPCW
         JkDiHpBk1e76a81/vdvECQ1yadIxWGyHYw5Fxr6SKmTjfQGJebo+LAggzm6PEhnQhfgK
         LTfnh0sLL3DIaDObL++PnqTAju7A5lT55ylK2b1CN3RpRLu2UXySHN73OCcsdONVCnsd
         NcEQ==
X-Gm-Message-State: AOAM532k4PTdazB669efQRAQpM6ECqWFJBO7YgYuRQrrW9f8Q77wtQOE
        6YhF/MgkIeiNUMb2lv5xWazpV8+SawCFi8U5NE8=
X-Google-Smtp-Source: ABdhPJxJ4bZVJmCBA8XaNi7ZRMpuiFwrpBrkOSrmtzS27QoOSCEP1CsHFptUkZUzxwiqY+HEYQs3UaEuITFFHOBJ0sM=
X-Received: by 2002:a05:6512:3a4:: with SMTP id v4mr24464331lfp.500.1620825804804;
 Wed, 12 May 2021 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 12 May 2021 10:23:13 -0300
Message-ID: <CAOMZO5AFp6zaL5=g7N3LwuA2egJWW+Y0r3rFHQ7tDRBAg5_FDQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Configure the OLED display
 segment offset
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, May 12, 2021 at 6:55 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
> The display consist of a 128x64 OLED panel and a SSD1305 controller.
>
> The OLED panel resolution is 128x64 but the built-in controller default
> resolution is 132x64. To display properly a segment offset needs to be
> configured.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Next time you could submit it as a patch series.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
