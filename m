Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8E426850
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhJHK4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbhJHK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:56:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:54:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r7so28462712wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kKtYYGgZiFJvuei0yiQ5fmR24Nxd9GVQH20PjQB9cTo=;
        b=t7qHQgIs/f4qDsFUFAY2SVTHbN3Jd4tJFH2VDtmjdG3KA3kr8p2qO4hG+1VNmtXfMw
         NtLFsqTkv0iw2P+vrnBPW1eJXfC1ei9j6glHWVDpEdyg6CQGIWTQil3Vf+I2sjJ6ejYA
         FTp/kqf+yhsbMpvcvNMjHGORPLLuq65hPzx3GScVywgpQxkz4dDYXs81pENbRzsj2xPm
         mtE5VKKZ43dpDDytoq/lMYLop6kL5+mln76Bg0O+IwrApDZoyBbUYGYdfEZtgTakUrDl
         P6ej8zjuLFV0aIEt3zfThdrXbtNWWjfAdg5GpleYxmRRbbHkY6jfW+YRYM7azdVfuqr5
         JgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kKtYYGgZiFJvuei0yiQ5fmR24Nxd9GVQH20PjQB9cTo=;
        b=O1TsGpB76Ix4URQgNRl3w4HimzLXoL3k3KCoW6BD8sTZl3E3tnmEH0ENvOhaNITe6N
         nYkp1wZlwtxA9GkXPSmcp6cot8AjARvqrnUBgkYmCZdKFgW6THLFEjwdxCEBW4Al9mLl
         Zy527YY574YRwoQsFPxE+2P0t+TaRiybSmroDtcyJfnwakRY/7Z12KbO6qC+bnu+ULah
         RiRSZcj/T3F5u5OWbuwiLB22hAVavyRI7X9Vl6HoXkdwRODqrope18aahrywfnf/+/hG
         m8wsmqIq1oEN4IKAubv0aLkFwJvTIh9FC4KCyKtGBrGehNEcIzdxjrXX4FsAk+qSSO8q
         fV9g==
X-Gm-Message-State: AOAM533HqgasaURiRHbdIBN88v3AYxf6a+bOFqHVuFXC83U5DakOf4oX
        blCZQap3OdhTNDxVvt+Qr0hGnKkXmlopuA==
X-Google-Smtp-Source: ABdhPJzQIZ9XolMu8iQFcvt4FDGHlxb50OFJdQH6HP9nn83ou4f2CIx/s2ewtnDc9wNXJe1sBPnNPQ==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr2662284wmq.16.1633690443692;
        Fri, 08 Oct 2021 03:54:03 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l2sm1855394wrw.42.2021.10.08.03.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 03:54:02 -0700 (PDT)
Subject: Re: [PATCH] soundwire: qcom: add debugfs entry for soundwire register
 dump
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
 <YVaMlSbmFnrQyb0u@matsya>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <465c7753-4b39-c309-f535-a7a1809ae6ff@linaro.org>
Date:   Fri, 8 Oct 2021 11:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVaMlSbmFnrQyb0u@matsya>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2021 05:20, Vinod Koul wrote:
> HI Srini,
> 
> On 07-09-21, 11:56, Srinivas Kandagatla wrote:
>> +#ifdef CONFIG_DEBUG_FS
>> +static int swrm_reg_show(struct seq_file *s_file, void *data)
>> +{
>> +	struct qcom_swrm_ctrl *swrm = s_file->private;
>> +	int reg, reg_val;
>> +
>> +	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
>> +		swrm->reg_read(swrm, reg, &reg_val);
> 
> Why not use regmap_read here, that would avoid reading from the bus when
> we already have the values...

Sorry for such late reply.
But these are controller registers which are not exposed as regmaps in 
mmio cases.


> 
> Second make sure later when pm_runtime support is added, this take a
> reference ..
> 
Yes, Am currently working on runtime pm support, I will make sure that 
this is take care.

--srini
> Thanks
> 
