Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F7309CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhAaO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhAaOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:14:15 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55611C061573;
        Sun, 31 Jan 2021 06:13:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e15so10945879wme.0;
        Sun, 31 Jan 2021 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhDv/BYCeM6la1A7sYj3SvVPGnwohy8wVXqenagBans=;
        b=IXaE/GJvpRoj3dmKrJTG8REL6nbjkc0se/4mqdhaorihgZYPihaN+MahLQMcdjwswc
         boas0SxnBLVJ8emgsLU2Ld2ignFYbh+D4470J1EurUBEzwy0XSMbRiQXG8BB50acn5fy
         3scIZYBsw4mJoekdCcbCSm/k7+BGS6qaGPikkdfpYYLitS7ke/iDXlE20DlzQKSRaf6p
         iYN8VrhGWfvUKnTka97bWIZqgKEpk6lxUaYsGFIJIJBtG2oNBtLqbAU3+++G/EEnPQr/
         pfK0fRnZvKMGW2PZVxXpqVIYpw44WOUWrxPsMmTRGXzfUD+4Rsa9MOj49WMQMX+9WGjL
         XT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhDv/BYCeM6la1A7sYj3SvVPGnwohy8wVXqenagBans=;
        b=rTqP667t5gjGmAkECgcSdRQykn5tYreFwb7yQ0FFQDTJaiyjx8Le93FMvN4v/otlNa
         dkB83SQsWjyodIuX5/KLl0m1auzT3omYd6zFHBvPNihlS3ObybnnJU6jJIqs4RLNTCTL
         1gyJq5rBOzjzuebj2ijf08wuZrAYqMrBK/+YrWwgfsWVgyTO/KHISw10FnJe6R6V7+Jz
         t7iw8zyeCeoF1HBwO8jFk14Q5ecuGfmmBUUIc1Stsu2YDLgM/CvQufL+5Vf2xwSShTWw
         bTUEM7szW/2SyFeBDnezpOmR1+alk1qG+q32F0ifolzWajjacDJI9aaOm80KRdqjAHqW
         jiZw==
X-Gm-Message-State: AOAM532rPTTcM1n+yVUkCfW0pL2M0iDDB/DAArOtPY9CVZ+K2rTq/Ln2
        dNmlKLkZbTqCEHSrSqmYsH67haiZNCNcHzTf
X-Google-Smtp-Source: ABdhPJzR3F6h7g1CPY7SUlWtIPiSXUVojrCP1HvEZ/3pa3WaNEC5rUvj1nGEdZKG3d5PwFApAajw7Q==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr11011669wmt.119.1612102410914;
        Sun, 31 Jan 2021 06:13:30 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id r13sm19349909wmh.9.2021.01.31.06.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:13:30 -0800 (PST)
Subject: Re: [PATCH 2/3] usb: xhci-mtk: fix UAS issue by XHCI_BROKEN_STREAMS
 quirk
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rosen Penev <rosenp@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
 <20201216115125.5886-2-chunfeng.yun@mediatek.com>
 <CANMq1KDBmuoBNeizm9+f1yJgqF9oMqU5k26KfZrSdjrPQm_LwA@mail.gmail.com>
 <1608171557.23328.53.camel@mhfsdcap03>
 <CAKxU2N8q1XjDbWbv5ksqYr7RMEedV7fng7OUccVggsT89Oyf5w@mail.gmail.com>
 <1608794285.23328.79.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7ad022d3-ff83-9126-ee74-6d1e4d381366@gmail.com>
Date:   Sun, 31 Jan 2021 15:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608794285.23328.79.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/12/2020 08:18, Chunfeng Yun wrote:
> On Wed, 2020-12-16 at 19:43 -0800, Rosen Penev wrote:
>> On Wed, Dec 16, 2020 at 6:29 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>>>
>>> On Wed, 2020-12-16 at 20:28 +0800, Nicolas Boichat wrote:
>>>> On Wed, Dec 16, 2020 at 7:53 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
[...]
>>>>>         mtk->lpm_support = of_property_read_bool(node, "usb3-lpm-capable");
>>>>> +       mtk->broken_streams =
>>>>> +               of_property_read_bool(node, "mediatek,broken_streams_quirk");
>>>>
>>>> Would it be better to add a data field to struct of_device_id
>>>> mtk_xhci_of_match, and enable this quirk on mediatek,mt8173-xhci only?
>>> This is the common issue for all SoCs (before 2016.06) with 0.96 xHCI
>>> when the controller don't support bulk stream. If enable this quirk only
>>> for mt8173, then for other SoCs, the compatible need include
>>> "mediatek,mt8173-xhci" in dts, this may be not flexible for some cases,
>>> e.g. a new SoC has the broken stream as mt8173, but also has another
>>> different quirk, the way you suggested will not handle it.
>>> And I plan to remove "mediatek,mt8173-xhci" in mtk_xhci_of_match after
>>> converting the binding to YMAL.
>> I'm guessing this also applies to mt7621?
> Yes, mt7621 doesn't support bulk stream
> 

Then please provide patches to the DTSI for all SoCs that have this problem.
Either as a follow-up or as part of this series, if you need to resubmit.

Regards,
Matthias
