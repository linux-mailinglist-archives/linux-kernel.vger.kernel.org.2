Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7413646091C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359313AbhK1SxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 13:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhK1SvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:51:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEEC061757;
        Sun, 28 Nov 2021 10:46:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t5so62676815edd.0;
        Sun, 28 Nov 2021 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoVtCz413kfAVrTASvnosHXITKjbPFpV1EpFdoQvcC4=;
        b=RTooAPLgR0sJ4bCNi47YrjSTcj/Psae+59W3yeV1CHFQTmiAGBTy8L/xp2O5rjHgVI
         fot2kbPDZF9FKgX97GdMKgvDHc0lRQogjGug0nUykY1CveYSLl7FplLzkRIWgslLRdUz
         1QMh9BV8zvt04IHUxCWWFTSYjfiDzI+kzQ869CkZd6CGRsvBm0Ehfu3VaF1FDJ2M2fJ2
         aCXmapBFsFbo1D9icBWrXdS47Oy4h7LeZ2TgiLP8Azkp976vs1dMcNHS5yOZQRbsqUaz
         EXyDyGfAiTuGxOypV459fhYccQeGgKjI+c0O1Ydy9MLGAX9agWfyLC+GocIPReZqzVg9
         YdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoVtCz413kfAVrTASvnosHXITKjbPFpV1EpFdoQvcC4=;
        b=1O2X51Gp7srk10VTIuligVb9rGi7yjYDj9VA3DvT0HzXkkm5AuZp3Ct4Bh8J3Low6e
         jH6Mz5MkyVnK1TOozbiv7/42JTtD4aonYJLbk+SH8v++cJiraNQt9uUGG6YUezaibUAN
         fqT/BRoCLiIjeQLTmLCUgSZMV2tg1tfW33XjLu0kK5TU/WQvsjVqD9gRQh44CYlkc7Tv
         MY/hYOXaopzjQlCNFn7dHwRovYUxMMCoSmyWgd8mf1dpeEzI1AFV0xqf0CPfTMhrHQNu
         DgGdNbv42eqa+RI12eh7Lh/b2VZURNIeN8oB4vk3fitdAHc2d3oql4WZclbY5jHpXDNm
         gd0A==
X-Gm-Message-State: AOAM530eWdL/96cbXOUw/qCL9HvqWE99sDBbgcXLNJhzIjHIwWEOYPvc
        xkRHSA+sn4M7lXCmbNXLMP80pWW4mSLC6dYQAwoD5ZUaTRo=
X-Google-Smtp-Source: ABdhPJx77owul9Ttufb/7btyttSLplWBRJyVBib5ZhxlO4pTAi9PbPoesK7sSmqnJ8FyZGHrPkhdTXgkynyRV/0emnE=
X-Received: by 2002:aa7:d288:: with SMTP id w8mr27686252edq.404.1638125181432;
 Sun, 28 Nov 2021 10:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20211128131853.15125-1-aford173@gmail.com> <20211128131853.15125-4-aford173@gmail.com>
 <YaO5kccgK9rYy6G5@robh.at.kernel.org>
In-Reply-To: <YaO5kccgK9rYy6G5@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 28 Nov 2021 12:46:10 -0600
Message-ID: <CAHCN7xLToHQ-N1fJFRhr_UBsXH20GpQ5G2ERGL4K4y_0zAoPNg@mail.gmail.com>
Subject: Re: [PATCH V4 3/9] dt-bindings: power: imx8mn: add defines for DISP
 blk-ctrl domains
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:17 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, 28 Nov 2021 07:18:46 -0600, Adam Ford wrote:
> > This adds the defines for the power domains provided by the DISP
> > blk-ctrl.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  include/dt-bindings/power/imx8mn-power.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>

Sorry about that.  I grabbed the patch series from [1], but it appears
that the patchwork there isn't updating the patches with the
Acked-by/Reviewed-by tags.

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=575601


adam
> If a tag was not added on purpose, please state why and what changed.
>
