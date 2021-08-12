Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485F63EAB75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhHLUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhHLUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:03:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e19so8720445pla.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NWgmDEccyBvUvz6V9WedwFoBsgEY8nM0D4Z4cC7Dw1I=;
        b=KPAXx1x0ghxtiKWnxWPLcRjyNaCb/MBL5gr9Di8dpaE8YepmpQG2Py4q8Km5krGwtf
         hd+78annMTSb2H0HMRRSTjqEUs4TihRPMXUVRnMUHRcbUTiVgQ26wUiwkvWpACTGEMqc
         w9Rql7eM/6wI6QrJYRxBaTdXaU9rCL5Wfk2lvKu4XmGieAfwjinEoU6SObJ0Kh2r6yyx
         nmntBx+tzxXS5gnEyXFT+0OCEKZnDXgfADScdkkVOwyxICnatOkR5/pws77rEAHtP8L+
         GIIw/KqLIR5y7OicfcKxB4kD4DOUs+QEhVPg5J/BQtezR3K/BL8eO2dnFkeh2ixMwXFV
         n+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NWgmDEccyBvUvz6V9WedwFoBsgEY8nM0D4Z4cC7Dw1I=;
        b=QyNgHQj88doAlg0STIJbuyQAbVqfcsuRMHXocM0f8p4He521gmMMz5eLazwOFprzHX
         Gch3EbmfPctVnX5mevoxfalFwrnXwccMgHJlQRVKfH+cvGGwQYq2UmDtHByQMnKNBV9K
         4MiqCVjX7aNk0EXaOPUn0rGKRi2uZRHS4UqvYOg35jveixpLxTu6H3UMPxDhUBdVYRSz
         bOtykXQJaG0rzMe7nHSuIQXM7vdX7qLA/x/d4VtQ/Qvkpp3aCzxhaDGFFzAZOV3ahXkI
         Cuc8T+XiL0HT2AqDY8cpwjWNX6/vhDrBN52FAHbY6vytmgRQhj7euT+2l3a02umvn9u7
         McEQ==
X-Gm-Message-State: AOAM5322JFS5nvSYZMKNoHMselD0MBNyJy3Ndb2FfeC3R4ubtjVCXuux
        jb7G6DCJG624kvd3Ib7ZTJA=
X-Google-Smtp-Source: ABdhPJzWO9vakgn2ani735QDF0vnWMKiASMkhe7pnHHh6mQ14HrUJpPPjqx6RbxVrw8DLFjU6DlG8Q==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr18539852pjr.4.1628798589513;
        Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l11sm4526447pfd.187.2021.08.12.13.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 13:03:09 -0700 (PDT)
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
To:     Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
Date:   Thu, 12 Aug 2021 13:03:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2021 12:23 AM, Hannes Reinecke wrote:
> On 8/2/21 1:26 PM, Daniel Wagner wrote:
>> From: James Smart <jsmart2021@gmail.com>
>>
>> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
>> exposed an issue where we may hang trying to wait for queue freeze
>> during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
>> the queue. However we never started queue freeze when starting the
>> reset, which means that we have inflight pending requests that entered the
>> queue that we will not complete once the queue is quiesced.
>>
>> So start a freeze before we quiesce the queue, and unfreeze the queue
>> after we successfully connected the I/O queues (the unfreeze is already
>> present in the code). blk_mq_update_nr_hw_queues will be called only
>> after we are sure that the queue was already frozen.
>>
>> This follows to how the pci driver handles resets.
>>
>> This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
>> controller reset hang during traffic".
>>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> CC: Sagi Grimberg <sagi@grimberg.me>
>> [dwagner: call nvme_unfreeze() unconditionally in
>>            nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
>> Tested-by: Daniel Wagner <dwagner@suse.de>
>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>> ---
>>   drivers/nvme/host/fc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 133b87db4f1d..b292af0fd655 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>>   	 * (but with error status).
>>   	 */
>>   	if (ctrl->ctrl.queue_count > 1) {
>> +		nvme_start_freeze(&ctrl->ctrl);
>>   		nvme_stop_queues(&ctrl->ctrl);
>>   		nvme_sync_io_queues(&ctrl->ctrl);
>>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>> @@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>>   			return -ENODEV;
>>   		}
>>   		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
>> -		nvme_unfreeze(&ctrl->ctrl);
>>   	}
>> +	nvme_unfreeze(&ctrl->ctrl);
>>   
>>   	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
>>   	if (ret)
>>
> There still is now an imbalance, as we're always calling
> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
> call 'nvme_start_freeze()' if we have more than one queue.
> 
> This might lead to an imbalance on the mq_freeze_depth counter.
> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
> the if() condition to avoid the imbalance?
> 
> Cheers,

Daniel,

try this. Moves the location of the freeze and will always pair with the 
unfreeze.

--- fc.c	2021-08-12 12:33:33.273278611 -0700
+++ fc.c.new	2021-08-12 13:01:16.185817238 -0700
@@ -2965,9 +2965,10 @@ nvme_fc_recreate_io_queues(struct nvme_f
  			prior_ioq_cnt, nr_io_queues);
  		nvme_wait_freeze(&ctrl->ctrl);
  		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
  	}

+	nvme_unfreeze(&ctrl->ctrl);
+
  	return 0;

  out_delete_hw_queues:
@@ -3206,6 +3207,9 @@ nvme_fc_delete_association(struct nvme_f
  	ctrl->iocnt = 0;
  	spin_unlock_irqrestore(&ctrl->lock, flags);

+	if (ctrl->ctrl.queue_count > 1)
+		nvme_start_freeze(&ctrl->ctrl);
+
  	__nvme_fc_abort_outstanding_ios(ctrl, false);

  	/* kill the aens as they are a separate path */

