Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAA3246E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhBXWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhBXWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:34:01 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:33:21 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id m144so3875983qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+G6Mfwk+58XO0Kv7YBTIXzchf5cSSAWYKhZa1MTn4wI=;
        b=gJxM0NiMNdzZLbhJ04WmIAQqEO3cWXKgESPdlBJ4eNzsw7qPQjO4wU00xk075Uhz8P
         /fyxZT+Q3k7USkIlqqI2jY4mfxKguY3SM+9z2sLYjuicsgKgLfdP1jj3FXCLUQpQNDzp
         hOFEBuYMh8uOJ+8DGac8VuTNs2XPeOb+oq6TcODlL9f6Jg13ijqO8/ajtiC7SqSJb+1F
         2J72I66B7YVZnFLqCEl1rtD5fvPcbiwoFDmgj3IZp4z6I3iDTcqboO/OwaWXSJL2S8tI
         D7Mw4PPkjusZdkzJu3eJzifBJFarD3omUXWS/xzII8jZCJB2KzuQFIoqhh+ELi7KIJ6O
         8T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+G6Mfwk+58XO0Kv7YBTIXzchf5cSSAWYKhZa1MTn4wI=;
        b=KZWmgwZ1vMfNohc1Nn4gFpZGXAWuCpHYixIDTbJ3/QvVeBEaxcnAy9Hx56DbejXide
         9Vc35VS6PXYeDaMKjIP3frl3nyMpLUdNEg/LWOcnFbZnbdkmENRgyUcLhwfzGjJorvYV
         IU8iCqZTkREUcphICVi/ZEl7CYAKwRFmVQC9duGMpAAsyxSAOq4DVy8JhNqfmKPVSI9b
         pHKJ9JPwYV86KkiLmyhK48+ckVkOqjQ++dXCdZJBmwN3xeDdiUa8KelFue7fWfps57+q
         w8Ni2GomHTQyPMHnwuHqQNQLqv/7mVDhTrqPttx87MaVu3qqgDzoqjsP0qIwkOTjKmA3
         cSBQ==
X-Gm-Message-State: AOAM532e8+VkOG8O+dJTOMrcODE07Qhi1OlmTnwH0/0RUPnjDonR1zKH
        Wyb0drdIiJP2cyUQLcG6QJ4pdR9K8+HKMw==
X-Google-Smtp-Source: ABdhPJxop4blgYQ3TmVzEcJLlV2hqoAF0KvSEU8K7/LmcpxgIHoNICCvtm8ULH723Nmf5YXGNxGDVQ==
X-Received: by 2002:a05:620a:131c:: with SMTP id o28mr168349qkj.483.1614206000231;
        Wed, 24 Feb 2021 14:33:20 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id c127sm2645331qkd.87.2021.02.24.14.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 14:33:19 -0800 (PST)
Subject: Re: [PATCH v7 00/11] Regression fixes/clean ups in the Qualcomm
 crypto engine driver
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210211200128.2886388-1-thara.gopinath@linaro.org>
Message-ID: <7fc0db6b-995f-6ede-cc45-9b9e87b768da@linaro.org>
Date:   Wed, 24 Feb 2021 17:33:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211200128.2886388-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 3:01 PM, Thara Gopinath wrote:
> This patch series is a result of running kernel crypto fuzz tests (by
> enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS) on the transformations
> currently supported via the Qualcomm crypto engine on sdm845.  The first
> nine patches are fixes for various regressions found during testing. The
> last two patches are minor clean ups of unused variable and parameters.

Hi Herbert,

This version has all the comments from you and rest of the community 
fixed. Do you think you can merge this ?

> 
> v6->v7:
> 	- Fixed sparse warning in patch 4 as pointed out by Herbert Xu.
> 	  This means the checking if any two keys are same for triple
> 	  des algorithms has been reverted back to using conditional OR
> 	  instead of using bitwise OR.
> 	- Rebased to 5.11-rc7.
> 
> v5->v6:
> 	- Return 0 for zero length messages instead of -EOPNOTSUPP in the
> 	  cipher algorithms as pointed out by Eric Biggers.
> 	- Remove the wrong TODO in patch 6 which implied that AES CBC can
> 	  do partial block sizes when it is actually CTS mode that can as
> 	  pointed out my Eric Biggers.
> 
> v4->v5:
> 	- Fixed build warning/error in patch for wrong assignment of const
> 	  pointer as reported by kernel test robot <lkp@intel.com>.
> 	- Rebased to 5.11-rc6.
> v3->v4:
> 	- Fixed the bug where only two bytes of byte_count were getting
> 	  saved and restored instead of all eight bytes. Thanks Bjorn for
> 	  catching this.
> 	- Split patch 3 "Fix regressions found during fuzz testing" into
> 	  6 patches as requested by Bjorn.
> 	- Dropped crypto from all subject headers.
> 	- Rebased to 5.11-rc5
> v2->v3:
>          - Made the comparison between keys to check if any two keys are
>            same for triple des algorithms constant-time as per
>            Nym Seddon's suggestion.
>          - Rebased to 5.11-rc4.
> v1->v2:
>          - Introduced custom struct qce_sha_saved_state to store and restore
>            partial sha transformation.
>          - Rebased to 5.11-rc3.
> 
> Thara Gopinath (11):
>    crypto: qce: sha: Restore/save ahash state with custom struct in
>      export/import
>    crypto: qce: sha: Hold back a block of data to be transferred as part
>      of final
>    crypto: qce: skcipher: Return unsupported if key1 and key 2 are same
>      for AES XTS algorithm
>    crypto: qce: skcipher: Return unsupported if any three keys are same
>      for DES3 algorithms
>    crypto: qce: skcipher: Return error for zero length messages
>    crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC
>      algorithms)
>    crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
> *** BLURB HERE ***
> 
> Thara Gopinath (11):
>    crypto: qce: sha: Restore/save ahash state with custom struct in
>      export/import
>    crypto: qce: sha: Hold back a block of data to be transferred as part
>      of final
>    crypto: qce: skcipher: Return unsupported if key1 and key 2 are same
>      for AES XTS algorithm
>    crypto: qce: skcipher: Return unsupported if any three keys are same
>      for DES3 algorithms
>    crypto: qce: skcipher: Return error for zero length messages
>    crypto: qce: skcipher: Return error for non-blocksize data(ECB/CBC
>      algorithms)
>    crypto: qce: skcipher: Set ivsize to 0 for ecb(aes)
>    crypto: qce: skcipher: Improve the conditions for requesting AES
>      fallback cipher
>    crypto: qce: common: Set data unit size to message length for AES XTS
>      transformation
>    crypto: qce: Remover src_tbl from qce_cipher_reqctx
>    crypto: qce: Remove totallen and offset in qce_start
> 
>   drivers/crypto/qce/cipher.h   |   1 -
>   drivers/crypto/qce/common.c   |  25 +++---
>   drivers/crypto/qce/common.h   |   3 +-
>   drivers/crypto/qce/sha.c      | 143 +++++++++++++---------------------
>   drivers/crypto/qce/skcipher.c |  69 +++++++++++++---
>   5 files changed, 126 insertions(+), 115 deletions(-)
> 

-- 
Warm Regards
Thara
