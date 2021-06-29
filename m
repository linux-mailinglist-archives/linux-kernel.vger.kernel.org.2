Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3673B7729
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhF2R1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:27:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45438 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbhF2R1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:27:36 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyHTw-0003NL-GX
        for linux-kernel@vger.kernel.org; Tue, 29 Jun 2021 17:25:08 +0000
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402424eb02903954930851bso5476352edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ri3WXGzuTojlL+9mSjxaDY7X42NrL+ai9PlKm2Tb+w4=;
        b=cOuIAjY6R79oZ60GcSiTn/yH2PwS3WDaQRhhxkqB+PDYHmdzC6H1vqzWNUR5S7fY8W
         UGGMaBOCfaRMHOl/3r6Bvy2jxYldr3J02wjdRtVKXIfrqCcMUEeRq+rTZiq5wcu7MWfl
         8PX2sZdVFvbfVawrR1xB3/JxiEE1RJMyLn12zip4z5Jbs3JPcmwKNbzfyl4qxAbxTHFy
         3n+L+lJkXiV30DseITWRW8BfBcR6dUKzp2QsG1WwUI/hbhjNvSkKksdvLbV6Zq+qr5zU
         c8jTkZDNLcg3e0KYzr8kbuZSlntcR3QOKi4lXxqK4RMCWI4hAFubr5J1Ci+i0B/6sDV+
         sfkA==
X-Gm-Message-State: AOAM5307vcDE6RbVe3LNjWHOQgaUVUjvFggVL/Y8l/tXcnxVgRGwD/Ii
        OPFJfqquwAUAOUIgaaNOqJHjq47jMhgH9yg5kMmm3x6jop5IIjG9k44Z1VjXVPQID5GexP6BJD6
        e8fwKBxwzAvy/GQOTZWzzFerKLzaFujUikRzdmfbr8g==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr41493364edb.164.1624987508253;
        Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU/YhwLaYMTGQNMSd2pgQJxlfGs1UWubtAp8nzGtPKda2VM7Jpw2ZllP8AvwmGwX6cwntukw==
X-Received: by 2002:a05:6402:31a9:: with SMTP id dj9mr41493349edb.164.1624987508141;
        Tue, 29 Jun 2021 10:25:08 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n2sm11450840edi.32.2021.06.29.10.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:25:07 -0700 (PDT)
Subject: Re: [BUG] btrfs potential failure on 32 core LTP test (fallocate05)
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
Date:   Tue, 29 Jun 2021 19:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2021 19:20, Josef Bacik wrote:
> On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
>> Dear BTRFS folks,
>>
>> I am hitting a potential regression of btrfs, visible only with
>> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
>> instances (x86_64).
>>
>> Tested:
>> v5.8 (Ubuntu with our stable patches): PASS
>> v5.11 (Ubuntu with our stable patches): FAIL
>> v5.13 mainline: FAIL
>>
>> PASS means test passes on all instances
>> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
>> fails on 32 and 64 core instances (did not test higher),
>> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
>> Standard_E32s_v3
>>
>> Reproduction steps:
>> git clone https://github.com/linux-test-project/ltp.git
>> cd ltp
>> ./build.sh && make install -j8
>> cd ../ltp-install
>> sudo ./runltp -f syscalls -s fallocate05
>>
> 
> This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

It tests all available file systems, just wait till it gets to btrfs. I
don't know how to limit it only to one file system.


Best regards,
Krzysztof
