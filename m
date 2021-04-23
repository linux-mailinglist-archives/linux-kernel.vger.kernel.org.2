Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3F369482
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhDWOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDWOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:21:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:20:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b17so35297699pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xghm4OXD8c/QLiiGnWTz+eX5J3vFTUT6uMEKutl3hs=;
        b=Ye8U9iMLDZV2fucp4kn601q9lppSMINsKKEwNooGz2vucLufcoXK8aUsogzRVUgJDl
         1wpCqbgv7vVSbSHFIRBB7yaRQqkjHNdTbmDF+YsvcDgsLEGPMYqe29Q9xKfRXWiXHYKu
         hUoepEi6yOUboJXa5YvAg2Mlt2dCBPMcG7htg4j8XX6IY3LjBJDRbR12Reo1tJhD9z46
         yHCja3hOrPFDlZcPnjlhwIeZNgS+V1nWxKNUiAFFIXcdb2Ncm2xaMA4pbXfTrkhevWn/
         F7emJZQMK/ixiunFM+cLOQjrxFR3rl/0p27ZfwTquWYCBfheKvdFk4sRkC2rxbFt1nFN
         ru0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xghm4OXD8c/QLiiGnWTz+eX5J3vFTUT6uMEKutl3hs=;
        b=Lyag4OBGouKIHR4a1rWbw/aBuDVxiD0+XpE8F7M5jcHQzQp0kMwK5ri8hHzdiBWkzT
         IY3vJtl/6E5p127sHTz4n4kJSY6KOPKBCNtze4seYe77JvjX0AgUfoz8y/yRr8SPyJr6
         MYfUnO/DULd/nvFguy14rszn/iRaKLJcDCYlO4Pq0A3qvB0KBa4VZtjnJ5hij7ZpJZ1n
         kRzrLQcDOp9xuDQgjbs5pju4LhpZ6HMf27X2EbLF4iNv6YGhUQT83tazt8vLDhMhTTxA
         KMLZnZae8QTsQk+kLegp+eVy+LcYPxO1vSeSPJhgtw7zFWhx4jzX1zdrIwoypKU5FeWV
         l8Yg==
X-Gm-Message-State: AOAM533SK+pG6iABIaWiHASbsBNGd8ppEv8AQhH3bavm+BX31HW8KbLX
        vaYfMq+n4gtQwFK2CqfpqsKtfMxsFI0EyZVO
X-Google-Smtp-Source: ABdhPJy2+amVauYpcugTFnQ+Oi/lsJTU11+p37KXaElfiq9cTMZ6LTfgj/M8vKyB9idx/KBcDXDUMg==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr4126113pfc.0.1619187628882;
        Fri, 23 Apr 2021 07:20:28 -0700 (PDT)
Received: from ?IPv6:2600:380:497c:70df:6bb6:caf7:996c:9229? ([2600:380:497c:70df:6bb6:caf7:996c:9229])
        by smtp.gmail.com with ESMTPSA id a20sm4918907pfi.138.2021.04.23.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:20:28 -0700 (PDT)
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
To:     Peter Rosin <peda@axentia.se>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, wang6495@umn.edu
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk>
Date:   Fri, 23 Apr 2021 08:20:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 3:29 PM, Peter Rosin wrote:
>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
> 
> The reverted patch looks fishy.
> 
> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
> memory is kfree:d but the variable is NOT zeroed out.
> 
> AFAICT, the above leads to a double-free on exit by the added line.
> 
> I believe gd.cd_info should be kfree:d on remove instead.
> 
> However, might not gc.toc also be kfree:d twice for similar reasons?
> 
> I could easily be mistaken.

From taking a quick look the other day, that's my conclusion too. I
don't think the patch is correct, but I don't think the surrounding code
is correct right now either.

-- 
Jens Axboe

