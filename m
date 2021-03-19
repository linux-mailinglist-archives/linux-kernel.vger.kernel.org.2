Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFF341DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCSNDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:03:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF2C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:02:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v8so2930868plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wXHovB37a0QJHpx5DUoWt2sw0VIuG6bxED3Ql0+897M=;
        b=dgkAcgdbSkOYSSr8ldJ806F0J+eQwwbrjvnIZoF65DbRuswwFCq4Q7s/bSdjLikATT
         U6F7dr28dS7cPEA34QgkivHVx7GcCFY1vkWdTMkxteN1o1PG4ctJWTh37ULXZxnMCVnM
         Ei/ofXhNRPE+sdw9UZNLjSB7kP2c8n5CLlN0mOcZ5V79FbPOexLt9MbHA9VMyHewyHUI
         xo6MSNKB0Bp1/2Vu8wBx51IbPEdVWE6RXgJtiCf8Ve5oupefeGICk1mvl/c7Gzz+zTPj
         4H/MlVI+vygFfFeC+DcgWx605m4jNTkycjOlBEdfDNV3c8q8DpNEr2YooIH6y+ZkBh+F
         P/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wXHovB37a0QJHpx5DUoWt2sw0VIuG6bxED3Ql0+897M=;
        b=ocS5k0vUF1tkC/P/pKxw8XTJEeJEKo0yhEHoH7/bFMRk2jqMQif/XfJUpJ4DVulKmq
         HOFHk8FjKZXCMafSzV87JcccqwphqJJtSLbMg2nSlEbw+h1sn1Xxla0LD9jX0tLBf/e3
         z7i7DriJLidRfIFW3P8sDOUPF5uXm5/Yi48Eu9pqguCEJcrl4QulLuUIrc6DFuIHC597
         iPdmmhXmLZEQqfKH34McB2NZz8wHAd1FOu17SQEPgHYT8dKJVCip8AbelBAz0zpLidxq
         pGoeito5GmQB3krypSpTDOpJTtp3YGF2o40/SiHQywg2LiG0BYdx/aLNBrjX4XBOiBRj
         onYg==
X-Gm-Message-State: AOAM533FOs4JMqthYMRMXRNIaEBO+GhayQa57AjuYtAPAKXHGfypsd5m
        NknxjbOEsVyuqxoEeBaO2663Hve2O4cH9A==
X-Google-Smtp-Source: ABdhPJxqNPs1177EKKmSattFT9ashy1tucFtFqMtHD+DZe1PbSmsJK8pSMzFDSIMsKhp+cfgYZJFsQ==
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr9665158pjx.102.1616158970239;
        Fri, 19 Mar 2021 06:02:50 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ms21sm5618365pjb.5.2021.03.19.06.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 06:02:49 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
 <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
 <20210319094759.GH2087@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f30c726-6351-6c70-bc8c-6a0aaad4d0a4@kernel.dk>
Date:   Fri, 19 Mar 2021 07:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319094759.GH2087@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 3:47 AM, Dan Carpenter wrote:
> On Thu, Mar 18, 2021 at 02:42:33PM -0600, Jens Axboe wrote:
>> On 3/18/21 2:24 PM, Colin Ian King wrote:
>>> On 18/03/2021 20:12, Jens Axboe wrote:
>>>> On 3/18/21 9:16 AM, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>>>> however currently it is the lo->lo_number that is intended for the
>>>>> loop%d number. Fix this by adding in the missing max_active count.
>>>>
>>>> Dan, please fold this (or something similar) in when you're redoing the
>>>> series.
>>>>
>>> Appreciate this fix being picked up. Are we going to lose the SoB?
>>
>> If it's being redone, would be silly to have that error in there. Do
>> we have a tag that's appropriate for this? I often wonder when I'm
>> folding in a fix. Ala Fixes-by: or something like that.
> 
> I've always lobied for a Fixes-from: tag, but the kbuild-bot tells
> everyone to add a Reported-by: tag.  But then a lot of people are like
> Reported-by doesn't make sense.  And other people are like Reported-by
> is fine, what's wrong with it?

I don't reported-by for this use either, as that is a lot more
appropriate for a single fix that fixes an issue that was reported by
(duh) that specific person.

Fixes-from seems a lot better.

-- 
Jens Axboe

