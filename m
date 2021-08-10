Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACAD3E55C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhHJIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhHJIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:46:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4BC0613D3;
        Tue, 10 Aug 2021 01:46:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c9so25136996wri.8;
        Tue, 10 Aug 2021 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OB6UtG4zFPtQqAnDfNSTJxFcLRUWyCnisk7BYFNOzqE=;
        b=MerkW78o00SexssjoYMursF3joCceU4hD/5+wHLYpy7d/PfUX8ryPbMCCupegOkeHB
         HGd71w077wojxCfKiNmEuEbmFnSB4py22cDyeGkMMiRuAG0g/cRNUrlzUUqYAnpzHMfJ
         6DmexI6xrZ+TyEwj9kq8PKP25/kJSuE4uaeB4dzTinACNPKTXLziqiAmQnyPji0U4bCn
         X1BYBwXyEdBkbSYHqnW9AEx6ILBMH5lAJdWPocfstxodvSdKy1MVghgpAB91WXrRjZzF
         zdLbFsJC7Z/Vi+nMWAhOcM5D5r1vLwdIXHCbMvMri7Bvy6F0FUaWLXnTaoLD7IkMJSqs
         xuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OB6UtG4zFPtQqAnDfNSTJxFcLRUWyCnisk7BYFNOzqE=;
        b=MrF6t8Vw/SntcARYito3n/msAsM9IM0HzqWhZn7u8tMiUYTpsgnuhVuEeSV4SL6HJV
         2+mX1fPThztlmFUyfdvgoyS9VhVVW8oYUcBW2GxXL8bsf66FgpHHRIdvVrhAHIheJsaj
         vjfnoAiso8TWYOXhgk1OQB0fvuSY9pTH79iE0W6rVS2KUv4A13WoJljezIRFhNhDkkLk
         YNJw1aKotvwo7iORP0lpJjNKVTqL9KdiX0UBNVh/iqEYYGwS+XiGD7U7a5wcHf9AkbwR
         sdwaeuqZrkMmyeAD0q2EpjKhaJvADjy83EAWXjYCQbgYw5vIJ1b0SYERGvSF84ocSAwI
         f/Mw==
X-Gm-Message-State: AOAM533PkV60QkUK8OVWJE8NQhS40cSyJeMOCLPZgKSogurg82G9nHzl
        GC4amV0G6AwYnHahKZ/izZs=
X-Google-Smtp-Source: ABdhPJz97nyY/SNStvhPEdEAKxnpS8lnpteyvnRLKrJfZ8hjlqRCL9wOivECar5o2rREqAcCv2P3eg==
X-Received: by 2002:adf:80e8:: with SMTP id 95mr29812738wrl.388.1628585181037;
        Tue, 10 Aug 2021 01:46:21 -0700 (PDT)
Received: from ziggy.stardust ([207.188.163.204])
        by smtp.gmail.com with ESMTPSA id j6sm7920180wms.44.2021.08.10.01.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 01:46:20 -0700 (PDT)
Subject: Re: [PATCH v8, 0/2] soc: mediatek: mmsys: add mt8192 mmsys support
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <1627894773-23872-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e4afa712-9936-15fc-ad43-576948758f6c@gmail.com>
Date:   Tue, 10 Aug 2021 10:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1627894773-23872-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2021 10:59, Yongqiang Niu wrote:
> base v5.14-rc1
> 
> Yongqiang Niu (2):
>   soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
>   soc: mediatek: mmsys: Add mt8192 mmsys routing table
> 

Series queued in v5.15-tmp/soc

Thanks

>  drivers/soc/mediatek/mt8192-mmsys.h    | 67 ++++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c       | 11 ++++++
>  include/linux/soc/mediatek/mtk-mmsys.h |  3 ++
>  3 files changed, 81 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h
> 
