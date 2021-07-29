Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFA3DA1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhG2LUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhG2LUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:20:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D84C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:20:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 185so6596626iou.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZk79eZwy6x+5Des0crP9loTl+BHfLniFPJ8a5R3MHM=;
        b=N9S73oZEJsM8IaumKtSaen8iSrm90EsGjAxvIsq6mvLqFdg840yVPe55yu20oDM675
         c9QYyK6NVKWNimQ3Ez8XY1IYoGzyqgVr5Q8N/T7Da0Mb6Tj2gUoANAYJGxGarT8ws+8O
         8o+nBI+FGGRRsfXDlBDOlS9m55FPEXRa8ho7xvIj40FcFhZVRc63J0YxBKvkRmToGbmD
         LxBLzGJdyp+DfVt4gP7AQFmK0sWsZ6IPCQ0UiWHmPMM29h5qZAHUPvp/LbasSYP1C+QX
         YNpFAqGyM8taIrfNucEPw4Vjem5ETSJzrkTRal8f7varvQfsKDXQP1k0uY9YK9zRW5Dq
         cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZk79eZwy6x+5Des0crP9loTl+BHfLniFPJ8a5R3MHM=;
        b=czFwMVGQRpG9XMHfFe03m7i+Aw7vFfQOtIzTi2oYFG8V/sYwa4vcRnLgkipMLZyv05
         +d7IlbPrPstGQnrM+uhtOVzm5dv5tY/j4TyaY87XfOTf0uUleNy10SaY8lHa62H1pAC8
         t49fMAKhE5tPuPM9U1eXyG//5OtByb5GqGUpUeR92QonoLWO+M2sbcIj4TlIA4Qzrd4n
         djTNjNitWMAZ6AyVx0Cz19PXVbokCDCFEdGh1ztNM9g7erNL3cUXksG84RvhQKHOWbxY
         Rs4pesOsk3/GJHxqWEOsE26iPYnHAiu6Z6KfT4N+c2U1MlsoKD0WGpw/45QTn5CgVRKK
         KYJw==
X-Gm-Message-State: AOAM53234SdYwNfsP2cNeb58iwJ1nDhjgaC1fYTNHHDjGsDbF8CoQLsg
        aJIAeVBbk4h0+loaXgyFLq082ZwhCFPgyDWt23syUSbE9ogY6eOr
X-Google-Smtp-Source: ABdhPJzzBojF1/sBh9mtvv1Ulm2hDVIQ9aPxqmxd3Y8oGPLcI41CcWvzCrzT7v4F9Dw4BJCcmV8ftQYB2KITY9k99PU=
X-Received: by 2002:a6b:490d:: with SMTP id u13mr3818153iob.176.1627557641844;
 Thu, 29 Jul 2021 04:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210706114120.197-1-alistair@alistair23.me>
In-Reply-To: <20210706114120.197-1-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 29 Jul 2021 21:20:14 +1000
Message-ID: <CAKmqyKP8HKERLS3ckOA3wwpiv6J4tdFXn8-d6wXxDXDGn5iN=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: sy7636a: Remove the poll_enable_time
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 9:41 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> From testing on hardware the poll_enable_time isn't required and
> sometimes causes the driver probe to fail so let's remove it.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Ping

AlistaIr

> ---
>  drivers/regulator/sy7636a-regulator.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index e021ae08cbaa..c3b34cac8c7f 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -13,8 +13,6 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/mfd/sy7636a.h>
>
> -#define SY7636A_POLL_ENABLED_TIME 500
> -
>  static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
>  {
>         int ret;
> @@ -61,7 +59,6 @@ static const struct regulator_desc desc = {
>         .owner = THIS_MODULE,
>         .enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
>         .enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
> -       .poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
>         .regulators_node = of_match_ptr("regulators"),
>         .of_match = of_match_ptr("vcom"),
>  };
> --
> 2.31.1
>
