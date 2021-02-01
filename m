Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5FF30AC03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhBAPwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhBAPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E66C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:50:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so17125165wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUbSt0j2uNzzROn36a7WfkVYptDQ/uSsFU0bvcjSRt4=;
        b=iVwe12+w6d+TvGIK6PdqeM5/IyY+6TdYFfcg6cIsXVAhkvpXl5+Vn4uzAMd7IX8Nlf
         xdu7G033xQ8LjtRsbwBv3lo1EYW8z3Ne7aqlIo7+5n2t0jwUbvEsto+hKaB+tCyz5L6S
         WKA2BDkp0ubXCcUeq80dxk1/D4eRptxa1bXXYS/n89duMIxegfiMyLZd+bLPUHLyDQxE
         n3E9u9VxII8nWJdj3HhIjjelD3TcNitolmNo7ll5I7Nz7M+onDV7HV+GXtF/9kQjthDg
         Gi8IfWk+J1KpzO/lQM/BRK4givkrcJmbFiTCOQvbC7ks/rdyG4XaUBIMXeijMN9weWcq
         35yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUbSt0j2uNzzROn36a7WfkVYptDQ/uSsFU0bvcjSRt4=;
        b=MJ48HAW3dngqoLruWh8dMYQazsNkdKmyZ/4JlMphqRjKtHayRjqZqOS56Itgi+E0O4
         +eBjP7IZwGGf8fOEz494yDq69TkAVTz+o9VjfV1DQuCp9as8BtS/9KGD3fPJ96lp8Duo
         WOzm/wTu2wSiD0pBAA4dxCulHfSj+5Mqh1IZLvfnaenrP0SKWVFL2t52gE9zUw8xN3LI
         wH5ajOwR5hC/SdoTE8Ff+63L+Bnh2cnNaTJsmU3IzoCrl/FJ2KEojz5WKNsPSLJmBcBi
         5X3Vh7moELbjkJwGOJjm2abRsbvI0aZlVUA1wHZh4XT05GJD1lQiw3eoOZTJKhja3PMI
         0Wsw==
X-Gm-Message-State: AOAM533Uf7daYbujbwvMrSpoRpxBpO5wstEOR/gxMxj5LQqgr8ci6riW
        o6A/V4C7bnYxJBGCyBFBDYFlUw==
X-Google-Smtp-Source: ABdhPJzDgzhQ6fs0p2Eb2FufY9C7QaoAJX+/hVppqdwV2uli4Jwr9tU0w32Jgf+dv/0c5OePuLHjkg==
X-Received: by 2002:a05:6000:1372:: with SMTP id q18mr18592228wrz.280.1612194645863;
        Mon, 01 Feb 2021 07:50:45 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id y6sm27196771wrp.6.2021.02.01.07.50.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:50:45 -0800 (PST)
Subject: Re: [PATCH 5/6] soundwire: qcom: update register read/write routine
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
 <5c69ed09-60be-2f3d-ed25-f6dbfcb9d62f@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3a2b5c2d-21aa-2bf5-62df-ef85c7c9293c@linaro.org>
Date:   Mon, 1 Feb 2021 15:50:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5c69ed09-60be-2f3d-ed25-f6dbfcb9d62f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 19:33, Pierre-Louis Bossart wrote:
> 
> 
> On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
>> In the existing code every soundwire register read and register write
>> are kinda blocked. Each of these are using a special command id that
> 
> what does 'kinda blocked' mean?

I meant read/writes are waiting for completion interrupt!

> 
>> generates interrupt after it successfully finishes. This is really
>> overhead, limiting and not really necessary unless we are doing
>> something special.
>>
>> We can simply read/write the fifo that should also give exactly
>> what we need! This will also allow to read/write registers in
>> interrupt context, which was not possible with the special
>> command approach.
> 
> This is really unclear, sorry.

If read/writes are waiting for an interrupt, it becomes difficult to 
read or write to any registers from same interrupt handler!


> 
>> +    if (id != SWR_BROADCAST_CMD_ID) {
>> +        if (id < 14)
>> +            id += 1;
>> +        else
>> +            id = 0;
> 
> that is really odd. if id=13 (group2) then id becomes 14 (master 
> address). A comment is really needed here.

This is magic value for each fifo read or write, so that we can verify 
that them by comparing with this magic value!

This has nothing to do with device number!

> 
>> +    if (cmd_id == SWR_BROADCAST_CMD_ID) {
>> +        /*
>> +         * sleep for 10ms for MSM soundwire variant to allow broadcast
>> +         * command to complete.
> 
> that's also super-odd. There is nothing in SoundWire that makes any 
> difference between a regular and a broadcast command. they all complete 
> in the same time (a frame).
>> +         */
>> +        ret = wait_for_completion_timeout(&swrm->broadcast, (2 * 
>> HZ/10));
> 
> is this 10ms really or dependent on CONFIG_HZ?
> 
>> +        if (!ret)
>> +            ret = SDW_CMD_IGNORED;
>> +        else
>> +            ret = SDW_CMD_OK;
> 
> no CMD_FAILED support?

Qcom controllers does not provide that information if the command is 
ignored or failed by any means!

That was the behavior from the starting of this driver.

> 
>> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
>> +                     u8 dev_addr, u16 reg_addr,
>> +                     u32 len, u8 *rval)
>> +{
>> +    u32 val;
>> +    u32 retry_attempt = 0;
>> +    u32 cmd_data;
>> +    int ret = SDW_CMD_OK;
>> +
>> +    mutex_lock(&swrm->io_lock);
>> +    val = swrm_get_packed_reg_val(&swrm->rcmd_id, len, dev_addr, 
>> reg_addr);
>> +
>> +    /* wait for FIFO RD to complete to avoid overflow */
>> +    usleep_range(100, 105);
>> +    swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
>> +    /* wait for FIFO RD CMD complete to avoid overflow */
>> +    usleep_range(250, 255);
>> +
>> +retry_read:
>> +
>> +    swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
>> +    rval[0] = cmd_data & 0xFF;
>> +
>> +    if ((((cmd_data) & 0xF00) >> 8) != swrm->rcmd_id) {
>> +        if (retry_attempt < MAX_FIFO_RD_FAIL_RETRY) {
>> +            /* wait 500 us before retry on fifo read failure */
>> +            usleep_range(500, 505);
>> +            if (retry_attempt == (MAX_FIFO_RD_FAIL_RETRY - 1)) {
>> +                swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
>> +                swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
>> +            }
>> +            retry_attempt++;
>> +            goto retry_read;
>> +        } else {
>> +            dev_err(swrm->dev,
>> +                    "failed to read fifo: reg: 0x%x, \
>> +                    rcmd_id: 0x%x, dev_num: 0x%x, cmd_data: 0x%x\n",
>> +                    reg_addr, swrm->rcmd_id,
>> +                    dev_addr, cmd_data);
>> +            ret = SDW_CMD_IGNORED;
>> +        }
>>       }
> 
> the flow seems complicated with multiple tests and goto? Can this be 
> simplified?

I will try to simplify this in next version!
