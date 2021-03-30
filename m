Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3934E416
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhC3JK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhC3JK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:10:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F409CC061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:10:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so15461206wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z5DCAj7NVDVNfpSZjWR8M5jLq6WPETQxdZhOG5sD1z8=;
        b=pqvv6KRbqK9UNpiG6OcQfbAr+R59ty+YH5DBQsdn8BnkaBlUPjH1FApi5Ei5VmlYyB
         zAO09LbALoY2NhIoKqNs7r5qYnslNkMOzBlTMB6ilpIy3wlXIFl76Rav0jvVmFA0SWif
         E5iIbhE4WmPWCM6pKrE2deGuEnLoxGxwztJGUVz1l+exyFTULlEIlHuQ+SE3hhnoPBaP
         UYZ/BAY/GCGLDXT5+ivGQuFlzf5TnqrUgtT6zCrcpX/0O+hjIduJhb35CcoA88K1krcU
         LMkWWzY3Tk/cQkItk7Nh0kJD8bnmvugq8ERnhrsAW4tuI92Q7SaDrk2uUrdYbi16tO3f
         Ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5DCAj7NVDVNfpSZjWR8M5jLq6WPETQxdZhOG5sD1z8=;
        b=uC10CG+MmyBMXRtK6s4eorFMWynBM1lA9FFHJfut+rLd8GFcWDJsWFYr5tFZMCaP2X
         yBBN+s+Yiyz+N4BK6EkzksZUuWsiLySGuWy8VZRNrXGaKUQXQzAYPuHLEHIqo8LTnZMM
         aJ177j8xA5X4Hsdh79GNi4/0jjNLZWcRAXSDTl6AbvVEwsEiyLClA57z0Mb/aqFJouM6
         TwzbjbNxyfrco3qI9C7m0v+YgCarU9Nwxoj5Su/o2oWONREFttmr3g+H6Le8auNZUG0v
         iJ0ZMLD7Dl8YsPNIhctLLIBRfSPNt/zQixdU1k/vt0M4OajLF1lT+AeWczrOEPzKpvOB
         xMYg==
X-Gm-Message-State: AOAM533fXvGqELoyFAoLQwWF6oV6fjh1dWp6MKzjlZpegCz8Lm5XOv2k
        gcMBIMu1M7bozWJJ6Ox30SM=
X-Google-Smtp-Source: ABdhPJweDUo0yRtRVVcnq0c+GFxDoqdf6UE26XHvsMvMeuKxVRud5qkChQn9oQJZ4jqRpXO73KvK7w==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr32243825wru.119.1617095425723;
        Tue, 30 Mar 2021 02:10:25 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id j12sm33771727wrx.59.2021.03.30.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:10:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] soc: mediatek: Prepare MMSYS for DDP routing using
 tables
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210317181711.795245-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9ae52157-c4b3-3080-6835-a6c4b349284a@gmail.com>
Date:   Tue, 30 Mar 2021 11:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317181711.795245-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2021 19:17, Enric Balletbo i Serra wrote:
> Dear all,
> 
> This is the second version of this series intended to prepare the
> mtk-mmsys driver to allow different DDP (Data Display Path) routing
> tables per SoC. Note that the series has been tested only on MT8173 platform,
> for MT2701 and MT2712 based devices we're using a default routing table
> that should just work.

That's a good base to improve the driver.
Things I'd like to see:

Split the mmsys_default_routing_table in the SoC specific one. But each SoC
specific routing table in a new header file.

Whole series applied to v5.12-next/soc

Thanks a lot!
Matthias

> 
> Thanks,
>   Enric
> 
> Changes in v2:
> - Use a default table for mt2701, mt2712 and mt8173.
> - Remove the mask field from routes struct as is not needed.
> 
> CK Hu (2):
>   soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
>   soc: mediatek: mmsys: Use an array for setting the routing registers
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 300 +++++--------------------------
>  drivers/soc/mediatek/mtk-mmsys.h | 215 ++++++++++++++++++++++
>  2 files changed, 257 insertions(+), 258 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mtk-mmsys.h
> 
