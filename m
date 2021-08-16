Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC373EDCBF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHPSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhHPSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:02:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CCC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:01:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so638061pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQAn3RJnCnEKhUAHlpFfnDVdKYIBRS8GR6cHa78A0bI=;
        b=OiP/jE5lIKzaI86z/cSbkWq8KS+Zn367o727+x1oyIZCvtiHty5VuI3vR9Wd9m/DKC
         mrAvJapyrn3wsenqZ8mHt9roDOSCGfRyzs/k1mCcI1rBa1xvrOhQ1kmKQT1zcDOSS1FB
         9jlHPQve9GjHuRcHIygklthjRruh8CAuZ7VKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQAn3RJnCnEKhUAHlpFfnDVdKYIBRS8GR6cHa78A0bI=;
        b=Cv+XUUY6JdDz5lkNPFOW67wjdLqQRGx0gVknoJdt9XeE8H/3Jles2LM2iH9wAc4TKb
         7XmT9zK5iYyUuuZFN5WqtUn0lys2WJ8X4eacO6bzuxFhV5nFk5Pe77luZjnZoNRylT1m
         IhZ2R4ylQ+ApDAuACwPWrd+b1XAeYWERYsg1li/V4x+N30ctOsO8jLaDYaK7lZqmLl4b
         BYU6pXDpWMzljUyhVv2UoteDFXZUfsZQPlb17bKVeFUKg80KONj70sIcC7bvzw15Ey8E
         W/2sLeB90g1dNr1RBbNPEnoTiQysWGFEXD5aeYezyExXJlUyiIRLlIjjIQLbnPHpEFb7
         nlKA==
X-Gm-Message-State: AOAM530Y/8ccINCW3lwLlElAq5cCtIOiwN9urrSRgytaojzytMsY70tS
        Drr3cBX09hhW9UlJXAIe3I90cA==
X-Google-Smtp-Source: ABdhPJwa1Xm3ePFA3SuM8XZOqgsVOXYMQm8FtguFpY+P9+T3EtyPVM2ryfi8HpcN6WgUHqWEMqbCBg==
X-Received: by 2002:a17:902:a609:b029:12b:858e:d116 with SMTP id u9-20020a170902a609b029012b858ed116mr104173plq.25.1629136905928;
        Mon, 16 Aug 2021 11:01:45 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5cff:3a19:755c:1b91])
        by smtp.gmail.com with UTF8SMTPSA id x12sm63119pfu.21.2021.08.16.11.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:01:45 -0700 (PDT)
Date:   Mon, 16 Aug 2021 11:01:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Subject: Re: [PATCH v1 2/2] dt-bindings: Add SC7280 compatible string
Message-ID: <YRqoB2UEJtVcr6AN@google.com>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org>
 <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 05:38:02AM +0530, Sankeerth Billakanti wrote:
> The Qualcomm SC7280 platform supports an eDP controller, add
> compatible string for it to msm/binding.
> 
> Signed-off-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 64d8d9e..23b78ac 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -17,6 +17,9 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-dp
> +      - qcom,sc8180x-dp
> +      - qcom,sc8180x-edp
> +      - qcom,sc7280-edp

This adds compatible strings for sc8180x and sc7280 (e)DP, however the
commit message only mentions sc7280. So either the commit message needs
and update or the sc8180x compatibles should be removed.

The driver change (https://patchwork.kernel.org/project/linux-arm-msm/patch/1628726882-27841-2-git-send-email-sbillaka@codeaurora.org/)
adds some (currently unused) 'io_start' addresses which are hardcoded,
I wonder if these should be in the device tree instead (and 'num_dp'
too?), if they are needed at all.
