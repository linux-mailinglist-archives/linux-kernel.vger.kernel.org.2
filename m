Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D203AECF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFUQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFUQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:03:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF34C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:01:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m14so2979122edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJINl3ujyElFF79o2Vp6G7gTRrWKDKDmi7XTzlrNQuo=;
        b=fux+ZPc4AJRwDv70FuZ0/eTKAWRBdJbvBe12avwC7WTFmYx9RXoAqtQU3b92nmYgrr
         SAdaZx9qV85GN85nhBVX+bXhD8cjIE1c7yZXOCdtFgC64PdrqkdrHZ4s9Pa9uUNzSSgI
         V0ng5OzjTjNJyHr5MhxRopH7B3RZ+atucD4TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJINl3ujyElFF79o2Vp6G7gTRrWKDKDmi7XTzlrNQuo=;
        b=nTzKMCJRqllaBqtvk2FgiorCP/ET1HGIDf3Zu5A4LGnHVCLSot6h76EEnUqGUyx1tI
         usl/i5W6QajCpEChWYJ20+L0Tc++M8qzmxRlGSXbhTVYzeuBVNkCtrwb365zVTA62RJN
         c3s8Hp+KrhIMyc136yUHjILTAYEZpaBwesxt1bX89LT8FXBRgFpz6YJRInzRer2kBiKt
         fmze+DMfM7zBHzYfVtWmGgyN8UD0dS86jsk8/f0hVUcaG/paPywJ+TZJ0KP7UKjRXHSU
         VB3N8iVbMvtXsrZ0DmswQotDzzWT03mI2oC+NB3Rp1P6NCmmw+8VoiTR5c3TIQR+P4RE
         fulg==
X-Gm-Message-State: AOAM530M5NyhkuispTtp92FkzMa52mSv3jl0r4lJlC5LkyG6KRDMMckb
        nLq/7/jPpcqf/qy2XnfRPp+IE1D/IjB+WQ==
X-Google-Smtp-Source: ABdhPJwIgu6wJ+DzjSb7rdWV8o1Xs362qySHLk/qlWURN5a6En6I3SxbPcwZ4LzhQNQ5OVfTUT2cuQ==
X-Received: by 2002:a05:6402:1911:: with SMTP id e17mr22488554edz.62.1624291279115;
        Mon, 21 Jun 2021 09:01:19 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id h16sm10666590edb.23.2021.06.21.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:01:18 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: __alloc_pages_bulk(): do bounds check
 before accessing array
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210507064504.1712559-1-linux@rasmusvillemoes.dk>
 <20210507102634.GD9524@techsingularity.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <387ca68d-7c59-b316-7d95-cf13a3b26770@rasmusvillemoes.dk>
Date:   Mon, 21 Jun 2021 18:01:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210507102634.GD9524@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2021 12.26, Mel Gorman wrote:
> On Fri, May 07, 2021 at 08:45:03AM +0200, Rasmus Villemoes wrote:
>> In the event that somebody would call this with an already fully
>> populated page_array, the last loop iteration would do an access
>> beyond the end of page_array.
>>
>> It's of course extremely unlikely that would ever be done, but this
>> triggers my internal static analyzer. Also, if it really is not
>> supposed to be invoked this way (i.e., with no NULL entries in
>> page_array), the nr_populated<nr_pages check could simply be removed
>> instead.
>>
>> Fixes: 0f87d9d30f21 (mm/page_alloc: add an array-based interface to the bulk page allocator)
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 

Andrew, will you get this to Linus before 5.13 is released? I got a mail
on May 9 that it had been added to your queue, but I don't see it in
master yet.

Rasmus
