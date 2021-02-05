Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0004310C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhBENnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBENkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:40:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5AC0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:39:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id u8so6993824ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeehWlA/F2e6kevzgurBlXoC2SgLPzjICfnHBJp8xXw=;
        b=fyC5ieFmhX2gXuRDFBl3MnJdGZZEBosubYtfM0C93wwpliWDPTRzOqXUilpk4XXCUz
         hx4lNX6V72yPEdFSLsfyuHZ0iMwCoF74ht9WUNRALMemGQVDJp69HdSWnFkV+sz/dYsA
         z/6hVd0me17m0sY6+0FoRiQJY0hOgB2t5WhX0v2VtR5AZ0+sQAjTDKdTDBTm3szHb9ap
         6h9XgVcz/Fk2Cjw9FEQTOZZGSagzggpCfl5amOD2VybjZjpabcc/KGi4kdztbgXt2IaI
         jymzV5CR7YYK+44JKb4br38wOqkh9MDNDsSb4ETZQZYjjUBP2sYDz+oCSMKsqrNEfdfs
         mQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeehWlA/F2e6kevzgurBlXoC2SgLPzjICfnHBJp8xXw=;
        b=jqxcN9fUxm2ewL0CFn1aVTfQzaYyhWqRT5dH5fz9mzC+6Gw3LD0piw5S5Anqv0ZCGq
         I6pKaydadiXlD43VKR+9H1c5wY4zZ8dTQ2NoMOOyHLwzYqEfICfJGPCWkvIs+nUXQ9LI
         pxVfhYQhM1PuSGLabzmcE6mXeOCbvlPTQLKZmKaHjBMbKjnI97G+5p9vOM2p3b/oPPBB
         2kDl/VPn2CNQRv7hkScz96BARPTlBcy9+aGUE82SDRVqNDvZ95xDS+2iQejNyPAhxznQ
         KrCrZuCAetyX8EbdrVMpZ7lbY/CoQtj8oke7LCgkQOTZhHIv0aXdag9SvyAbUl97xa6+
         Z3zA==
X-Gm-Message-State: AOAM5301RBwkSJ5xIwWx8CBv7rL1xX6RU5O6odhlOc9u1YneflsXmOno
        0fLVqU+fUO/9GcLkHuBx1HfsDzHZMpsPzw==
X-Google-Smtp-Source: ABdhPJzUu+mLjlS/mhwP9hIeGWQ2RXg/qpyfzUFtaOO8kCp50lZbw/OnwZvXxP1IEajLQvBtp/k+jg==
X-Received: by 2002:a05:6602:1223:: with SMTP id z3mr4210661iot.130.1612532354220;
        Fri, 05 Feb 2021 05:39:14 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f139sm4081947ilh.60.2021.02.05.05.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 05:39:13 -0800 (PST)
Subject: Re: [PATCH net-next 2/7] net: ipa: synchronize NAPI only for suspend
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, elder@kernel.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203152855.11866-1-elder@linaro.org>
 <20210203152855.11866-3-elder@linaro.org>
 <20210204205322.792e079c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <b054d86b-dead-3fa8-e2d5-6068a4d54e6c@linaro.org>
Date:   Fri, 5 Feb 2021 07:39:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210204205322.792e079c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 10:53 PM, Jakub Kicinski wrote:
> On Wed,  3 Feb 2021 09:28:50 -0600 Alex Elder wrote:
>>  int gsi_channel_suspend(struct gsi *gsi, u32 channel_id, bool stop)
>>  {
>>  	struct gsi_channel *channel = &gsi->channel[channel_id];
>> +	int ret;
>>  
>> -	return __gsi_channel_stop(channel, stop);
>> +	/* Synchronize NAPI if successful, to ensure polling has finished. */
>> +	ret = __gsi_channel_stop(channel, stop);
>> +	if (!ret)
>> +		napi_synchronize(&channel->napi);
>> +
>> +	return ret;
> 
> nit:
> 
> 	ret = function();
> 	if (ret)
> 		return ret;
> 
> 	/* success path: do something else */
> 
> 	return 0;

No problem, I'm happy with it the way you suggest.  I will
update in v2.   Thank you.

					-Alex

