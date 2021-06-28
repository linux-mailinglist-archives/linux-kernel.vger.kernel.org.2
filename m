Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8053B574E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhF1CsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1CsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:48:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1808EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 19:45:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h4so14137117pgp.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ZglMk5xEV7kqPnzl923s5w51WPieL3sLq9YmzBcALE=;
        b=nUlOpiZdsURZNX3nXwrPK+lpBucURq3MdKAQtTyUnwKnkg7GvNT0HpVWB7Npvqk0lc
         J2yelxl+xiSaTC4As+derq954XeTRGPPldSVUofYHA3gs4bIdr3vQy+EomVFHj2kDaIh
         i01MYeGTLmrGifrVCvEetNzpWtfrEjRTYByTWGhhw9BA5LU3f6BagH91yjHD8+lV35in
         7Q2krdV5Dre6o1fpocAdU1Az4ghMdA3aghNV9uau6s2kR8QO2gaZX+q7px9+SNDp46uJ
         tBGXas+0+fckhDeVeWzEgRzwuDu3msk/F6LzKeSp+1Ct825R41NfphxwazxJCYTSpnHg
         3TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZglMk5xEV7kqPnzl923s5w51WPieL3sLq9YmzBcALE=;
        b=Pcy654KW2zdfCNaSOz/ny76Ea0wd4UVHdx1ziYT+1mOPysF5OdbxmhQpZIf73ZcM//
         HrhcnBzTcT6uHqlddEY1W8539V2RAhE6OeuHTQ2NdrICpENthg7YgSldqPRr+YZrXEsQ
         N8McR30aT3jB/81KgAz1/1EaUQgHW1rN4o0hFjujmUmSNohXgehJiUBSr56LV7Dwrdjz
         J486YOnfQ+Z53H2r8xliYvvNUKQ9H4/YFvzFkFJs0RXielKzvo+VhEDW2mif/K4kW2Nd
         Ox9Fe4cAXAtHTLhJDWOtX4rJ8lExNsONgceUmiKkG6MoMU7EH/YS3bAs/rAwLC+ULSZ9
         lJiA==
X-Gm-Message-State: AOAM530n+cdmFwpdPQpnWDEnD0aD58jSzdPQIEmkb30KseR2OZ53SSsr
        PRHLx3eAMu1aednyPh6ktxY=
X-Google-Smtp-Source: ABdhPJyox2quKoYGLxF1JyW4tUbI8GVPUip1KPU4wHP8CJqx1CNd54QO7ZciKVkiyP1c17eJJ7/BWQ==
X-Received: by 2002:a63:1841:: with SMTP id 1mr11515809pgy.377.1624848355530;
        Sun, 27 Jun 2021 19:45:55 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id n127sm1472443pga.58.2021.06.27.19.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 19:45:54 -0700 (PDT)
Subject: Re: [PATCH] ntfs: Fix validity check for file name attribute
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
References: <20210614050540.289494-1-desmondcheongzx@gmail.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <ea63e5af-6ac4-08fe-4261-904d55392b10@gmail.com>
Date:   Mon, 28 Jun 2021 10:45:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614050540.289494-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/6/21 1:05 pm, Desmond Cheong Zhi Xi wrote:
> When checking the file name attribute, we want to ensure that it fits
> within the bounds of ATTR_RECORD. To do this, we should check
> that (attr record + file name offset + file name length) < (attr
> record + attr record length).
> 
> However, the original check did not include the file name offset in
> the calculation. This means that corrupted on-disk metadata might not
> caught by the incorrect file name check, and lead to an invalid memory
> access.
> 
> An example can be seen in the crash report of a memory corruption
> error found by Syzbot:
> https://syzkaller.appspot.com/bug?id=a1a1e379b225812688566745c3e2f7242bffc246
> 
> Adding the file name offset to the validity check fixes this error and
> passes the Syzbot reproducer test.
> 
> Reported-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
> Tested-by: syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>   fs/ntfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index f5c058b3192c..4474adb393ca 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -477,7 +477,7 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
>   		}
>   		file_name_attr = (FILE_NAME_ATTR*)((u8*)attr +
>   				le16_to_cpu(attr->data.resident.value_offset));
> -		p2 = (u8*)attr + le32_to_cpu(attr->data.resident.value_length);
> +		p2 = (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_length);
>   		if (p2 < (u8*)attr || p2 > p)
>   			goto err_corrupt_attr;
>   		/* This attribute is ok, but is it in the $Extend directory? */
> 

Hi Anton,

Any chance to review this patch?

Best wishes,
Desmond
