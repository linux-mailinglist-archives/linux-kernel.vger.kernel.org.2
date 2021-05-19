Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3143892DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354961AbhESPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:45:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354551AbhESPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:44:58 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljOMD-0005tg-8v
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 15:43:37 +0000
Received: by mail-qt1-f199.google.com with SMTP id a7-20020a05622a02c7b02901fbef073c99so3646204qtx.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/vgvmFQbf3VJCykpSF3jvpehXSRZj50bg2GrVxLoTg=;
        b=IkWs5gB89jvcVPKhnpgN31sED7p5xKQAV28zCLtyiSdOqfQni4Lg7hwqfozCThBeK1
         BUh7ST2fK7Gxm2omN2BvDCbWZ3ic5G1Lkb/UaA9GslOrNHGYeGHgvWj51ZJgspujJKir
         Iq/GP/PQBlQ7dQfEhNjoap5XI8RUtH0J+ACBDGnShYmbvPzQxpopKq1+Z+ua92+v1Q8s
         jjfuzoTjvEh4P8yYLxTuQcolkl4lVPmKtBBXO/784YETqXHHBPxKDyhsU+RU8q1vA2bX
         M862gMRF2nBc4cq/h7gGb3uje4CTmfeNDMzVHM7Y2Hmp8Pgx3XCiLXNWlUOKYlyZewn3
         u6Ag==
X-Gm-Message-State: AOAM5327mWnvixkzI0uaMy/BapnYOQD/HB0FKmdSq5sNSOI9a8Ccet9S
        l9B07iyfmzUd0gzHA873RwCTvOizr6ZZxwMf2YfjqG3VlKDT37jZ7Yk81iqDYjjfIH4yo7uD7b7
        WotWJTjhLIhr4c96nvijh3rQqng1cQa0uUAnELLUC7A==
X-Received: by 2002:ac8:6911:: with SMTP id e17mr5360qtr.135.1621439016397;
        Wed, 19 May 2021 08:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRf8Y6mo0WGOcOJQjevKMQ8QFLmQDDyMbnIOYMRU2B0qSkFYq7TEiaJkHZRiV9MWDg4gFQdA==
X-Received: by 2002:ac8:6911:: with SMTP id e17mr5347qtr.135.1621439016258;
        Wed, 19 May 2021 08:43:36 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id m7sm33085qki.67.2021.05.19.08.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:43:35 -0700 (PDT)
Subject: Re: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with
 hibernation
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>
References: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
 <892e685f-004b-88db-b1e6-a05c0c84b43a@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <42f47d7e-4bf8-22a8-c8b8-8fa5221f2cd0@canonical.com>
Date:   Wed, 19 May 2021 11:43:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <892e685f-004b-88db-b1e6-a05c0c84b43a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 11:38, Vlastimil Babka wrote:
> On 5/19/21 5:28 PM, Krzysztof Kozlowski wrote:
>> The documentation of DEBUG_PAGEALLOC states that it cannot be used with
>> hibernation, however the Kconfig entry would allow it if
>> ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.
>>
>> Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Hmm the documentation seems wrong, as going through history it was indeed in
> conflict only on PPC and SPARC.

Indeed, x86 was never marked as a problem, although text/info warning
does not mention specific architectures.
> 


Best regards,
Krzysztof
