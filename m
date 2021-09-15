Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7F40CC62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhIOSNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhIOSNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:13:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA78C061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:12:19 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a22so4602420iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qmtfPSicZt4+W2xOw2eszJcd4ZX5j/8yAZIvINEaqeI=;
        b=FQoBMAFPRgxPefJNqhuYC1ycRXDOTjCVKeT+UiN4mRGYXHlPaPNCeAQAQr6ipL+ANA
         V8w2xDHKUi9HrakNPg2Bw9lDPKEAdwx5XED0kW8hur+XT7xD1YVIf5U/cWr8wQtjidvN
         wh/pLqEkXmljXk9SJLHQjp662qj+KXrUMFqlXfyJfi7dcNodAaE6Z/jm5B+xvLKL0zjF
         B2nj7day+w03GiIMfWwWXLeiBDHNQxXJPz2g4efYV3ILXzmcS0CkH+BK2NancUITIhGx
         HGz4JOg3rJ0LWP37/5c1YH5uwQO6PhXNDoaVT2QOWBJZHj5SgI9BtuJuyEa27w6A8to1
         ngRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qmtfPSicZt4+W2xOw2eszJcd4ZX5j/8yAZIvINEaqeI=;
        b=QgJNMK1bWIX+vj4+G+EGVAgZujHMf7RueNz8krvP4fY8XZGkiX+25iOPvDMUhwMvc3
         Eczx7ONch9w54zU0WamQ01kgsnFXkJ5AWHd9pjpjZc7TUOZqM0hizm7ncpVVXM1XkwLs
         WNFyof9a81BOzOnw1YwNMcVDBnQQeU6wVpbIslwgUmm8n8a21iRoHqwA4w2SYYlEeI+6
         1H/A4yU+szvHOYEYyYjGxwg+rQQL48TGY2Q8EXxXtYugGjQCQjhLJ/nrqxkYANXhTHRF
         f5ILPrGYZFkcUDPrqQ3tW/W6zCeZnQtY1Z43x5QGJ72iXzFjpPSXB9XwXuCKwELsiOGw
         ovqg==
X-Gm-Message-State: AOAM53356EKLmRdjMFWuS8+3zBFtu+0+E36jcpYOV60baGbta43tw2eG
        W5V6eziiyRDMDAWAL/M9i+HJ2A==
X-Google-Smtp-Source: ABdhPJwQLuFHVEAc/C8enU+7Z2DY367nDmN1D1cBfRP90xSgmKTKUVhS3Uzr+T6ofKInOsfOLEXUsA==
X-Received: by 2002:a5d:9488:: with SMTP id v8mr1090849ioj.195.1631729538420;
        Wed, 15 Sep 2021 11:12:18 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r16sm348008ile.66.2021.09.15.11.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:12:17 -0700 (PDT)
Subject: Re: [PATCH -next] io-wq: Remove duplicate code in
 io_workqueue_create()
To:     Hao Xu <haoxu@linux.alibaba.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210911085847.34849-1-cuibixuan@huawei.com>
 <49d9bb13-a7b3-48b5-20ef-d3b72052f92b@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba41595d-d7a7-4641-3c4c-26ddfe01eaed@kernel.dk>
Date:   Wed, 15 Sep 2021 12:12:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <49d9bb13-a7b3-48b5-20ef-d3b72052f92b@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/21 9:36 AM, Hao Xu wrote:
> 在 2021/9/11 下午4:58, Bixuan Cui 写道:
>> While task_work_add() in io_workqueue_create() is true,
>> then duplicate code is executed:
>>
>>    -> clear_bit_unlock(0, &worker->create_state);
>>    -> io_worker_release(worker);
>>    -> atomic_dec(&acct->nr_running);
>>    -> io_worker_ref_put(wq);
>>    -> return false;
>>
>>    -> clear_bit_unlock(0, &worker->create_state); // back to io_workqueue_create()
>>    -> io_worker_release(worker);
>>    -> kfree(worker);
>>
>> The io_worker_release() and clear_bit_unlock() are executed twice.
>>
>> Fixes: 3146cba99aa2 ("io-wq: make worker creation resilient against signals")
>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>> ---
>>   fs/io-wq.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/io-wq.c b/fs/io-wq.c
>> index 6c55362c1f99..95d0eaed7c00 100644
>> --- a/fs/io-wq.c
>> +++ b/fs/io-wq.c
>> @@ -329,8 +329,10 @@ static bool io_queue_worker_create(struct io_worker *worker,
>>   
>>   	init_task_work(&worker->create_work, func);
>>   	worker->create_index = acct->index;
>> -	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL))
>> +	if (!task_work_add(wq->task, &worker->create_work, TWA_SIGNAL)) {
>> +		clear_bit_unlock(0, &worker->create_state);
>>   		return true;
>> +	}
>>   	clear_bit_unlock(0, &worker->create_state);
>>   fail_release:
>>   	io_worker_release(worker);
>> @@ -723,11 +725,8 @@ static void io_workqueue_create(struct work_struct *work)
>>   	struct io_worker *worker = container_of(work, struct io_worker, work);
>>   	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
>>   
>> -	if (!io_queue_worker_create(worker, acct, create_worker_cont)) {
>> -		clear_bit_unlock(0, &worker->create_state);
>> -		io_worker_release(worker);
>> +	if (!io_queue_worker_create(worker, acct, create_worker_cont))
>>   		kfree(worker);
>> -	}
>>   }
>>   
>>   static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
>>
> AFAIK, this looks reasonable for me.

I took that as a reviewed-by, let me know if that isn't correct.

-- 
Jens Axboe

