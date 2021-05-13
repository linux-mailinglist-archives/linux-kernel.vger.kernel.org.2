Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903D637F3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEMIGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhEMIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:06:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:05:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so30838010lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGYhlEtHJ4cDIvOhyvkm1Ik0yqS7El9eC6BJ8CsVKBM=;
        b=R4HgB1qbhtCEbNxBfKElzO/lZ5CpsVCPCWNCWhThJU/+wTDVcDWWFQywbKGfht7LZF
         MKeaPQXJe61GjYKxoSZ6ZCNDqlfM261JYubKxvrFPfFDhARR0nX/CwaG6icsukv2EJPt
         WZ8HLr/Z2RlsnhLSq2SFo/ZWb2QBId1KIYw8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGYhlEtHJ4cDIvOhyvkm1Ik0yqS7El9eC6BJ8CsVKBM=;
        b=nof/bVC9Rnd7FY/KMd9mdGg2K0F+BVbKL1Ee3DUfAYn0zoR0pZRy1rn6zV/ySVPq6t
         h+uH1az6SNROFxSWZfwgFK2JRjSoMSFe7e+TZDiZz5ldScEGT/5a2cJPz6xToq4nriMu
         60HOKmZ24iyw2NU5vZp5G7Xgz7CR7peZgi/BMikaCwcpwKhoLe4Thdpu2DAV+kpHB5sO
         KGZEwODlxLFu4ONg5jEXEkn8YSnMMqM7Z5JJvwC/vpy/7sVVyAZBJMnO/VdTCzvxnPva
         v2JOqEyVDCsPOS2yZna12jys44My1/zH84Mv/BUExthpPV4+1W8g/bJtFKF5+yAH6I+b
         3ziw==
X-Gm-Message-State: AOAM531icPDX+UHzV6KNP4+1NuX2oxGeDdHAGsJLf017Mcjt8Mu221ZU
        UB7LiaRgppD1GUFJmuR9iquxZf85qXyWuw==
X-Google-Smtp-Source: ABdhPJzsBQmMV0WkNMPZuwmGlW3yU1zSyJVzGxuwtib1AxPTKqghSwpnTe/HUMFcrYyoqw3aBSVd9g==
X-Received: by 2002:a05:6512:3d94:: with SMTP id k20mr27075816lfv.604.1620893116031;
        Thu, 13 May 2021 01:05:16 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c7sm215317lfv.27.2021.05.13.01.05.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 01:05:15 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p12so32821510ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:05:14 -0700 (PDT)
X-Received: by 2002:a2e:5345:: with SMTP id t5mr33513099ljd.259.1620893114204;
 Thu, 13 May 2021 01:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org>
 <20210427111526.1772293-8-acourbot@chromium.org> <faa5553f-2ea5-27a5-7f85-e1418d2c7df1@xs4all.nl>
In-Reply-To: <faa5553f-2ea5-27a5-7f85-e1418d2c7df1@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 13 May 2021 17:05:02 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUKtxCS=JbtBmvwwEovrN8NCtLmMGcTkozo_gnDMRsqHw@mail.gmail.com>
Message-ID: <CAPBb6MUKtxCS=JbtBmvwwEovrN8NCtLmMGcTkozo_gnDMRsqHw@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] media: mtk-vcodec: vdec: add media device if
 using stateless api
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, thanks for the review!

On Thu, Apr 29, 2021 at 4:28 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 27/04/2021 13:15, Alexandre Courbot wrote:
> > From: Yunfei Dong <yunfei.dong@mediatek.com>
> >
> > The stateless API requires a media device for issuing requests. Add one
> > if we are being instantiated as a stateless decoder.
>
> Why for the stateless decoder only? Why not create one for all?
>
> It's not a blocker, but I would recommend looking at this.

Would there be any use in creating a media device for a stateful
decoder that does not need to use requests?

Cheers,
Alex.
