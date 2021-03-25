Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947253496CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCYQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:29:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD58C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:29:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f19so2518202ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSF0pivwzy3fBYbfzo8IgvCNBR/Hw3crvEop98fZXCg=;
        b=n/ll6FIqeHJKlpZG8seLI/5tmNYd1JNATCmHWlxI1aibGm2zob8+SEERP8L/XkU0UT
         aoPUovkhVPFlyxakHzue+mQ+SDVZK0BPhyCywSivUGhdOeewfRNOFPdqFRk3qavaoE2A
         KWhPPy8RE/oAsQW3LO6DUnC4LGTsetvZt5ZKwI96360hTpqwkl5a136I6bdXoXAVJ5OT
         yXVPCmcYQLEeUYYAU4D1u0aGZpSI6CmlLdCy2nnAPAnLHnl7f6EUu8MOe2UaMSrvnQdm
         vUHd0tJJqp81YYy3K1jLxT1LMIvoF6WiwLHVFYNrigG4Xhu3ADxWsUhtzWgPaiSBk+1g
         nrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSF0pivwzy3fBYbfzo8IgvCNBR/Hw3crvEop98fZXCg=;
        b=MkM9AcHEtkjJ9EoYvynh+sx3jQZprjDgksAZWekQ0pgizn7Cq9vCkgAMA0dyuBnJ+H
         zmkVhi09Q18vlFNW2gSbuEX9mb5V9OYocQMIPVjN4aUdZzEls81+5zrtmmeQSNTZ2JDs
         xXAPHvAIyRySXxdLIM4xt3OS0kweeuUiHaleUinPIvfI0UkxsbMMUAMZ1ECDgyDXM43C
         d8qKq6J4cpJp59OfyUoT1D+MOU9g789EKCWjp6ETftdIm0hVYdWQwS1lRqp6ts1T+huv
         HQx0RhR+J/UWOwqegzbECVNk7es6h3U4cG2e/S2vRIXUl195FublRo8VXjxSj433oJ0c
         e7Ew==
X-Gm-Message-State: AOAM533kHdX+4exyxaEOPtwM0iKEziyJ9/2xUcYylt98P4RpQODokCZ4
        O2NjUhQsLRdYsBWOdPvV2XcNbh04TivH+g==
X-Google-Smtp-Source: ABdhPJydx5+yyeRQGFt1qi82utbriCQ1JZmy6qkm1FzVoBRb9wH/6bcFzkNbgwRAr4rpxnTwHrw3Ag==
X-Received: by 2002:a05:6602:26cc:: with SMTP id g12mr6746649ioo.169.1616689785483;
        Thu, 25 Mar 2021 09:29:45 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m1sm2667686ilh.69.2021.03.25.09.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 09:29:45 -0700 (PDT)
Subject: Re: [PATCH] livepatch: klp_send_signal should treat PF_IO_WORKER like
 PF_KTHREAD
To:     Dong Kai <dongkai11@huawei.com>, jpoimboe@redhat.com,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210325014836.40649-1-dongkai11@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <832b5870-b926-3ccb-155d-3c364ee5508d@kernel.dk>
Date:   Thu, 25 Mar 2021 10:29:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210325014836.40649-1-dongkai11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 7:48 PM, Dong Kai wrote:
> commit 15b2219facad ("kernel: freezer should treat PF_IO_WORKER like
> PF_KTHREAD for freezing") is to fix the freezeing issue of IO threads
> by making the freezer not send them fake signals.
> 
> Here live patching consistency model call klp_send_signals to wake up
> all tasks by send fake signal to all non-kthread which only check the
> PF_KTHREAD flag, so it still send signal to io threads which may lead to
> freezeing issue of io threads.
> 
> Here we take the same fix action by treating PF_IO_WORKERS as PF_KTHREAD
> within klp_send_signal function.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

