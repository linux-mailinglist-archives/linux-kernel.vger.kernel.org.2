Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED93898F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhESV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhESV4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:56:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:55:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so4153274pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ivKuA8eA0E4VB/FOYglu30M5yoHYAjJwhMfE0IGotA=;
        b=Jw+5Py0TWikm6pW8u3N3gqhTxuFjTZYf7ifc4I+8o+ndKLET3H9EMmAc7sBw9y6W9o
         2+il5d/YC4FWuVpNl7FRZjfmCByzMLJNFaeAChSYLJFXTEwCRDQy94bYlvIgDZjms3LN
         aKRqgISJKW+haoxFwnBWGDMYGYOb01dUotzdw7DKRkHVPpotS/9QuW8KCqkWyXdFZ3fN
         onq2nUqcTNPd6nd3b70iO6mUjoJDthIu8FBfPLI5IGfY4L04LJKPN4XlSRT0A6AAblia
         vuqa9yUUDIqQI1sI5b4DPSFcthbNP66zDCUZJT2N2kd/H+0lLkYnSTcpoE4jCu9azJi9
         8Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ivKuA8eA0E4VB/FOYglu30M5yoHYAjJwhMfE0IGotA=;
        b=XttWLlI+PUmlsci/WsBoxCmk+FYAdOKtru0r6WmQLjeVrwSoj/poALe1xEfmwrmsK1
         vXfXT44QdaZyzo3Y/Ju88hz7NhL5DuJ9cHB/wKlatxG+K36WJ2ag0EztB1PZgn6nvqm2
         Mb07bDOLLXRi0k4dYRnqn0IabrtzOfXTgjh+AG0nShZEDUgIBHINT4w5RWG95bC4ZfHk
         g0w6LVhlbIN+0GBR6vSyZ9uJd63K5uDYjgOVUJs2rhKH1DM51HAQGd7b5SNbUMzRninn
         K0dN0WNurn0oqlP8h7NH1kvNRSrObY/ARPN3i5HoLfuE82ITOmjt08wgxyf1/JRrdt5A
         2tUA==
X-Gm-Message-State: AOAM530XBL3IM1UqjFrzxJcB/EjOcLJaCjzoEsDxJVVVKzVLpY85PO9O
        hKSvvFyvRpWIGEgF06noZ+o/O8CpuytTlg==
X-Google-Smtp-Source: ABdhPJyiPZaaRiS7d68AG3+9tPqf1YZAp6bLaqxJGmxQaCX62iwcFyXDUPiKqUS9EGTE+u+NeFFm5Q==
X-Received: by 2002:a17:90a:66cb:: with SMTP id z11mr1177565pjl.15.1621461326778;
        Wed, 19 May 2021 14:55:26 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x13sm340531pjl.22.2021.05.19.14.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 14:55:26 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210519080143.583d415d@canb.auug.org.au>
 <3c2c877d-aa02-5202-e8e8-53b8470b0154@omp.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d51b1a64-e6a1-68e9-5a1d-da4f9b88d019@kernel.dk>
Date:   Wed, 19 May 2021 15:55:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c2c877d-aa02-5202-e8e8-53b8470b0154@omp.ru>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 1:25 PM, Sergey Shtylyov wrote:
> Hello!
> 
> On 5/19/21 1:01 AM, Stephen Rothwell wrote:
> 
> [...]
>> In commit
>>
>>   1437568b56f8 ("pata_octeon_cf: avoid WARN_ON() in ata_host_activate()")
>>
>> Fixes tag
>>
>>   Fixes: 3c929c6f5aa7 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
>>
>> has these problem(s):
>>
>>   - Subject does not match target commit subject
>>     Just use
>> 	git log -1 --format='Fixes: %h ("%s")'
>>
>> Maybe you meant
>>
>> Fixes: 43f01da0f279 ("MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.")
> 
>    This one!
> 
>> or
>>
>> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
> 
>    Perhaps this could be fixed still, Jens?

Yep, I fixed it up, thanks.

-- 
Jens Axboe

