Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0D32F5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCEWSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCEWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:18:30 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BEC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 14:18:30 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z128so3573828qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEPdvK71SYnnYxU/iYMYQe/u4D1Hboa4Ycom7Yjf1Uw=;
        b=LAiu13ud2ieteI1GC7oTRufOmHJCXPRSrLKl5fh0T8ZtOH0SD/XlcVSIeqtPxBrL0v
         iorOjbfWYdI1rWZzDfENDWZx8rWebaQIaZN0iTWtJd+9UisdnfWvF0ZbBMn7/8T5RkXE
         /BvplMJpUvWr0rMw7G6eU9PvsjcrG7DHhnA8e9G2HaD31Up6Hhrnod7o+pyJem9nXIsv
         K1CQefEQsOIioZWB7+IYnXZLZkLGu0yxY44HFIDj+BNXPnXLC0BZQT4bOoPA/QB135zk
         p3SNWX8ZsmJeiCQG6SQZfV52KZp/A/Wi8b9PP/MEeArtw/cAjHY26STc9U0jeXtca+xb
         H2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEPdvK71SYnnYxU/iYMYQe/u4D1Hboa4Ycom7Yjf1Uw=;
        b=pkFk6fxUGUz3IGKufbr1xqQglYpoey1kMebwktnGiROXLhAseXUzkZ0x/EffHE9Axt
         JgwRtnWqUugnJE5N0EyrbSgqqogkAWgW6OAvbKYWeZPB7ROXvYONN4rkl8nMIShphVvs
         UWo9QidXsVzLLui9W6jtHCBIlQQ0DfMhMMN640wXDpYKzRKDovZcquP9h8KfYOtQQllZ
         83cvbbO+dFVhqZG/e/Y6Y1CaxDPxPZF0XGud+QfANtCqAzJ1f1R+nNatnGevocaLYdX7
         Q7Ebqzd5ZKzWBM3FladGDWA5idQTHh1MtJuwGIR2VgzK0fqxpqstKkL76j6ISsTRpsVX
         P3bg==
X-Gm-Message-State: AOAM530P/31EOAvbQ9+2PWVmxYIGCU3E1e6VEqwlJ+YghQuYUBtuMndL
        AmF7Fg0GK78XgK05c0zX2YuYKeMXABjzjoIx44c=
X-Google-Smtp-Source: ABdhPJzQrZBfsrI9YYiNPI9gMDvzV87Lgi/44erfU6o3ciulWwl/Z0QtFrZefcU5AlH8znMSAZt34w==
X-Received: by 2002:ae9:ef89:: with SMTP id d131mr11080051qkg.214.1614982709146;
        Fri, 05 Mar 2021 14:18:29 -0800 (PST)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id z2sm2898711qkg.22.2021.03.05.14.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 14:18:28 -0800 (PST)
Subject: Re: [PATCH] drm/msm/dsi: support CPHY mode for 7nm pll/phy
To:     Rob Herring <robh@kernel.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210215162805.21481-1-jonathan@marek.ca>
 <20210305214802.GA701567@robh.at.kernel.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <cbaf67d2-d5b8-9684-061b-8de9382a438b@marek.ca>
Date:   Fri, 5 Mar 2021 17:17:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210305214802.GA701567@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/21 4:48 PM, Rob Herring wrote:
> On Mon, Feb 15, 2021 at 11:27:44AM -0500, Jonathan Marek wrote:
>> Add the required changes to support 7nm pll/phy in CPHY mode.
>>
>> This adds a "qcom,dsi-phy-cphy-mode" property for the PHY node to enable
>> the CPHY mode.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   .../devicetree/bindings/display/msm/dsi.txt   |  1 +
>>   drivers/gpu/drm/msm/dsi/dsi.c                 | 12 +--
>>   drivers/gpu/drm/msm/dsi/dsi.h                 |  6 +-
>>   drivers/gpu/drm/msm/dsi/dsi.xml.h             |  2 +
>>   drivers/gpu/drm/msm/dsi/dsi_host.c            | 34 +++++--
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c         | 49 +++++++++-
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |  3 +
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 89 ++++++++++++++-----
>>   drivers/gpu/drm/msm/dsi/pll/dsi_pll.c         |  4 +-
>>   drivers/gpu/drm/msm/dsi/pll/dsi_pll.h         |  5 +-
>>   drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c     | 71 +++++++++------
>>   11 files changed, 210 insertions(+), 66 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
>> index b9a64d3ff184..7ffc86a9816b 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
>> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
>> @@ -124,6 +124,7 @@ Required properties:
>>   Optional properties:
>>   - qcom,dsi-phy-regulator-ldo-mode: Boolean value indicating if the LDO mode PHY
>>     regulator is wanted.
>> +- qcom,dsi-phy-cphy-mode: Boolean value indicating if CPHY mode is wanted.
> 
> This is board or SoC dependent? The latter should be implied by an SoC
> specific compatible.
> 

It is board specific, 7nm dsi phy can operate in either D-PHY or C-PHY mode.

