Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE26F3F05FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhHRONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbhHROMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:12:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A30C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:12:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q3so3384331edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB91atCKNaWXZ4G9jJEBMaY5XPxe3TqKcsNVpOzbuIg=;
        b=DTpujLDvvVlnCM0pQBx0BGUvqOtWu8KBNz/CCnb7ZL5qIIyj7oaB3Y+4sG+KNhUGLW
         QODJIvfC/DH/QkIFP9RbwFPkJPfBFs6cRwVYwKnmsLfbvPwhM5XuQKyQMvEihdS7/h6a
         OliQ4yemaAPXBuf+QpGJZJSXwNRm2FepmDXyvB0z4o3M3N4/pSvlRBHUwQM4y8TYj31K
         xcA7guBOAdi/pbrejynrby1xf9Bq9kk5S2qRJ1gsLRTlU3LWDAxGLOU+yCb4SY9qZDqC
         H8sTkMkmtdJix9r6CICDC7d34EnN+F4Si5DBumcF8AzLxuik7TCkS+UPlSlqiAZLWKfv
         YiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB91atCKNaWXZ4G9jJEBMaY5XPxe3TqKcsNVpOzbuIg=;
        b=pXAqlI44x/OkdSAAiKgOAo6kRQRUZCU/rHspjVC5QSrSIzY0R7mTsljHX0tFZK+340
         b7g1e9v0NRikyjkwjt/GhTiY1PfgCQ1F1l9HNcz41ZmAsrB9kgigfhGOHKobxWjl6kqt
         6zOHfj5u9RTHmHdArTFE4gWsGdQ5srPIXjpmKLGhnZtyswuVYKwM78BLLK/cRmuMuN93
         omPr2hRWOqp0zhNPkWdGI1MHach+9rzkeIeELu0S9Mhdmee4wqxWzAJOf1bPGYGGUqB3
         sa1NjSdn+G6hznCNPdGfi4G2TWoXuUKrc3wm83DpSM6OiuoSOg3RYkHXTDCNyLFznY8H
         bVdA==
X-Gm-Message-State: AOAM531XGhCHcCrPds3MVIc1yBQhXAy/maFd7fQg1SLGG0QQJ6YJS+2F
        FD3Ivf2R0TmRxYA+fFELufNlyfGcuvRFFsGarVuHiA==
X-Google-Smtp-Source: ABdhPJyCq8sH0IgDkVaL6YJK/HNWvHaqTzC1UOGz6EehLJOQW2PJ8Uo0EyT8gsWJU0/XrPvHBEQEwKmT97rUZZwiONY=
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr10261665edt.362.1629295928412;
 Wed, 18 Aug 2021 07:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210811025801.21597-1-yunfei.dong@mediatek.com>
In-Reply-To: <20210811025801.21597-1-yunfei.dong@mediatek.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 18 Aug 2021 11:11:57 -0300
Message-ID: <CAAEAJfDWOzCJxZFNtxeT7Cvr2pWbYrfz-YnA81sVNs-rM=8n4Q@mail.gmail.com>
Subject: Re: [PATCH v5, 00/15] Using component framework to support multi
 hardware decode
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        George Sun <george.sun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+danvet

Hi,

On Tue, 10 Aug 2021 at 23:58, Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> This series adds support for multi hardware decode into mtk-vcodec, by first
> adding component framework to manage each hardware information: interrupt,
> clock, register bases and power. Secondly add core thread to deal with core
> hardware message, at the same time, add msg queue for different hardware
> share messages. Lastly, the architecture of different specs are not the same,
> using specs type to separate them.
>

I don't think it's a good idea to introduce the component API in the
media subsystem. It doesn't seem to be maintained, IRC there's not even
a maintainer for it, and it has some issues that were never addressed.

It would be really important to avoid it. Is it really needed in the
first place?

Thanks,
Ezequiel
