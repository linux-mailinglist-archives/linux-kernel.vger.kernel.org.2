Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DC53CFBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhGTNdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbhGTN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:27:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CECC0613DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:06:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u1so26206972wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Y7wO3FmEg9E/e/M3ZFiJFbsJXbUsTlhUr/Aisk4F7w=;
        b=lu1K4wCxmYTUEOAY0h4I+WRyY+GjDf9LqwrVn+apJAj+WQ78hw81zzGUFuz1g6DyzD
         3qjJUaBpmVOpkjVoLyrsJ2/Kc4LH4ZGWlBAJBu8wuvbeO9zuoda9yFQQPBdkmxhJI57J
         9VQmX8jPbHoZj/VB7XrOzE3R+N9O+zOSAI7IxpF0zzQLSaRhHjq8GzHtSuJWqOGYohS5
         iImsZnRyOb/OjnPNtGHUwhR/fTpzZYbAWb8D6BlLVXBC2tA6VvwBF6tRNsDr7dRJvWtC
         LPJTPTIGzM5jGa8K4Ylulif0sIoiFM/LeO/syFCA9ksIL6oJCzEirXmlegbA9itahNlu
         HDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Y7wO3FmEg9E/e/M3ZFiJFbsJXbUsTlhUr/Aisk4F7w=;
        b=g/3BZE2hNCiLe4GN/NfZw9aSA4/tJvBpZh98J5/JPwtyW+Zy5tOZfTyWH+leSR7sIk
         3VGXNiQO/r7sJTa8DkE9KjFwJwuna6zLohpAscKcSBIh8HaIp2AafwdA+SeXZSLsgK9+
         M5glPcigONnNVMLXkEMauSt2N4AylzOM45AqWu3hpzwc8SehefJiZfl+BWcxR0dSXn+m
         A376fJylg2n+wwytpG8D27D4NAI18+urltkskwyl1G8+E2xCwPHMkSYNPzfNs3iYrQHv
         4RrAcXPJD9QH7y5Rwh5KF5Q94jXEM0ZBpD5D2lC/7Ujog0FAA5Ozv+HRSEwC1KATS9NB
         X9BA==
X-Gm-Message-State: AOAM53250oFkLEaKuBQwgei2XVz+qDm9RDxO0c8ETjmRrkl2oAWtN/Ld
        mcx1cm585FZRpjkPCjg4jXm1dA==
X-Google-Smtp-Source: ABdhPJxjEWqFqQoktHsVZL6arngMcaaXABAJUgOrUrQFloZHgHwZpBl3SXOVE0HVVWN1F/G91ZiY9Q==
X-Received: by 2002:a05:6000:154c:: with SMTP id 12mr36606989wry.393.1626790009958;
        Tue, 20 Jul 2021 07:06:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ffa2:b757:e72a:11dd])
        by smtp.gmail.com with ESMTPSA id d8sm24562783wrv.20.2021.07.20.07.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:06:49 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:06:46 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH 08/14] KVM: arm64: Add support for tagging shared pages
 in page-table
Message-ID: <YPbYdtRx6dMH52oO@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-9-qperret@google.com>
 <CA+EHjTwmmV6EooG+Ykbso3G6nkjq=sbRzXH3vetazzPF5mO02g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwmmV6EooG+Ykbso3G6nkjq=sbRzXH3vetazzPF5mO02g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 Jul 2021 at 14:48:09 (+0100), Fuad Tabba wrote:
> This might tie in to Marc's comments for using enums, but
> consolidating the translation between prot and ignored/software bits
> in one place would be good: thinking about patch 10 as well, where you
> get the prot from the ignored bits. Even though you have documented
> it, I'm finding the part where a field can be borrowed and shared as
> opposed to being only shared not very intuitive, and I need to reread
> the comment here to remember the difference while going through the
> code.
> 
> You also mention lending as potentially reserved for the future, but I
> think that lending is the other side of borrowing (depends on who's
> doing the giving/taking). I wonder if in this case it would be clearer
> to describe it in terms of whether it's exclusively owned vs owned but
> shared (for the owner), and just shared for the sharer...

Argh so I actually found the encoding pretty neat :/
The idea is the following:

  - an entity that has a page mapped as SHARED in its PT means it
    doesn't have exclusive access to the page;

  - an entity that has a page mapped as BORROWED in its PT means it has
    access to a page it doesn't own;

From that we can build the states we need:

  - when an entity shares a page with another, the original owner gets a
    SHARED mapping, and the recipient a SHARED+BORROWED mapping.

  - and in the future when/if we implement lending (which means an
    entity gives exclusive access to a page to another entity, but
    retains ownership) we can map the page in the recipient as
    'BORROWED' only, but not 'SHARED'. And the original owner will have
    an invalid mapping with a new state 'LENT', which is encoded with
    both SW bits set.

How does that sound? Did you have something else in mind?

Thanks,
Quentin
