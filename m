Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C622B45C9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhKXQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbhKXQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:29:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E745C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:26:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 133so2997659wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJMSjgjB8SBuw3xGd9DksSxoXrvTi8wJo/B0a8tS7qQ=;
        b=G6gwTG6Bsn+1T6N/vp3ZSKszg9ljzrkDmE7VZCmk+OCnwxcvDTmVfJchkUzoIMY6zM
         z+xRcOxqOkJb5x4Jymn76aHKVOptKWpcZq7ZEiNOCGrNQhx4CwGZtZidRnK8fB48sE3K
         xxT5Ov5YdWm1bu3Y+7d7ivk2iiCja0AMF9rzpcBg05GbVgUtiSM4vYwds7ozySvEK01S
         p70c0WhuCbU7O74WWxTjhXKv/NXNCkq3Ctx15Vd7fJiDXapDo4ko9yWPsixmqFpM+W98
         owIbITToYVAo99Lr0tUdl/u7to3+8RF6t1OdYzcswt7Ltp7V+chZjHynzBSMxP2nSkPP
         pH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJMSjgjB8SBuw3xGd9DksSxoXrvTi8wJo/B0a8tS7qQ=;
        b=2eNclBaNI4BK6pyE+93huMNyNyGgDjAepXH1LhG77zxK5IljNIgRnlwfrOVoPlcRwT
         YsvO12Ax+RFRGv5U2ax7kBV21OQcUfe7ZUqsNYkiLqVXJpJ2gsOREeaEW66XDaTwx1Af
         qI3Zdlql89jtOG5jjWoFw+vV1domUYYGkCHTS68+7UmmnnZnHWvAIhlXGc+X/7qBItbu
         vZ7Yb26hi9KIwmLHG6oz2CkILSsxwhvAeBKc9udyewdgfvRdX/CwDkJwr9VjCdtCKi2j
         LSlPQY72lHpiWBtGu9jkcnBqE7ZtJH79Bv81oCk6yicPypVXqQpc+PialHBe56wmtMZC
         kX3g==
X-Gm-Message-State: AOAM533k7cLu6SFARxOUFYrFjxfWW+MJAP3+Ovzbo/7k1iXmjigWAlNl
        yPkdkzMipk/RJQikpU7ZLuQQew==
X-Google-Smtp-Source: ABdhPJxqHDTxPmLpPgFDHSzAnT3Ut7UHfpNDugWGWbqgZqCUBEx36A5DbfaNSLBaw8OM2NlHg+bttg==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr16997630wma.45.1637771196291;
        Wed, 24 Nov 2021 08:26:36 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4839:bd64:93f4:614f? ([2a01:e34:ed2f:f020:4839:bd64:93f4:614f])
        by smtp.googlemail.com with ESMTPSA id y6sm5010635wma.37.2021.11.24.08.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:26:35 -0800 (PST)
Subject: Re: [PATCH 1/5] dt-bindings: Powerzone new bindings
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
 <CAPDyKFpJHzAxGk=Y52VXcuVbAunwfMo2ErnwXMqnxzHPs6O30g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <65873f24-46da-07f4-9661-e3f1001a4fa2@linaro.org>
Date:   Wed, 24 Nov 2021 17:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpJHzAxGk=Y52VXcuVbAunwfMo2ErnwXMqnxzHPs6O30g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ulf,

thanks for the review

On 24/11/2021 15:54, Ulf Hansson wrote:

[ ... ]

>> +  This description is done via a hierarchy and the DT reflects it. It
>> +  does not represent the physical location or a topology, eg. on a
>> +  big.Little system, the little CPUs may not be represented as they do
>> +  not contribute significantly to the heat, however the GPU can be
>> +  tied with the big CPUs as they usually have a connection for
>> +  multimedia or game workloads.
>> +
>> +properties:
>> +  $nodename:
>> +    const: powerzones
>> +
> 
> Do we really need a top-node like this? Can't that be left as a
> platform/soc specific thing instead? Along the lines of how the last
> example below looks like? Maybe we can have both options? I guess Rob
> will tell us.

