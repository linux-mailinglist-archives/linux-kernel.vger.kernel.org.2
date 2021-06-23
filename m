Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513923B16CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFWJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:27:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:25:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m17so850351plx.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZT/7Ux0bhzXpS+rf3sIBrRKhCNZmq/T8COWEpsyT4vY=;
        b=jT/xShcVdMcKeL4oR84DmNjF8Ol0x/t28pcCP6UWjmojgFpGCDTaWbUhUey+D9/VjC
         Fa1Y1LWPaxwZ54WdnRJaxarvAujXv6r//5mDcLAh6xR8aB6179P598fcqJpgFw/O8e9I
         yTn+mPdLFKs3Hhdq5aEBdwyy6yLqfaIjFuu+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZT/7Ux0bhzXpS+rf3sIBrRKhCNZmq/T8COWEpsyT4vY=;
        b=kkX1SYDEPIklKBZyKaxve/o0Ed26a65QeozD+SrH5rjU6GmNlDD0GKwNgOhSUsHEDY
         UHLT7Ohh+Gb8K+wK7Olp8+bVmDeOS2PlIEUvyNo3zahhLgSYgKekA+U3r5p1ddhSOcSK
         4zYFCVVpp1zSSBSwTM1LcIGYfuLstdtYk2ldvkqJjc9bDx4ctGUelBfm9Oz0ncRS8Jwt
         N+XO/ASQMlkQLYZkRxHUAve1e+OpM5+mAMLAZ1VEDC49s/Vq91LnmwX2PVFQYJzso4YI
         MsKNjEaLg+Oe8gTPbICE0l0a2ey/Ja2kAhRB1/wKhbaf32QMHeL22wuIgF3t7aDKuOTh
         bgWA==
X-Gm-Message-State: AOAM533CQxAMnntf2pXIA2mcWl8E5neikou2i8O7fv8/clA3WISJ2hHV
        FyHS3jKbkgVmvIa+QU/mgVzjDQ==
X-Google-Smtp-Source: ABdhPJzbsZxUgHYE+5c9jK/6f3Rta4+H0JAMzKESDJRylXWtH/o0U6l0mxh/tTrGSKf7QzJuynjyCw==
X-Received: by 2002:a17:90a:ee88:: with SMTP id i8mr8603384pjz.71.1624440316495;
        Wed, 23 Jun 2021 02:25:16 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id u10sm1860501pfh.123.2021.06.23.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 02:25:15 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Subject: Re: [PATCH v15 2/4] kasan: allow architectures to provide an
 outline readiness check
In-Reply-To: <CA+fCnZdJ=HHn1Y=UDiYJ2NagNF9d-bJfjQa0jmiDaLiqneB_rA@mail.gmail.com>
References: <20210617093032.103097-1-dja@axtens.net>
 <20210617093032.103097-3-dja@axtens.net>
 <CA+fCnZdJ=HHn1Y=UDiYJ2NagNF9d-bJfjQa0jmiDaLiqneB_rA@mail.gmail.com>
Date:   Wed, 23 Jun 2021 19:25:12 +1000
Message-ID: <878s31hr0n.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index 10177cc26d06..0ad615f3801d 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -331,6 +331,10 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>>         u8 tag;
>>         void *tagged_object;
>>
>> +       /* Bail if the arch isn't ready */
>
> This comment brings no value. The fact that we bail is clear from the
> following line. The comment should explain why we bail.
>
>> +       if (!kasan_arch_is_ready())
>> +               return false;

Fair enough, I've just dropped the comments as I don't think there's
really a lot of scope for the generic/core comment to explain why a
particular architecture might not be ready.

> Have you considered including these checks into the high-level
> wrappers in include/linux/kasan.h? Would that work?

I don't think those wrappers will catch the outline check functions
like __asan_load*, which also need guarding.

Kind regards,
Daniel
