Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C8365C09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhDTPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhDTPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:20:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23238C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:19:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so37991996wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=22YXfrzIvJI/e0g2j0aYDyGRkNGq51wKgMJOLCS1QVw=;
        b=O61+oMWcADefXaQH2XclZbsr8Gd7B9uLWxTfxX0HtcSO9lbF4+LkcGS0iIhDDh61be
         Z8oPcqd/CUqGkbr9KwpjSNpjMGm9Xc9TriI8pehb0SW2S0TRqn7erkeJjTFBS4cJlqxK
         pNcKkTRE71jn+HJrb/nPm0hoGEYJCLsuAiHH/YaP+MkVtO3NIaBt7M7c9eHfnGImLqMt
         Czv9TFOQgwdHlwcGkvbyaQfCPC0PDwBZ3Rb1aB7i8jO+QreDfqaM/DyI3kEtduKOeWfL
         AYh174xTlv8ExB69UMRkOBXLMhtyswnGm4rADX5Tlo9naPUH15Taa8l1N2KngHJMV5px
         R4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=22YXfrzIvJI/e0g2j0aYDyGRkNGq51wKgMJOLCS1QVw=;
        b=JrTolzZFsUC2164GupqLE8wJzoMMG7EPFFB/F+a4j2YrC5gW7LFOh63+RC1FfIWmaj
         mWqPwELy282Uioydvtnu9UsRJJDmsO5dSH2kYnQo0J/BKelJx/GyH6w5qbP1D6kD5gXR
         Rx2L3bwOYWfAiqQD8D3ltWOJIxEwnvwqwwb1RckTvZUMYu3RhHvA+02sZ1skbM3GCqJI
         dB2BmxmkD/1lIwJOtEHg52AEoqya73/l4idaQdu2+8Ll7yRtikq+u36sI2FlASfquKjp
         Ej7t1aBg5IPC1soyo4zbWpohxizUhHYRal3jhuzVot5JXUNeJJ2YvHAIYdKjiZlnCCVh
         7ihw==
X-Gm-Message-State: AOAM530hD0dhC1YjDAlSpWhWvou/s/Ds+pzbwIqLrFaoJX9dTa550EQu
        EAYcaaegH3f1eeroHDClxG5k+UGLnOvBzsor
X-Google-Smtp-Source: ABdhPJyYBtbYLuNyS+ppFk55wLeiEgofP4BmVUU7O9xG8j+pYW7WvxoWIH4KP4AuNd0cwIk7oMLsug==
X-Received: by 2002:a05:6000:178c:: with SMTP id e12mr21440298wrg.42.1618931993723;
        Tue, 20 Apr 2021 08:19:53 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b4:316d:263e:1360? ([2a01:e0a:90c:e290:b4:316d:263e:1360])
        by smtp.gmail.com with ESMTPSA id h10sm13764777wrt.40.2021.04.20.08.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:19:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC
 sub-driver
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jernej.skrabec@siol.net, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robert.foss@linaro.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
 <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
 <96b9e144-0791-4c19-3e3c-b0e9efb86138@baylibre.com>
 <cbea511c-5d5c-8c59-f91f-fedc8eec1e39@xs4all.nl>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <0821533b-9e6a-237e-3845-741e82de4ed9@baylibre.com>
Date:   Tue, 20 Apr 2021 17:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cbea511c-5d5c-8c59-f91f-fedc8eec1e39@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 17:13, Hans Verkuil wrote:
> On 16/04/2021 13:38, Neil Armstrong wrote:
>> On 16/04/2021 11:58, Laurent Pinchart wrote:
>>> Hi Neil,
>>>
>>> On Fri, Apr 16, 2021 at 11:27:35AM +0200, Neil Armstrong wrote:
>>>> This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.
>>>>
>>>> On some SoCs, the CEC functionality is enabled in the IP config bits, but the
>>>> CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
>>>> but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
>>>> confusion when the DW-HDMI CEC controller can't communicate on the bus.
>>>
>>> If we can't trust the CEC config bit, would it be better to not use it
>>> at all, and instead let each platform glue logic tell whether to enable
>>> CEC or not ?
>>
>> Actually, the CEC config bit is right, the HW exists and should be functional, but
>> this bit doesn't tell if the CEC signal is connected to something.
>>
>> This lies in the IP integration, like other bits under the "amlogic,meson-*-dw-hdmi"
>> umbrella.
>>
>> The first attempt was by Hans using DT, but adding a property in DT for a vendor
>> specific compatible doesn't make sense. Another idea would be to describe the
>> CEC signal endpoint like we do for video signal, but I think this is out of scope and
>> this solution is much simpler and straightforward, and it's more an exception than
>> a general use case to solve.
> 
> While a DT property might not make sense in this particular case, I still
> believe that it is a perfectly valid approach in general: whether or not
> the CEC pin is connected is at the hardware level decision, it is not
> something that software can detect. If the designer of the board didn't
> connect it, then the only place you can define that is in the device tree.

Agreed, we need to define a smart way to declare CEC bus relationship in DT, the side
effect would be to handle this particular case.

> 
> Anyway, for meson I am fine with this solution. At least it prevents creating
> a non-functioning cec device. So for this series:
> 
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks,

Applying this serie to drm-misc-next

Neil

> 
> Regards,
> 
> 	Hans
> 
>>
>> Neil
>>
>>>
>>>> Jernej Skrabec (1):
>>>>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
>>>>     driver
>>>>
>>>> Neil Armstrong (1):
>>>>   drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver
>>>>
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>>>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
>>>>  include/drm/bridge/dw_hdmi.h              | 2 ++
>>>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
> 

