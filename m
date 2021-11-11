Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2891544DDCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhKKWUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 17:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhKKWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:20:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A09C061203
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:17:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id o4so6728421pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=881bqaV4hOap+5xQX5kYGENA1lHJDDc/LK2wouh04/k=;
        b=lURGxsyLxjwY2FLfmOdVKa6x+z0tmb8723/Wmnx/91MO5iATSiP3Tda3zVpMZM16Zl
         Od1RUF3Djh+m+0N9Vjl/q+pys4kON8TlcJX/DvZo7Hzj0lLYDx7ErWdc9GpdPAJy+eHy
         KuNB3EIH1AhflR743qsX4lFCk1nTr+ebT0ickIk3lt7eYOnM3jnthChvdJHr/LtalCkl
         h2o2/K67r9djwcJpS1km8ZG0beLzgdDnpyqVQxnRw+aYlyO+Q7DHSuHSft6wtks0n35F
         ZVPX6zZTJFL6HZFgCgroBMf3uxGkQ6q6B77b0FXh5+o6nNIIh66h7SPN/HsvztcKU0KC
         hfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=881bqaV4hOap+5xQX5kYGENA1lHJDDc/LK2wouh04/k=;
        b=namPh4UphJnbYyA0VbrDokVq2cuGovbayWlncTdYRMNGuztZ98a/7BdT/vYhVbtOew
         iR7tW/bRNa/LGbbTxM34lvdk52r7Xqrr8DjEZw5aIInejl0gormv6tTtvYuqeRgmn/3J
         Q0emY6bqJKRJH0ChBxXgibkAFNDxrab6TvmWyJ5M9NlYA3hNR9y4C/enTFpxWRyWzfb8
         0VFMm/VHi+uvyc9seivYmMtfz7kJNGQoThLAbXzAyrtgiVtsWD7a/VKrga8BwN/rwaJg
         BM3W5yL+Tk0h7Ta5Iek6Co215eLMTH+is39uZVqT7m5TlXZNoM2vgOSfxVnu5q8BCJTe
         CQ0g==
X-Gm-Message-State: AOAM5335PDR5f2aDGZU+ETi4XC07wmTgv2Wrn3LccGPAGiijYkYcRmuP
        D5oCqdQyDJe8jthuWJePc6w69Ctmb5j91Q==
X-Google-Smtp-Source: ABdhPJw2vEEg9ikhuL3ArMhJNkVkpLOsXJgqkmWLKQN8kNxJd0fg+jWpb10iW4yKIvsf4MI2BQwA7Q==
X-Received: by 2002:a05:6a00:1310:b0:494:672b:1e97 with SMTP id j16-20020a056a00131000b00494672b1e97mr9795873pfu.77.1636669050416;
        Thu, 11 Nov 2021 14:17:30 -0800 (PST)
Received: from ?IPv6:2600:380:b520:3c36:289a:c960:2525:2be4? ([2600:380:b520:3c36:289a:c960:2525:2be4])
        by smtp.gmail.com with ESMTPSA id mp12sm8996462pjb.39.2021.11.11.14.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 14:17:29 -0800 (PST)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Ming Lei <ming.lei@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <YY0eVnbjmHmPZ3M4@T590>
 <CAMuHMdWTiF3MpcwHc=jCGLoBtTngzXTLHsYSYKPyfLBFBn8B2g@mail.gmail.com>
 <YY01hzAuvmeMxO+0@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <17ce59ff-bc8c-e8c8-22e1-96605440629a@kernel.dk>
Date:   Thu, 11 Nov 2021 15:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YY01hzAuvmeMxO+0@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 8:23 AM, Ming Lei wrote:
> Hi Geert,
> 
> On Thu, Nov 11, 2021 at 03:51:28PM +0100, Geert Uytterhoeven wrote:
>> Hi Ming,
>>
>> On Thu, Nov 11, 2021 at 2:45 PM Ming Lei <ming.lei@redhat.com> wrote:
>>> On Thu, Nov 11, 2021 at 01:58:38PM +0100, Geert Uytterhoeven wrote:
>>>> On Thu, 4 Nov 2021, Jens Axboe wrote:
>>>>> On 11/4/21 1:04 PM, Christoph Hellwig wrote:
>>>>>> On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
>>>>>>> On 11/4/21 12:52 PM, Christoph Hellwig wrote:
>>>>>>>> Looks good:
>>>>>>>>
>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>>>>
>>>>>>> So these two are now:
>>>>>>>
>>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
>>>>>>>
>>>>>>> which is the one I sent here, and then the next one gets cleaned up to
>>>>>>> remove that queue enter helper:
>>>>>>>
>>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
>>>>>>>
>>>>>>> Can I add your reviewed-by to this last one as well? Only change is the
>>>>>>> removal of blk_mq_enter_queue() and the weird construct there, it's just
>>>>>>> bio_queue_enter() now.
>>>>>>
>>>>>> Sure.
>>>>>
>>>>> Thanks, prematurely already done, as you could tell :-)
>>>>
>>>> The updated version is now commit 900e080752025f00 ("block: move queue
>>>> enter logic into blk_mq_submit_bio()") in Linus' tree.
>>>>
>>>> I have bisected failures on m68k/atari (on ARAnyM, using nfhd as the
>>>> root device) to this commit, e.g.:
>>>>
>>>>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>>>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>>>>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>>>>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>>>>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>>>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
>>>>
>>>>     EXT4-fs (sda1): I/O error while writing superblock
>>>>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>>>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>>>>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>>>>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>>>>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>>>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
>>>>     EXT4-fs (sda1): I/O error while writing superblock
>>>>
>>>> This may happen either when mounting the root file system (leading to an
>>>> unable to mount root fs panic), or later (leading to a read-only
>>>> rootfs).
>>>
>>> BTW, today I just found that hang in blk_mq_freeze_queue_wait() is
>>> caused by commit 900e080752025f00, and the following patch can fix it:
>>>
>>> - blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
>>>
>>> https://lore.kernel.org/linux-block/20211111085650.GA476@lst.de/T/#m759b88fda094a65ebf29bc81b780967cdaf9cf28
>>>
>>> Maybe you can try the above patch.
>>
>> Thanks! I have applied both patches, but it doesn't make a difference.
> 
> Thanks for your test!
> 
> Can you try the following patch?
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f511db395c7f..a5ab2f2e9f67 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2517,7 +2517,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	struct blk_mq_alloc_data data = {
>  		.q		= q,
>  		.nr_tags	= 1,
> -		.cmd_flags	= bio->bi_opf,
>  	};
>  	struct request *rq;
>  
> @@ -2525,6 +2524,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  		return NULL;
>  	if (unlikely(!submit_bio_checks(bio)))
>  		goto put_exit;
> +	data.cmd_flags	= bio->bi_opf;
>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
>  		goto put_exit;

That's definitely a real fix, akin to the other pre-enter variants, this
one just post checks. Geert, can you give this a whirl?

Ming, would you mind sending this as a real patch?

-- 
Jens Axboe

