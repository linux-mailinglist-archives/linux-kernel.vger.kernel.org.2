Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1C3BB696
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGEFHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhGEFHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:07:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF880C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:04:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t17so30287091lfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZVX4eT3B7Nm/OGF+XAiEc62jgHZwkAo/MjUxL1pluA=;
        b=g8FZck8lzNIbA3se1q2+eTbTHf4nnCuhCP4BT1v6H2bb7BifxKIR/oSqx0wBszdMHC
         0FfCGl1PBiPZtngEp3rMd7q5cigS0bBol2V0ySFX9Ps3spfspz83FJj4oMxjratShkYk
         VWQ7obstYPgMbb3Gbrh5PtI9I3Cq4209IdfLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZVX4eT3B7Nm/OGF+XAiEc62jgHZwkAo/MjUxL1pluA=;
        b=AVmxub62xWVf12gtBEi0ajFKGBsGI1yQZr2DDwrntN4ctzZh52PF1l4PLGnpF9cNcX
         VOVLdZRmL318RpVMog6RBhw6NOXJwKBOtZ4bTo+yky0gfmZjd/LaXZwjXl/eZ+/CjIRO
         uDhZI1X3vU/jvMJak2mlSieamXdi1D7zHxdvLn5bOp6pmR/TQ1laNkc4dNQSE/lwa5y6
         K7PD94BiSQDRI1p0oKe7G4fQf2F8NCykc9aKQz9brKAEgTTTgBrF++Ah1VC0JqfE0I2I
         qKv2Sa74qAgRwx8wwk2Js/zNwakiMYvNVuIlegEDdIwINXzCCwwW9GFeY4RCKXo2C+Yg
         b3Ng==
X-Gm-Message-State: AOAM531MMvpm880cxmBW5fzqeNvA6rnUcy7FP5hFtMkpLxUEa5vfpcoa
        izpPiIy3o8rX+NfG0sbs+GXqnMpg+H+TZA==
X-Google-Smtp-Source: ABdhPJx56pC+ctYyXYoj9MVJ6Ny32iTVNO5K2YE1LN6V127KhHTUU+RHcfiLTAQ0HQnIBiuaFG1QUQ==
X-Received: by 2002:a05:6512:3fc:: with SMTP id n28mr9218978lfq.546.1625461491981;
        Sun, 04 Jul 2021 22:04:51 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o2sm965794lfr.201.2021.07.04.22.04.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 22:04:51 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n14so30191760lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:04:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3e11:: with SMTP id i17mr9353285lfv.233.1625461490550;
 Sun, 04 Jul 2021 22:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org>
 <20210519143011.1175546-6-acourbot@chromium.org> <9b37044d-f909-9169-3d22-fa6c5f788822@collabora.com>
 <082ffa69-1280-f5e8-f8ef-a1bb6d2bc8c5@collabora.com>
In-Reply-To: <082ffa69-1280-f5e8-f8ef-a1bb6d2bc8c5@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 5 Jul 2021 14:04:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXUqwKFRHVC2aBjW=iG66uABrvhx3qCmp012YOF7rTn=A@mail.gmail.com>
Message-ID: <CAPBb6MXUqwKFRHVC2aBjW=iG66uABrvhx3qCmp012YOF7rTn=A@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] media: mtk-vcodec: venc: support START and STOP commands
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 4:44 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> >> +static int vidioc_encoder_cmd(struct file *file, void *priv,
> >> +                  struct v4l2_encoder_cmd *cmd)
> >> +{
> >> +    struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> >> +    struct vb2_queue *src_vq, *dst_vq;
> >> +    int ret;
>
> I see that the driver return -EIO on the ioctls when in state MTK_STATE_ABORT
> so you should probably test the state here as well.

Done, thanks for catching this!
