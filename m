Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652E33D9421
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhG1RPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1RPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:15:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA66C061764
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:15:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so3470318wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QAWjI1HeB1hTA5bY9JWN/5jd7hflgLO2RENExto/KKk=;
        b=HwmLn0Ec0akkBwvyuhBw+muIC2adP2/KfYTSr6njRzVp++4INWvhPvYlvXKN9jLDb9
         nuyNbqIQYJIrxdR7pYdOUT+q6oqc//pa4XOv7PyeVkRlhvyQ7/gwbNTT20w4DapVHA+R
         iIZcNh3JrVgmNrntXeYCIdy9l45qF985IMFQzf5C+zuZrc8foTfIplbTW4jWf4DP+qrm
         o0gqi8I80ewBuC5LsC5egjS/OKoT72cTUGPOaPq9JyZ1mcz28KMZb2kHirPuZ7hozqxo
         SciHsLETt4anGEtNk+eNTc0PB67b6cXL+W3Ot65QyOdFDoHq9nw3Tp0ke1bzcjlZqcXI
         bdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAWjI1HeB1hTA5bY9JWN/5jd7hflgLO2RENExto/KKk=;
        b=Og1sxtqwV/9udD9Yehi1+n3Fn4KBRmoepsS2HGgQVcVEL2/4UmRIjnjqenANj/Tk4w
         4dQnBdb1o1BjOtZKl4qhJBOnHB2yqEpr8+gaNAqKHM7FHu06HOxM7+jmYmagwM4FM1+h
         ucli6ddu5NQkCxD+soAgfun+XAVopid0z1F1RnpbrVtfg/eHop89WWxNM9Ptql3K66BQ
         RSyAXKwzPwscQqdVxVLS2c7emwKeuDzOvh1wusGBRIpi5H4udSsxuopDHCBiAyWLKlI0
         gIfk6QeM3PCs/h+WbymSAUJed4J0RY0JG+EwO2n3K9Mn4SGYnqef9nJJDeymBdof86bX
         hmNA==
X-Gm-Message-State: AOAM533L/mWM0yQv2t/O8eL77gcTP9WFe4WOANKhw6FtVdLH/Fsnrpok
        ep0CdJ7A5YyrY9TGXpxwt8A=
X-Google-Smtp-Source: ABdhPJwORhy4xEr3z6KRtI5vPBYgQG6GCnOQ3bw0U0q3iaH/5v5z+EGPn/NhV4xOagBqh+n5OtslVA==
X-Received: by 2002:adf:d1cf:: with SMTP id b15mr455163wrd.382.1627492499598;
        Wed, 28 Jul 2021 10:14:59 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id k186sm7673463wme.45.2021.07.28.10.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 10:14:59 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
 <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
 <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
 <fec30933-46b1-1085-1af1-1fd0d2265981@gmail.com>
 <a3ba73e5-ffd1-887e-acd9-11f537db27e0@acm.org>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <b33a5330-472b-9961-c590-5c07420cf9de@gmail.com>
Date:   Wed, 28 Jul 2021 19:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a3ba73e5-ffd1-887e-acd9-11f537db27e0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

I reviewed and tested the new patch. For me it works fine.

Just one warning to fix:

fs/configfs/file.c: In function ‘fill_write_buffer’:
fs/configfs/file.c:184:6: warning: unused variable ‘to_copy’ 
[-Wunused-variable]
   int to_copy, copied;
       ^~~~~~~

Apart from that you can add my tested-by or reviewed-by if you want.

Thank you,
Bodo



On 27.07.21 18:47, Bart Van Assche wrote:

> Hi Bodo,
> 
> How about replacing patches 1 and 2 from this series with the patch below?
> Do you agree that this patch is sufficient to restore the behavior from
> kernel v5.13 and before?
> 
> Thanks,
> 
> Bart.
> 
> Subject: [PATCH 1/3] configfs: Restore the kernel v5.13 text attribute 
> write behavior
> 
> Instead of writing at the offset specified by the write() system call,
> always write at offset zero.
> 
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Yanko Kaneti <yaneti@declera.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Reported-by: Bodo Stroesser <bostroesser@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   fs/configfs/file.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 5a0be9985bae..8adf6250b207 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -177,12 +177,11 @@ static ssize_t configfs_bin_read_iter(struct kiocb 
> *iocb, struct iov_iter *to)
>       return retval;
>   }
> 
> -/* Fill [buffer, buffer + pos) with data coming from @from. */
> -static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
> +/* Fill @buffer with data coming from @from. */
> +static int fill_write_buffer(struct configfs_buffer *buffer,
>                    struct iov_iter *from)
>   {
> -    loff_t to_copy;
> -    int copied;
> +    int to_copy, copied;
>       u8 *to;
> 
>       if (!buffer->page)
> @@ -190,11 +189,8 @@ static int fill_write_buffer(struct configfs_buffer 
> *buffer, loff_t pos,
>       if (!buffer->page)
>           return -ENOMEM;
> 
> -    to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
> -    if (to_copy <= 0)
> -        return 0;
> -    to = buffer->page + pos;
> -    copied = copy_from_iter(to, to_copy, from);
> +    to = buffer->page;
> +    copied = copy_from_iter(to, SIMPLE_ATTR_SIZE - 1, from);
>       buffer->needs_read_fill = 1;
>       /* if buf is assumed to contain a string, terminate it by \0,
>        * so e.g. sscanf() can scan the string easily */
> @@ -227,14 +223,14 @@ static ssize_t configfs_write_iter(struct kiocb 
> *iocb, struct iov_iter *from)
>   {
>       struct file *file = iocb->ki_filp;
>       struct configfs_buffer *buffer = file->private_data;
> -    ssize_t len;
> +    int len;
> 
>       mutex_lock(&buffer->mutex);
> -    len = fill_write_buffer(buffer, iocb->ki_pos, from);
> +    len = fill_write_buffer(buffer, from);
>       if (len > 0)
>           len = flush_write_buffer(file, buffer, len);
>       if (len > 0)
> -        iocb->ki_pos += len;
> +        iocb->ki_pos = len;
>       mutex_unlock(&buffer->mutex);
>       return len;
>   }
