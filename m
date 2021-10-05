Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9B421B54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJEA7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhJEA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:59:32 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ACEC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:57:42 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id y28so7982633vsd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3DZPJUSQwIIwcPnyAkR1NQv0eMMiHcXMtz6SXNb7OxE=;
        b=3WOFksZy8ZZOIybnQMCGjrluGv5EQ4Ygdb6XCkoY8gV7RjahThEVHApn5Jjp7VnAza
         TVt+KiyxjgcbhbuiQh3QMNGjSeI6SDKnBWrYsScLXWa7WV1YkZguNq83rcOzasY7lDIF
         /tdT/vbJUS3WqDmgUIeh7SuCp78FA/65OSGOYwBvBxq2Crvyye6Bf4ZHX0iKcJVC+YjW
         kql5Yr2axPjMehM48whKIh2Qn0rldDk1O43L/lfrtANCWP1rEZ/CRXp1zL5KxJ1+mRjs
         PxGme7xJqw81yAoF8gIDofh5BFycCFl5zfFJkcyvJNzzgxMnWfpyaOXy3ME2y55uUjFI
         8e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3DZPJUSQwIIwcPnyAkR1NQv0eMMiHcXMtz6SXNb7OxE=;
        b=zImuBxWa4KTjB5DxO3kB9xERT6cE+N7BGj9+GSQMD9p20fgrWr05BbKxJHSsXewEgE
         lBqCaUDF+DZSriUbwhEQbLbZWf/mRUgINkUDW7jt361xGuCZDpCAIaltR0hgB9pMxa53
         02jSVrWKIAz8VEeCp+hn2kycMZR2BdkV3PmVbAhFXx4zdLJCdQh6753uIrP/A9GidduO
         ApTe0pKtYfz33Hxe8l0+vh46j4RdGeExJiwMQPWMKEncDRqehVlmgHEGDzJGEOrTAP9z
         IDKxdc6Yx2L7Kuu2RXyII2sjhp5IHMs/HJJ0eUXK1ik49Odntv8tQm9Za4OIXv4RvK18
         RADA==
X-Gm-Message-State: AOAM530qL4m3uY5UJH3yOVqOGwCTesDTyEof5HUaxO5Qi4opBSPSwJac
        WnltpEI3sjQNr90e2weNY7sJBA==
X-Google-Smtp-Source: ABdhPJzGUd4ZAFoZqSktNsK2dhWzWX17bSWZQSxjM2h80ka1/OxjD/4MCvt9MJ5Exlxj2RsdsdBj5g==
X-Received: by 2002:a67:d78c:: with SMTP id q12mr3535268vsj.28.1633395461689;
        Mon, 04 Oct 2021 17:57:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b3sm7872360vkl.6.2021.10.04.17.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:57:41 -0700 (PDT)
Date:   Mon, 04 Oct 2021 17:57:41 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 17:57:31 PDT (-0700)
Subject:     Re: [PATCH 05/10] riscv: remove Kconfig check for GCC version for ARCH_RV64I
In-Reply-To: <202110041750.C90595D1@keescook>
CC:     ndesaulniers@google.com, akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@rasmusvillemoes.dk, nathan@kernel.org, masahiroy@kernel.org,
        joe@perches.com, arnd@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-f7c38c89-4c50-49cc-9b9e-7089cb83a307@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Oct 2021 17:50:46 PDT (-0700), keescook@chromium.org wrote:
> On Mon, Oct 04, 2021 at 05:40:42PM -0700, Palmer Dabbelt wrote:
>> On Mon, 13 Sep 2021 09:23:45 PDT (-0700), keescook@chromium.org wrote:
>> > On Fri, Sep 10, 2021 at 04:40:42PM -0700, Nick Desaulniers wrote:
>> > > The minimum supported version of GCC is now 5.1. The check wasn't
>> > > correct as written anyways since GCC_VERSION is 0 when CC=clang.
>> > >
>> > > Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> > > Cc: Albert Ou <aou@eecs.berkeley.edu>
>> > > Cc: linux-riscv@lists.infradead.org
>> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> >
>> > Yeah, good catch for Clang too.
>> >
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> Only this patch ended up in my inbox.  Where you guys planning on keeping
>> this whole series together, or did you want me to pick this for the RISC-V
>> tree?
>
> Linus already merged this series (see d20758951f8f28c0ee1b2a8a6bb8189858083895)

Thanks.
