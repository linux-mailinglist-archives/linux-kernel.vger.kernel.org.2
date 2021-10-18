Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5A431196
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhJRHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhJRHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:52:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04502C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:50:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso7672661wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/qx6dvcDkO1aEfmrGOeAb9WXZdVZKpvlTMRbcmlbAg=;
        b=v2pQOhbcutTJ6Ai/KVzZj6lkpmfHXo+VLK9KyltkpnhAPqUqMH2p8q0GMh2PCXif7+
         +qTlYgBeKCX4qazwHZU2eB+u2auOcwfQSTWvqViCeWi3dS5A8K2boiGjewnvkffZroel
         oblW4qX8LRKJFsPG+zfaTvTwIUBuEaRhSnMAyT7W/vRYTbWBP5FEOM/Ge7oqnBfZPWiv
         ghTNXo9ahfQ3Xd5RBiTVEOOzuP/JE6uweRvIQjSYtzxTZwewSjYrWdpW4LimUBCZbseQ
         lh9HiBEqSmvFFNE8Gi9/LbbWgzuo/VC1T0adTfJPUrVm7s+r4041jV2k6PJmISMvTy01
         Utrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=T/qx6dvcDkO1aEfmrGOeAb9WXZdVZKpvlTMRbcmlbAg=;
        b=CAz5COzH3aiDW9CRuai2Q3dH7A/8y6m1b/5KHZZnz6SjhPfk+Ufb46ECBTBqdEZ8Ay
         sfGE0l7762zfuJ80XuIt2Y5jSA2MRmWMFSZfYMraVda3GWdDRo6DGBdYW3G0L/RJHeE8
         9oUUgvSY9AeCU8wvqEBAUlqpZucI2xWZSJuAC6Pjyva6U9ljI+6gsSPcylJeM45LRi9m
         O7VOYCHoVi6hRK5ltcGRPsm4FxBs6WtB2RyRLlBIAJgvmYgK8jT/W6bq7cuS0QBuVCGI
         N2F7+3i8Rz3mojiIvfVBa0vmRyBdBjWVy+fdFJ8f2Yo0VUUiDWKPHcyfvAww9zBdYrqh
         /hQw==
X-Gm-Message-State: AOAM5337zt94med9tUQp3aUvXdKbIr1tn7fQ4anjAnWcx0A8UqbzytSO
        zOVgU0F51EZtkoOgsa3deFHnpOEC2uw=
X-Google-Smtp-Source: ABdhPJwYyhnLt4aqI4jUYRQVzmEWl7fxodIOaaHM4325FF2WV3XJQPVTYW3pID+zVKG5yz0eTko1IQ==
X-Received: by 2002:a7b:c741:: with SMTP id w1mr1938097wmk.9.1634543398107;
        Mon, 18 Oct 2021 00:49:58 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:2dd7:d5eb:6e87:f924? ([2001:861:44c0:66c0:2dd7:d5eb:6e87:f924])
        by smtp.gmail.com with ESMTPSA id u2sm11453082wrr.35.2021.10.18.00.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 00:49:57 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] drm/meson: encoder_hdmi: switch to bridge
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015141107.2430800-1-narmstrong@baylibre.com>
 <20211015141107.2430800-5-narmstrong@baylibre.com>
 <CAFBinCB_Z+errWL4C-K3WrPu2B7gxr3NRFsF3_Xoy48XDsOb-A@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <9cba6fbf-a8f7-4831-5774-1e270932816d@baylibre.com>
Date:   Mon, 18 Oct 2021 09:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCB_Z+errWL4C-K3WrPu2B7gxr3NRFsF3_Xoy48XDsOb-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2021 00:07, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This implements the necessary change to no more use the embedded
>> connector in dw-hdmi and use the dedicated bridge connector driver
>> by passing DRM_BRIDGE_ATTACH_NO_CONNECTOR to the bridge attach call.
>>
>> The necessary connector properties are added to handle the same
>> functionalities as the embedded dw-hdmi connector, i.e. the HDR
>> metadata, the CEC notifier & other flags.
>>
>> The dw-hdmi output_port is set to 1 in order to look for a connector
>> next bridge in order to get DRM_BRIDGE_ATTACH_NO_CONNECTOR working.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> another great piece which helps a lot with HDMI support for the 32-bit SoCs!
> I have one question below - but regardless of the answer there this gets my:
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>> +       pdev = of_find_device_by_node(remote);
> I am wondering if we should use something like:
>     encoder_hdmi->cec_notifier_pdev
> 
>> +       if (pdev) {
>> +               struct cec_connector_info conn_info;
>> +               struct cec_notifier *notifier;
>> +
>> +               cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
>> +
>> +               notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
>> +               if (!notifier)
>> +                       return -ENOMEM;
>> +
>> +               meson_encoder_hdmi->cec_notifier = notifier;
>> +       }
> and then move this logic to meson_encoder_hdmi_attach()

We can't because we create the connector after the attach.

> This would be important if .detach() and .attach() can be called
> multiple times (for example during suspend and resume). But I am not
> sure if that's a supported use-case.

Attach for now will only be done once at probe, and detach only a remove,
we don't change the bridge chaining while suspend/resume, we only reset the
pipeline state and put the old state back when resuming.

Neil

> 
> 
> Best regards,
> Martin
> 

