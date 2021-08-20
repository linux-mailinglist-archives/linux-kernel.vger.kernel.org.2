Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0963F2F76
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhHTP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbhHTP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:28:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCBAC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:27:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so9485084pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xWUYFVShPfBnoUhetkkSmNUWocaFeL6/9s7+z7WErjc=;
        b=bghtBO7IJBFQP2SOMr7k6cKho3fdH1dZ1vC3B+ySOux1h8a172sFF7xofaaPaGrMoe
         r4giNUdyDZzTMdQ2KvnFfh5Vcp/3NwGyT6rargw2sfQkQ15wVdWeBTRJvafCPilot86o
         obXDCh2+74jQ2GCmL+6BDAQzGksxjgc5wDe3OS/lXHDBFoO17TyoED/dNVItoTUC6nM1
         tDC42Y3mJGa+B6CJ6PaEkb4AZJDKadBLrI+WvRV70AhnUdfqhwqvfcU6m1x4ddycBaeW
         zIeO0NZqzNEVV0LIzuxDFPg4NdpKLHx+vma77rBiJ4R7ECo8zyt2v79R4sHIkbTl99Kd
         DRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xWUYFVShPfBnoUhetkkSmNUWocaFeL6/9s7+z7WErjc=;
        b=fF+WQf+DNEkXOmh8+gzjz64C/EehPVKn9amIeJnBLV8ZB3at3iF6f0a3P+pMjQXiR6
         Ec6Bx0fauYpndcfr+cD2quYlIdXL7jw2IaikO4+vIUcwB3wNqMRcnFsNOsol35aw79Ki
         fiK+GwRqIkSNzyu+ZR1C57D5VnU2AGvBQn5flHPwcVz3Aj2CMo3XQpZAGysRDI0zTaT4
         oVrQkEORQjpmHA5Q4JZ4PrVCn5/nW/OZJhl2Q/j/O61NCKdSvC5nwr9I7NyF0UjUARX6
         6rC3AMZUem/hfTNWgu7iPqPvNzXibVfO+XOdy4EzSBDnIYCkj005DKyCDMQOpLoomWcW
         6feQ==
X-Gm-Message-State: AOAM532tkN/jTyuw9shuIN8K8+h53GuZn0m2s2SdeyMKHG1Nh4dFWb3w
        /Gib/bOKXLT2NPg6bWbKaj4=
X-Google-Smtp-Source: ABdhPJxysHeQTtCzXK0dNQgiidOi1ZOG5MX3uXaDcnuxN7BT2yxhF8TCrIcihHJZvUkwVkb0KPSeAw==
X-Received: by 2002:a17:90b:d94:: with SMTP id bg20mr5105902pjb.61.1629473269873;
        Fri, 20 Aug 2021 08:27:49 -0700 (PDT)
Received: from [192.168.1.40] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id o10sm7984608pgp.68.2021.08.20.08.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:27:49 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210820084832.nlsbiztn26fv3b73@carbon.lan>
 <20210820115521.alveifzvad3zuwh4@carbon.lan>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <73a430da-84c8-5457-108a-7e1e2d81fa61@gmail.com>
Date:   Fri, 20 Aug 2021 08:27:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820115521.alveifzvad3zuwh4@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/2021 4:55 AM, Daniel Wagner wrote:
> On Fri, Aug 20, 2021 at 10:48:32AM +0200, Daniel Wagner wrote:
>> Then we try to do the same thing again which fails, thus we never
>> make progress.
>>
>> So clearly we need to update number of queues at one point. What would
>> be the right thing to do here? As I understood we need to be careful
>> with frozen requests. Can we abort them (is this even possible in this
>> state?) and requeue them before we update the queue numbers?
> 
> After starring a bit longer at the reset path, I think there is no
> pending request in any queue. nvme_fc_delete_association() calls
> __nvme_fc_abort_outstanding_ios() which makes sure all queues are
> drained (usage counter is 0). Also it clears the NVME_FC_Q_LIVE bit,
> which prevents further request added to queues.

yes, as long as we haven't attempted to create the io queues via 
nvme_fc_connect_io_queues(), nothing should be successful queueing and 
running down the hctx to start the io. nvme_fc_connect_io_queues() will 
use the queue for the Connect cmd, which is probably what generated the 
prior -16389 error.

Which says:"nvme-fc: Update hardware queues before using them" should be 
good to use.

> 
> I start wonder why we have to do the nvme_start_freeze() in the first
> place and why we want to wait for the freeze. 88e837ed0f1f ("nvme-fc:
> wait for queues to freeze before calling update_hr_hw_queues") doesn't
> really tell why we need wait for the freeze.

I think that is probably going to be true as well - no need to 
freeze/unfreeze around this path.  This was also a rather late add (last 
oct), so we had been running without the freezes for a long time, 
granted few devices change their queue counts.

I'll have to see if I can find what prompted the change. At first blush, 
I'm fine reverting it.

> 
> Given we know the usage counter of the queues is 0, I think we are
> safe to move the blk_mq_update_nr_hw_queues() before the start queue
> code. Also note nvme_fc_create_hw_io_queues() calls
> blk_mq_freeze_queue() but it wont block as we are sure there is no
> pending request.

Agree.

-- james

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

