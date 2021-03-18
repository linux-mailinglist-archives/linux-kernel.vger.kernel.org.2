Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF7340F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCRUnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:42:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46651C061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l1so2212088pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWaSlg6oRWJqHUVbQpRW1jMSvQBI7bpCNdpPwyZ5tv8=;
        b=E5IBzCjxOylBWqbMJk+0k7tNFv+BhGw0bpB1rKkTnMVqomQZgrru2n5DE2ak1zFWw8
         vsL2fzTeU0zdwAvpDPu+D0nLASjWg5UgVDAklH3niWuqWsmxPqBRc1Nr4kUmZhZlHn/7
         u+P5qyDz5QnR2KiC9QqPCvboQAkGrsK6wq0EiLm9H0zUFoLxTIDjCn59Mzz1ifddar11
         zvIHPbQMNB+DePF0PU5tQ7sytS4dRaibhDjUZpIg/sZiel+Udaudzg8NEXzZVNBW88jZ
         wz5GXmV1P4GAOuj/7frp5jycae+fNSOslqw37zcLJ5HyApHwfRBLtiSLiBD6SGCMSDv8
         +v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWaSlg6oRWJqHUVbQpRW1jMSvQBI7bpCNdpPwyZ5tv8=;
        b=ItmOlqAgFslW90Gy6E3APGagX2M/8MsxObWRI45Qp8uBWTDIqI6QC41N5I7pJ2ldBR
         4KF7nIxXJcw9Xh6WjsPSA0gfLLFfJJNgIQY1oX2IQLICYoV7hI1UlGJSzAiYEUgMsmHW
         FYn1f/tP1ILNQnEboN5NUvd+gF9nK/rLvkWbg1K0IR11rUYDas7eSRyMeHfWEehuFSNR
         1gpf87WHY57S7vK5M7p/++Izf2iPRPndU2W09B82tbFNhs33y/derytTteHN1042k+2l
         fYJjwgsibHyGeiQing8sKaSYA0OxMvSxy2x2PDdz1D+IYMSTrw5W7iBep7SuvGaE/RCD
         qFaA==
X-Gm-Message-State: AOAM530kZelEKJfkDf9gnD5lsopxQ63EkaNfXwxxBbOoLQtAfNT2OOO3
        Dwi9MMcc36N+/1ltikTI47fWh8B3ExUXoQ==
X-Google-Smtp-Source: ABdhPJwottvNmX24kN/kLJmNJK5xak//3AaeHe0lM3N2xPXIsboak8d6CXZqWF+UEXJWS8xIonsk1w==
X-Received: by 2002:a63:905:: with SMTP id 5mr8396543pgj.337.1616100156472;
        Thu, 18 Mar 2021 13:42:36 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gm9sm3078201pjb.13.2021.03.18.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 13:42:35 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
Date:   Thu, 18 Mar 2021 14:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 2:24 PM, Colin Ian King wrote:
> On 18/03/2021 20:12, Jens Axboe wrote:
>> On 3/18/21 9:16 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>> however currently it is the lo->lo_number that is intended for the
>>> loop%d number. Fix this by adding in the missing max_active count.
>>
>> Dan, please fold this (or something similar) in when you're redoing the
>> series.
>>
> Appreciate this fix being picked up. Are we going to lose the SoB?

If it's being redone, would be silly to have that error in there. Do
we have a tag that's appropriate for this? I often wonder when I'm
folding in a fix. Ala Fixes-by: or something like that.

-- 
Jens Axboe

