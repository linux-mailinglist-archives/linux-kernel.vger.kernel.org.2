Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEF31F75D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBSKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:36:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D1BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:35:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so6574955wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GJzyDbQEHvg9RkTSSUWmUHNbCY2ZbX3arjdVS2a1MdA=;
        b=Y3dqrshqF9TfTg9lBFRHAc4MLVimbvqcVUlP5n5yYvGF9QcGBOl13ZvykEFpZDSIl3
         ZsQdKHSOIGEH98YBVHAY91xzaVGwxYMmbHBht0DmbQqXBbr45Sa9VApxzOBYGOuev5tQ
         +HG5fxBpQ8PuymjEvpo8mDxSEf+4oryltPfuVi+ExU8l92UtsUKQY48aEcgJzWcdeAqp
         mDuvl/c23FaZnMcbRL7k5yR8rhgcA6S8LnrdRQpwwKdT0rnC57Bo/ZXKu7FAJ9Or7L3a
         a+AXFq/Z7P4pzOQwMx8xhgylQ0a1zrT7Jf/vP7W51E8w9go36Gw+R8vcbladaO2TJ667
         xM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GJzyDbQEHvg9RkTSSUWmUHNbCY2ZbX3arjdVS2a1MdA=;
        b=H6JOiH4NXbw6nfmOH2JtDD/5BDd3ps/oC42D4QLyo8zzclN6m9IzvN7rMBoTAHUp+Y
         5pOVe54S+a+ItuMKBPeMLRzisMfQ5vEPgsnU/8/zx9Hv9vUg0fFzenYKWxkRWVvJhRG1
         wKyvr0iLx5Hv2jWXDtU02+3XKovfWl7lO0DJ4H2qyYFtk9rnUAfTVy7/k4k+qbf+UzWc
         mDGmizqd1KYMfh1Iev1Z3cvxlclLbqBa90ASmzW7g9npRrrDFcVeFlKojHQiYiUMk2LG
         q1GJOazxrklEBj2PNM6kYGCPBlatHSC2eeZz6XFuydGe3GL9n4sAchb5crV8HJb2+x+W
         bcKg==
X-Gm-Message-State: AOAM532htMEqPUkxARBLgfWRk7ZwSky9+1beLst1y6ZfgZaUU4ge6KT9
        7/5IZOCh8AbIzFn+0VEMtjFZdpU7wcQ+nQ==
X-Google-Smtp-Source: ABdhPJwRUf2mIwFss3MVliBzY3n+8PXZU8YQpwkoTd/sxal4PHFIG7rtsGlvWyEAajW6SS8eX89mjA==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr7568203wmk.116.1613730947917;
        Fri, 19 Feb 2021 02:35:47 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q140sm14326786wme.0.2021.02.19.02.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:35:47 -0800 (PST)
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        yung-chuan.liao@linux.intel.com, gregkh@linuxfoundation.org,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
 <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
 <31ff9d2b-760a-374e-5b37-45d8e8116f7b@linaro.org>
 <20210201102709.GT2771@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c8bb718d-c06d-2942-9c0b-2a6f97031e10@linaro.org>
Date:   Fri, 19 Feb 2021 10:35:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201102709.GT2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre/Vinod,

On 01/02/2021 10:27, Vinod Koul wrote:
>>> It seems you are in a different solution-space, where the codec driver
>>> needs to notify the master of which ports it needs to use?
>> Correct! As Codec is the place where we have mixer controls ant it can
>> clearly tell which master ports should be used for that particular
>> configuration.
> And that should come from firmware (DT etc) and driver should pass on
> this info

Are you okay with the patch as it is, provided this information is 
populated from DT?



--srini
> 
