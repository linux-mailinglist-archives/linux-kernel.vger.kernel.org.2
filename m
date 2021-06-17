Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02E3ABA14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFQQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhFQQ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:59:03 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:56:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d1so5962800ils.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kneleO/C/1wJdRhD70UTQB0QxB1Ynnx3aL11L5hJxPA=;
        b=MQutW8hqt89oYRL5tGG4lo6BHipr+3HtQcqexNEoyKtO04vMZlJR0Xc141WPyuF/mj
         DibhttlvQ81Xd6m/s2Z0uvagCROYp5F9X9buy39oXMiI+dGMisLmv4AxFFC/DEUMDgqL
         kGTGY5O43DAFemft+Mt0O/m7oikQd7XqV8V6IOQJfG51yDlLThBZ073Nwj95qJHtgJSv
         pAP4hVar/DCooHskr4YvDc+7G/clRcDkATWyWmIULwPqsT95tLTM3W2p+tRHwKlPHmkl
         86YX/tKHWFg2G9wQQvFMsOVDp7bhoT1lS8U01v9SvoVXkAIF1HB59jypoFTRHxsWxgSH
         YM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kneleO/C/1wJdRhD70UTQB0QxB1Ynnx3aL11L5hJxPA=;
        b=Cmv07feJBijYnxiXlZaVbOWdGn0SgiSbl8SwEQG1HmYw7CWED+KeUdMqFW3JjEwF7A
         yk59DcDE4a8RIiLY+reuIv/nHNtGbMGjiqRxL6pjaKltKox4rdMfd0onw+B4RYOXN63u
         dqhZz/Fk8NT+paGeNbHpKyQJXVCrSoAee/rCHl9rmu5BGA7gVEtJoL+uCD4Au/GOYh9P
         XOplt9U7TjKUWPiISuy1WA6gB9elIlHQK4MP9ak2Of6+Bc5P9SXOXj4LKD9zIpoHjdP1
         SvTgUhJx0R7hL7TI+Q4+6RZxPif92isT1OA3EmLlbhADkEkXHTt7grjPI+mwIfhCtGfc
         wOmw==
X-Gm-Message-State: AOAM533fJpdwYNSebRYlX7XnMReE//0Tofv2Ovl6FgTlaxKKaLdq/gqU
        /bTtkZ7ZiMA7whMA7/ZKdrZ45A==
X-Google-Smtp-Source: ABdhPJwoui+axVMpoPLMHMB8CBma5vhU+Sv/gLXEQyhNcj5UK2UtFO645wCk+ZuwQLsWqdSYgCUipw==
X-Received: by 2002:a05:6e02:1a45:: with SMTP id u5mr4247755ilv.242.1623949014355;
        Thu, 17 Jun 2021 09:56:54 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d12sm2913876ilr.38.2021.06.17.09.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 09:56:54 -0700 (PDT)
Subject: Re: [Bug] fio hang when running multiple job io_uring/hipri over nvme
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
References: <CAFj5m9+ckHjfMVW_O20NBAPvnauPdABa8edPy--dSEf=XdhYRA@mail.gmail.com>
 <6691cf72-3a26-a1bb-228d-ddec8391620f@kernel.dk>
Message-ID: <1b56a4f7-ce56-ee32-67d5-0fcd5dc6c0cb@kernel.dk>
Date:   Thu, 17 Jun 2021 10:56:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6691cf72-3a26-a1bb-228d-ddec8391620f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 10:48 AM, Jens Axboe wrote:
> On 6/17/21 5:17 AM, Ming Lei wrote:
>> Hello,
>>
>> fio hangs when running the test[1], and doesn't observe this issue
>> when running a
>> such single job test.
>>
>> v5.12 is good, both v5.13-rc3 and the latest v5.13-rc6 are bad.
>>
>>
>> [1] fio test script and log
>> + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
>> --iodepth=64 --iodepth_batch_submit=16
>> --iodepth_batch_complete_min=16 --filename=/dev/nvme0n1 --direct=1
>> --runtime=20 --numjobs=4 --rw=randread
>> --name=test --group_reporting
>>
>> test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
>> 4096B-4096B, ioengine=io_uring, iodepth=64
>> ...
>> fio-3.25
>> Starting 4 processes
>> fio: filehash.c:64: __lookup_file_hash: Assertion `f->fd != -1' failed.
>> fio: pid=1122, got signal=6
>> ^Cbs: 3 (f=0): [f(1),r(1),K(1),r(1)][63.6%][eta 00m:20s]
> 
> Funky, would it be possible to bisect this? I'll see if I can reproduce.

Actually, this looks like a fio bug, that assert is a bit too trigger
happy. Current -git should work, please test and see if things work.
I believe it's just kernel timing that causes this, not a kernel issue.

-- 
Jens Axboe

