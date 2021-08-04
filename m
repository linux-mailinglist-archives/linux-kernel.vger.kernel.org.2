Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE03E03CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhHDPB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbhHDPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:01:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E3C0613D5;
        Wed,  4 Aug 2021 08:01:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m19so1422121wms.0;
        Wed, 04 Aug 2021 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GQYlKIfQGDZD7FjoDWhvgGxvqgy3lDL6xTNjgH07BzY=;
        b=VlQGEEEUxHdlEKHwFEl/LqPBI96Zk5RcZFcREolzaECkFymiY04eiDMv/K07o4c65e
         6pbpHwdHaBE6zEuxsxWDKWULyKmE3ob2eLFRPCvNZT++1I9aCC7lVMannu61bxB2Re52
         KB8B3XG10J5KqmK144Qeu2Sj2SCJQDhy093zRHwr95OBj3QTKjSXSMZ7SQo/5CdNq4Kg
         3/e7lrDsX24eU+nc8LTYe715HLfWJLl58MbJZGDuviX0ocim4PI4Rt89CEpiEjMNarGS
         5IJ5y2JbwKZO/3GkadcEKsogvYgmfEQETxmEkBHAgDsUQGdmasvUMZyWNWnqJo83llIo
         W76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQYlKIfQGDZD7FjoDWhvgGxvqgy3lDL6xTNjgH07BzY=;
        b=lBO/md5DhFen6x0Mr/2W+A/IqZCIb0HxJEAoGgrMTrTEnhzBc4sob9YQ/ybjI25glj
         M/TrFjdtXTnJhwRDvT8SECCuUk9KJelgmsz0Lm/DhIsAXgJ6IULxXoixCfmIcngVtxSE
         yRMKHew1o8ArrDlxKFQQyW+GvYJpkGFqr3uon9UYtZGQl/Ur4WbWy7+DzVxcS9OGEMPO
         fUxNsP1UxvmBZ0Yvlq1OkhCo8QgC0qq8GhyzELCf08P8QEXwlIRNAd52Vkqc2R7/A1uh
         TikcVzWXPYxiFa1GwcZOY7TY1LZhv3fLC3I4WjYA+diIfbSo5vbLC00wv/v+E2Em8N1R
         qVAg==
X-Gm-Message-State: AOAM531W5wC14kouAK6Dfg8ocov2RRDpO7neAwFeMmqfS+z9ptzLzcN/
        Gr5kx8CoWfs8B/vi3S4rYQlmoLCYS8J+3w==
X-Google-Smtp-Source: ABdhPJxzfcsOveuM0G0E1e5sbC3j6IImykpjnYq9eMdoePCdanTPzPJYXQcYKmILkERsf0um35DdlQ==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr50842wmj.148.1628089270421;
        Wed, 04 Aug 2021 08:01:10 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id q9sm6223449wmj.2.2021.08.04.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:01:09 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add MUSB for MT7623
To:     Sungbo Eo <mans0n@gorani.run>, linux-mediatek@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210803151320.71531-1-mans0n@gorani.run>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <638a4526-2688-e7c6-c71e-0ebaaeb773b5@gmail.com>
Date:   Wed, 4 Aug 2021 17:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803151320.71531-1-mans0n@gorani.run>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sungbo,

On 03/08/2021 17:13, Sungbo Eo wrote:
> These patches add support for the MUSB controller on Mediatek MT7623.
> Tested on Mercury RUSH-318AC Wi-Fi router.
> 

Nice to see you are working on Mediatek devices.
Are you planning to add the device tree for the router to the kernel? I'd be
happy to see them submitted.

Regards,
Matthias

> I got to know this from a BPI-R2 forum post [1], and managed to make it work on OpenWrt snapshot.
> I'd like to know if this also works on BPI-R2, I can happily share the details if needed.
> And I've just copy & pasted nodes from mt2701, please let me know if I missed some big differences between SoCs...
> 
> [1] http://forum.banana-pi.org/t/bpi-r2-otg-port/10551
> 
> Sungbo Eo (2):
>   dt-bindings: usb: mtk-musb: add MT7623 compatible
>   arm: dts: mt7623: add musb device nodes
> 
>  .../bindings/usb/mediatek,musb.yaml           |  1 +
>  arch/arm/boot/dts/mt7623.dtsi                 | 34 +++++++++++++++++++
>  arch/arm/boot/dts/mt7623a.dtsi                |  4 +++
>  3 files changed, 39 insertions(+)
> 
