Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97783AE2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUGNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:13:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u2so3946356ilk.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrVnWD4uqk477BZlRoS6bPA0gBVrgjlmN2CjO1g4ZrY=;
        b=b7jNAfXK+9+FAA00prZSOHK32v7G04pvd7XGXWaJDoQhAgeyFKeHtahoZQXX8mRdKD
         w2BtpOuAerm7s4/3jQS5LmioFE0lk9cmsNBWko9c4CIQj3xlFNaWaXL6qtdPNL3RTEiQ
         HMrTXeM5ULR2LfmbFT5EFF1U/l6oFfhYtJbWVL2VA6FNHdlepozCGYkuT2kI6I4ZZrLv
         z1wFIIR+feiCuHNLR9McO8u0fhUb7p79WQjUrAKmqOm5G15paYZODcS/63w8bvBVX3nC
         Xvk5XQbfM/zd9+F7YJZrGCw/mQ2HnyvjUXdSOA0RMBS1pldze0IjLhKiqg0khW199GnH
         AZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrVnWD4uqk477BZlRoS6bPA0gBVrgjlmN2CjO1g4ZrY=;
        b=TL8A528+u6BBbuxuP2ZlPbXP54ZWhSDWTx37hSoV2chAVHe2BNS3fMgur9M+hLs3Xw
         DMgIzRqa6v0nAEcZ8f0MvyaAaly0632uN95j3IjIcYtrDFfTsHKPyxCELB0I2ySOzOIh
         r6JVAuAWCP9p3e+sSD3YJSBGsfpn874zKHWF5eZYfSqH//Y/2UtawIp3KyD4HAuu+mty
         1G8Oka40bU5SSUNMXsAUaDt0c8WCO4pUlYrv+XP4M7C+3kVncNQgape3M5IzldER6leg
         AEswTyGT8xPW8JHxpi5gOe3JDIweXimH3SUKUtYKut0kL0Y98fL8pRZWYP5HuDSh+F02
         eakg==
X-Gm-Message-State: AOAM533GFzkOprW5PDEl1OBkVSH4xpkJpgX+H6qtLsgUrkFQkFRnmRp9
        iG+7Db/ZOwhf2EjbK8pWd4TRs7Md2MzXG9RTbG7+Jg==
X-Google-Smtp-Source: ABdhPJyH1zVl7wIiAFgQ8e1e8lUbGMzodYIhXDk676HPCNCBJlym94W/qbDfS3mva7wU9ICE+EAx0H0frj0pQnM7DGY=
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr17552207ilv.204.1624255894489;
 Sun, 20 Jun 2021 23:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210620134954.15233-1-Christine.Zhu@mediatek.com> <20210620134954.15233-4-Christine.Zhu@mediatek.com>
In-Reply-To: <20210620134954.15233-4-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 21 Jun 2021 14:11:23 +0800
Message-ID: <CA+Px+wXG=KDRKzm-bS95tnmpbBTCD3C72nhi3RJGw6PG6Cj-hQ@mail.gmail.com>
Subject: Re: [v1,3/3] watchdog: mt8195: add wdt support
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     linux@roeck-us.net, robh+dt@kernel.org, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, linux-watchdog@vger.kernel.org,
        rex-bc.chen@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 9:50 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> add support for watchdog device found in MT8195 SoC
Please write complete sentences.  For example, "Supports MT8195
watchdog device."

> Change-Id: Ib2434cf2d47a2e14916056f08a4fc630569624ed
Remove the unneeded tag.

> +static const struct mtk_wdt_data mt8195_data = {
> +       .toprgu_sw_rst_num = MT8195_TOPRGU_SW_RST_NUM,
> +};
Expect to see the of_device_id (i.e. mtk_wdt_dt_ids) has the newly
introduced compatible string and use the mt8195_data but failed to
find it.
