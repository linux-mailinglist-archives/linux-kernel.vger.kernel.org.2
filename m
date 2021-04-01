Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9235351092
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhDAIGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 04:06:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28657 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhDAIGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 04:06:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617264365; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=IfL9i5EThcXAVj5yr7daU1/owcdLSXTZKtg98zUYSuM=; b=XDibQnTdbi6r9QDDrUts1JnXqivsEqn5SBfB+YG7shpT2pwddeEAJnsYxCfL2mfzUSE6p1qv
 Ryj7CnI4mnYW1tHztQZGqUqYtrIo790/D7M3lYKbD2TB6zqzSQRBAaqKUc7K8MOoshQqlpbG
 3RteLn+3J6EL42u9FZwijN89lWQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60657ee22cc44d3aeaf43840 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Apr 2021 08:05:54
 GMT
Sender: hangl=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B44DDC43461; Thu,  1 Apr 2021 08:05:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6702C433C6;
        Thu,  1 Apr 2021 08:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6702C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hangl@codeaurora.org
Subject: Re: [PATCH] binder: tell userspace to dump current backtrace when
 detecting oneway spamming
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, maco@android.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <1617176056-1440-1-git-send-email-hangl@codeaurora.org>
 <YGQoTPnndiJ5+mk3@kroah.com>
From:   Hang Lu <hangl@codeaurora.org>
Message-ID: <5035e2d0-8093-5570-88e0-01c81b9ae6ed@codeaurora.org>
Date:   Thu, 1 Apr 2021 16:05:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGQoTPnndiJ5+mk3@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2021 3:44 PM, Greg KH wrote:
> On Wed, Mar 31, 2021 at 03:34:16PM +0800, Hang Lu wrote:
>> When async binder buffer got exhausted, some normal oneway transaction
>> will also be discarded and finally caused system/app stop. By that time,
>> the binder debug information we dump may not relevant to the root cause.
>> And this issue is difficult to debug if without the backtrace of thread
>> sending spam.
>>
>> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when detecting
>> oneway spamming, request to dump current backtrace. The detection will
>> happened only once when exceeding the threshold (target process dips
>> below 80% of its oneway space, and current process is responsible for
>> either more than 50 transactions, or more than 50% of the oneway space).
>> And the detection will restart when the async buffer has returned to a
>> healthy state.
>>
>> Signed-off-by: Hang Lu <hangl@codeaurora.org>
>> ---
>>  drivers/android/binder.c            | 25 ++++++++++++++++++++++---
>>  drivers/android/binder_alloc.c      | 15 ++++++++++++---
>>  drivers/android/binder_alloc.h      |  8 +++++++-
>>  drivers/android/binder_internal.h   |  1 +
>>  include/uapi/linux/android/binder.h |  8 ++++++++
>>  5 files changed, 50 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index c119736..28ceaf9 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -87,6 +87,7 @@ static DEFINE_SPINLOCK(binder_dead_nodes_lock);
>>  static struct dentry *binder_debugfs_dir_entry_root;
>>  static struct dentry *binder_debugfs_dir_entry_proc;
>>  static atomic_t binder_last_id;
>> +static bool oneway_spam_detection_enabled;
> 
> Why is this a "whole system" value and not a "per binder instance"
> value?  You just allowed one binder instance to affect another one,
> which does not seem like a good idea to me :(

Sorry for the late reply. Actually I add this as it needs to be enabled to protect against user-space that doesn't understand the new command, so I make it a global setting. But making this flag per-proc will gain a finer control granularity, so I'll follow your suggestion and submit a v2 patch, thanks!

Regards,
Hang Lu

