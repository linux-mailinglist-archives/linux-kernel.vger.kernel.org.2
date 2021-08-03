Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C042B3DE641
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhHCFiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhHCFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:38:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EBC061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 22:38:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z7so22162588iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vi76Iy2+G7lRArH6vuam1Hfh2GEzigTGHE+mXu3eEQw=;
        b=qLj1y6fObSImVY0F0di8u/IF17wANqqqgvULYkhwRpKAGIdln28rEco4Riz8tMS4z+
         3ZfBL+GTgm0I3uYsrPqR38H1ZePcnoxJJA5jHljoEUgk57jKKhKJvmj1uXlK8Fcrcnfw
         IYoUcNNbQStu/smuDcK/AU7hIRpe5mCbAHIJtLG4wBYq1OiM5cIO1KCjwMHyu3O6SzwR
         VSrTFDVzKDqdZwOqIY+qk3GT8nxZWCAXeKQiVxkNrWwQKgihwE1nYU1//j0WTbUzxCiw
         GlEZZTBXyEK8nzark4WGWGiA/azDDniWdirEvCdMJ9NtpU6nygtVUuN0+rQgaX56lt0I
         pD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vi76Iy2+G7lRArH6vuam1Hfh2GEzigTGHE+mXu3eEQw=;
        b=XqknfIESub8xFVfYTIp7Qh/ByqRdwSvYiSBHRbEZlc+eXIylb/A0uLY1UbeCIfcEs0
         0aq5ZZuoJStMmuaW3/7DcD2ofQOwz1URzTItnb3bo3kZszi/qd57JnYFCiLDGBnV9ZFg
         zuPUaPLGDxCmK7IvaaGZFdlSqXDQuTxYossIaXGNdOKyP7DHt6FMeQuvVQHYegB1FrtS
         PEbNTx61XnegxVBeToswKejYmhEIGXyT6dgtwBsTIwUNquCLr+OKzV/2eQnxR6eIo7aX
         pcgjCNcEiEQVVi5TD/HYd3v7JEca4lBVru9L5E+DsLD0vekhlJnMdg0rODJCZnOzIMuK
         A1Tg==
X-Gm-Message-State: AOAM530rHqkbJFhuatCGwbdiNXaQVm/ZBIOg0mmYjHjdhOrq4eKedgRC
        PsyHLEw0NMJxuz3CbUrv483if8AvWblKec2J5sSNNQ==
X-Google-Smtp-Source: ABdhPJw/2YigJyn4JYO2+qd6bLRkOERLsf4W8mUBRLblDDC0N6ey6KPmqUc7erPS6iYqy2aN3qVsIE+0gB6rMCfF710=
X-Received: by 2002:a02:ba87:: with SMTP id g7mr11453418jao.110.1627969081709;
 Mon, 02 Aug 2021 22:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210726122901.12195-1-Christine.Zhu@mediatek.com> <20210726122901.12195-2-Christine.Zhu@mediatek.com>
In-Reply-To: <20210726122901.12195-2-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 3 Aug 2021 13:37:50 +0800
Message-ID: <CA+Px+wX+gy4hV3BsTU81ThS=FUe0HidUV-iZZvQ3qm4WxKXGxQ@mail.gmail.com>
Subject: Re: [v7,1/3] dt-bindings: mediatek: mt8195: update mtk-wdt document
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        matthias.bgg@gmail.com, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        seiya.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 8:30 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> @@ -13,6 +13,7 @@ Required properties:
>         "mediatek,mt8183-wdt": for MT8183
>         "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>         "mediatek,mt8192-wdt": for MT8192
> +       "mediatek,mt8195-wdt": for MT8195
Just realized the patch has been applied in commit b326f2c85f3d
("dt-bindings: watchdog: Add compatible for Mediatek MT8195").  Could
you rebase the series to the latest tree and resend?
