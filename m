Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AC42EAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhJOHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhJOHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:55:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A5AC061760
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:53:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g25so24826881wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0spq/U0Y1vUnnJkuA8fNer3gwXr4La5+YzTv1JANT4=;
        b=OPKHsjsMlECFIRSoyAxu0nUIdT9MWAa07Xu3fjBTCoVAF0BBsOrOtvPtXCMdcLuPQ+
         3B3ZcONLcdihxRhdhBmgnow0TFyuzfxG1SAh1XPErSy5wm2DqBm/UtvpE4fdVtYS9bPU
         b6DWraJF69wd7i8OrBWEMwJHgfqLVjE5LAGTJ+PrjuPnK4u58nBjDdwCselzwtHbIZd1
         ulGl9TytTaixcaZjx8GGMa2LhIE3Epa6gc0G5A+4+anxFSYH1sOF/1bbnS+rrnKR6kq0
         W6uJti3CPiuwi6fyyPjd/bQ+luOL5WAkzx54V7LueZKdeSAYuV1tghauq6rVn/7mXHa8
         ydvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r0spq/U0Y1vUnnJkuA8fNer3gwXr4La5+YzTv1JANT4=;
        b=BKyJW0HTQZfucMbukQSI3ck5BucUHV2RWOZyetoljxZE6x8SIsB+l5EcHZj6AYElw0
         Phjb0aECkh/L9GF807sWqfQBzgHEiTB+EZF4qSpUo1ur+Vx/Awq285LO1r2rwLfaU0Nz
         EA+Fw6U+xofyvZBV0iYwX3jMfjxIaZAXstYYfhFeEa0n8N/eEBynTTNMRYtf61KRGEKl
         DPDTdxaUMJ5LUtNXsIgXUlsQif1RvhNQUtDGUIum3Rh3UaYp8J7V0umR/3yRLpjTTmmx
         ZOY4iziGumE/nmu2s+9TqX4HFij9kRX7xpdKbKcG85Wlf+HmLLy/+w/HYxqQgGlu/k2X
         Otjw==
X-Gm-Message-State: AOAM530UxYCdCzohtrym28rpJcNUuxeWXmcight05qqeaZhHlO2darbM
        oLwJthoukEVMnQ8LDOeOn3yxe/QUDLzKmw==
X-Google-Smtp-Source: ABdhPJwNyqlhUMZpM2GkOpFAlS8ek+MAN89gKyE9g9mbwBMMGFkXf9TpS6bjzZ8K8545wj7L+GVp0A==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr12566299wrn.215.1634284411932;
        Fri, 15 Oct 2021 00:53:31 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb? ([2001:861:44c0:66c0:f6e3:13bd:45ae:5eeb])
        by smtp.gmail.com with ESMTPSA id b10sm4144098wrf.68.2021.10.15.00.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:53:31 -0700 (PDT)
Subject: Re: [PATCH 2/7] drm/meson: remove useless recursive components
 matching
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014152606.2289528-1-narmstrong@baylibre.com>
 <20211014152606.2289528-3-narmstrong@baylibre.com>
 <YWhtuscoVWCdQAkY@ravnborg.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <56fe9cd4-6903-b1d3-d2bd-8b559fdd4304@baylibre.com>
Date:   Fri, 15 Oct 2021 09:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWhtuscoVWCdQAkY@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 14/10/2021 19:49, Sam Ravnborg wrote:
> Hi Neil,
> 
> one comment below. Other than that
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 
> On Thu, Oct 14, 2021 at 05:26:01PM +0200, Neil Armstrong wrote:
>> The initial design was recursive to cover all port/endpoints, but only the first layer
>> of endpoints should be covered by the components list.
>> This also breaks the MIPI-DSI init/bridge attach sequence, thus only parse the
>> first endpoints instead of recursing.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_drv.c | 62 +++++++++++--------------------
>>  1 file changed, 21 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>> index bc0d60df04ae..b53606d8825f 100644
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -427,46 +427,6 @@ static int compare_of(struct device *dev, void *data)
>>  	return dev->of_node == data;
>>  }
>>  
>> -/* Possible connectors nodes to ignore */
>> -static const struct of_device_id connectors_match[] = {
>> -	{ .compatible = "composite-video-connector" },
>> -	{ .compatible = "svideo-connector" },
>> -	{ .compatible = "hdmi-connector" },
>> -	{ .compatible = "dvi-connector" },
>> -	{}
>> -};
>> -
>> -static int meson_probe_remote(struct platform_device *pdev,
>> -			      struct component_match **match,
>> -			      struct device_node *parent,
>> -			      struct device_node *remote)
>> -{
>> -	struct device_node *ep, *remote_node;
>> -	int count = 1;
>> -
>> -	/* If node is a connector, return and do not add to match table */
>> -	if (of_match_node(connectors_match, remote))
>> -		return 1;
>> -
>> -	component_match_add(&pdev->dev, match, compare_of, remote);
>> -
>> -	for_each_endpoint_of_node(remote, ep) {
>> -		remote_node = of_graph_get_remote_port_parent(ep);
>> -		if (!remote_node ||
>> -		    remote_node == parent || /* Ignore parent endpoint */
>> -		    !of_device_is_available(remote_node)) {
>> -			of_node_put(remote_node);
>> -			continue;
>> -		}
>> -
>> -		count += meson_probe_remote(pdev, match, remote, remote_node);
>> -
>> -		of_node_put(remote_node);
>> -	}
>> -
>> -	return count;
>> -}
>> -
>>  static void meson_drv_shutdown(struct platform_device *pdev)
>>  {
>>  	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
>> @@ -478,6 +438,13 @@ static void meson_drv_shutdown(struct platform_device *pdev)
>>  	drm_atomic_helper_shutdown(priv->drm);
>>  }
>>  
>> +/* Possible connectors nodes to ignore */
>> +static const struct of_device_id connectors_match[] = {
>> +	{ .compatible = "composite-video-connector" },
>> +	{ .compatible = "svideo-connector" },
>> +	{}
>> +};
>> +
>>  static int meson_drv_probe(struct platform_device *pdev)
>>  {
>>  	struct component_match *match = NULL;
>> @@ -492,8 +459,21 @@ static int meson_drv_probe(struct platform_device *pdev)
>>  			continue;
>>  		}
>>  
>> -		count += meson_probe_remote(pdev, &match, np, remote);
>> +		/* If an analog connector is detected, count it as an output */
>> +		if (of_match_node(connectors_match, remote)) {
>> +			++count;
>> +			of_node_put(remote);
>> +			continue;
>> +		}
>> +
>> +		DRM_DEBUG_DRIVER("parent %pOF remote match add %pOF parent %s\n",
>> +				  np, remote, dev_name(&pdev->dev));
> Avoid the deprecated logging functions.
> Use drm_dbg() or if there is no drm_device just dev_dbg().
> 
> I assume the driver uses DRM_xxx all over, so I understand if you keep
> it as-is.

Since it's in the probe function, I will move to dev_dbg().
I'll probably do a print cleanup all over the driver.

> 
>> +
>> +		component_match_add(&pdev->dev, &match, compare_of, remote);
>> +
>>  		of_node_put(remote);
>> +
>> +		++count;
>>  	}
>>  
>>  	if (count && !match)
>> -- 
>> 2.25.1

Thanks,
Neil
