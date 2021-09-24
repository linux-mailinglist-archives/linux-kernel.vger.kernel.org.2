Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13941793A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbhIXRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245679AbhIXRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:08:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7737C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:06:31 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q205so13534993iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=buBo8TkuaLnLPT4SKYQyAEPp/d82uwvxJ08uqCLKYxs=;
        b=VusRO3SQ3l/meRDKcOPMceqMsV9IFMcMIgUGCD6OI/F1KAUqvKh6tsPwyxSsQdFcEl
         G6eA4zfuYr3ex6+u983e/s7JJJq1Qi681HLd6sRFTf+Ncf6/nq/ZrCY7eIt//4KKBFH4
         VnwKYryuAsUXkBaWTzh1i67/NKDtMZjp2TYSx/h3qaCDfZXIecwyoGAOC1eK/+J4cbMV
         I+L8eU2KD0otVtyt197ZECiZWT1N4hC72AhmSA/NGxCr/8/BZQcInIfbeLIcilTgye1Q
         ohPeIPpxqYdw8+sJ5prZ8m6YPGFX5rIItWjgeXZAnIlU6ozx2zxe+96E9pEpwlgEI1mW
         aTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=buBo8TkuaLnLPT4SKYQyAEPp/d82uwvxJ08uqCLKYxs=;
        b=inZk3LRYKWqSyWAPb8bp3f8OPUBrH5OOazW3JNld5OM4Ws0A/FWwJXRdBUHQ2T3zxW
         vd41VcVdA788d3eXYNufkBzGD08tk6QwxcM8rYy6QLP5/Wj/EHZj1iLY29tpCT7pvC2S
         e22ILdMyvIgkRCqwajGX9Up/rVmbi3tkCcz9qf1aWcZhxeSFHXgiA15+ARrjwDcz3b+R
         ykuATKKUJvQFzaXZDYsyh/+mvwmDok9zuahHTC0+gt4u26EiAQRIEDfB18ji4TinuRKq
         aNcSr3Fe5xOZWCnrwH7RzXQGi/fDIe8jwBOgwqULpSDgwWnIwsNDbuVvueUQQyFlmivc
         tsTQ==
X-Gm-Message-State: AOAM532Hdm8l+lBge8mzotm0lPZIBNq98gt3GVvTZntVHx1EbcwvcqE6
        u24oJX7/nh1MWdv9zyzFOw8zigM86SUQR/gAbG4=
X-Google-Smtp-Source: ABdhPJwQkM2Qt7xUqyEbgcEHGyfAfH/e+2mZ3jPF4JYiKqa6jd24jcP/mHcej8E9D9QtxggAshmmGA==
X-Received: by 2002:a02:1049:: with SMTP id 70mr10341263jay.123.1632503190795;
        Fri, 24 Sep 2021 10:06:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h11sm4544943ilc.7.2021.09.24.10.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:06:30 -0700 (PDT)
Subject: Re: [PATCH v2] blktrace: Fix uaf in blk_trace access after removing
 by sysfs
To:     Zhihao Cheng <chengzhihao1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, acme@redhat.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210923134921.109194-1-chengzhihao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed409047-4745-7c0d-430d-0cd87447fc23@kernel.dk>
Date:   Fri, 24 Sep 2021 11:06:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210923134921.109194-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 7:49 AM, Zhihao Cheng wrote:
> There is an use-after-free problem triggered by following process:
> 
>       P1(sda)				P2(sdb)
> 			echo 0 > /sys/block/sdb/trace/enable
> 			  blk_trace_remove_queue
> 			    synchronize_rcu
> 			    blk_trace_free
> 			      relay_close
> rcu_read_lock
> __blk_add_trace
>   trace_note_tsk
>   (Iterate running_trace_list)
> 			        relay_close_buf
> 				  relay_destroy_buf
> 				    kfree(buf)
>     trace_note(sdb's bt)
>       relay_reserve
>         buf->offset <- nullptr deference (use-after-free) !!!
> rcu_read_unlock
> 
> [  502.714379] BUG: kernel NULL pointer dereference, address:
> 0000000000000010
> [  502.715260] #PF: supervisor read access in kernel mode
> [  502.715903] #PF: error_code(0x0000) - not-present page
> [  502.716546] PGD 103984067 P4D 103984067 PUD 17592b067 PMD 0
> [  502.717252] Oops: 0000 [#1] SMP
> [  502.720308] RIP: 0010:trace_note.isra.0+0x86/0x360
> [  502.732872] Call Trace:
> [  502.733193]  __blk_add_trace.cold+0x137/0x1a3
> [  502.733734]  blk_add_trace_rq+0x7b/0xd0
> [  502.734207]  blk_add_trace_rq_issue+0x54/0xa0
> [  502.734755]  blk_mq_start_request+0xde/0x1b0
> [  502.735287]  scsi_queue_rq+0x528/0x1140
> ...
> [  502.742704]  sg_new_write.isra.0+0x16e/0x3e0
> [  502.747501]  sg_ioctl+0x466/0x1100
> 
> Reproduce method:
>   ioctl(/dev/sda, BLKTRACESETUP, blk_user_trace_setup[buf_size=127])
>   ioctl(/dev/sda, BLKTRACESTART)
>   ioctl(/dev/sdb, BLKTRACESETUP, blk_user_trace_setup[buf_size=127])
>   ioctl(/dev/sdb, BLKTRACESTART)
> 
>   echo 0 > /sys/block/sdb/trace/enable &
>   // Add delay(mdelay/msleep) before kernel enters blk_trace_free()
> 
>   ioctl$SG_IO(/dev/sda, SG_IO, ...)
>   // Enters trace_note_tsk() after blk_trace_free() returned
>   // Use mdelay in rcu region rather than msleep(which may schedule out)
> 
> Remove blk_trace from running_list before calling blk_trace_free() by
> sysfs if blk_trace is at Blktrace_running state.

Applied, thanks.

-- 
Jens Axboe

