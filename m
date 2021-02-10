Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAF7316A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBJP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhBJP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:56:59 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:56:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o193so2059722qke.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WJrPc40c+DHT1+Gb1xeUmwrG0pKHWNH3yQxd2xtCK8M=;
        b=cRjkdnxEuSk+fKCTpDoKWDNN+/sf80UvA1Z2MDKXGUHXz28rm2laXv43GuId/wawCx
         LVa9x17Qyy1g6/q6h8ocMmn8DGFB/NGdJt6uUZnAepydn/ZFNQQN3O9LMa56RbCAv+e+
         dKR8fedr+SNMchL0+cUIonB81msurXgwinDFI3916n/H0d6N2dto3Ua5/Pq3rX/l9+zm
         iyyST5Wmw5lHYfwJM8aqc6WxRTXHu1nEPE9yUnl5+dRhpgtylsilioX1e4W8rRx5S3xO
         C4MmD3V9D3F/ogJ+y1XJgBgVNJQj/sNWIxS1nFRzYM96W5bff1EG9Iqp2/QsnS5hvEeY
         Fq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJrPc40c+DHT1+Gb1xeUmwrG0pKHWNH3yQxd2xtCK8M=;
        b=FeBcurJaOdk2hG/m5m1G2nlPIwCqd0THRHOfjL+HrgWa2Jl/ydL586TXy5ZimzflUl
         0FyF1MWmFc5RE+qRYMOtXpol7TiSDOFkUHy9u2mkQzEZSKa4S50kjjIswcgOuchMl1ln
         Z8pMp/Gj/I1jySZoFWRp2uyTxctnzDTQ1FXIvVemS8nAjQ8YmJl07tzS/sv2O1I4QGdc
         wjXiyLi8lW3lO3A8m9lBcZXVLME1OD+k5XGUbODFFgPNKKhJueel/ylJjZE8wrvejbAO
         mIrmOPPy99dZIXj13L7ZAZoKIue0/gKBnTorerN/BriwR2mYwLD/G1PwhvSHi5YpCXJz
         YSiw==
X-Gm-Message-State: AOAM532eBDh1EEeNsZl2NxUJUyAu67nedgNR1VascjT+N2tiqZqyGFmF
        znZNLvzLIUqN7/11XOawFRuZiXn/VAB0laFH
X-Google-Smtp-Source: ABdhPJwqLfnej9NV46Nv57GVPs/3uYC7wdpgJJUxUqsOCUK5RycE7UKiM5g5ymbyseJiosrxh6V6ug==
X-Received: by 2002:a37:6592:: with SMTP id z140mr3949912qkb.319.1612972578074;
        Wed, 10 Feb 2021 07:56:18 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t4sm1480081qto.62.2021.02.10.07.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:56:17 -0800 (PST)
Subject: Re: [PATCH] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
To:     winndows@163.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1612595455-4050-1-git-send-email-winndows@163.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3f6f04a5-b2e1-2f02-bb42-7466605e4dcb@toxicpanda.com>
Date:   Wed, 10 Feb 2021 10:56:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612595455-4050-1-git-send-email-winndows@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 2:10 AM, winndows@163.com wrote:
> From: Liao Pingfang <winndows@163.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liao Pingfang <winndows@163.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
