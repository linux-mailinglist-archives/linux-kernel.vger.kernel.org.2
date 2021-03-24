Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA46348466
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhCXWNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhCXWNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:13:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A675AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:13:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q29so34136696lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E5EF3+3G1pSNN3Vz+zg1CDDR54BRucBQmvRe9cDEpR8=;
        b=IBv0B9r4ZSeKXc64Nc4HJ+1nRa9RRuAsa3xZeZwLdMOgMBLRLMTFYL/N6wlhKHjAMs
         hddD91lWO7phpnAF2LYWBKutkcRc/rKQCDDNCZZ1Ry10BZegVRIZNw6mDjK8l+nV+1B4
         UAootwjzIBABQXQX8htpDIsMQL5WaJwvfu7MVvM2ZGdjOZXrTDvyPDM8jXEO706MZCGq
         g5cNOZ07F6Lp5RPwKoA7Eoqru/SP7O02rTrnwWWiJ6HqWfIx+ynbDa9nUFreHOfPBF6X
         z84pBvqLokS2GbcM3BhWdxviOMlJjJReChfG1VEKkeQFEzcYHL+/+/N7JcDTKTDcrrY0
         giOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5EF3+3G1pSNN3Vz+zg1CDDR54BRucBQmvRe9cDEpR8=;
        b=DCb1oriDoYO5Rm52cCyF7JV19yp6IQlx7zjtnfqQ1NI4TgKiBxZGvwDcggA7QebaEC
         Ky6eU++jRJUI49c9rZTFOoc8o3ywRIqd5Z/HfG646Nrsmsd43S0A7qpSAmC3fClBnMeW
         Ojw9GQ8Vh/h6uXt7t+NSnLqEqgI6FoUa859kI3cxnam9DQEk1F4+gQcYBVMok47Xs1Z2
         jNcBpoDSqoxCnr/xyZLfjjbfQS4NO5NgnIMny85+GRPCmi88qjdOJTfRR/3oAZYexpiW
         CU6OKbaor22/4zPRa62/CAp+oI9BIYQH/4XHMX108wgczAWNF/tyMh8Lc9sa5DoHeIbV
         +CSw==
X-Gm-Message-State: AOAM532OSY6fcq42P8FdpRaTXFRl80wB0AfKLH9+EQNEz4hvniDGf01U
        l3ApRikKk7GbExOoQXcW5B8=
X-Google-Smtp-Source: ABdhPJzezBSMioh74r3e4fXxnre83j5GCODMtwXav8+0cEFFKx4IshGnNxwHlcAVGkl2g3FoCyyNKg==
X-Received: by 2002:a19:e12:: with SMTP id 18mr3316830lfo.296.1616623980213;
        Wed, 24 Mar 2021 15:13:00 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id e18sm462122ljl.92.2021.03.24.15.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:12:59 -0700 (PDT)
Subject: Re: [PATCH v7] mm: cma: support sysfs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org, Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <YFu1QoiPEnAOAvXS@google.com>
 <7d9ccfac-b705-8682-d05c-cb239c215677@gmail.com>
Message-ID: <2ddd2bf8-d610-a6ad-a56b-7ff66f1a535b@gmail.com>
Date:   Thu, 25 Mar 2021 01:12:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7d9ccfac-b705-8682-d05c-cb239c215677@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.03.2021 01:10, Dmitry Osipenko пишет:
> 25.03.2021 00:55, Minchan Kim пишет:
>>> There are no dereferences fixed by this patch.
>> Let me add this:
>> https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/
>>
> 
> The tag is invalid now, since you squashed the fix. I think you may add
> "Co-developed-by: Colin Ian King <colin.king@canonical.com>", but this
> also should require to add the s-b from Colin, if he doesn't mind.
> 

Ah, I now see that the s-b tag is already there.
