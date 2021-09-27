Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E729E4193E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhI0MO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhI0MOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:14:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A20C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:12:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so76578010lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=H6EL1rHo2uoK5fFTFUzy/VMgXzQT2h8SY0Z7WSLLQvM=;
        b=lTM+PSwfTRdVQQDFiLo5O3KwSQ7scG35jAAF09V7BQN5haoLyl/fqb68x3BLEYABcJ
         X6L1iUeX2ZK5ysQ2y8AqU3q0ZCPqwfSH3fChGj4KxI0cz1VrqGauVWEHLoG4hpfNk9SX
         OXKBnQWQhh+z8rqi2412JhbbUq2iJwRGnUFcDO34ZSI7Vmg3gMKoMD+TPXsQTqvgBW8x
         x5uCE50ImUYPQDneHVvxtVpnLmScYBNIyY39dOoOv2SUVuAFCxpnCGPvNASC7+5hVu1q
         Wp/NiiBBCl+kPeTbsrWCkvWjZNNl7IjbfkQx2h99gViRBqVnfBeLD2i5u5iX0jaQD5o8
         1V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=H6EL1rHo2uoK5fFTFUzy/VMgXzQT2h8SY0Z7WSLLQvM=;
        b=yxcB0F56MFozzj3Mnx2VklR8SWnwS0wVe1tg5TA4JRyVK1C2wfLx92mFUSUDxNmVvE
         z6putSJ5aQKMP16ddDOFhx2ME1bayJAhswbL8xF4Q/XNfgm0lleMrbbkKjLcZAlqQMSx
         ldzechlkOcPFJINJ7q7I2smP/BUzw0dcbJx53oVz0Otec/YCuYVdr0GpfnHsuc231uPe
         MDvaUMiGxkMMM2r7+J/0a+dittcL8US4Pcvt++6kLskgvS9xJ8FFhD+RBYJTDfTnezIe
         3tGF7ejrPIlr+4cgp/qVK/2wiOPTShryFFtE/dOcRdpK+wGCtGsfMtrWl7yyL70OYKqx
         vgrQ==
X-Gm-Message-State: AOAM533qb481fGC+nix8Xa2JBgI//VD/nla8K4KMKmmcac7lUXRO85pN
        QmPO/oucqqn2jpgf6qm2Cp0=
X-Google-Smtp-Source: ABdhPJz6sKozOssEmR0+7u3kxMxWyrRNRHHdZwPzx9dQs3Et5dB3foz85ZPTQfCikYSazlROQL9F2g==
X-Received: by 2002:a05:6512:144:: with SMTP id m4mr23387338lfo.64.1632744763856;
        Mon, 27 Sep 2021 05:12:43 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.149])
        by smtp.gmail.com with ESMTPSA id h9sm1920662ljj.103.2021.09.27.05.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:12:43 -0700 (PDT)
Message-ID: <787abb01-f8c0-6ddf-baee-90b8e558914a@gmail.com>
Date:   Mon, 27 Sep 2021 15:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] sysv: use BUILD_BUG_ON instead of runtime check
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org
References: <20210813123020.22971-1-paskripkin@gmail.com>
 <dc7771f0-e4db-ee5c-a66d-b5db5f26a59d@gmail.com>
In-Reply-To: <dc7771f0-e4db-ee5c-a66d-b5db5f26a59d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 13:15, Pavel Skripkin wrote:
> On 8/13/21 15:30, Pavel Skripkin wrote:
>> There was runtime checks about sizes of struct v7_super_block
>> and struct sysv_inode. If one of these checks fail kernel will panic.
>> Since these values are known on complite time let's use BUILD_BUG_ON(),
>> because it's standard mechanism for validation checking at build time
>> 
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>> ---
>>   fs/sysv/super.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/sysv/super.c b/fs/sysv/super.c
>> index cc8e2ed155c8..d1def0771a40 100644
>> --- a/fs/sysv/super.c
>> +++ b/fs/sysv/super.c
>> @@ -474,10 +474,8 @@ static int v7_fill_super(struct super_block *sb, void *data, int silent)
>>   	struct sysv_sb_info *sbi;
>>   	struct buffer_head *bh;
>>   
>> -	if (440 != sizeof (struct v7_super_block))
>> -		panic("V7 FS: bad super-block size");
>> -	if (64 != sizeof (struct sysv_inode))
>> -		panic("sysv fs: bad i-node size");
>> +	BUILD_BUG_ON(sizeof(struct v7_super_block) != 440);
>> +	BUILD_BUG_ON(sizeof(struct sysv_inode) != 64);
>>   
>>   	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
>>   	if (!sbi)
>> 
> 
> Hi, David and Alexander!
> 
> 
> Maybe, this one can go through one of your trees? I didn't find any sysv
> related trees, so..
> 
> Lore link to the patch:
> https://lore.kernel.org/lkml/20210813123020.22971-1-paskripkin@gmail.com/
> 
> 
> 
> Thank you!


Hi, Andrew,

Maybe this one can go through your tree?



With regards,
Pavel Skripkin
