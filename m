Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC83BC859
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGFJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhGFJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:14:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99AC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 02:11:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c28so13684951lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBkKGziaj4RSYQU8gwfk0FrmJer1D24V4dZYAbmnoxs=;
        b=XS5wTUCdxHC15PUxyxDqrPhwXwxUA3j52nH+yxpG+pfSfYIAtn+iiV4InkG5nO9rSV
         +M68go/eB308e1uJfEQgo+bf9/gZtsOHZri7NHZ68wOMy1Pcfz3NBQW0fmyEM/NiQe+d
         guci0TayPEt9dmWmJp+YYbalVT1NA+kiuaIlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBkKGziaj4RSYQU8gwfk0FrmJer1D24V4dZYAbmnoxs=;
        b=S+92GLQrkH0oFILyllNE8NVpsG/g/YHV/EsynGMnuaY6XlFMPb0sgEPWHkitUPOULw
         F1Gv85ZTRbLJBqJ6NyuiyeOwmFs8P3MojN9A83z/KyLprlSv9qNt0WNU1Na6ZNhl44o7
         bHQLePd0UvOJ8PY6PBcd98k8IdOh4/2DQoCj1V4tcyC11HiNAaiZCSvU7CsCoWEShppq
         K3iUeAS9gTJB+jZaum42ZflLlmKuh9dBfnAZwz+YFvOIDKGDHxmpi4nEY72VG7Cp90rE
         uVEk+k53WWT7Jry9CcRXYsfuFlD8vaIwBorWNBXuX7y6tbDKpErQYT8NKKdHTlvOFTJl
         a2vw==
X-Gm-Message-State: AOAM530XcjtiAoZbZigQVwq0teA3YnPQQoDGZ0uchviNH5oo3bPSCIo6
        vjBrpxmjUUoQVxpZffnDbUjj03um9zwTNn8PNX3RTg==
X-Google-Smtp-Source: ABdhPJygTAoCzUuSlXy2SSRDYl6kk7yXXtcJN9JToMMi6g5XXB+H+1QY3X3T5IW2n3XK0DbgU6raZl/fZlssaegBtgA=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr14742181lfh.342.1625562709577;
 Tue, 06 Jul 2021 02:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-11-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-11-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 6 Jul 2021 17:11:38 +0800
Message-ID: <CAGXv+5H-+cjbvivtAs0p=8o-ifkfqyWhSHBus=KBRwZW2wERLQ@mail.gmail.com>
Subject: Re: [PATCH 10/22] clk: mediatek: Add MT8195 ipesys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:08 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 ipesys clock provider

It would be better if you could provide some more context for the patch,
such as what hardware subsystem / group does this belong to, what do
these clocks feed into? And in the case of supporting multiple clock
controllers in one driver, what led you to group them in the same
driver?

This applies to all your patches. The single statement "Add xxx clock
provider" is simply repeating what the subject already says.

The code looks OK.

Thanks
ChenYu

> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
