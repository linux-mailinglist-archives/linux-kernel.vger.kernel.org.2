Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F969361F95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbhDPMPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:15:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18464 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhDPMPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:15:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618575277; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TE0UfCCs0t5M7uKrBfemPgC5lI7MMceAzvf4wl8pkcU=;
 b=xQqMj957nF3gaVwobgGMJxmb33SPZZRWo36+eC6BlxYQSNETRoo9fa+oWFNO8IrHFl1nLe5t
 TWzjuuq76H0iTOMIcDm9j+sLLQzsP5ISc3mlILPFC8uYQBXRErWfl38M1xGKbPX0HsW5nvje
 8Q/K2bQnoXv01JVDowrHfpLEqMc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60797fa0853c0a2c46ae3822 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 12:14:24
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9501C43461; Fri, 16 Apr 2021 12:14:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2FB1C433C6;
        Fri, 16 Apr 2021 12:14:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Apr 2021 20:14:22 +0800
From:   taozha@codeaurora.org
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: Re: [PATCH v1 1/2] coresight: Add support for device names
In-Reply-To: <87im4mfpds.fsf@ashishki-desk.ger.corp.intel.com>
References: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
 <1618560476-28908-2-git-send-email-taozha@codeaurora.org>
 <87im4mfpds.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <fbadb638e161e62d38ed2ba905da7340@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-16 19:19, Alexander Shishkin wrote:
> Tao Zhang <taozha@codeaurora.org> writes:
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 4ba801d..b79c726 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1640,6 +1640,12 @@ char *coresight_alloc_device_name(struct 
>> coresight_dev_list *dict,
>>  	int idx;
>>  	char *name = NULL;
>>  	struct fwnode_handle **list;
>> +	struct device_node *node = dev->of_node;
>> +
>> +	if (!node) {
>> +		if (!of_property_read_string(node, "coresight-name", &name))
> 
> Ok, I'm not a device tree expert, but I'm pretty sure the above is a
> nop.
> 
> Regards,
> --
> Alex
You are right. The pointer check code here is wrong, I will correct it 
on the V2 version.

Tao
