Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62EA359554
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhDIGWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:22:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56579 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIGWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:22:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617949325; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Dr0V2K2hPThW8HdEC7Q5FkD6Iazwjel62EYhwC4zXhE=; b=iM18ZoGg4eaJ2WNep0n2UUvKjg147gxehTdkxQsZZOWmayTKFlQmAnVS1eF4LOc5+cDREyf0
 NgF7mwBgd5MwsHIkv/GIlNVr4V+kDwQMEdZyACgy9tr8vqwon7FXmeDXvn7BRbd2yken3KD1
 Dywx1bDi32kh8D2Hjnri9Pw0P1o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 606ff28c2cc44d3aea2d642c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 06:22:04
 GMT
Sender: hangl=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 776C6C433CA; Fri,  9 Apr 2021 06:22:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.239.97.70] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hangl)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EC88C43461;
        Fri,  9 Apr 2021 06:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EC88C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hangl@codeaurora.org
Subject: Re: [PATCH v4] binder: tell userspace to dump current backtrace when
 detected oneway spamming
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@google.com, tkjos@android.com, maco@android.com,
        arve@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <CAHRSSEyTDZTWMrWe+H4awCOBrf+AZd-TEqi3gZONZxYYQSWB5Q@mail.gmail.com>
 <1617939657-14044-1-git-send-email-hangl@codeaurora.org>
 <YG/veiWKkaJtEZkq@kroah.com>
From:   Hang Lu <hangl@codeaurora.org>
Message-ID: <17cf5552-8fec-3aca-a671-f5fbc9344c95@codeaurora.org>
Date:   Fri, 9 Apr 2021 14:21:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG/veiWKkaJtEZkq@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2021 2:08 PM, Greg KH wrote:
> On Fri, Apr 09, 2021 at 11:40:57AM +0800, Hang Lu wrote:
>> When async binder buffer got exhausted, some normal oneway transactions
>> will also be discarded and may cause system or application failures. By
>> that time, the binder debug information we dump may not be relevant to
>> the root cause. And this issue is difficult to debug if without the
>> backtrace of the thread sending spam.
>>
>> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when oneway
>> spamming is detected, request to dump current backtrace. Oneway spamming
>> will be reported only once when exceeding the threshold (target process
>> dips below 80% of its oneway space, and current process is responsible for
>> either more than 50 transactions, or more than 50% of the oneway space).
>> And the detection will restart when the async buffer has returned to a
>> healthy state.
>>
>> Signed-off-by: Hang Lu <hangl@codeaurora.org>
>> ---
>> v4: add missing BR_FROZEN_REPLY in binder_return_strings and change the size of binder_stats.br array
> 
> Should the BR_FROZEN_REPLY string be a separate patch as it's a fix for
> the "binder frozen feature", not this new feature, right?  Or does this
> patch require that change and the frozen patch did not?

Yes, BR_FROZEN_REPLY string is a fix and seems should to be separated from this new feature. But I'm still wondering how to submit these 2 separate patches as they edit the same place(maybe merge conflict). Do you know which of the following two commit methods is more suitable? Thanks!

1. char-misc-next HEAD --> BR_FROZEN_REPLY fix patch --> new feature patch

2. char-misc-next HEAD --> BR_FROZEN_REPLY fix patch
                   \-----> new feature patch

