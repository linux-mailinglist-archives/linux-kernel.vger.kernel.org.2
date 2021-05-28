Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E68394319
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhE1NBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhE1NBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:01:08 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3559C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:59:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 76so3927086qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QkS67PNWJLrMlG0Eh1DFrl12I+MHfh0CuXPqyN2o9Jk=;
        b=RoE5+ne+IEtUIwJTmkaKAmIW8xmlFFiZyFu+RXc8Xtk3xP3WS2cnNmBkmt0rGcwaq/
         qb2PuixGE3rnUfQLjmTJ60OtadS6WqwIMVT+H21njXbcac9gUxl4ua+OaRnV6dmBPQGk
         cCjgQ0xixLesraJ7oA4Tw1q7d1IW86tp8+qcQKQmnLrhSW2W5PPT0vIu/dA7120u6STL
         lP8WtyfVW1q00VzSS8n+0giUcaceB12ncIClUcgKgzU6JWAGYtnVT6Fs+IJQA/a+kbEy
         bbqVyqPOW610wOc+b5AIAlA2tuOsdLLB6pV2bXvQM/3xs04eGLgpqeh/VYCtDPtFmGeu
         NfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkS67PNWJLrMlG0Eh1DFrl12I+MHfh0CuXPqyN2o9Jk=;
        b=AQ8CAacoHlazAXIkarZn3fOMocE9BeTT8SqCYvgjLSiBZtrToGxxKuA6oRqoauax9Y
         MGYi0ks1CkjaDb4VNRHksV/5kBWax4fIWyNrk2IT1UrzKRegT1ST3ml3pV+72fjDTgPF
         UFItpE3eZHtxuLTbEwJm7O7WO6OoeLFKT8fiXydKNNXqqO9ZjOmoQbNIro0KKEuMW1lW
         jRdklHrAGGEpmPfaxMOS/MNVT8jzC058Z+1VKNlCRwkxQF6WFsOa3hwSxPWMPAF+GoXP
         8Mu5ylFozIfnGkwTJxscEcjFnUQTJNZQxYwypV+UIEnc+tWlC5b9FH2bfynEdsWq+6vw
         /pVQ==
X-Gm-Message-State: AOAM5328GZJSaqp8wV3a0Mk4/Ihec5tNmJrbxPro5wkKe1RlsQ4IGhYu
        TqAJq1PMReDDmw24bgg79GDj1w==
X-Google-Smtp-Source: ABdhPJzrZ6/fmuomvi1UY7oEviJSluEuJL6Gjb+/l1q88tzyHFRCD8yK7EweolQnqF3+MS3DPRFyUQ==
X-Received: by 2002:a05:620a:745:: with SMTP id i5mr3821434qki.324.1622206771962;
        Fri, 28 May 2021 05:59:31 -0700 (PDT)
Received: from [192.168.0.189] (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id d6sm3525975qkf.109.2021.05.28.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 05:59:31 -0700 (PDT)
Subject: Re: [Freedreno] [PATCH v2 2/2] dt-bindings: display: msm/dsi: add
 qcom, dsi-phy-cphy-mode option
To:     Rob Herring <robh@kernel.org>
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
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <0e083e31-d349-6d5c-048f-258414492b2c@marek.ca>
Date:   Fri, 28 May 2021 08:57:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210503171139.GA2011901@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 1:11 PM, Rob Herring wrote:
> On Fri, Apr 23, 2021 at 01:24:40PM -0400, Jonathan Marek wrote:
>> Document qcom,dsi-phy-cphy-mode option, which can be used to control
>> whether DSI will operate in D-PHY (default) or C-PHY mode.
> 
> Given this is a standard MIPI thing, I think this needs to be a common
> property. We already have phy bindings that use the phy cells to set the
> phy type which I think you should use here. See
> include/dt-bindings/phy/phy.h.
> 

Is it OK to simply change the option to something like "phy-mode = 
<PHY_TYPE_DSI_CPHY>;"?

(using phy-cells would be annoying to implement, with no benefit IMO)
