Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC73B7E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhF3HeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhF3HeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:34:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35166C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:31:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w19so3322240lfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxYiu8p2N8GfVq4zjyFWRywFohMl9B93gUN+WOKNciM=;
        b=P3dnnE9etYGaSIabOdksbhak7yrNNEj7JkC2s9ceXmf359Lo+sLDn+MN5AaMIeP7nH
         uuFlGOlo+AL2gRFKJ2sRTPn6O3eDynC6a1yVJ32Vnr9A044z8C0sghr9j14oH/VWFeof
         tYfsqbi8erpR+0ZcEnIoOakG/5XanHNAsR8JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxYiu8p2N8GfVq4zjyFWRywFohMl9B93gUN+WOKNciM=;
        b=m9OKVXJbKR3CiPc+CoAeMh7p7jYCeXWs+muIHZkNL1IeWAjK7KPjrAmiQwEYUv4SV0
         9yMJtlw6v0xbMIsOe57V7x9McJIofgfwcYQbKFydQbp2E8CEAE9K1C0R1XxatFx6Gabc
         AjffePUqVkcqnoS8O2NrIgTZyoMiTEUE8/OpRjvCzbULPLbJ9DwLRVnJSSLbkRnldtOJ
         Qv8LmC9oj7nxA06dvIYsJ+K1ObeOAeNkftv4ifAGe2KTgXZ1yGRsVJYuJ4XYLFYHOMNb
         srRNffBRHYgsdRPFtC9ikyrdWv2rp/3OswhCaZyQTrikNywu4XjjExV9VX7VsIqRLbpV
         H8Xg==
X-Gm-Message-State: AOAM530XTxHKEyDOADuxP6kN0FrggqxOJ2ZFMi1kjwe4yCmOVk5nDxKo
        YOhJiSFcDqfSV9dhj0sv5ZRhYbPOwqgAbINoIMY/fQ==
X-Google-Smtp-Source: ABdhPJwtWq5t1qxUswjy8XnO5yHQyrzaf/PASJx0qZL1yG9gn+vAucP21N28ejrTjvh3GXcAhuzEvusugeGYSyVNteY=
X-Received: by 2002:a05:6512:63:: with SMTP id i3mr26374013lfo.587.1625038295495;
 Wed, 30 Jun 2021 00:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-4-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-4-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 30 Jun 2021 15:31:24 +0800
Message-ID: <CAGXv+5F2zTcqnjH2ud38vUD149KJtgxhPQME2Mk6-vGtQv+2YQ@mail.gmail.com>
Subject: Re: [PATCH 03/22] clk: mediatek: Fix corner case of tuner_en_reg
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:01 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> On MT8195, tuner_en_reg is moved to register offest 0x0.
> If we only judge by tuner_en_reg, it may lead to wrong address.
> Add tuner_en_bit to the check condition. And it has been confirmed,
> on all the MediaTek SoCs, bit0 of offset 0x0 is always occupied by
> clock square control.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Though you might want to consider converting these types of checks into feature
flags.
