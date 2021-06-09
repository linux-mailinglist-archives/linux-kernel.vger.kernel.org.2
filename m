Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22553A1712
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhFIOYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237954AbhFIOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623248555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5ldgdL4oevbJpGhiyzWJtU/uw/xXI5crD+GIdVCm0s=;
        b=OJ1I9cYMFyz2F7ZV7o/1oUMyy3ieURQ1hM8IN5AxkRNkF90eazNjRq6pKZiqb1bVe2/hA/
        0MPz0Higt9Hr5lX7WdBwXo+Bk01iqKDVPSO1NlYXKrCCQiXWlfrc0WHStbqaE3TW/ipYF4
        fV5e/zDd6T/lljpjHg/MBiMAibStcn4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-2eltCnHxPpO2EDG-tjnMeQ-1; Wed, 09 Jun 2021 10:22:33 -0400
X-MC-Unique: 2eltCnHxPpO2EDG-tjnMeQ-1
Received: by mail-ej1-f72.google.com with SMTP id a25-20020a1709064a59b0290411db435a1eso4191154ejv.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5ldgdL4oevbJpGhiyzWJtU/uw/xXI5crD+GIdVCm0s=;
        b=oQxWtAyaC1mYSu/tM09LyX0c0XJyd2phRYHiAxgTfgvX7YtJibHg+PXAJ1oiSYXPgi
         hPMgQYtCykJ6At9iLi3MUttqqoDCDfzo2La81f2s9x2d4pRY5gti63gfX3LJuCpSyeWI
         5XyiNecFGyOL/o5LnrbNJZTDVJLppQea3OVHflk4eH8q7MVaY0LT8u2Ep4YojTHCHKaL
         G/mU4j2Ar75654fYNrHhrrf9gva6Ej1QkSf45i1oc9u8AV//a0zT8sHRkBKF75Tu7KNv
         ipOAkz6MKfphMxKGZfOk3ELbbeCNp8nrjWD07qbmD7UHui+pJKlbF6M/evdzSQJ2eMA2
         F0Mw==
X-Gm-Message-State: AOAM530JTiKLWjkw6HxBccKHMXOq0QnDdRDhamy3bPjVaRR9CFOzmZFU
        wqd7pxUZ8HE4MR2TRQvmNFEdGbWNxK2s48OeepQmedr0YdSaJ299gyVdSAUFgH8gywQP0uYvIMs
        Bv78PTD18ovLxC15TPLxP2Flnz6RMUXDaBr/OjrwJjDZk+7vXNt+AqXm/LqAJ80r9aJO71zQvWx
        D8
X-Received: by 2002:a05:6402:b5a:: with SMTP id bx26mr18821829edb.81.1623248551918;
        Wed, 09 Jun 2021 07:22:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx11VXiqLbrpgaiXY0p+/cIwMtuO441HX5rKo0DbOlN0/EysED/CirhOcdAkzYCw9skKMFqfw==
X-Received: by 2002:a05:6402:b5a:: with SMTP id bx26mr18821799edb.81.1623248551706;
        Wed, 09 Jun 2021 07:22:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y15sm1203116edd.55.2021.06.09.07.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:22:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] platform/surface: aggregator: Fixes for user-space
 interface extension series
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210604210907.25738-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8c006308-4e0d-d6a8-fade-f6025bd28256@redhat.com>
Date:   Wed, 9 Jun 2021 16:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604210907.25738-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/4/21 11:09 PM, Maximilian Luz wrote:
> Small fixes for "platform/surface: aggregator: Extend user-space
> interface for events".
> 
> Specifically, prevent use of an uniniitalized variable and drop an
> unnecessary initialization.
> 
> Maximilian Luz (2):
>   platform/surface: aggregator: Do not return uninitialized value
>   platform/surface: aggregator: Drop unnecessary variable initialization

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

