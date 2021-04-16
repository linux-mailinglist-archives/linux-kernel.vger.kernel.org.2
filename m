Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0443621F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244515AbhDPORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:17:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62256 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhDPORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:17:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618582599; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=Zl5SJ6yEG1uasCvrWCfh8DC8M7mWjl5h/xZTSl3ucPw=; b=VdRMWGcSQq533IcIue7FZZVNo+jVXYSeqdWCxxPd8hQHSLKrwORTB1/Czzgp1Q6jMqwi399R
 wEUzX+VomRUBflxNEI5jfnEFNdg8Lnn0KrblF6Vnifm52xvrYNox7CewwWiZ6AXPuMlhy3EB
 PQDm8+2dW7lLZLIjYnJiFCaSyao=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60799c36215b831afbdecd7c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 14:16:22
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4023C43465; Fri, 16 Apr 2021 14:16:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 001A9C433CA;
        Fri, 16 Apr 2021 14:16:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Apr 2021 22:16:20 +0800
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
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: add property for coresight
 component name
Message-ID: <4c91ac77d6a9def6e521c6a2aeaa32eb@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-16 19:23, Alexander Shishkin wrote:
> Tao Zhang <taozha@codeaurora.org> writes:
> 
>> Add property "coresight-name" for coresight component name. This
>> allows coresight driver to read device name from device entries.
>> 
>> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt 
>> b/Documentation/devicetree/bindings/arm/coresight.txt
>> index d711676..0e980ce 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -103,6 +103,8 @@ its hardware characteristcs.
>>  	  powers down the coresight component also powers down and loses its
>>  	  context. This property is currently only used for the ETM 4.x 
>> driver.
>> 
>> +	* coresight-name: the name of the coresight devices.
> 
> Which devices? Also, is it a common practice to extend device tree
> definitions based on arbitrary driver needs, or should there be some
> sort of a discussion first?
> 
> Regards,
> --
> Alex
Through the device tree entries, we can define their own name for any 
coresight device. This design is mainly used to facilitate the unified 
naming of coresight devgies across targets. e.g, without this patch, we 
can only see from sysFS there are multiple funnels, but we cannot know 
which funnel it is based on their names from sysFS. After applying this 
patch, we can directly know what device it is by observing the device 
name in sysFS. And the common scripts can be developed, since applying 
this patch, the same coresight device can have the same name across 
targets. Each developer or vendor can define the name of each coresight 
device according to their preferences and products.

Tao
