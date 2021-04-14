Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E935F031
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbhDNIwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbhDNIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:52:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E0C061574;
        Wed, 14 Apr 2021 01:51:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so135840wmf.3;
        Wed, 14 Apr 2021 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SgTS99h3WWD1mgPszmFTe76jbtJ46MHLnHqqyUGMuQ0=;
        b=Fz3NGIt8XnWPoiQNLlgvGgX2zguCjrxyGfrDYuF67IXU+FZYfc/tiRpU77lhKHmR+B
         sbeGhmDqhAZbhQv9kVpJY4uPqOEl4AjbKZFXYm7h41WNRqGQV+WQ97QPuEcPevy0OY0u
         CtyfYljhV2GcKG8co/lTtfA+ozOx0Bxz3O7EGIQs2ok02dhlqZ3DyVlshbwOPt1rSbEf
         t9HTVsNly+wFUgSYAfLL90J0Mz42RoQZTlcLgkfeRX8R0H95Rg41dri5Hq5vwlcP+j0k
         M1P6eHlbm+CQ7e6HqU69sfwL5fnIUx8chtXdLPbE+eOyXd/4PNFUM9sOOJPdqBLNbsfy
         0Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SgTS99h3WWD1mgPszmFTe76jbtJ46MHLnHqqyUGMuQ0=;
        b=FHIJpTi082NIdUbfz62wpVLmwS7NY6ntkHSZyhEf61XfuZLCa+h9JWo96yrWonc6yO
         RZqXIsGMIrSbepzSthoiAAKJs12spA7nXeRGyQnAmvExQ9A3yLZi+oIK+3e3lTiqg4Ey
         mdkyKQE3mbYdjGKsERQCv1KtL5/pwO9RjY8mXXD8Fw2o36P4zUGHTt/UHj7r7ftkwbKm
         hI+FVShrwR8Zqy9usV6pNbzb7ZcfsLdd+41cbnt1aCpwlLQYLisIdnUyVHWm3bR+YqN5
         jekPMMdoY5q7Tv8FlLQBJWhKzJkm539IuT0I4VSC9M3yaRmoYq5FG8q/DJPDKDJQbBWa
         Jnpg==
X-Gm-Message-State: AOAM532BMPtdVXl5QV2DJjYMyWGSDwsCe8Ii5oAkGm6Vxa05zhpiMYdl
        pzAx7xZMJ+M6n0vheF9AkAQ=
X-Google-Smtp-Source: ABdhPJzlsoMGmtNqfM+N+3qmXD8myVkzGZ3TeNQOfQEJ9Qx9NmrcG6bRpvhCGDTiQPkNkLctsN4FAQ==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr1898048wmg.81.1618390302777;
        Wed, 14 Apr 2021 01:51:42 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id v14sm22498881wrd.48.2021.04.14.01.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:51:42 -0700 (PDT)
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com>
 <CABb+yY1b9wD0hoBx=aYzpLcF-=EEG4QTrV68sZj8+rtf5J1aJQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2, 0/5] Revert "mailbox: mediatek: remove implementation
 related to atomic_exec"
Message-ID: <1d946d1c-1626-33ed-26ba-f840729d63e7@gmail.com>
Date:   Wed, 14 Apr 2021 10:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABb+yY1b9wD0hoBx=aYzpLcF-=EEG4QTrV68sZj8+rtf5J1aJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2021 17:29, Jassi Brar wrote:
> On Mon, Apr 12, 2021 at 6:18 AM Yongqiang Niu
> <yongqiang.niu@mediatek.com> wrote:
>>
>> This series base linux 5.12-rc2
>> these patches will cause home ui flick when cursor moved,
>> there is no fix solution yet, revert these patches first.
>>
>> change since v1:
>> add mtk-gce.txt and dts modification
>>
>> Yongqiang Niu (5):
>>   Revert "drm/mediatek: Make sure previous message done or be aborted
>>     before send"
>>   Revert "mailbox: mediatek: remove implementation related to
>>     atomic_exec"
>>   Revert "dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value"
>>   Revert "arm64: dts: mediatek: mt8183: fix gce incorrect mbox-cells
>>     value"
>>   arm64: dts: mediatek: mt8183: add gce information for mmsys
>>
>>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  2 +-
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  5 +-
>>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  1 -
>>  drivers/mailbox/mtk-cmdq-mailbox.c                 | 80 +++++++++++++++++++---
>>  4 files changed, 76 insertions(+), 12 deletions(-)
>>
> Please break the patchsets (this and the other 3) into mailbox only
> and platform specific ones.
> Also, it would help if there are some acked/reviewed by some mtk folks
> especially when reverting patches.
> 

I'd prefer to have DT and mailbox patches together as otherwise the burden on me
to find out which patches in the driver are needed, and to check if these got
accepted, gets higher.

Regards,
Matthias
