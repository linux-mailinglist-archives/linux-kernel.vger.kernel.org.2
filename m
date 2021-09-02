Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3033FF1E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhIBQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhIBQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:56:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:55:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n27so5948038eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdjT4Us6xIPBwUlhi0ZmrboIND0msaui3k9fDHdcywk=;
        b=MRQ5J5NcSS7kJA+NVAT9d1mDsJd8/n7Rnu9sLmT8pLWh9ftJXZqtSi8PlEUhOL84AT
         tTxglMgU891q1EsiSmgMa9okBFOpmeT3hK8xZlyZNM5AUc0/JVm8rb2WBHSnACSrWfTY
         dpWAWSt//ZkKIq9EVQw25M0w5NtMLQx/NGVskYLV7hA7B9gl4D4sHJJ4zabbj2wkgAo5
         kzKWnYZ6QigeYm/QNjmp5uC2ZGgdQuzp0lAsBHa4v6wNHNoxc8xeSWIZcTglFTneUvmp
         3wKkWOPGpfOg75hZI6Lq6kSPiYOimtTBzD9LPozCWMXgYq8QzyUgG+Pkue477uU6shQz
         QYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdjT4Us6xIPBwUlhi0ZmrboIND0msaui3k9fDHdcywk=;
        b=ftGC5+IzBQ+s3TpZaSyNYDmySd+ZoKotVni4t0KAoiabv5IC8me0jUPE9XGJC+WlNn
         kyok4v7UeT6T5X5R3hVf+Q64YSaXaNdEPMikJFnCOwe/89Iz7GRQDOzXT5mXfp/5i5aF
         Qu1YEVghZ3iO1thm+0heBT+jesWfHSx11iAIthcvMOe3a/7bKkTh+REd2tykDRgokQWo
         V65HbZ1C1CA0lNVWBs3Bk656YZaoZsHxoZcttPzTLYuqtFr7Rto7EL1gjNnlsS3KzYkd
         GHs+duv9yJcTY22Brn/QAgU5PVnAfP0yCN26ygbGqnPVUzKetNrcMDbuSpIqRmil9xVA
         7dxw==
X-Gm-Message-State: AOAM53182mabjWC/lmwaC50mFXWYvnDsRLV1YyRcLRDGhgz2Cv5G8GBC
        Sy51gUsqVDC67jzzhmJLxZJpN10haNGDz5gwfsv/tA==
X-Google-Smtp-Source: ABdhPJwh0/RZoQbsfLsqpqYa2DxpxgVPhTrvfHT/R7bfvGSqtM20ZcJksUFa4sf2GDzTTqsDLOUud4ibRTEhfeHDVWo=
X-Received: by 2002:a17:906:7749:: with SMTP id o9mr4966675ejn.141.1630601738117;
 Thu, 02 Sep 2021 09:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210831094900.203283-1-benjamin.gaignard@collabora.com> <1484b5ebb9c943c72d7d7a0481c1a2cd9899705b.camel@ndufresne.ca>
In-Reply-To: <1484b5ebb9c943c72d7d7a0481c1a2cd9899705b.camel@ndufresne.ca>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 2 Sep 2021 13:55:26 -0300
Message-ID: <CAAEAJfA9Sjr78c==1tCoqja4abY2sZ++UcAT7fgBrK7wid1-2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: HEVC: RPS clean up
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        John Cox <jc@kynesim.co.uk>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans, Nicolas,

On Tue, 31 Aug 2021 at 16:19, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>
> As per discussion with Ezequiel, I think this patch should perhaps be made an
> RFC titled "media: uapi: clean and make HEVC uAPI public". Keep it RFC until we
> have collected all the needed changes.
>
> Opinion ?

I agree.

IMO, it makes no sense to keep merging anything on Hantro G2 HEVC
support, until the BLK-CTRL part is ready [1]. Without that, we can't
test anything
so we may introduce regressions without knowing.

Also, I think it's time to start discussing the HEVC uAPI as a whole,
with the goal is having a stable interface that can be used by userspace
frameworks (GStreamer).

[1] https://www.spinics.net/lists/arm-kernel/msg913881.html

Thanks,
Ezequiel
