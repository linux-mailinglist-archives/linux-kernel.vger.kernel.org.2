Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71383EFF37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhHRIfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhHRIfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:35:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321AC0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:34:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so1507177pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZp/mhDkH4ig1ld6XLX33/9sqE9sEjBNvxVZC8FkvXA=;
        b=qSulCpTew7c3zfmlIgOJ7vgVUTMIITlwihKDUEFmvYXA8qfonm85VNj3jOXeLZGWzI
         CUhVmdlunApiovitqV8qQ/ZpQ9e9yyxs4V26XvkPX+LS75mnA1ujSMmj7cSf7c93OETb
         GbrcxiwuGsG6uGCsul/WwzLVZX1rxdUPO17Cxyz+jQvBj6jgyHZI26wPa7HZWJN9fIiG
         j6PzExDVHc4mbyS+1nB1H7kg2l0/8rW2OpYTCJ4Im6prsDIch7WTJz5z8o+yJ5EUzLU5
         xCRRoxjWA19DxuO25vDGV4YFlkGFOad/6jEAp/LlOsnM5QPzToSqRMBB+ploRNzbRf0a
         fXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZp/mhDkH4ig1ld6XLX33/9sqE9sEjBNvxVZC8FkvXA=;
        b=kCtDnTokaEds+wknaQ5SSo3cItyDC8NmfjyKUQlj1JvdPiyNH1d0/LXF7Zi3ExdV0Y
         YhFoYtQ4bJmXbb6XWcDgN+WbXtOm7NzzzPL09PrgbyeyXpVLTl4+MEhymR/pGs8lXHbx
         kXx1fLqDoy0E25zs+TJ8yR8U6khgYhFkxdavzH8uO8quKR0EaEx9L8ngVek3Hu2QR5lP
         hq+u0Fk9T/HQMcPxLRONJBMvLs1J/c1SPVhuh4XC+wT131vmVn+vBtQjDTjLpRqqqlHz
         Mzk18krmdrmoJ5qFuXnmaBIQg5lkQe2Y/sDfsWDZUH6u4jntxkWcCMpaF07RvJUXXlmn
         ad9g==
X-Gm-Message-State: AOAM530LLGWKaHz1HvKjhhWU+vDEMF/+gT98O8Vox/rxpplj2w/Gdrab
        hpYWTBkJ6PChbZyTVs2ROOT9L19IH2UphQ==
X-Google-Smtp-Source: ABdhPJzmK5OA5pl1B6yGn90CYWy1+VFcm6lNS0F46W7wZ6uk6zzHyv3HAEWvl1Cjsg/oTKYsP7E0UA==
X-Received: by 2002:a63:4f54:: with SMTP id p20mr7807415pgl.437.1629275680603;
        Wed, 18 Aug 2021 01:34:40 -0700 (PDT)
Received: from [10.2.24.177] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id c12sm4931671pfl.56.2021.08.18.01.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:34:40 -0700 (PDT)
Subject: PING: [PATCH] crypto: public_key: fix overflow during implicit
 conversion
To:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210810063954.628244-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <4dcd4254-030b-4489-d5d3-e320eb2953e7@bytedance.com>
Date:   Wed, 18 Aug 2021 16:33:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810063954.628244-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


PING

On 8/10/21 2:39 PM, zhenwei pi wrote:
> Hit kernel warning like this, it can be reproduced by verifying 256
> bytes datafile by keyctl command.
> 
>   WARNING: CPU: 5 PID: 344556 at crypto/rsa-pkcs1pad.c:540 pkcs1pad_verify+0x160/0x190
>   ...
>   Call Trace:
>    public_key_verify_signature+0x282/0x380
>    ? software_key_query+0x12d/0x180
>    ? keyctl_pkey_params_get+0xd6/0x130
>    asymmetric_key_verify_signature+0x66/0x80
>    keyctl_pkey_verify+0xa5/0x100
>    do_syscall_64+0x35/0xb0
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> '.digest_size(u8) = params->in_len(u32)' leads overflow of an u8 value,
> so use u32 instead of u8 of digest. And reorder struct
> public_key_signature, it could save 8 bytes on a 64 bit machine.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   include/crypto/public_key.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 47accec68cb0..f603325c0c30 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -38,9 +38,9 @@ extern void public_key_free(struct public_key *key);
>   struct public_key_signature {
>   	struct asymmetric_key_id *auth_ids[2];
>   	u8 *s;			/* Signature */
> -	u32 s_size;		/* Number of bytes in signature */
>   	u8 *digest;
> -	u8 digest_size;		/* Number of bytes in digest */
> +	u32 s_size;		/* Number of bytes in signature */
> +	u32 digest_size;	/* Number of bytes in digest */
>   	const char *pkey_algo;
>   	const char *hash_algo;
>   	const char *encoding;
> 

-- 
zhenwei pi
