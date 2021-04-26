Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E536B564
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhDZPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:05:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E55C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:05:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so687035ils.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMztohQgZ6nJz0Yf3sV1YO0hfcw9sjGPqCAVQaP0xKg=;
        b=AmduKi1LpOfaOKLNxHbTAsmqOsnJsgBSJkPL69Tlsz53G4PgbsczXBRLNUAlpqNlGF
         63EAgM1kxyF0m67NqbJkmMZZdeoHWhrJsRwLEk9RTy1eSy1v+cbv8AWF9aeGLvtsFX9Y
         YGNvmxfARZajok7XYvpDDuXtpvZgCrinICvlTnraUpTUGXiXouz6uiCh0h/5767rXmU/
         iUPjI8YqXYnSMtB9GXUsat/aljFWjehWu/WE8knJ8KFET7UlmcFxthLGQOEjNEbm+lvY
         CoOl0nqohL0CPPbS6/3/5GtIWfjaS9bwuXuJnk1ituSPP4zZpoG+mVpsyDAE+IbnmeLF
         sCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMztohQgZ6nJz0Yf3sV1YO0hfcw9sjGPqCAVQaP0xKg=;
        b=B9nBXp6mhwvbjAP3eNwGEGoibxySn2u7e0UT4hyXhk0b+18GHNcCQNbGQWmReXUkc9
         5dL2JP3nn6O7VPBkf0ym8kXNcR2iydA8JQeJ6Ml0Ck2ECtI0TzAgKZkLhHUx/TsRj03a
         VRGqYZf7oaGRKfij/LeD3rSlh6V9XdOJJaHhfHbg14Kc0SMblIuP3NSuY74TYEQrZSag
         gdQxkVoOVG+2bcjoqnT5VGQtnvijLWIjTXLopmjiVTJtAxqq3c3cwfWrde8zRFJ+IUJn
         kawZk1/mB2om2J79TXJIHsWMCT24kwao/Trr+GKczPvTHSVcO9eWrRlvxYWpW6JdzgWa
         4I2g==
X-Gm-Message-State: AOAM5339ws+pDuFxbDDX8ub0t8iQwve5L50myQw4EVxTil1T2SVhR26G
        43E5JqXWpJjmJkdfaCasS48gXFcpkV/NUw==
X-Google-Smtp-Source: ABdhPJy4XK0nwvX6VqHA4XaVwMJoW4D29o0DXqLGumuBpYj+IT4ig6jXO7NU12w2dBSPJTaKhiuRAQ==
X-Received: by 2002:a05:6e02:20c1:: with SMTP id 1mr13557255ilq.71.1619449505796;
        Mon, 26 Apr 2021 08:05:05 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k14sm7336813iov.35.2021.04.26.08.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:05:05 -0700 (PDT)
Subject: Re: [PATCH] drivers/block/null_blk/main: Fix a double free in
 null_init.
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, damien.lemoal@wdc.com,
        johannes.thumshirn@edc.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210426143229.7374-1-lyl2019@mail.ustc.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <434036d5-4610-3b60-74ba-5641cc2b9d5b@kernel.dk>
Date:   Mon, 26 Apr 2021 09:05:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426143229.7374-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 8:32 AM, Lv Yunlong wrote:
> In null_init, null_add_dev(dev) is called.
> In null_add_dev, it calls null_free_zoned_dev(dev) to free dev->zones
> via kvfree(dev->zones) in out_cleanup_zone branch and returns err.
> Then null_init accept the err code and then calls null_free_dev(dev).
> 
> But in null_free_dev(dev), dev->zones is freed again by
> null_free_zoned_dev().
> 
> My patch set dev->zones to NULL in null_free_zoned_dev() after
> kvfree(dev->zones) is called, to avoid the double free.

Applied, thanks.

-- 
Jens Axboe

