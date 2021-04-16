Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF9361FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhDPMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbhDPMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:31:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2AFC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:30:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14so9061910pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5iDQ+n5O+yKXMjT+TRIf4eZ4wu1n263xyTGUJyOMGZk=;
        b=poaug3sfihBK/PNZlpnWudeGAAaaZGqBflAJqkGlUdZOkob3Rlj+kRbCgHuXqrGxfU
         9bH/OsiNwI4rE8Vyh8E0eI+fBJiZW6S5L6MDSTSHLTQIrKPvGA5XJFdJKL0BRDFFO9uZ
         +bEA+KMj6VmchABU9cEWhLJqky38zZHnzlHJl1mATVroUHQ906GtpZpAGLc91o1uGxDk
         NIRVH/vM0cBnPZ9qW8xCdtXBHlhhOeXjhJyGEFCNRjrpCn5c/qlXpGUYB+LCqw6Q5lvy
         hNsOt34tkvimsHY5eCftYUJNtyh1JkbMpLRUOMcBYgOQRV0R0gtEUfppI/YbR3Qtp+9E
         QizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iDQ+n5O+yKXMjT+TRIf4eZ4wu1n263xyTGUJyOMGZk=;
        b=eMv9trQ1HJiT7fmBx+RtaL+FnZsTo1Sj2GduDlgB2xx/1HKpMbwTw6QNonYch1X3/O
         NjCkX6yHn+k2bgpnm0liwNvZ8f8KCW296UW2kO4EDXo/wmmNUz75MOXw82s6Zy48dI7/
         RatHYEK0Vni92X2oKYABP1M6BLzO7q+NPLlCbFEpIEw+bOaVM77wYsftQ8ecImnQf4pE
         1zbo/v0j4Rs61gaVrJh3/EeZ99fWVN5G94pGvCzKGwQxpBve5+A+jleVg/pB3X5Gjmj2
         popc3A/oghfpq1ZrhaGfR4oX7iqwuDieuoqfd+EkjnLezXQ64RAM3X4MXVZjevIa8d8t
         Nb+g==
X-Gm-Message-State: AOAM531CZrgI6H/cPG6+UBuhlI7PEWFrX9jvzQKxZ4Japy2LSiGQVS7H
        lNtde9TveMD96v7Mv3slCFzj15doWJ7CYw==
X-Google-Smtp-Source: ABdhPJw9rE4NqIus0mK7zt2Ef16XnLgBz/gbAgkWlhy2LAvQdKD98QnKkKd465mwQJSXov69gYu8Zg==
X-Received: by 2002:a17:90a:7f95:: with SMTP id m21mr9850212pjl.174.1618576233554;
        Fri, 16 Apr 2021 05:30:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i10sm1668126pfo.37.2021.04.16.05.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:30:33 -0700 (PDT)
Subject: Re: [PATCH] floppy: remove redundant assignment to variable st
To:     Denis Efremov <efremov@linux.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        Willy Tarreau <w@1wt.eu>,
        linux-block <linux-block@vger.kernel.org>
References: <20210415130020.1959951-1-colin.king@canonical.com>
 <d6c29628-be82-c812-e021-fd0f0ab02172@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a61c6976-0035-d562-6059-d8ae0c6d2425@kernel.dk>
Date:   Fri, 16 Apr 2021 06:30:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6c29628-be82-c812-e021-fd0f0ab02172@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/21 6:29 AM, Denis Efremov wrote:
> Jens, could you please take this one? I thought to send it to you with other
> cleanup patches in a merge request, but you already applied rest of the
> patches. If you prefer to take it as merge request, it's ok I'll send it
> based on your branch for-5.13/drivers.

I have applied it, thanks.

-- 
Jens Axboe

