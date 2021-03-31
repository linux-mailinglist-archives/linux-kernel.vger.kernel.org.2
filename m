Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601EB34AC40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhCZQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCZQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:05:28 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C95EC0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:05:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 19so5468783ilj.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XwZJJeoSZZ2cKv8CdUYDg+6zFyzeY4El3NDCPxPqSDM=;
        b=bwDNydOAwVH0EpgvOeiujp1fFuCEVXJmzl5cvMhdvCa6UkmXA3gUjp/fAaLbKCvlQ/
         /dAMZvn+yq24DcXke2A2uPZ9cZpcwZf7vLWZafM1BfeDaUIbaPIeeBJH8CW2iSJ90lf1
         2NLoPOUeOdUV5H1GX1CHHs2W2skn+1i/55/lkLfRvcY/NVtjYu/O5963VbenQRZEzR6M
         Aw7bivgUGj5PQNPfF8reUs41v9QJCtQEzkb1eo07710Zt6hLfFRxBVuqL6bJOv4vOFUc
         FlVVGkkzmSHWAMSmuDEKmTDlAARFj5hkMWR6LTGAdDeGl11DMgMFdt4W54ZXg02vL/4R
         cQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XwZJJeoSZZ2cKv8CdUYDg+6zFyzeY4El3NDCPxPqSDM=;
        b=g/p2HKWBCrFU0PuoiLgrAEzWnnKOW4ib2Zh9qEaoNP31XqaoKR9lcTLaz8ktqa/lTP
         vyo+Syv2NJVpjdoWC9sQk3eUlAjNsX59yhAUMo3fjT11BhpMSTby3giX7SLIUGYTrP2r
         A+OK8n/uMH8lJvBVff2LJVntd9AHy2wRNjYlhFiSFgGrHJ8n0TCFalg67ZeazIrYmCKM
         vJWp4rT/XDN434Tl33q2IxdXG83p6C9LN8cEWmy70WkPmhdBuuCk7lFJJOkVqkKvqBU8
         /dftmv0Eln+XtKtM8B+uoNSSfv4qHC+4hAxh/ZpkKX9ob4J6a7z5yTFeTr3ghkF37vyH
         wdaw==
X-Gm-Message-State: AOAM533XRs3T+6fQRPlnuihS3kQ9Zb4tmrbp32yudrfE7RIKxG7GVgTk
        VJvXeppERM91MYrq7uQ5gLra/1Q+dH+7Qg==
X-Google-Smtp-Source: ABdhPJwGNn0m1B5FDWyRVxmOmK7n6oXzRr6uK0+K26KjnmDjgGxDp3pgu6YaP+NtW6JJZYH+Genfhg==
X-Received: by 2002:a92:3003:: with SMTP id x3mr10988731ile.124.1616774726523;
        Fri, 26 Mar 2021 09:05:26 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x24sm4427554iob.28.2021.03.26.09.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 09:05:26 -0700 (PDT)
Subject: Re: [PATCH] tomoyo: don't special case PF_IO_WORKER for PF_KTHREAD
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <46f6e3cb-cc96-d214-e183-71dd238da075@kernel.dk>
 <935b000c-77df-fa88-6e2e-daffc256a11e@schaufler-ca.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c78e259-fc25-52dd-7128-289f016425a4@kernel.dk>
Date:   Fri, 26 Mar 2021 10:05:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <935b000c-77df-fa88-6e2e-daffc256a11e@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 10:03 AM, Casey Schaufler wrote:
> On 3/25/2021 5:44 PM, Jens Axboe wrote:
>> The io_uring PF_IO_WORKER threads no longer have PF_KTHREAD set, so no
>> need to special case them for credential checks.
> 
> Could you cite the commit where that change was made?

See previous reply, same one:

commit 3bfe6106693b6b4ba175ad1f929c4660b8f59ca8
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Feb 16 14:15:30 2021 -0700

    io-wq: fork worker threads from original task

-- 
Jens Axboe

