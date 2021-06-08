Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E039FD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhFHROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:14:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10019 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhFHROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:14:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623172329; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=CIKLmkMnvwyP5IOM9d74QsZFNlusl5GyO4NIbwNDzag=; b=EYOvaeQxZco5iVrgGtPM3Z33mvvTL30kO3Xm1AYTj51aamD0wbt2yn/FNNtD354o6dV8chxN
 eZLQBjxYaKTOgAe38+sOflzt7SOGwsaLOdlq27y9nEki1JhUaItg8523IWUa1My2CSBjjvAC
 Ja6YXQzagO8qWo7DGs4FYD6jt5c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60bfa4e4e27c0cc77f8d7889 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 17:12:04
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6844FC43148; Tue,  8 Jun 2021 17:12:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9679FC4338A;
        Tue,  8 Jun 2021 17:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9679FC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v11] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
References: <1623141934-7699-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <b84892d5-06ed-fdbe-b5b3-0956140573ec@codeaurora.org>
Date:   Tue, 8 Jun 2021 22:41:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcwW6RGALAjzcK4W9xy_hDPyFti4cNY_pCwJnjUr+VYVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2021 5:20 PM, Andy Shevchenko wrote:
> On Tue, Jun 8, 2021 at 11:45 AM Faiyaz Mohammed <faiyazm@codeaurora.org> wrote:
>>
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>>
>> To overcome this issues, move the alloc_calls and free_calls
>> implementation to debugfs.
>>
>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
> 
> It seems you missed the version bump along with changelog.
> Note, some maintainers (actually quite many I think) are using tools
> to fetch up the patches and two patches with the same version is a
> problem. Hence I do not consider it a nit-pick.
> 
Hmmm, I think to avoid same version problem I have to push same patch
with new version number and thank you for your patience.


Thanks and regards,
Mohammed Faiyaz
