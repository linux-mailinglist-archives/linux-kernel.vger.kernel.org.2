Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA97F3F6276
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhHXQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhHXQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:12:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632EC0617AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:11:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g9so27045684ioq.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JAsKRN3bly1YA9bPZ1MQXzadV3alLJQ6BFvBOznMdfc=;
        b=x3t6Igle4xKMrUrFP1IGFtgXi7yZDPeXMHU921icvD2kUSHfH5Jl24+zfhqRqO3o9+
         ianmQOi2yUAqYoK5Kko4euXqWgeVm72XpNCa9W3yC+eMiKZlFV1zmDEH42C6d1OiKEH9
         xNj0pJZKY/7n1mqxIi7fRWl8Apv4imnWEnoDgjvKWg3VI/EU0Go1mEPNryiuvl/UI9N8
         RQkj/ULEz6ayHGZXW4qIfMC761BSC3cm5rr3+Kma+/KA5pgrv59/KaZeO+DkZpOifwOV
         H01dakL9VQp+jwhHN+Qi5z0RLVL1WvYLsax0t1PLE7QlAPobcmSO+8aiqEiGc1Zo6pao
         syOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAsKRN3bly1YA9bPZ1MQXzadV3alLJQ6BFvBOznMdfc=;
        b=atbVvBvMe0jpVrEdvS1Cm1M+e1sxjSieb2hSXnJKWBn/IY5/e2CPwsZN0EcF8Va6yW
         SuZCkw+ERTAuyVEpEv2aKneNKvySEcOZJYYPUh9x6CJlEq/oXz2aZGuSGidliyY5dRMp
         nokv9EErs+YaSQ+uCqlNlBH6N+oi8XhDSV0ITc065mgWdkYg83+ZgdDCxmqF61nk2msD
         t7Tl+Y5DcwhOXiR+RVZS9XD6H45Y8qXRdfQYfPmtkFXgQ5gj5+cDKwSObHBfIpT6V4xp
         iSowdcfvULbM8iaUjT1i6gXNxkVkY0h9mUWTMpJTz3QUgwGRhspQzuoXB4t5gqkY5vgo
         XQ8g==
X-Gm-Message-State: AOAM5306RQzGYrHK4M0MSNX18l3ix7Q6z4OsVyzz06c03Ey/Bweec8I4
        7PBtqDcouatOCK2VpeuPKrXHvQ==
X-Google-Smtp-Source: ABdhPJxQezq6YEXGwvgGJIGh/xG32FXNToJF3KRwkIcbaEuNSf5vCd8mqCG2RRAUXTX6XqrUVvhpPw==
X-Received: by 2002:a5d:9592:: with SMTP id a18mr30914809ioo.168.1629821501641;
        Tue, 24 Aug 2021 09:11:41 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id v5sm10014577iln.42.2021.08.24.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:11:41 -0700 (PDT)
Subject: Re: [PATCH linux-next] include:libata: fix boolreturn.cocci warnings
To:     CGEL <cgel.zte@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210824060702.59006-1-deng.changcheng@zte.com.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fe2fc07-bd1c-32bd-138d-a04cf4c5e489@kernel.dk>
Date:   Tue, 24 Aug 2021 10:11:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824060702.59006-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 12:07 AM, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> ./include/linux/libata.h:1462:8-9:WARNING: return of 0/1 in function
> 'ata_is_host_link' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.

Applied, thanks.

-- 
Jens Axboe

