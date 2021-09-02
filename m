Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43C3FEDE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbhIBMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344618AbhIBMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:38:17 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9AAC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:37:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h29so1613221ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dBeUfUN5jD/JlFS2rAqlRD6MfCD/VygLrQHRAZUBmEE=;
        b=NMUoUC1ZM+tbRGXcyKRC4Suo6c/iJudflLokmiLJu3K5AZbfjbR3RWkqCEeEt/6obH
         YUU17lhEs0ryZ8aQMS9Vf1kXzLnvQAK6a9aykzly1O4MXqvsbdy3xqz4pbi6d7O/KImP
         OFrUvCAD8n/G/pyY8fS+yIXDlYZdXz0mmni7L5xsdN+kLptX/eojOwnwgb8rwx6f8ltL
         fFfdpRpnrK5glbI6BEs1/wxisRh+O2WcsOPeUJ60po+y0B9sDsCM4sqvTWH8Hs4E/iUR
         RE0nuiB4JVUZ9/AHwBnYBtLkVLdnx2xtMJVvUz/Ppx0rNLtfi7B021uW+Xfkgy8YZNN0
         wrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dBeUfUN5jD/JlFS2rAqlRD6MfCD/VygLrQHRAZUBmEE=;
        b=qTHQVnmlbHL2wTBJbJBqMmuXuAvszIr1bZeDsIPOAkp7H6tFsOYwWzpEcw+VKWZNy2
         EvBSO3h+4xeHhPYTonURB2XZcaIZcTU38sem3aE/0+HGQ1O3U3l7bzUfnUb7cnH8Ae8I
         QhH6uB5yqjVXP5+QWXJzsIluhlzpMg/HBnA2evTr50y9ucIx85NhNsUpv0NymC4zv80L
         7x5WirX3/ROc8C8harxht2G1zg3fRwPpEP8r+qtaqNTjOTIOYP41MUE4DXGPxzqoRklb
         vgRDCQXIU2tESjXsJnx24St3pTJAW5qHztUudYP4bqWemQxYtwBicaS0gREjOku17txS
         8ODg==
X-Gm-Message-State: AOAM533vOljk4noR+KDZJnH8AVxEXGqO8fBflQnYhbviIrPHhMEABb8Y
        6RNv+I9qAHUVL+8q6jBYllaD1A==
X-Google-Smtp-Source: ABdhPJyv4XE2V7XQN/ri4A7eSEUHIyiS5yz9T47Rn2SJml+M/3iAczWiymxX5ha/j0iLQc2PxwdJPg==
X-Received: by 2002:a05:6e02:961:: with SMTP id q1mr2261821ilt.76.1630586238976;
        Thu, 02 Sep 2021 05:37:18 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v14sm924412ilc.65.2021.09.02.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:37:17 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: honor already-setup queue merges
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com
References: <20210802141352.74353-1-paolo.valente@linaro.org>
 <20210802141352.74353-2-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df5c8291-9282-1512-cdbf-28aad60beaec@kernel.dk>
Date:   Thu, 2 Sep 2021 06:37:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210802141352.74353-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 8:13 AM, Paolo Valente wrote:
> The function bfq_setup_merge prepares the merging between two
> bfq_queues, say bfqq and new_bfqq. To this goal, it assigns
> bfqq->new_bfqq = new_bfqq. Then, each time some I/O for bfqq arrives,
> the process that generated that I/O is disassociated from bfqq and
> associated with new_bfqq (merging is actually a redirection). In this
> respect, bfq_setup_merge increases new_bfqq->ref in advance, adding
> the number of processes that are expected to be associated with
> new_bfqq.
> 
> Unfortunately, the stable-merging mechanism interferes with this
> setup. After bfqq->new_bfqq has been set by bfq_setup_merge, and
> before all the expected processes have been associated with
> bfqq->new_bfqq, bfqq may happen to be stably merged with a different
> queue than the current bfqq->new_bfqq. In this case, bfqq->new_bfqq
> gets changed. So, some of the processes that have been already
> accounted for in the ref counter of the previous new_bfqq will not be
> associated with that queue.  This creates an unbalance, because those
> references will never be decremented.
> 
> This commit fixes this issue by reestablishing the previous, natural
> behaviour: once bfqq->new_bfqq has been set, it will not be changed
> until all expected redirections have occurred.

Applied, thanks.

-- 
Jens Axboe

