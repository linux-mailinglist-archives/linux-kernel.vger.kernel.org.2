Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0137AE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:17:20 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33586 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:17:20 -0400
Received: by mail-pf1-f178.google.com with SMTP id h16so3915726pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b4PMiCif1x3iYDBqI6f5owLmB4HyczaNc9Vt8ePTfoA=;
        b=PXtWKc2EKBOA1msX/QKI+2i7P/opdLxm0rxDYvXQi4MnwJdJ0pblMao0T+B75LyZzI
         AKnROlRhExVI+GPeRpH1cLIHfGcbE8RfnfxR4L5Pa9u5WOFKGmGgAzkkyA94vST3HnN8
         DYKW6UOTfC5NM4ptwrOq285BYOD6fIaYAcNdAaLDwbDmK2TyTYOdDvXGbLQdxx3t6r7U
         GY2K1QxsVWXV3Rc1TegC3YRRODJqF9wHWLwcvBJWQmpVMqoh4iMFfxfdYLIa7omT6rqu
         AsWrGpF8axRcJH7WzLuOY+wVlRMdN+miFjgoN+CcO2x7wSfbeVWfdAziAG5UVIs6UXdu
         Q8Nw==
X-Gm-Message-State: AOAM532b9eCG5I9fiwsSeYxlQECfNxkxDVF4uGNPgDtiHKmUYKvUl1hA
        HFoyAMBU3gYOuZ1I1zHNbFs=
X-Google-Smtp-Source: ABdhPJy/S0xkZUvf9TSn7lSiIEUJMHDcs7G0YskbAUaxpQZW5QBFsAoax93TgUAnoX0w0dLOnSHVnA==
X-Received: by 2002:a63:5c4c:: with SMTP id n12mr11568471pgm.288.1620756973013;
        Tue, 11 May 2021 11:16:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:57ce:f5c2:eedd:e35? ([2601:647:4802:9070:57ce:f5c2:eedd:e35])
        by smtp.gmail.com with ESMTPSA id q19sm15729398pfl.171.2021.05.11.11.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 11:16:12 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
 <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1989b8fe-7ef2-2145-75c5-5e938f74014c@grimberg.me>
Date:   Tue, 11 May 2021 11:16:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/21 4:30 AM, Hannes Reinecke wrote:
> On 5/8/21 1:22 AM, Sagi Grimberg wrote:
>>
>>>>> Well, that would require a modification to the CQE specification, no?
>>>>> fmds was not amused when I proposed that :-(
>>>>
>>>> Why would that require a modification to the CQE? it's just using say
>>>> 4 msbits of the command_id to a running sequence...
>>>
>>> I think Hannes was under the impression that the counter proposal wasn't
>>> part of the "command_id". The host can encode whatever it wants in that
>>> value, and the controller just has to return the same value.
>>
>> Yea, maybe something like this?
>> -- 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e6612971f4eb..7af48827ea56 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1006,7 +1006,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
>> struct request *req)
>>                 return BLK_STS_IOERR;
>>         }
>>
>> -       cmd->common.command_id = req->tag;
>> +       cmd->common.command_id = nvme_cid(req);
>>         trace_nvme_setup_cmd(req, cmd);
>>         return ret;
>> }
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 05f31a2c64bb..96abfb0e2ddd 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -158,6 +158,7 @@ enum nvme_quirks {
>> struct nvme_request {
>>         struct nvme_command     *cmd;
>>         union nvme_result       result;
>> +       u8                      genctr;
>>         u8                      retries;
>>         u8                      flags;
>>         u16                     status;
>> @@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
>>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>> };
>>
>> +/*
>> + * nvme command_id is constructed as such:
>> + * | xxxx | xxxxxxxxxxxx |
>> + *   gen    request tag
>> + */
>> +#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
>> +#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
>> +#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
>> +
> 
> That is a good idea, but we should ensure to limit the number of 
> commands a controller can request, too.

We take the minimum between what the host does vs. what the controller
supports anyways.

> As per spec each controller can support a full 32 bit worth of requests, 
> and if we limit that arbitrarily from the stack we'll need to cap the 
> number of requests a controller or fabrics driver can request.

NVMF_MAX_QUEUE_SIZE is already 1024, you are right that we also need:
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 92e03f15c9f6..66a4a7f7c504 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(sgl_threshold,
                 "Use SGLs when average request segment size is larger 
or equal to "
                 "this size. Use 0 to disable SGLs.");

+#define NVME_PCI_MAX_QUEUE_SIZE 4096
  static int io_queue_depth_set(const char *val, const struct 
kernel_param *kp);
  static const struct kernel_param_ops io_queue_depth_ops = {
         .set = io_queue_depth_set,
@@ -68,7 +69,7 @@ static const struct kernel_param_ops 
io_queue_depth_ops = {

  static unsigned int io_queue_depth = 1024;
  module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 
0644);
-MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and 
<= 4096");

  static int io_queue_count_set(const char *val, const struct 
kernel_param *kp)
  {
@@ -164,6 +165,9 @@ static int io_queue_depth_set(const char *val, const 
struct kernel_param *kp)
         if (ret != 0 || n < 2)
                 return -EINVAL;

+       if (n > NVME_PCI_MAX_QUEUE_SIZE)
+               return -EINVAL;
+
         return param_set_uint(val, kp);
  }

--
