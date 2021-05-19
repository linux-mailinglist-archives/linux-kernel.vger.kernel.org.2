Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACC388BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhESKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:50:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18208 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhESKur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:50:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621421367; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6jN30GAH7SHyi9pdzuWcOo8HGMqceCQWxC8zP9uePyA=; b=xCxspIARlFxvtUJb3HAqbJIZeiGty9lGevWd7DP26Jek+zNEFAU3+DnuhfFMjJMidsT/enFl
 LmBt/bDuvv34bRJXEhwkJNgksciLyQLpwzD0tFVicnG/X6/NrHp7DPK5oGOxa/Kgtvx2B9rB
 p4RQVV0I5gpE0hBX3c/xxkQRUy8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60a4ecfbb15734c8f906106b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 May 2021 10:48:27
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE1A0C43144; Wed, 19 May 2021 10:48:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2438C43460;
        Wed, 19 May 2021 10:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2438C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v6] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Greg KH <greg@kroah.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
 <YKPBFn26BlPJZn0t@kroah.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <ddc70189-39a0-04b3-8d89-57cb524792df@codeaurora.org>
Date:   Wed, 19 May 2021 16:18:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKPBFn26BlPJZn0t@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/18/2021 6:58 PM, Greg KH wrote:
> On Tue, May 18, 2021 at 06:15:49PM +0530, Faiyaz Mohammed wrote:
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>>
>> To overcome this issues, move the alloc_calls and free_calls implemeation
>> to debugfs.
>>
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>>  include/linux/slub_def.h |   8 ++
>>  mm/slab_common.c         |   9 ++
>>  mm/slub.c                | 359 ++++++++++++++++++++++++++++++++++++-----------
>>  3 files changed, 294 insertions(+), 82 deletions(-)
> 
> If this is v6, what happened in v1-5?  That should always be below the
> --- line, right?
> 
Will update in next patch version.

Thanks and regards,
Mohammed Faiyaz
