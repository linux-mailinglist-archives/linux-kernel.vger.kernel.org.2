Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAF357252
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354351AbhDGQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhDGQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:44:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4247C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:43:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so811569pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZXSquVdNTnJV6sENmFIy57LLxGa3DHW5OaRJtKQMEqE=;
        b=Q/eVLwdZeqMpOn6mWC3xedWa5aaBshfCet80piSYa7fI6XhvFrxJ0ZUNpLjWQfgIR+
         w22cV/konELrLQngdB+LF3HzOzvME7sLzyvGe5kMLixaUxLpl1Mln+nLuZRvVAOGARR1
         KSoROc1baZ6kEnBycVa89hg7LnhH0xttJco81BAw8FNe+iCqwkCG/6d7qITsmfIlUo1d
         cdOgpM0FNjIqixa5QdRDmJUo/yBh6wcZBQL6UfnLqZHERHgZqZXVmLHm7gJ13G+CgPse
         eJRvvLzDsG4/wZWBnpQmWbzg9CGw3CNCFhQb2wbdrgwJnDf2nOZLy4rfYWWe4VMKfh5v
         T42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZXSquVdNTnJV6sENmFIy57LLxGa3DHW5OaRJtKQMEqE=;
        b=ehXl7o9j/uDfbRcKorcXLVCsym7oZ27z98o7yZ15M250GvcGTLmwdu5LLG9lnbB2JC
         IIzeHqUjb0DU7epQ9hvXN57vs4AAChw9FjQoirPhVbzdljxEBQAyZd8WZ3SFHGmRitwA
         emruAzx2YvwP+zHZtw8Jv+kUUY1IzxvhJT70c0I6EuFSAo5yIKsJJq0Np2CRnMgDXwvF
         Iw5qqQrFD4w5PaamA2Xdv6c2jGq9cg8DAbAE/SQpDbHBwBoOhrxxVsRNZgtuKb1xBZ71
         QyL2IPVHxsmkntPeCWHHq7XlmUew/KLKx6kic5qKSo0K8cAFVJr4nJ2GcbBNIakA49l3
         SuUw==
X-Gm-Message-State: AOAM5302snCND216WOYNANzCWgrIJDFrNd+27jyUbLnj2DtI5cDzebJl
        5SjSjOokK3pYVtNXxrotC+ECDQ==
X-Google-Smtp-Source: ABdhPJw8Y8AnmgaJ1lgzk3/bpLg0ktvFBPC4tvE7MOQ13QiF3fO59oX5L95aNliexL6KjcvynBuNnw==
X-Received: by 2002:a17:902:8d85:b029:e7:1029:9114 with SMTP id v5-20020a1709028d85b02900e710299114mr3853158plo.42.1617813835289;
        Wed, 07 Apr 2021 09:43:55 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m1sm6045239pjf.8.2021.04.07.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:43:54 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ata: Drop unneeded inclusion of kernel.h in the
 header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
References: <20210407134706.81383-1-andriy.shevchenko@linux.intel.com>
 <202104072325.Zv0JLqbH-lkp@intel.com> <YG3X7ogK/Oq2Hv4J@smile.fi.intel.com>
 <5111151e-35a5-0422-8414-7b900f01d316@kernel.dk>
 <YG3ddNiPdUgRmBZc@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <728ec7f8-310e-e478-bd53-8784392aee25@kernel.dk>
Date:   Wed, 7 Apr 2021 10:43:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG3ddNiPdUgRmBZc@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 10:27 AM, Andy Shevchenko wrote:
> On Wed, Apr 07, 2021 at 10:04:49AM -0600, Jens Axboe wrote:
>> On 4/7/21 10:03 AM, Andy Shevchenko wrote:
>>> On Wed, Apr 07, 2021 at 11:51:31PM +0800, kernel test robot wrote:
> 
> ...
> 
>>>> All errors (new ones prefixed by >>):
>>>
>>> Thanks, we need to include bits.h.
>>> (It passed my simple build, but appears I have no such driver included)
>>>
>>> Jens, I saw your message, should I send a follow up fix, or a v2?
>>
>> Let's just drop it, not worth it for the risk imho.
> 
> Does it mean I may try again in next cycle?
> 
> Because kernel.h inclusion seems to me too wrong there.

I don't mind taking it, but not on a hunch. If you send something
that has been thought about and went through full compilation, then
you can resend it.

-- 
Jens Axboe

