Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E14361EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbhDPLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbhDPLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:39:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831E2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:39:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so26400623wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ch3B1QB839TpxbyTCaHh7+PjqFlJHeFp/HZU3MiGscw=;
        b=EkzQjer0WgUEgQkZ/WCQ1qZSR+xOL8CYkmgyGZqX8M/cpDnJ3Jdq7NAUhqBGqi3yjA
         RvxLBAhdzA+iPTcZCJ9eRsGEGviRSKwt63OrvHOCS0KWJWgntOZuiNpq0t2/LzV1v7RI
         XdY+G5TuRKGbvh/bK/vA+nuoL3oWvnx81/1QcUl0hPVXiX6lne0wZcU39Dnw01eexj4/
         aAmRmD45JLqraflxN0P9n9NRW+tOLy31DVmNZNxB1sJtCQ6rBU4/vaMe3bZ/bjGdQU/c
         vNXcsAyBt2CKFWL7r7Dzm/htr5Q83g2zk0NzsSft44P0UdjSeRe0LKdJOehBAf0HNf2D
         7mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ch3B1QB839TpxbyTCaHh7+PjqFlJHeFp/HZU3MiGscw=;
        b=P/7ZXv8j7/wGXkgt5AGWCjCrQosMutw3JSnnKjKQenUVVPR/uip66xfXJrllDwo/ER
         WSwvnNtuTnTRlzGzYzDQNOXWpw8lOafJ6eceqjdBXWoYc1mm1QuS0aHyBpwmNjA+PCyG
         ihDJwYBFcRjY/R1teZSmAphLBui9Zi4JZiAQly0dUCetv2IuEXnp2KWMLrd5ZjPcwogh
         21cQ1FSC9Yo9OTxj24YpfyiGbXb1z7sZJ5rFZJECjbfFh1BnUCIsucwR3x+WWRLlcC3F
         /rvO6DQH5P6/jIgGG/MzswgAKbrj7AYXydKHCOMiVpXw5Fi0b9sQ0tG1dPW5jSRaHrmN
         KygA==
X-Gm-Message-State: AOAM5320AkQzky+hC+Tuwbyd+xuVXzpoyMzQbJzg0tWbeSt3uIhj1hvE
        l+Cq32lYnl2k/ghN839JWgmSGXFHSBw+EmC9
X-Google-Smtp-Source: ABdhPJxV3W8/JmRRJjOYH3rbQ9IP5SnGF8wi+6Gmv+4bzOiXNfk7ypsXlDfWMH46OpTJMpcWlMSOlg==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr8565355wru.3.1618573140641;
        Fri, 16 Apr 2021 04:39:00 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7? ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id n2sm9756992wmb.32.2021.04.16.04.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 04:39:00 -0700 (PDT)
Subject: Re: [PATCH 0/2] drm/bridge: dw-hdmi: disable loading of DW-HDMI CEC
 sub-driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210416092737.1971876-1-narmstrong@baylibre.com>
 <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <96b9e144-0791-4c19-3e3c-b0e9efb86138@baylibre.com>
Date:   Fri, 16 Apr 2021 13:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHlfqJIlUh7eytty@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2021 11:58, Laurent Pinchart wrote:
> Hi Neil,
> 
> On Fri, Apr 16, 2021 at 11:27:35AM +0200, Neil Armstrong wrote:
>> This adds DW-HDMI driver a glue option to disable loading of the CEC sub-driver.
>>
>> On some SoCs, the CEC functionality is enabled in the IP config bits, but the
>> CEC bus is non-functional like on Amlogic SoCs, where the CEC config bit is set
>> but the DW-HDMI CEC signal is not connected to a physical pin, leading to some
>> confusion when the DW-HDMI CEC controller can't communicate on the bus.
> 
> If we can't trust the CEC config bit, would it be better to not use it
> at all, and instead let each platform glue logic tell whether to enable
> CEC or not ?

Actually, the CEC config bit is right, the HW exists and should be functional, but
this bit doesn't tell if the CEC signal is connected to something.

This lies in the IP integration, like other bits under the "amlogic,meson-*-dw-hdmi"
umbrella.

The first attempt was by Hans using DT, but adding a property in DT for a vendor
specific compatible doesn't make sense. Another idea would be to describe the
CEC signal endpoint like we do for video signal, but I think this is out of scope and
this solution is much simpler and straightforward, and it's more an exception than
a general use case to solve.

Neil

> 
>> Jernej Skrabec (1):
>>   drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC
>>     driver
>>
>> Neil Armstrong (1):
>>   drm/meson: dw-hdmi: disable DW-HDMI CEC sub-driver
>>
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c     | 1 +
>>  include/drm/bridge/dw_hdmi.h              | 2 ++
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
> 

