Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2733132F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhCHQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:16:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 08:16:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo4153333wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dUhsdpgyKbkw4pWWzlPQlJO0EnmBV3jJKURQm4/QkFA=;
        b=Nff/mQrlyV5ROAurVkLSqXKFuMVDszocw7rDWhPBnR1Ok/wDmBLCS7nSDiGVDCozIp
         80abNeWluZ3qJunraTaWeTDrTS6QZ55A1JrT+eOXxLY/VB8r0lVPL4S2vI9JqXfUw0Qg
         jb+a3xx6pBIAaJX274bWbRkLGTLpBwGJCgCj/mU7Jh1LVVmhvZbA1Yfo5a594wVROqUF
         cbvNKf6TSIj9Cebzvjd+bnKKtgJfjwRW4lwN84X4C8ewFjkxdJsneCURVdlOu38mHCCF
         LGW4Eqinvni1b7sguCO8y/yy0KD8f0vs5HY7l6zV1f0csCm/Z6QNTZIXx80Spfy2uVhK
         r2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dUhsdpgyKbkw4pWWzlPQlJO0EnmBV3jJKURQm4/QkFA=;
        b=lsuFjqWyXnwK4UOIpJ98WS1AI99YH1VOMGmixcAD5c77DNHJxTHmQswqheTHNaItW9
         G0rxBB9MBvlSKgqufx49bYAgbBfvaDJLsHagVkXL2h/BIdjOSAssXh5maJVa82es4sdP
         LKSmGo5oPdMt/VDu3U65sfruLhsJKQGmAqoFMHN2hcpQ02OR6rVbb1cfxC7gthsvKx0U
         b0zXkuMB7+N0qNKZvchRTYpRsZ5w5qjq6z7KmUFzDGZZI8eG62xyjqyaXgo9ee7ujd9j
         ZWxsWV1uuQxv/3YaoUOScKbLkpUCRg/h53IeEfJF0dhRe89W8yBG5OWyzX1BcSC9w8GC
         /5Bg==
X-Gm-Message-State: AOAM533hRexwY140c/Oakn2lHUUIZQe4o5WN435j/I7hLGcvrKIiWRhj
        U+0yA2uugL03XuF9Tn2eJnWK2g==
X-Google-Smtp-Source: ABdhPJx+IiBiziHQQ87PcUBmZFUJZZod0kR9YdAx8gqEn3DHUhj10eGtKcUpB9mxBAwo+eSgd3bZaQ==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr22525795wmf.99.1615220172820;
        Mon, 08 Mar 2021 08:16:12 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n6sm20123107wmd.27.2021.03.08.08.16.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 08:16:12 -0800 (PST)
Subject: Re: [PATCH v3 8/9] soundwire: qcom: add auto enumeration support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210308134957.16024-1-srinivas.kandagatla@linaro.org>
 <20210308134957.16024-9-srinivas.kandagatla@linaro.org>
 <ab00438b-dbb9-e6c6-019a-d50494e5dee1@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6050461e-5594-6272-e0ef-2ebdc271d809@linaro.org>
Date:   Mon, 8 Mar 2021 16:16:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab00438b-dbb9-e6c6-019a-d50494e5dee1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2021 15:56, Pierre-Louis Bossart wrote:
> 
>> +static int qcom_swrm_enumerate(struct sdw_bus *bus)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    struct sdw_slave *slave, *_s;
>> +    struct sdw_slave_id id;
>> +    u32 val1, val2;
>> +    bool found;
>> +    u64 addr;
>> +    int i;
>> +    char *buf1 = (char *)&val1, *buf2 = (char *)&val2;
>> +
>> +    for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>> +        /*SCP_Devid5 - Devid 4*/
>> +        ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_1(i), &val1);
>> +
>> +        /*SCP_Devid3 - DevId 2 Devid 1 Devid 0*/
>> +        ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_2(i), &val2);
>> +
>> +        if (!val1 && !val2)
>> +            break;
>> +
>> +        addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>> +            ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>> +            ((u64)buf1[0] << 40);
>> +
>> +        sdw_extract_slave_id(bus, addr, &id);
>> +        found = false;
>> +        /* Now compare with entries */
>> +        list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>> +            if (sdw_compare_devid(slave, id) == 0) {
>> +                u32 status = qcom_swrm_get_n_device_status(ctrl, i);
>> +
>> +                found = true;
>> +                if (status == SDW_SLAVE_ATTACHED) {
>> +                    slave->dev_num = i;
>> +                    mutex_lock(&bus->bus_lock);
>> +                    set_bit(i, bus->assigned);
>> +                    mutex_unlock(&bus->bus_lock);
>> +
>> +                }
> 
> you haven't changed that part, if the device is not in DT we should 
> still set bus->assigned::i

My bad! I missed it again!

Will fix it in next spin!


--srini
