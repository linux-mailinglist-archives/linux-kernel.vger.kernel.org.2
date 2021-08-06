Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F303E2887
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbhHFKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbhHFKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:25:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADFC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:25:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f13so12325159edq.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mF+yL+47/DsWHQZArdqtb40AfaqAOgDr8uoJ3fcRW3M=;
        b=i5ieuuAcW5JSbO+j07fpYlK8pdDnKCDyvCHm6hQxPrezOnpEGkc+3G/oNRLWjmgqyg
         nsDNwKjyqXLa8k716U/zGpuT/OCZEANp0L1DtuHtss2AaPVeaFA9rBY2dTfIT4LKr+2o
         YXG0heX/nQdhdUKrB8aThPPbmDbdxClho9WSKRD/W1RwFBfPrWGgcIBoMc/oznd9OawV
         jB3cFSwdqbbdzNGXNNsGqeneFC0adljwVvLJ9ln7BWkVQ5HsGHrGEXWZPXAx0QYG8v7J
         WilaOA0hxXoBqX0qwzYt6BiwJ0eOF+o7epGy+WbYbxG2oIEuV29SisvzJOp/hxdpJGsJ
         O/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mF+yL+47/DsWHQZArdqtb40AfaqAOgDr8uoJ3fcRW3M=;
        b=l+NApiKktJ9Ltc/t2VUWb8XsH83Mvj9KFp5Bvdt/RolFTw9Y40cYL83Jvaz+bdEYvM
         I62h9pctbt6DHVT/jmcsUjS0NSYBdRyW2QrJSXy4Sw7MeOFGca+B7Cak6SSA8e4XiFC3
         PmVRhb591PJFJVczPiS4rcueqC4aHPQMq+Wq72QC6LbNCDPlhb+z4LH7eSO4eLtYWYcy
         HHy3uWTTv8+026QWY1t1WTa0DheSSHIoehmNKqjC0efjymrhfB/xMQq7M5PBgu/To04l
         WKoTYxgyAzgvz0pad+r/B3OdR1vayrkg8HLfz53tnmqg1bUdLjH78XYlPmHy1nddKQjG
         r8hA==
X-Gm-Message-State: AOAM531TI8JM9HEAhGJ6gOVvXWeqUzSCtN6QFdPCmNm5azmzBqhrZbfN
        GkqxdmVuL/LmW1NtmfsjnnzZNnrGt4lJ8eMla68bm2HXzDM52g==
X-Google-Smtp-Source: ABdhPJwjEXcDg0BIRl4V5dV6PtfFDw94T/qIhY1Vjb6T9s63HKZUqry3cReNSbBBInnoIbLH5RrrBAquuY/AUSTO0ZQ=
X-Received: by 2002:a50:9ae3:: with SMTP id p90mr12036657edb.154.1628245532009;
 Fri, 06 Aug 2021 03:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
In-Reply-To: <925cebbe4eb73c7d0a536da204748d33c7100d8c.1624448778.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Fri, 6 Aug 2021 12:25:21 +0200
Message-ID: <CAHTX3d+OaDuh5d=LCCQTapSkfEosyCFWrStbjBwySgK47Q4YQA@mail.gmail.com>
Subject: Re: [PATCH] reset: reset-zynqmp: Fixed the argument data type
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

st 23. 6. 2021 v 13:46 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>
> This patch changes the data type of the variable 'val' from
> int to u32.
>
> Addresses-Coverity: argument of type "int *" is incompatible with paramet=
er of type "u32 *"
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.=
com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  drivers/reset/reset-zynqmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
> index daa425e74c96..59dc0ff9af9e 100644
> --- a/drivers/reset/reset-zynqmp.c
> +++ b/drivers/reset/reset-zynqmp.c
> @@ -53,7 +53,8 @@ static int zynqmp_reset_status(struct reset_controller_=
dev *rcdev,
>                                unsigned long id)
>  {
>         struct zynqmp_reset_data *priv =3D to_zynqmp_reset_data(rcdev);
> -       int val, err;
> +       int err;
> +       u32 val;
>
>         err =3D zynqmp_pm_reset_get_status(priv->data->reset_id + id, &va=
l);
>         if (err)
> --
> 2.32.0
>

Can you please take a look at this patch?

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
