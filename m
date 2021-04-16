Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF25361F88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhDPMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhDPMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:09:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76216C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:09:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 20so9910479pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIDmVnLhcJob/WVEmytbtnw4gMnQ5FLA8aQ3AsBxhpc=;
        b=ZugLpJwgk2+D/GFB760D+t/HpfzWey5Aih5aZqrv3WA6sO2E6eVVHWNHK8mbFWaF19
         D7rXg3Ep5rIZIVBgjWiKE6WN0TFenBlREKAgLbXLIIPYa5t3RDjlTiOyBLGoQ0J5ZcS6
         5SWzIM7Ol2FxTVa+yad6qPoIBg2D8p5QPAFNQayHL7qg1TAe8Y4D4xRS52gMSPLxH0tp
         AfwyPTWzobHKV5GJ8Ml+sQZSFIalm24SMrjOzDeR3u1rLg7A8qjHlEKd4y9/zvXs3QvF
         5VAawncWpYuqaSeSy+/3fIJaUHg1m0+lhZYpRm4g5Cpqev6v+DX4wqOnZyOWiEk/TX1T
         53tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIDmVnLhcJob/WVEmytbtnw4gMnQ5FLA8aQ3AsBxhpc=;
        b=XIPWwoFgcyoJ0F6Oe9DeQw3bCZyySRI01Uc91jM1M6qxAlbEbhMmesYx56BZgEj/yF
         h8Sfekk5Mz5OwECwbf0yTDgToLBL6Q3za3dBJEF0Zy6O0jHQsaOTKKZgOGP3V33BIwsm
         9JDWYgZbDWx2O7htMF1A5vESzw8KhY1dvP1o0tW4u17o0YD+9MlfN1oJCL94CKNNchAP
         6ulSdzRledKxrBaL/XiH0A7C/WzUpwQCQFbtJihcCwO4gyPEYxEiuS+PPCHywVvhPI6+
         uEX3+NdYpYVWI+QC7QikVkOg2ogA786ylofbBTa5us4ITrjM/SQBWa8aoKnhpDfsnjUM
         anIw==
X-Gm-Message-State: AOAM5338UWUlFkR+uNJ8NHjdh61ZGb1irG2//7iZ93DhFj0ET4EJ+pQo
        mzFp8RmMdRUshOju5oMB4K2fB42+5bgfJg==
X-Google-Smtp-Source: ABdhPJxwghsxhR6BzjbVHa+WCLQYJaqIwBx5pPuq5cFz9lzfycrcSJSUQzF9hZ+M4LNvRqL8zl2mog==
X-Received: by 2002:a17:902:9685:b029:e9:abc1:7226 with SMTP id n5-20020a1709029685b02900e9abc17226mr9401450plp.64.1618574959604;
        Fri, 16 Apr 2021 05:09:19 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m1sm5748490pjk.24.2021.04.16.05.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:09:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: bypass IO scheduler's limit_depth for
 passthrough request
To:     Lin Feng <linf@wangsu.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210415033920.213963-1-linf@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8c572f3-ac49-5a9b-0ca0-6ec150bdb27c@kernel.dk>
Date:   Fri, 16 Apr 2021 06:09:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415033920.213963-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 9:39 PM, Lin Feng wrote:
> Commit 01e99aeca39796003 ("blk-mq: insert passthrough request into
> hctx->dispatch directly") gives high priority to passthrough requests and
> bypass underlying IO scheduler. But as we allocate tag for such request it
> still runs io-scheduler's callback limit_depth, while we really want is to
> give full sbitmap-depth capabity to such request for acquiring available
> tag.
> blktrace shows PC requests(dmraid -s -c -i) hit bfq's limit_depth:
>   8,0    2        0     0.000000000 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
>   8,0    2        1     0.000008134 39952  D   R 4 [dmraid]
>   8,0    2        2     0.000021538    24  C   R [0]
>   8,0    2        0     0.000035442 39952 1,0  m   N bfq [bfq_limit_depth] wr_busy 0 sync 0 depth 8
>   8,0    2        3     0.000038813 39952  D   R 24 [dmraid]
>   8,0    2        4     0.000044356    24  C   R [0]
> 
> This patch introduce a new wrapper to make code not that ugly.

Applied, thanks.

-- 
Jens Axboe

