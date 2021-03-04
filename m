Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87AE32D1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhCDLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbhCDLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:25:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C46BC061574;
        Thu,  4 Mar 2021 03:25:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z11so42511416lfb.9;
        Thu, 04 Mar 2021 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdkH6uGk7+7YBpvtpYA2s/VJXeyCOp8/uk6uSIcITXo=;
        b=Hj1VeFufZlR1BIkHnUW/iBAAGn0Vqq3woKHu1s4QlbeCSR0sEk+66q+qu1BtYWAy/B
         zf+zUHV3I5wHDw7dZQXljh9KUiJbY/W56Que+gltpRefx+3mgB9wV6FsYAVzARNU/I1R
         ZHy3BDH80yPtxrrdNNSZO7veHkntpDZReOUvLoEpER/ayLPuHuN04fL+iYvitTGzJJ2W
         B1G7XEa68nC3Lqj7jh8SQ6AmmzY9LkAwPgeioJVKlfJry5MUWgZq6eUBDsuWIqau8mDn
         Ev1w0bphDdFPsFU0ckzjslWCtvw4neoNsilX5fQwmsTS2Jh2Tj+vLDjp1IeK+kXhxLtX
         kNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdkH6uGk7+7YBpvtpYA2s/VJXeyCOp8/uk6uSIcITXo=;
        b=q7RwZmkQwX3Tn+uTF8xrl8dM9MQtIsZ5TQ16Mp4gWMM5aldKOW9/W9Af73MgCBR6BP
         MZlBNjjmnMAbPg2awGBs4dja6VXMBPE3fSdqseO44cYhQf9agGzs2yYmYPPivK7e3y79
         R2slJsJ2qBVu64d9QnIBIprpFLapYc1XwzJ1YCExdNE3OWN61ZNFrZZWDhPOp5rA/LxE
         NPE8XHSBa/PVICuLUY7OdoBqGiyAClAcfI6/LfDyewVGM7wEnFjjePAILr6u59aoQY+9
         a9tbnpYYCQWuRp+Qb3dwfP6v90P6R6zVlRGFD9EldREFSV2qbVEQSF4Ay6cHs5M3HDMb
         NBlw==
X-Gm-Message-State: AOAM531jl0VaixJtz9pOCUaDZY5De7LyA7VgLZNOQkJWBdNxEiiPedo1
        TyHfh00HyMJao8xoItD1K4DNvwoCDTy68z7M9ho=
X-Google-Smtp-Source: ABdhPJx61uBUr8bPAf5qE9CaMOl4dVtpaTqJQL4D+jzTmf2R7QMTWbLK7Ylu6ecXM0+p2mBVd1iOeK0LwGCgVXPlsFs=
X-Received: by 2002:a05:6512:3884:: with SMTP id n4mr2047802lft.539.1614857104735;
 Thu, 04 Mar 2021 03:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20210304093139.471554-1-philippe.schenker@toradex.com>
In-Reply-To: <20210304093139.471554-1-philippe.schenker@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Mar 2021 08:24:54 -0300
Message-ID: <CAOMZO5COBmBc=3kHHWtftaRaAjgr0LkmvGrmTkQGZ_da-5_NFg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Change drive strength for usdhc2
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Thu, Mar 4, 2021 at 6:31 AM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> The current setting reflects about 86 Ohms of source-impedance
> on the SDIO signals where the WiFi board is hooked up. PCB traces are
> routed with 50 Ohms impedance and there are no serial resistors on
> those traces.
>
> This commit changes the source-impedance to 52 Ohms to better match our
> hardware design.
>
> The impedances given in this commit message refer to 3.3V operation.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