Do you mean a compatible string?

> Moreover, maybe we should put some constraints on the names of
> subnodes (provider nodes) with a "patternProperties". Something along
> the lines of below.
> 
> patternProperties:
>   "^(powerzone)([@-].*)?$":
>     type: object
>     description:
>       Each node represents a powerzone.

Sure

>> +  "#powerzone-cells":
>> +    description:
>> +      Number of cells in powerzone specifier. Typically 0 for nodes
>> +      representing but it can be any number in the future to describe
>> +      parameters of the powerzone.
>> +
>> +  powerzone:
> 
> Maybe "powerzones" instead of "powerzone". Unless we believe that we
> never need to allow multiple parent-zones for a child-zone.

May be that could be needed in the future. No objection to rename it to
'powerzones'.

>> +    description:
>> +      A phandle to a parent powerzone. If no powerzone attribute is set, the
>> +      described powerzone is the topmost in the hierarchy.
>> +
> 
> We should probably state that the "#powerzone-cells"  are required. Like below:
> 
> required:
>   - "#powerzone-cells"

Ok

> Moreover, we probably need to allow additional properties? At least it
> looks so from the last example below. Then:
> 
> additionalProperties: true

I was unsure about adding it. With the actual description what would be
the benefit ?

>> +examples:
>> +  - |
>> +    powerzones {
>> +
>> +      SOC_PZ: soc {
>> +      };
> 
> This looks odd to me.
> 
> Why do we need an empty node? If this is the topmost power-zone, 

Yes it is

> it
> should still have the #powerzone-cells specifier, I think.

Ok, makes sense

>> +
>> +      PKG_PZ: pkg {
> 
> As I stated above, I would prefer some kind of common pattern of the
> subnode names. Maybe "pkg-powerzone"?

Ok, may be 'powerzone-pkg' to be consistent with the power-domains pattern?

>> +        #powerzone-cells = <0>;
>> +        powerzone = <&SOC_PZ>;
>> +      };
>> +
>> +      BIG_PZ: big {
>> +        #powerzone-cells = <0>;
>> +        powerzone = <&PKG_PZ>;
>> +      };
>> +
>> +      GPU_PZ: gpu {
>> +        #powerzone-cells = <0>;
>> +        powerzone = <&PKG_PZ>;
>> +      };
>> +
>> +      MULTIMEDIA_PZ: multimedia {
>> +        #powerzone-cells = <0>;
>> +        powerzone = <&SOC_PZ>;
>> +      };
>> +    };
>> +
>> +  - |
>> +    A57_0: big@0 {
>> +      compatible = "arm,cortex-a57";
>> +      reg = <0x0 0x0>;
>> +      device_type = "cpu";
>> +      #powerzone-cells = <0>;
>> +      powerzone = <&BIG_PZ>;
> 
> Just to make sure I understand correctly. The big@0 node is a
> powerzone provider too? Or did you mean to specify it as a consumer?

I'm not sure 'provider' or 'consumer' make sense in this context.

big@0 is a powerzone we can act on and its parent is the BIG_PZ powerzone.

However this description is correct but confusing.

Given big@0 and big@1 belong to the big 'cluster' and when we act on the
performance state of big@0, big@1 is also changed, the correct
description would be:

    A57_0: big@0 {
      compatible = "arm,cortex-a57";
      reg = <0x0 0x0>;
      device_type = "cpu";
      #powerzone-cells = <0>;
      powerzone = <&PKG_PZ>;
    };

    A57_1: big@1 {
      compatible = "arm,cortex-a57";
      reg = <0x0 0x0>;
      device_type = "cpu";
      #powerzone-cells = <0>;
      powerzone = <&PKG_PZ>;
    };

If in the future, there will be a performance domain per core, then the
former description above would make sense.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
