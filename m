Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4163496D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCYQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCYQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:30:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:30:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z3so2490019ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQ/dY657sE4UsZwKDF7GjxYBChWqEwh+LM/zpMvtxaY=;
        b=bc+Ns3lXBqVMXTlIuEVSboJTpqZcYuxuIei/lusb4fPtdj10mgZVmndW62d8kZo6yM
         7sNaf/p2SV3t4uwpHplIyHrIA+nkOdkBkOOXajCf1iKE7ybnluJ2r8x1ikTaCmdkCPqV
         wTzCY57SwHbZqQtNdNty97wHpr/k4nEvlCDKgw7tm1dMLr8yYNV/NkFxLNxXp0Pzcpbv
         3fmklR0FETweq/SlOgi1/s8yTYiEgqGrU8C24liAhjiL90F0riwRX0Y2BSDApZd1Z+hq
         lPe99VRSApYq+rr0z81RuNTH/vykQHDf1O1x3w8zpls6Exr2XHWX5yqUw1iXfIqszMuC
         fD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQ/dY657sE4UsZwKDF7GjxYBChWqEwh+LM/zpMvtxaY=;
        b=FLYYINmQREiKjQdbaL7Sl1pN2R7sXI7KJb2YOj/ssYmW1palR4QegMM1QSXuUHTcVd
         hVBz+WvWFJJe8L/wg2nv7Z85/41ju5Mx3PqJbI05tQkM5Tt1N1t1dqJZqobCsE4ClgVQ
         /ggh0LGC8buKyckktf0ohtEncDPbAlDSyhkR/PgQeuDsaPnZTS5Jdt7ZxDnCrt4Fb635
         Cu8Zy3fWgBhBTchWGLN+Hj4PaPd8620YZR6zeAhleCaOoI++XLYMwj487+hoTUVYcTY5
         EBmCysDtNgYrxlO1boJJrtP9rWfYaiftfK1ip7bfnnGWFlkBOA4OpfGLVZnXZUmSrNXO
         VOJg==
X-Gm-Message-State: AOAM533PzUlL9cQDR8eHWK6qJbDDkTjtmdreCmASpkA9G7v18JgOaULg
        tlleJWcR+jPb3OUUu8t97c22frtcuVf9fQ==
X-Google-Smtp-Source: ABdhPJwYGvKiS1yIXxvUvXI5VI+Zbl3OF8GnszEgjrkKtFmfJFLqPYi6hDez75PoVx8kY8W9ysiSiw==
X-Received: by 2002:a5e:c809:: with SMTP id y9mr7216094iol.192.1616689838798;
        Thu, 25 Mar 2021 09:30:38 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c19sm3040920ile.17.2021.03.25.09.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 09:30:38 -0700 (PDT)
Subject: Re: [PATCH] livepatch: klp_send_signal should treat PF_IO_WORKER like
 PF_KTHREAD
To:     Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Dong Kai <dongkai11@huawei.com>, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210325014836.40649-1-dongkai11@huawei.com>
 <cd701421-f2c6-56f6-5798-106bc9de0084@redhat.com>
 <alpine.LSU.2.21.2103251026180.30447@pobox.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4969563-23fa-cb49-8243-d600f1bf0b23@kernel.dk>
Date:   Thu, 25 Mar 2021 10:30:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2103251026180.30447@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 3:30 AM, Miroslav Benes wrote:
>> (PF_KTHREAD | PF_IO_WORKER) is open coded in soo many places maybe this is a
>> silly question, but...
>>
>> If the livepatch code could use fake_signal_wake_up(), we could consolidate
>> the pattern in klp_send_signals() with the one in freeze_task().  Then there
>> would only one place for wake up / fake signal logic.
>>
>> I don't fully understand the differences in the freeze_task() version, so I
>> only pose this as a question and not v2 request.
> 
> The plan was to remove our live patching fake signal completely and use 
> the new infrastructure Jens proposed in the past.

That would be great, I've actually been waiting for that to show up!
I would greatly prefer this approach if you deem it suitable for 5.12,
if not we'll still need the temporary work-around for live patching.

-- 
Jens Axboe

