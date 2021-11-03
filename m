Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91A94441C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhKCMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:44:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53991 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhKCMn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:43:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635943281; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5Zua4IDTp0PuDzRqPrRVeJnmjfF/rB/RxwKO2VUkodo=; b=gVF4ljDmr8QJw2kH3dkyV7thJ2dANfArF92M+/FYJVonFV94keee3Af8fGrsMUAKval7Fbl/
 t0LYvX6Ejaw+7J7yTJN9ugdpn/dG1KKdaxiqcdGpe9zYIuv0u7DO3Yv5PA+RDHOdpZ3evIf7
 iUeCuL3SYJbWNn+FthimkVuyISc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61828364e07de15b128b6cb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Nov 2021 12:41:08
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F03FAC4361C; Wed,  3 Nov 2021 12:41:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.156.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D854C4360D;
        Wed,  3 Nov 2021 12:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4D854C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, rppt@linux.vnet.ibm.com,
        guptap@codeaurora.org
References: <1633701982-22302-1-git-send-email-charante@codeaurora.org>
 <CAJuCfpEikFP8sifts8-p7zviJSW7A=Tff5ve2Wc6PZEWAP9OXA@mail.gmail.com>
 <442feb78-a1f0-581a-84de-5d33baa5a7f5@codeaurora.org>
 <CAJuCfpEy7UCD6C9OyxzDFV-4AOj7-QQEZa4KXJwZer2BkBnO+g@mail.gmail.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <1ef89af2-43a4-415c-3c8b-97dca429a416@codeaurora.org>
Date:   Wed, 3 Nov 2021 18:11:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEy7UCD6C9OyxzDFV-4AOj7-QQEZa4KXJwZer2BkBnO+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Suren for the reply!!

On 11/2/2021 11:42 PM, Suren Baghdasaryan wrote:
>>> Also not sure if you need to isolate the page before this writeback.
>> Isolation may not be required but this is to avoid trying of the reclaim
>> on the same page in some parallel path as both any way places the page
>> in the swap. Or you want me to remove the isolation here?
> Maybe you could isolate them in bulk then? Seems like a waste
> isolating them one-by-one.

Okay. Should the bulk here be SWAP_CLUSTER_MAX fine?

> 
>>> Won't deleting the page from swap cache interfere with ongoing
>>> writeback if it has not yet completed?
>> I just followed the path of how to reclaim the page:
>> shrink_page_list()
>>      pageout()
>>      ..........
>>      __remove_mapping()
>>         __delete_from_swap_cache()
>>
>> You see some issue here which I can't understand.
> I think shrink_page_list() would not call __remove_mapping() if after
> pageout() PageWriteback() is still true. Maybe I'm missing some path?

I agree here. PG_writeback might have still set on the pages under
background writeback thus should be excluded.

I just considered the case for sync writes, eg:zram,  where PG_writeback
is cleared before returns.

Will update the change accordingly.

> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
