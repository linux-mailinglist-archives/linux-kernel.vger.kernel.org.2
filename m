Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC23942EAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhJOIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhJOIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:04:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7BC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:01:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k7so24821257wrd.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YxrOR9K6vhkLr9CjYB6yPZ8dIuZ0sUqPm84e+3V43ao=;
        b=gbtRdhAVWAfMeOpv8nsZ8fzW2oljAjNi4vEA1JRQhEUqq5+H14WXSh3SLab1ZMd6WX
         Uwo8YQk0JnXz7xfFsaN1sZJp2x5CbDi8tx1wf3EhmdXr1iYtp5IcL2ElDUvi9h9natRL
         WiVSAt4SRScgQ8fncgRHTUzP4r6Xinmp73uByxmuljlZdevUigp26lus9IuSiu7kntLS
         fVmiIzimtdLm0Ey62cl5p5ENcf1HNCEsN+VmAq6OSc00eE/BS479DkfkKGVLgB2VEMsy
         JBjaKUNAuXOypRIlDSfp/VYU9yCk72x1TLHpMG6PEEO6MgpvOUwvDbMa+Pr4zZ006Xr5
         yKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YxrOR9K6vhkLr9CjYB6yPZ8dIuZ0sUqPm84e+3V43ao=;
        b=hXbdhkcw+6Qbb7cr3uys9E/iRZvrgFDuIkrlaQNAO8PDJAuEvC+D08m7uynxIm1i4L
         PA1mtBWU0ASe/iIzUWVQiCyRae3oItWn9sXFgcK1lRMSvB9PzyHIyi5F6+Hv6/3xa4ne
         D7TiH2I1/GLIB98fqcWR94s1XK5LkN96f+Jhfz0s8uLhMaUFkBZ8Qs4J9g+r2ZsOSWjS
         mRgzdihpvcDIpoN0XetryIW2s3uuet3x6M1i7tMOtNgVlMM2NRml3f3wGJmm4H55zS8n
         yV1urZ8vEv79O3ObnU9YugXuwL+g7Pye1YeAruoymvLPplqVcXtly+w1Y5QREPItKv8G
         UjxQ==
X-Gm-Message-State: AOAM533k/FQu/K0HCIEZhZQ6qyOE+Kx6ELyN3UnFVhTv4j7FMDfYJKRi
        2STMxaKD+7K9cfwaoSjhFgiSUwVurwC1+g==
X-Google-Smtp-Source: ABdhPJzkiF7LkaHDd/2UrFjm/BApNwYvDwLW34HSiWSar7EyjXdbWpJay1YOcgLGP/mkp1k56fulIw==
X-Received: by 2002:adf:b348:: with SMTP id k8mr12345019wrd.435.1634284910439;
        Fri, 15 Oct 2021 01:01:50 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb? ([2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb])
        by smtp.gmail.com with ESMTPSA id p17sm4241934wrx.33.2021.10.15.01.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:01:50 -0700 (PDT)
Subject: Re: [PATCH 4/7] drm/bridge: synopsys: dw-hdmi: also allow interlace
 on bridge
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014152606.2289528-1-narmstrong@baylibre.com>
 <20211014152606.2289528-5-narmstrong@baylibre.com>
 <YWhyGBlz7JW8NciX@ravnborg.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9ec51817-a9e4-8a70-da08-5bdc2ba73697@baylibre.com>
Date:   Fri, 15 Oct 2021 10:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWhyGBlz7JW8NciX@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 14/10/2021 20:08, Sam Ravnborg wrote:
> On Thu, Oct 14, 2021 at 05:26:03PM +0200, Neil Armstrong wrote:
>> Since we allow interlace on the encoder, also allow it on the bridge
>> so we can allow interlaced modes when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

I applied it to drm-misc-next,

Thanks !

Neil

>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index f08d0fded61f..62ae63565d3a 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -3413,6 +3413,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>  	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
>>  	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
>>  			 | DRM_BRIDGE_OP_HPD;
>> +	hdmi->bridge.interlace_allowed = true;
>>  #ifdef CONFIG_OF
>>  	hdmi->bridge.of_node = pdev->dev.of_node;
>>  #endif
>> -- 
>> 2.25.1

