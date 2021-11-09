Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E044B161
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhKIQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhKIQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:45:06 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286FC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:42:20 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f10so21282505ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZUeqW/lq8pCujML2AhgHfhtcT1KSprwhQa9BHxegsUw=;
        b=UJr9e4n/Fy9YeToIpiq/SIWUjqkGf9Ucb/A5whoFNf2FvkNI7neaCK3O1WPWJhf1Fa
         aqoG8notC0BveuJl9hH3pEhKyBXTwe3i5AbwCVFgQ/1l1uMQNsSLMYvScWSMWvK58KNw
         O0pFGwe8jc1N1kCBetK+91KLrlgdHBEYMfT5ZXcNDb897zGqhLJOj+YSk6eOHeP3JgDf
         OJNoSYudXiajB+KEcMRf0pU7KWR8STZOEmLBm/CIseEuOBEqai/0s/YmmXrsNT1RWX8z
         KOobbhvhXEgwTkc6nPOE6qf5filokDPgOTvSjpFhn1DFgxEium39JD6MU/b8S6ma3Q1D
         QTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZUeqW/lq8pCujML2AhgHfhtcT1KSprwhQa9BHxegsUw=;
        b=PWjZeMBXPg7izIcDfdZ/7E9cgsUqhU1L5giV9PAXWM+6jjT+kQ2ebYl1ENv5H4rmA9
         dB+vkJrpIl7SQo0Ewp1ZdNykU/cEKg586WT3r10hHAIBQ+gQB/TblIJh3r/7s2yGD0w/
         OU2MEWmhrPrkApX/lOv+T9cMv0hCZ/TVveI5Y4dQY00qQ+yMLWfShBin+g2p2OudVrM0
         jzM1wcoj/hLZ30g5XQ8LZXt1QdJ3qbcC/J5fEDY+euD0W7vwZ1qGUDqhbh6j1bAJYLYv
         sNWXgvZT4NWKZo7tFFQfYWCykvCgItIirli7mjkUd/e1DbVV+knvKKvRYz6aFTN+l8+S
         tdGA==
X-Gm-Message-State: AOAM533RdNRWTkJoi273OZ2rolXPvLPMM2cKEeSMj8NZ39PKWXn3tGGc
        RJphZ+2e+tfjZzS+NhITPu+xYQ==
X-Google-Smtp-Source: ABdhPJyzOQ+ZATudReIxL0Z/XQPF2ByazrfkavI3W2BoftBSQ7ULpLSV085IxHyatWS1GUyLbbDakw==
X-Received: by 2002:a92:cd86:: with SMTP id r6mr6099676ilb.149.1636476139843;
        Tue, 09 Nov 2021 08:42:19 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a25sm2478977ioa.24.2021.11.09.08.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 08:42:19 -0800 (PST)
Subject: Re: [PATCH] f2fs: provide a way to attach HIPRI for Direct IO
To:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
 <YYqkWWZZsMW49/xu@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <042997ce-8382-40fe-4840-25f40a84c4bf@kernel.dk>
Date:   Tue, 9 Nov 2021 09:42:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYqkWWZZsMW49/xu@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 9:39 AM, Christoph Hellwig wrote:
> On Mon, Nov 08, 2021 at 06:13:36PM -0800, Jaegeuk Kim wrote:
>> This patch adds a way to attach HIPRI by expanding the existing sysfs's
>> data_io_flag. User can measure IO performance by enabling it.
> 
> NAK.  This flag should only be used when explicitly specified by
> the submitter of the I/O.

Yes, this cannot be set in the middle for a multitude of reasons. I wonder
if we should add a comment to that effect near the definition of it.

-- 
Jens Axboe

