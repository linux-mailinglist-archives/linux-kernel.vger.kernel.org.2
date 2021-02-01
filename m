Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0430AC00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBAPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhBAPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:10 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76FC0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:50:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so17078194wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jLXchjLYpfk30+3JtEghxJByQwUZC+98ZI/GjYhNUbg=;
        b=z7599OvxYrLMvpHxsHNK05a0YqO/c78Lfy4XVtHh6ZZAiQZf+GX3qcSBY3dOyupnJH
         WzhK+kImlQrQthVe2a6Q67Mun9T1xKgr0+ZFsdkRqB1fs6xElDf3LHkTDjwG0kcZ7sTw
         vP2r1qjM8H5wtH4rNomK9qsYtqlJ15hkTZROhL9OxCfC+CtgLdL1GzILYSevKINCP6ho
         u3heyPhv8ix87hUPyPW4cXCiFLxOSiWEI8rg/RHMmeI8VWZnKHM4RLs217ksX5ApWpGB
         qbKjEdXcAJ0qvOYVbSsKUE3KE7drPusCLbgKGJp7T5sA62rM374gnEXMWx65bF+7lh3g
         fofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jLXchjLYpfk30+3JtEghxJByQwUZC+98ZI/GjYhNUbg=;
        b=VcEV4WJs71LTugvwVmqH6tSQYRDpFMARlX70XCcNxeXADzjo+dWjjbWgomZ2Ywd4lQ
         qyxbA+ctzsL7N9GxqDQtg5l0sro/yZOEPNtsyw82DisBtOMwbP0D8Je2lf5f1g/ldY/6
         0/08jY7KFEBfYfoF6Z/soQnpyIs2gXnKr7yj9K27Ckhr0WVC1LYQItSLqT7TKMe6vnvl
         p6UNdi0uQp7YKTaHB71SVhND+6qwyZAuJfeVXJQ1IT3Ze4EBriqjymrVupJ0PLrAGAef
         qp5vXfL5fkSOdpNAqeMuGeyuE/FfaeXLZJHOfy7TUlMMtR8IpSstjWK8k9QhxWqvN5G0
         MOpw==
X-Gm-Message-State: AOAM533OksgUaoUZgXpU8XgTM9shkuDFowxxKViXfqFzimLI+tCxiX/z
        5NUIYTDvAxYHOseObeucqrppeg==
X-Google-Smtp-Source: ABdhPJxvTN05V+JBPnV7r7zqKX3YZT+mvFxve6FYJKYvgJEGf46lnACLZCASNhUQsNJ33KB5Qeg3kA==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr19168962wrr.108.1612194629550;
        Mon, 01 Feb 2021 07:50:29 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id x9sm5316729wmb.14.2021.02.01.07.50.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:50:28 -0800 (PST)
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
 <20210201141642.GB2771@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1fef14fe-b254-9282-c213-d23e3b7d5f61@linaro.org>
Date:   Mon, 1 Feb 2021 15:50:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201141642.GB2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 14:16, Vinod Koul wrote:
>>   	/* Configure number of retries of a read/write cmd */
>> -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
>> +	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
>> +	    ctrl->version_step >= 1) {
> why not use raw version value?
> 
>          if (ctrl->raw > 0x10501 )
> 
We can do that way as well, but Major Minor seems much clear to readers!

--srini


