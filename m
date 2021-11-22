Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3048459018
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhKVOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 09:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhKVOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:23:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2547C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 06:20:06 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id k1so18213607ilo.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=87fS3MfuXyxeM48QrmQXjZhP26c/dRVf2nmaGCq3Ooo=;
        b=MCT0sGQ5n9wFn8f1v5dDS1cB6pSsIHeRuf0QPw0piEm1jUTUSLX+oiMnbH84YQN2RB
         Lajf58SdXwsAoRK1ncoCRNzVry1ytjIxwsh2wOBPueM2SPmflaEWZP0UTdwQgeBgt9JL
         e8m4pCaNPyOQeqp+ow6bir/p+G28KACgYdPXUguFLlkY9KsrZaDT+dSGSm2+nz8UIFE0
         LD2SPS2xn64MpUZxv4liSyiVGaeX9Sc9Op4XoLfDS1VPvXtnJgC9OAedQa6zGf8//+ee
         VqfdJ7y99wWte0Pud+dO99IKisl+gmMXhMzICTFREVv8gu/hzg0t7dJiQ2Lh7cDo7JNt
         FDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87fS3MfuXyxeM48QrmQXjZhP26c/dRVf2nmaGCq3Ooo=;
        b=Tp27oUtQf8eibXPjP37lNr1mWlptXmxqa3O7Fh252rwKRgdl2+QE0rCunHf0dJnn6F
         LDqkcJdBTGnRDYp8ys8F9wl/mlh2WM8VBWBAMTFLfSRsGynAt5HcoIm2p6JVGRiERCE3
         AhqnyHpZRyrUskTimfHr9OTu0b483HdO8YbgJIZ6SwTeI2DbDYkgi20GZzLzbkYpSdli
         1hHokXEmu6Mxmx8VyN/ryX8v+/21eP9L5E8F45eNwlARW11CgH8FADab9NnK52O61h0r
         t7QyVpqh5pRiAV1UY9wIt1h+2i/QV3gsA2hZ+5YdPXqIkoPBYj66T/MY76x5Tj44h+D9
         XSxw==
X-Gm-Message-State: AOAM531YSnXpMO9QLTudeEGeldkUtNcjYwnLME9jx+ZdAiOL81ToRBDe
        B+M2q9fqfnu65K5LFx6Me/Hv1A==
X-Google-Smtp-Source: ABdhPJyK9hdXMsXAZrf6WJPCgGgys29RcikUa50BD5KPgYgoW7moIcwnMtomK6V4NlvKLh7y/J2vzA==
X-Received: by 2002:a05:6e02:1a2d:: with SMTP id g13mr19335748ile.134.1637590805845;
        Mon, 22 Nov 2021 06:20:05 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x15sm4990039iob.8.2021.11.22.06.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 06:20:05 -0800 (PST)
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
 <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
 <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2a421da-1bb0-c65a-d8e2-7cbbb2cccfab@kernel.dk>
Date:   Mon, 22 Nov 2021 07:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/21 3:02 AM, Christian Brauner wrote:
> On Sun, Nov 21, 2021 at 11:17:11AM -0700, Jens Axboe wrote:
>> On 11/21/21 10:49 AM, Mike Christie wrote:
>>> Convert io_uring and io-wq to use kernel_worker.
>>
>> I don't like the kernel_worker name, that implies it's always giving you
>> a kernel thread or kthread. That's not the io_uring use case, it's
>> really just a thread off the original task that just happens to never
>> exit to userspace.
>>
>> Can we do a better name? At least io_thread doesn't imply that.
> 
> Yeah, I had thought about that as well and at first had kernel_uworker()
> locally but wasn't convinced. Maybe we should just make it
> create_user_worker()?

That's better, or maybe even create_user_inkernel_thread() or something?
Pretty long, though... I'd be fine with create_user_worker().

-- 
Jens Axboe

