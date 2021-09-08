Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9E403D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbhIHQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349719AbhIHQAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=SwP5RoLM1shtTU4HSgZQsYkY2N0VGaXBZeJzY4wZMczDQBg5NRN+bOu4BzULQ1ISL4wPyZ
        q2n1lwuR7OxnGUvKqygHAhVLrYnIsFf8y9/JYhkLFqb1shETAH2mCKAd+Duq56VJzmXmNX
        kkCguYstJyPoNjxix+g4Z0b+I5yKONk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-t-_KTspKN-yDSpcgZZfSNw-1; Wed, 08 Sep 2021 11:59:45 -0400
X-MC-Unique: t-_KTspKN-yDSpcgZZfSNw-1
Received: by mail-wm1-f71.google.com with SMTP id c203-20020a1c9ad4000000b002f8cba155ccso1268395wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=FW8EcxF/LtctPhOtkIgfrD0nRJQOo+pdq0XTevjQ7cV+sHCKU5lXQkVdYW1boKWvm5
         yi2ZeIDwnQ+SHu6gHJ1an/THg1n6t1DqwEIbvJLt76VHVHoEN5LpISlGTuYeCUn02dwa
         54OrJcffF4O8Ndg4XSvSypI7pv/+F3rO/lOX25UvQywIjbn6mhbHKg3j1EPEd+5hd0t7
         CiI2NPgjuHrzNUj8bJ7l9WC1afqwS3mFT3eqU0Ep5HmT+r5pC9L8FDOx7Xm/yWBDrhLh
         pUitLBEk8Ezt2M+9UYldZLUZpuBWIpe3LFA3gEj6dEPKQkjhZ31QnUCN7B0zB9JPXhyd
         S1TQ==
X-Gm-Message-State: AOAM531dBx2SwKXuoEMziMgwWOnhdWe5xduoODjQD2UWrb5aack/MviR
        6575V7fl5FdVVLzly0+p/EJnb5w5qOkEpapHFdosqNGf0MPkWAautPG3/Ey0DGNQLaREwVG0iqZ
        EvAy8JQz0nLf+sn2jeMQ99op3
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057154wrc.14.1631116784252;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbV4MVn6sYe3duHRKvKFgkXf7OfAeyy0HcyFVucgkBnamnZJUt5EmSeR3LM818BjuO31ao5Q==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057132wrc.14.1631116784080;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6125.dip0.t-ipconnect.de. [91.12.97.37])
        by smtp.gmail.com with ESMTPSA id g1sm2745480wrc.65.2021.09.08.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:59:43 -0700 (PDT)
Subject: Re: [PATCH v1] hugetlbfs: s390 is always 64bit
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20210908154506.20764-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3f9d1394-600b-5851-670d-71f1ab13a88a@redhat.com>
Date:   Wed, 8 Sep 2021 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908154506.20764-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.21 17:45, David Hildenbrand wrote:
> No need to check for 64BIT. While at it, let's just select
> ARCH_SUPPORTS_HUGETLBFS from arch/s390x/Kconfig.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@vger.kernel.org

^ wishful thinking, lol

Cc: linux-mm@kvack.org


-- 
Thanks,

David / dhildenb

