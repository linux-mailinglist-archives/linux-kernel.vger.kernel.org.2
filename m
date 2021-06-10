Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE33A25E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFJH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:56:50 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38455 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:56:46 -0400
Received: by mail-wr1-f43.google.com with SMTP id c9so1102128wrt.5;
        Thu, 10 Jun 2021 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xJS0U9ByX0NxIuJpqaNPHe7gI5LppZzf1YoFLwdpgpQ=;
        b=AtutUx5F3FjGQHEtvWof9HOeTHWeBqvhVw+QiN+Sh6cWWewDfrjuaZjOgIU8GrvZla
         6PSpE270aJ7Btt2qATsv9ZhQy58/0GoWWD5CnAISW5h2u03IY721oe03cmG/VhveVGw/
         fIvFr3ZW60yd5JvkbVc401CsPLw/sMlHMPcEsS7+8fpbgaPGboXiVI4p2aQC0iupWWUA
         yvllp02g0KpE38Gh0/adERukIXbEQPWpkg5Hwp0/YamaLVTu8RR0KbFJ4rBVKtlUE2CD
         YXQcYwiWadJ1e0HyfnyVp6gQIJJRAngE/XVLL6ga9zNZL97Pp6Vg5oRaiPOGaMV825g7
         /9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xJS0U9ByX0NxIuJpqaNPHe7gI5LppZzf1YoFLwdpgpQ=;
        b=MXmy/UIVhsyRGp7eNgLaYOWvxyvTuIWmJh9VQZKPJhXb3cjmCZ3hcr3QEU6etqA8aA
         uz8gGcrGu1ExM4R0xSYsRv28qBwHkUAjJfDCtyCKqmcFPPRYQA6BiLEt9Gz3eVolY+ab
         /yvmeZzis59wB8ix+TOBk3wtZFhqc0dja0D7V4muh7ySou9K2VpKsysPmNfv1+qknzOC
         //3mMR7KoEMXYwIqAdxjNiWnFniEHT2cIM1zHOi4vzvWRsXNWgcsZq78veVQFT07RiP+
         jziMF0iek9Jp/N+Z1Yx4Ktgx06dqmamddLE+yE1FLEtkxP+/Qup8plDeD7gg+XQ+m145
         kPwg==
X-Gm-Message-State: AOAM531Yvp5gYxjUlnSZtoCA0XoksyF+jGPUUJzjXv8YhAMIpkld5jO7
        lLjkmxzqBGzuW0jyZECb4gI=
X-Google-Smtp-Source: ABdhPJyWIa0BThW8wleRBOOtD6X+dU2YcMMb96LCJzvn3Y7r3nvLUwAHQC9a6Zki2vUnentp0rRZoQ==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr3851640wrt.209.1623311615564;
        Thu, 10 Jun 2021 00:53:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o6sm2696870wre.73.2021.06.10.00.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:53:34 -0700 (PDT)
To:     Yong Wu <yong.wu@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, eizan@chromium.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
 <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
 <1620822547.2983.8.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
Message-ID: <c1422242-8d8c-9592-c22d-288c503cd8b1@gmail.com>
Date:   Thu, 10 Jun 2021 09:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1620822547.2983.8.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

On 12/05/2021 14:29, Yong Wu wrote:
> On Wed, 2021-05-12 at 17:20 +0800, Hsin-Yi Wang wrote:
>> On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>
>>> MediaTek IOMMU has already added the device_link between the consumer
>>> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
>>> the smi-larb's pm_runtime_get_sync also be called automatically.
>>>
>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>> CC: Irui Wang <irui.wang@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> Reviewed-by: Evan Green <evgreen@chromium.org>
>>> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
>>> ---
>>>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
>>>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>>>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>>>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
>>>  4 files changed, 10 insertions(+), 77 deletions(-)
> 
> [...]
> 
>>> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>>>                 }
>>>         }
>>>
>>> -       ret = mtk_smi_larb_get(pm->larbvenc);
>>> -       if (ret) {
>>> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
>>> -               goto clkerr;
>>> -       }
>>> -       return;
>>
>> You can't delete the return; here, otherwise vcodec_clk will be turned
>> off immediately after they are turned on.
> 
> Thanks very much for your review.
> 
> Sorry for this. You are quite right.
> 
> I checked this, it was introduced in v4 when I rebase the code. I will
> fix it in next time.
> 

Please also make sure that you add all maintainers. I realized that at least for
the media/platform drivers we miss the maintainer and the corresponding mailing
list.
This is especially important in this series, as it spans several subsystems.

Thanks a lot,
Matthias

>>
>>> -
>>>  clkerr:
>>>         for (i -= 1; i >= 0; i--)
>>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>>> @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
>>>         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
>>>         int i = 0;
>>>
>>> -       mtk_smi_larb_put(pm->larbvenc);
>>>         for (i = enc_clk->clk_num - 1; i >= 0; i--)
>>>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>>>  }
>>> --
>>> 2.18.0
>>>
> 
