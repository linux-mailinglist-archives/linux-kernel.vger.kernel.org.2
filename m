Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9441E81B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352188AbhJAHQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJAHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:16:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5BC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 00:14:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h3so8607456pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hQ5Dp9x0o7vj9OmS5x46emFCr7Zl/nJolk9+Z2BpJ/M=;
        b=fe9H/w2X2vuAp8bhFAjKcirq956EvG0Xsc4F/qPYLCr7shEcx/7zVRCvPxYTKIseYq
         cM0bGEaE6AOBmeVWMByscucDo3qj28Mo1bYpVvfDkpGyt16RzahFoQ3vLK88+7PljDI8
         g4xwbvUg0m6Q0tlQhV1A905dnxfllF0FbKG5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hQ5Dp9x0o7vj9OmS5x46emFCr7Zl/nJolk9+Z2BpJ/M=;
        b=obOK4BlX9Z7xTPmicrAY4UqHd54PIW8pP5jbijKJ0OpvMbQRsqwrLtJIE0rv8WGlXA
         +6BRU1pblenBZYv8jI7Q6W9rVShghLub4zr6OugwpmuIt0Vp4LJOletJNAe/Ns4sD8VB
         C2GTCUnFJt5hAxQD/YSXegaqaaJIDxqGG0wFdFcQpOnHOoSHJiyDrE2N3qQyNOTOsr9T
         T95LofCz+G0RIbnJY3ohcCKlFhTXzZ9WMjXtC9NzwSizJ+GEgG4yxayU4bcFSq3KUQ4N
         ppLTm9o9Pu8G/OsQU+zBOzIt26IZBwEOHiszXBViYzUgAzpu69q2J+ytkrz+zRm/v4P2
         cnmQ==
X-Gm-Message-State: AOAM5333maTIZvzqmUt/nlbEqeIrdGtRekI9VxgLiFrAPdIsBBIEgfhG
        iUlFwXeXLBHx14an4q3Z0GkPjg==
X-Google-Smtp-Source: ABdhPJybs5wSHjwxNYuL3Oj52Xlb/bebURrnTQ6GT1WSxewTOdLpU3woiWbsUUuDzK3q3lC/kp1vUA==
X-Received: by 2002:aa7:9a0e:0:b0:44a:3ae2:825c with SMTP id w14-20020aa79a0e000000b0044a3ae2825cmr8564635pfj.28.1633072484450;
        Fri, 01 Oct 2021 00:14:44 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:c98c:9868:6328:c144])
        by smtp.gmail.com with ESMTPSA id k12sm1219967pjf.32.2021.10.01.00.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 00:14:43 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/4] mm: Make generic arch_is_kernel_initmem_freed() do what it says
In-Reply-To: <1d40783e676e07858be97d881f449ee7ea8adfb1.1633001016.git.christophe.leroy@csgroup.eu>
References: <9ecfdee7dd4d741d172cb93ff1d87f1c58127c9a.1633001016.git.christophe.leroy@csgroup.eu> <1d40783e676e07858be97d881f449ee7ea8adfb1.1633001016.git.christophe.leroy@csgroup.eu>
Date:   Fri, 01 Oct 2021 17:14:41 +1000
Message-ID: <87ilyhmd26.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #ifdef __KERNEL__
> +/*
> + * Check if an address is part of freed initmem. After initmem is freed,
> + * memory can be allocated from it, and such allocations would then have
> + * addresses within the range [_stext, _end].
> + */
> +#ifndef arch_is_kernel_initmem_freed
> +static int arch_is_kernel_initmem_freed(unsigned long addr)
> +{
> +	if (system_state < SYSTEM_FREEING_INITMEM)
> +		return 0;
> +
> +	return init_section_contains((void *)addr, 1);

Is init_section_contains sufficient here?

include/asm-generic/sections.h says:
 * [__init_begin, __init_end]: contains .init.* sections, but .init.text.*
 *                   may be out of this range on some architectures.
 * [_sinittext, _einittext]: contains .init.text.* sections

init_section_contains only checks __init_*:
static inline bool init_section_contains(void *virt, size_t size)
{
	return memory_contains(__init_begin, __init_end, virt, size);
}

Do we need to check against _sinittext and _einittext?

Your proposed generic code will work for powerpc and s390 because those
archs only test against __init_* anyway. I don't know if any platform
actually does place .init.text outside of __init_begin=>__init_end, but
the comment seems to suggest that they could.

Kind regards,
Daniel
