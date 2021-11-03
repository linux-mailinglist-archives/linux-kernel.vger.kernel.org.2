Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F8444942
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhKCT7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhKCT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:59:07 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D8FC061220
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:56:31 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso2404877otg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TuTvA2VFldo5bKpIsQIYkfQTcqu/XUpeO+ZJ0o08srE=;
        b=Kc8JPw+Qw4syw39DvCFAkRFc5WtVBGeDV5KtRwWrl0nAo3ukcKEGX0JNPykLf0qpfx
         Qtx22OiLajageqDIjzdNeIIb07E4fDhKWMAjYJbE5Jmm+1F5bKW93Txpyz0JuUnohPRE
         GE3UEeEQiAr5D5b7RSd4Yp+FYUAFz4WR9be+pPc14cn/a01nloyJFiq6L9PW7jnPVXkk
         Xok+mMAlMsjyxEB9CA2RZQt4IfEftkY/0RqtzLOe+zbPta+iNyyF3JmoP0IVlTT+FSfH
         OGJhr922EJ40Zl3aKElIg4wtIZeBOHCeEsTkxiWNnd9+7IzEqt3jCcqkm3sCrqbIYxVI
         8WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuTvA2VFldo5bKpIsQIYkfQTcqu/XUpeO+ZJ0o08srE=;
        b=aa1dM0LDlPg7CmOK/65LAUssoFigiaYoQE0z1JlafQaKL3wmGU6uRFObLBw3yRygEe
         iQqphzDTOFcKh1iTYR2G6MAnJwwfiZul4ucqSKXxeVGTrF0LLXgpfS44tJWbhRenIt8G
         1teaSdjmpRBREsQYJYsRcwnjlUm9PbohHHuHoP15aa0MHsVVIvDizGSKZTQXTEg6fUpZ
         Ez3uUt2NeFn+oNPhq9AgvUJe9DH/+mBwUo6VNEgQyp2+JoLuzLfqarzWb1iIphrX2UPg
         3JVVsK+yzpXLEml5os4L5GSscbLDD9oMnYKg0u9zf0z4NkngoBBwV2YGLB+6+vdsj+yY
         /q1g==
X-Gm-Message-State: AOAM533k2ShKSMfMy6juIRoX1sxKXxWE1uQB+798B8OrTU+3Kq+RAxA3
        mpqf7JgagH4KDKEWrY67/grujtVFMWiNEA==
X-Google-Smtp-Source: ABdhPJxZAUHsHE+0bvOdtD3JkKcJuO8LDLO+Hz6J+nPiBBZWkwAOQI9WRgQ/AfNVGJ8qdhntnN2pSQ==
X-Received: by 2002:a05:6830:43aa:: with SMTP id s42mr16579659otv.13.1635969390149;
        Wed, 03 Nov 2021 12:56:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z12sm23945oid.45.2021.11.03.12.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 12:56:29 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-block@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
 <20211103195411.GA3156469@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef74ff48-6d9c-f39c-aff2-8a820440c953@kernel.dk>
Date:   Wed, 3 Nov 2021 13:56:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103195411.GA3156469@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 1:54 PM, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
>> There's a hole here we can use, and it's faster to set this earlier
>> rather than need to check q->elevator multiple times.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This patch results in a warning backtrace with one of my qemu
> boot tests.

Should be fixed in the current tree, will go out soonish. If you
have time, can you pull in:

git://git.kernel.dk/linux-block for-next

into -git and see if it fixes it for you?

-- 
Jens Axboe

