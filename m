Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474CB349751
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhCYQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:50:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA5C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:50:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j11so2634771ilu.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eGM+Wb+P5x3c9noHsnTuN/hj/s8DPZX00U0JLAeymJ8=;
        b=iqsccfzlZru7D/SzBxZSQV6V8nNiKAD6l2/EWpgaUa1obvKDk7301p63rga1nxatXt
         ASDt6GWHWiONj/FqhnazOKXO9DuAlid931fdQlD/Vt3/JMmD4Xqnx05a5iWrSF5AlWrw
         ot9g4QBq44RmXw2n0mZ1w+KaHeuE6gKcTtgLcYC6zuQIw+4QmtWdrq3OyhEQfgkVRLC/
         wZCzf8o402FaOBB4ErsZIHClOdXIVR71s2JQmogVasfU9fBO7wjBDcQ7xsgk/FpUJJ9s
         LIiw6YnWtig16v2xxq/7KM5UeLLxguky6T9HmSCH8G4a0hRc4hHaU/Gv7pJq63fkOl8U
         /XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGM+Wb+P5x3c9noHsnTuN/hj/s8DPZX00U0JLAeymJ8=;
        b=c/yRPbAO3PXdQPfsYdDMk1GV155tqzJX7VZuiV7kk2fFG8hqRDHb68+/QxnOTom+nR
         YRvtoZXgVMVVpOwAtQQTq4LwiLwWQv4gw1O4XTPnEefAJ3cfDC0G2s3ImVjy+x/QAXZo
         4UgXxAqKLcA70YSYqAwHhYxc6uLCz18RyYGNVNQNj1sZpnes6iPhY1B7e9wzrmYJ4N/z
         lVgA1gleLaaZyJNIezhQ+fk2ItrXrqzLnaYDryBdFeGeijYaCsbHR1Fuj7pGN/Pe8ZYM
         +FT0EwdqIoydFuKWpFqO3nR3OqJGBmA0xrvv3QqRoY3t6STzH9VkA15gcsrdwTtb+gWg
         XlBg==
X-Gm-Message-State: AOAM531mWMPraorIHp8cM2hUPc3GeZXs0WdkGS+aMo/iPYF7tdedFFdx
        MndS04EwyQjKyGjPJAd6MQtTjm7Ohnp4xQ==
X-Google-Smtp-Source: ABdhPJxK2Y+ZDGrbyjvV8N8vjntGzKY/hZmvzOaSKdaSY7GDlqdJYuPjJVZ2yCIvDVEZRDNchtNZxg==
X-Received: by 2002:a92:d783:: with SMTP id d3mr7712362iln.256.1616691030522;
        Thu, 25 Mar 2021 09:50:30 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q8sm2902491ilv.55.2021.03.25.09.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 09:50:30 -0700 (PDT)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and
 last batch of patches
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304174627.161-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96b5c1f4-2814-2d88-6e05-6bfb10c8e9e2@kernel.dk>
Date:   Thu, 25 Mar 2021 10:50:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 10:46 AM, Paolo Valente wrote:
> Hi,
> this is the V2 for the third and last batches of patches that I
> proposed recently [1].
> 
> I've tried to address all issues raised in [1].
> 
> In more detail, main changes for V1 are:
> 1. I've improved code as requested in "block, bfq: merge bursts of
> newly-created queues"
> 2. I've improved comments as requested in "block, bfq: put reqs of
> waker and woken in dispatch list"

Applied, thanks.

-- 
Jens Axboe

