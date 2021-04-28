Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959436D534
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbhD1J7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:59:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48447 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238345AbhD1J7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:59:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619603916; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=H694mQ/ziydDuhz33jUQw61T/pNYzvI3cMMA2gBlHiI=;
 b=pwZYjXf+2jjE++EuHtK0+/C2VMpXzWwomV8MUp1N2bhfeN7h0o1LHf42Rcu7abQLVW1+VkYY
 PXFjVvrIaq5SN/VHQwwXLelQrnr+8LpsxEcwu9a3DS6shKvmEKx2vWdUqyyFJ5DUvjWXePKj
 rvqAJKOKpbLHRi4ALpHnCyS48WA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 608931cbf34440a9d458588f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Apr 2021 09:58:35
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77C15C43217; Wed, 28 Apr 2021 09:58:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE916C433F1;
        Wed, 28 Apr 2021 09:58:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Apr 2021 17:58:34 +0800
From:   taozha@codeaurora.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: Re: [PATCH v1] coresight: add node to reset all coresight devices
In-Reply-To: <YIKbJ/WafuFnqGvr@kroah.com>
References: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
 <YIKbJ/WafuFnqGvr@kroah.com>
Message-ID: <5d9d5127a2f3e42380c78f77cfc719cd@codeaurora.org>
X-Sender: taozha@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-23 18:02, Greg Kroah-Hartman wrote:
> On Fri, Apr 23, 2021 at 04:29:38PM +0800, Tao Zhang wrote:
>> Add new reset_source_sink node to be able to disable all active
>> coresight devices.
>> In this way, we no longer need to manually disable all active
>> coresight devices one by one. After enabling multiple coresight
>> paths, users can reset their status more conveniently by this
>> node.
>> 
>> This patch base on coresight-next repo
>> http://git.linaro.org/kernel/coresight.git/log/?h=next
>> 
>> And this patch depends on the following patch
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2551216.html
>> 
>> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
>> Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
>> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
>> ---
>>  drivers/hwtracing/coresight/coresight-core.c | 72 
>> ++++++++++++++++++++++++----
>>  1 file changed, 64 insertions(+), 8 deletions(-)
> 
> You added new sysfs files with no new Documentation/ABI entries, so we
> have no idea how to review this code to determine if it does what you
> want it to do :(
> 
> thanks,
> 
> greg k-h
I will update this part according to your suggestion in patch v2.

Best,
Tao
