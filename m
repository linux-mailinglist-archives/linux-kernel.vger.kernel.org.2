Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C897839679F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEaSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:12:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A14C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 11:10:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a4so16002757ljd.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RqDyoSo09lPZO7GbOVPgOTHVdV/YSSWYh+JNDnVcsAM=;
        b=vy0uLjUP4b9/AdZSWCBIJkGYi4KqsFzlAguK9G1kq10RuG2QJ9SaCin/z40CAuN9N1
         Ny/vrCiMNiRFhNLvJpQsZYZINHFf3EaQct9tsqIhk5tAUsuxyy09Jt+MFTo1pb2DxMnI
         1mhuGM8ZMFNvXLG2phlK9NzBPLb3Sc3JtSvvZKZm+MyP/a9uTs2m53y9gSdGz1FPy9Zp
         irfZkJPLzEw5eyrLgj7PQlgSEwbb6I7tSu/8WspO4dXuoX2ho+xANIhvHef5g176dFCi
         3lou3RZZLIaFfJeZfbA0ikQgl/ZH1MLhSjVh8yTZE2in8m24BXFIdgP66V1SntHfTsA6
         U1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RqDyoSo09lPZO7GbOVPgOTHVdV/YSSWYh+JNDnVcsAM=;
        b=DqTdo3wy8VGIuUFKLEzrr9aiYQjNRsVzECQp0WpOmRedJa0QGuEVg4MUeJ06WzfA/0
         Mr/Pa5kYsGtNULQ2cHIRkDLMMQ6OYVtifsco8XRm47P7tXiV9FdzqRpnn2QIwxXKjaL9
         NGbEblhxT7Iu9iGi80Ou4Mxg9JzhIRpyJaG04G6i+JS5lA6HDDQ7q2bJsmA+ZLus+6xI
         pTheG/IoBdtbrW4poSgqAFnJIWrY9QCx00lEey1oEV8NFcJTbkFeOIvanKop2YJAKVBE
         QonFVGa/J+syEkqqIyxDW+BlTAT/smtug1IW4I6H2fdlMi1jeEaABpAaxiSCHtbFOHxj
         NtGQ==
X-Gm-Message-State: AOAM531bdLNLgeaFmshzfO+DZppMxaHXM741YgVnMqBg9ph4eRF/lRZM
        K+WN5c3pok+RozseWUPaRrBq7w==
X-Google-Smtp-Source: ABdhPJx3O6rn5NqZMzkPeijKZJM/6wPEQfnrs07M3tXIRXQouQa/sGsKJEEBs84ooxP684SBQE0Vag==
X-Received: by 2002:a2e:bf20:: with SMTP id c32mr17459713ljr.311.1622484620655;
        Mon, 31 May 2021 11:10:20 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y1sm1331962lfl.68.2021.05.31.11.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 11:10:20 -0700 (PDT)
Subject: Re: [Freedreno] [PATCH v2 2/2] dt-bindings: display: msm/dsi: add
 qcom, dsi-phy-cphy-mode option
To:     Jonathan Marek <jonathan@marek.ca>, Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Sean Paul <sean@poorly.run>
References: <20210423172450.4885-1-jonathan@marek.ca>
 <20210423172450.4885-3-jonathan@marek.ca>
 <20210503171139.GA2011901@robh.at.kernel.org>
 <0e083e31-d349-6d5c-048f-258414492b2c@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <4e623554-bbe4-4d4a-7b14-0ca4f684c7fb@linaro.org>
Date:   Mon, 31 May 2021 21:10:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <0e083e31-d349-6d5c-048f-258414492b2c@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 15:57, Jonathan Marek wrote:
> On 5/3/21 1:11 PM, Rob Herring wrote:
>> On Fri, Apr 23, 2021 at 01:24:40PM -0400, Jonathan Marek wrote:
>>> Document qcom,dsi-phy-cphy-mode option, which can be used to control
>>> whether DSI will operate in D-PHY (default) or C-PHY mode.
>>
>> Given this is a standard MIPI thing, I think this needs to be a common
>> property. We already have phy bindings that use the phy cells to set the
>> phy type which I think you should use here. See
>> include/dt-bindings/phy/phy.h.
>>
> 
> Is it OK to simply change the option to something like "phy-mode = 
> <PHY_TYPE_DSI_CPHY>;"?
> 
> (using phy-cells would be annoying to implement, with no benefit IMO)


To add another feather to the balance scales:

- `phys = <&dsi0_phy PHY_TYPE_DSI_CPHY>;` would bring knowledge about 
PHY mode to the DSI host (which does not really care about PHY mode)

- `phy-mode = <PHY_TYPE_DSI_CPHY>;` would stay in the PHY node, where 
this information belongs.

-- 
With best wishes
Dmitry
