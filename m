Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202844213F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhKAUEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:04:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E5FC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 13:01:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t11so12378015plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=//qLyozC7UQaBdURgH8zYX1NEvcJQYYYqxcLEEiD/C0=;
        b=peBqNdpy1901jw2VuRMcFADsSNPGF2oy8Kr3JTH5yjMnOZlkZ7FUSw2c+AbfaWojkL
         u1kye+XZNhbFlI5FANhCGhNvqQHCaD9wlL60y6neZNgZ/aE7uJjVYizEhfyP6ZywkXtd
         VSlfE1AYfiWuUjtlNT8xjq+tksH6x+z3jhxKPvjYXr1KWwMFrJmFKVkxzcAS6n7gLy3E
         oI2RURVtjxWVv2m6FeAnrJhrHm9UQQMiNHUIMbsCd8Pngg7Kg9l3w5subPAqC9lA2D3C
         eIoQThPd3PQcZcDEC9f7/1QFI5rMb1H1J0rxWNXhl8LkFxqbRFuzEvySsq6t/MVzOznT
         usaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=//qLyozC7UQaBdURgH8zYX1NEvcJQYYYqxcLEEiD/C0=;
        b=qoZyhzhiNKr7XMcB/97HFaVVlIwYIuz+0/WK9isXIZF+VJfdExFcK/bkR0/s9dgyxR
         iJGZ6GXCqiQG6V9kjFEo+I5FYgiLKhOS/VzLDiV5zfNX1pyemzeUj2at1qkbi0qXM5Fi
         Y5tz+T3rhjTU5LdsoQsa7j+iPX5W6VCpQNSpd6Pf7fQpnXcnciA9LIFZzt3LtOjFJxiL
         a5zD4JdcYK8BcWqAINZOR4ceKzc2+6QZo+QbhdRslw6wxDCsVOGe1in7MVQXbW8slD9L
         3ooe0iFUC2lHX/xkiPRVPQgKElvdo/K+23bQw397uQhraXP6yF2vJIYxA8H0KFtpU4iW
         pgug==
X-Gm-Message-State: AOAM532KxBFodtBM82ZZDUfcF0Pd2iRr/mqX3jH0dWAZYg5XCWifVHYB
        JhByEWWMO4hdyeVkYLi2znBhTxvtjuKxTLOy
X-Google-Smtp-Source: ABdhPJzxz3cnVsLDaAL1jCkkJjFC5U9ToZGS8xlNZ6wLOTkNhl62tXI+5y13i4LrDg7zVvr5wX7rbA==
X-Received: by 2002:a17:902:c407:b0:13f:68f:6753 with SMTP id k7-20020a170902c40700b0013f068f6753mr26985851plk.39.1635796903499;
        Mon, 01 Nov 2021 13:01:43 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id mr2sm258610pjb.25.2021.11.01.13.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:01:43 -0700 (PDT)
Message-ID: <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
Date:   Mon, 1 Nov 2021 13:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: general protection fault in del_gendisk
Content-Language: en-US
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
In-Reply-To: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 12:13, Tadeusz Struk wrote:
> Hi,
> I'm looking at a bug found by the syzkaller robot [1], and I just wanted
> to confirm that my understanding is correct, and the issue can be closed.
> First, the kernel is configured with some fault injections enabled:
> 
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAILSLAB=y
> CONFIG_FAIL_PAGE_ALLOC=y
> 
> The test adds loop devices, which causes some entries in sysfs to be created.
> It does some magic with ioctls, which calls:
> __device_add_disk() -> register_disk()
> which eventually triggers sysfs_create_files() and it crashes there,
> in line 627 [2], because the fault injector logic triggers it.
> That can be seen in the trace [3]:
> [   34.089707][ T1813] FAULT_INJECTION: forcing a failure.
> 
> Sysfs code returns a -ENOMEM error, but because the __device_add_disk()
> implementation mostly uses void function, and doesn't return on errors [4]
> it goes farther, hits some warnings, like:
> disk_add_events() -> sysfs_create_files() -> sysfs_create_file_ns() - > WARN()
> and eventually triggers general protection fault in sysfs code, and panics there.
> 
> I think for this to recover and return an error to the caller via ioctl()
> the __device_add_disk() code would need be reworked to handle errors,
> and return errors to the caller.
> My question is: is it implemented like this by design? Are there any plans
> to make it fail more gracefully?

Hi,
Any comments on this one?

-- 
Thanks,
Tadeusz
