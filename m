Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B800C3D5C84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhGZOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhGZORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:17:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACCC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:58:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p21so3852479edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVRmnCNemDnRF1RrY19aW7vNdbKNVzkQ+CowTKMYvak=;
        b=oKTrrgApsirRIkgHow1Cjvb77bMPZtBn7qc6hyWL2MRKO8deFapR4CIt+zdP33Apkk
         ialxwaVLs8mbUutd+0/1ipOpPtpzCtCOnkw7FV2GxgWOZ5tujPLw2yWsptCn/knYBmaM
         64NY+pypA6DmhXNlXiEgDZqQuB8xiFc5p9Hn5RAFeKQ/IT8B0iRuxY6lj9oxtzEGdzqT
         4GL/CGtAT4BilMuqqErBKOMbkZjd6WiqWbMPByHkrlqTtrmqvB/mWyTb0rdmFkw1QEiO
         3YGdWTLuOBXB5w/wCv/qkmERRxX+QhpPtoEUeEPMJ2n+mbsyizZNLf5p0bsLGwLSVjdS
         k0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVRmnCNemDnRF1RrY19aW7vNdbKNVzkQ+CowTKMYvak=;
        b=Z8uCBTOQ2Wt46eMPQFZBoTUYKAngkBz2sWZNQhLMFo4AJ2kcc8KRnxgldeDXjlLpds
         PINgMokJfH06qGy5LB8FWY9ETTRFXppauWWIOpb+C+FSA+y6NXqfoTBkkJlzCar/WjBr
         sX+9JZUAD8xSY3iC2C8AaZ0diplyjkBKR8/qYSTCd0PcqG2VyALCSuwmKHVuzwHfE3AT
         9LjFlnAv3VEhR8THV7+8bDuyIlpBH70x5WR1v29Bq/Kv602ZTakYvYLgdQ1rPKmwKQFH
         oFXPLHZHQY01uvlG4aPw34L26jLxhPLlIL+AQ+A1YdyAqjnUxR5Kt3vARVYsVLWFIEsU
         KVIw==
X-Gm-Message-State: AOAM532ojCq8iXGV5z0JXT9AowxOZelHiBenHjCFaKo4dq6pdhurMyxU
        D4tI893r6MAri1aDwPVCRLs=
X-Google-Smtp-Source: ABdhPJzCooMzOWLH88Dcof/w2xK6rcE22CWVS5/BgxTn+N5GRZhmN2GW8j2EXUktE+I8M9kRl5uUuw==
X-Received: by 2002:a05:6402:3481:: with SMTP id v1mr3064621edc.60.1627311494866;
        Mon, 26 Jul 2021 07:58:14 -0700 (PDT)
Received: from [192.168.178.40] (ipbcc187b7.dynamic.kabel-deutschland.de. [188.193.135.183])
        by smtp.gmail.com with ESMTPSA id d22sm14737031ejj.47.2021.07.26.07.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:58:14 -0700 (PDT)
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
From:   Bodo Stroesser <bostroesser@gmail.com>
Message-ID: <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
Date:   Mon, 26 Jul 2021 16:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723212353.896343-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.21 23:23, Bart Van Assche wrote:
> Store data at the right offset when writing with a non-zero offset. I think
> this patch fixes behavior introduced in the initial configfs commit.

Unfortunately I think it does not.

Let's say user writes 5 times to configfs file while keeping it open.
On every write() call it writes 1 character only, e.g. first "A", then "B", ...

The original code before the changes 5 times called flush_write_buffer for the
strings "A\0", "B\0", ... (with the '\0' not included in the count parameter,
so count is 1 always, which is the length of the last write).

Since commit
     420405ecde06  "configfs: fix the read and write iterators"
flush_write_buffer is called for the strings "A\0", "AB\0", "ABC\0", ...
but count still is 1.

This fix changes just the count parameter, so it now is 1, 2, 3, ... in our
example. But it still sends on every call to flush_write_buffer all the write
data gathered since last open().

I think, a simple way to restore the original behavior would be to revert the
part of commit 420405ecde06 that changed write routines.

Bodo

 From a
> source code comment in the initial configfs commit: "There is no easy way
> for us to know if userspace is only doing a partial write, so we don't
> support them."
> 
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Yanko Kaneti <yaneti@declera.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   fs/configfs/file.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 8121bb1b2121..3b2ddc2e5d42 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -226,14 +226,16 @@ static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   {
>   	struct file *file = iocb->ki_filp;
>   	struct configfs_buffer *buffer = file->private_data;
> -	ssize_t len;
> +	int len, written = 0;
>   
>   	mutex_lock(&buffer->mutex);
>   	len = fill_write_buffer(buffer, iocb->ki_pos, from);
>   	if (len > 0)
> -		len = flush_write_buffer(file, buffer, len);
> -	if (len > 0)
> -		iocb->ki_pos += len;
> +		written = flush_write_buffer(file, buffer, iocb->ki_pos + len);
> +	if (written > 0) {
> +		len = max_t(int, 0, written - iocb->ki_pos);
> +		iocb->ki_pos = written;
> +	}
>   	mutex_unlock(&buffer->mutex);
>   	return len;
>   }
> 
