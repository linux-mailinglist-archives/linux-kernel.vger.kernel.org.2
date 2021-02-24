Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A160E324206
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhBXQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhBXQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:24:25 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B152C061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:23:44 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id s3so2683840otg.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=684/od4aoI7tUivsEmcNI9ejXIY4H+GNT4qxioC9VLQ=;
        b=rWSb/yoGyDxaAQaRvuXJmyD7n9rzEz502Y5Z3ClJBNBns7pS3cNkixUSsxdvX78Sep
         BO3cJHN3I1BuOgtUfqn5W7p0d+9BRavZPpGoW0cIlgknc9/Nyov5GWu+E+OaOJwlkuaR
         gfK/hmP+b8qC7Si76LZYM2j/yad1zqDCdKBgMMWnWGzsRAwQw5tbll/T6/FAdNLu15qg
         IoULVBM/YlXF6Z+DmsgOANHr1OITW+yTqZtpFagQS5pIGWjFtH3mkBgMVUBRrBlLzk2D
         mOLWh+fAyDYv+wVUTtce4v5+7N/SY7j/7Tu50IQO8fuN9COtBWoLtExt4K9hpAZlB53Y
         djIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=684/od4aoI7tUivsEmcNI9ejXIY4H+GNT4qxioC9VLQ=;
        b=Mm2dbNdFevsDm5SELLS79Db3YEeJYW16n7FRrahb5o20KiEfgnN2Fou9LZhFh9xR3u
         xrF96JapfCvZt+QDl9JGWy8IvC7d82xjCP8a2YBDaEBCwdiukmtlgrMl5OFkmXwIKZQU
         PMGKNpq+py0DGLA3TtLQWnqjvkvdeQGOvdeRhTQ8RwqTNs2KBRjNKCcEsl2q8WSvTCHA
         sqmzgT24tEX6hcgf8vuM99vs8a2Qq/gVInw4W98p7JV60ZzElBbzxMjL1/7LKf4bW502
         fzZqZzmfiQsfIAbbkk7fQXSiLzzHGs8ZsH82NrO1Iti1huToKeTODgWpcaxgzeR5wUiL
         tEXQ==
X-Gm-Message-State: AOAM531NkvAtFHXqQlkIwoxeMf5e6nJk+ch1annAvWe58LfRCvcTYCOt
        1Qii39fgk1PSReK4Hn6UrSPuAO5+L7c=
X-Google-Smtp-Source: ABdhPJytLcpbawYpYC+uO8fG5pvujfrumdvM5qM1F2X9rC8xN/Jl3DsQTFDMafPzEH2xyLi/3mMRWQ==
X-Received: by 2002:a05:6830:2150:: with SMTP id r16mr2284648otd.27.1614183823862;
        Wed, 24 Feb 2021 08:23:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v19sm478674ots.48.2021.02.24.08.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 08:23:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] init/Kconfig: make COMPILE_TEST depend on HAS_IOMEM
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        KP Singh <kpsingh@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20210224140809.1067582-1-masahiroy@kernel.org>
 <fa9d393d-1bc3-fc08-52dd-88e76ead97af@metux.net>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c609139d-2df6-dd68-a80e-19b531adda78@roeck-us.net>
Date:   Wed, 24 Feb 2021 08:23:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fa9d393d-1bc3-fc08-52dd-88e76ead97af@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 7:58 AM, Enrico Weigelt, metux IT consult wrote:
> On 24.02.21 15:08, Masahiro Yamada wrote:
>> I read the commit log of the following two:
>>
>> - bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on !UML")
>> - 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390")
>>
>> Both are talking about HAS_IOMEM dependency missing in many drivers.
>>
>> So, 'depends on HAS_IOMEM' seems the direct, sensible solution to me.
> 
> I don't like idea of hidden indirect dependencies. If a driver needs
> iomem, then it should depend on it. Yes, a lot of drivers might need
> to be fixed, but IMHO we should do that, instead of covering 'em up.
> 

Unfortunately that does not reflect reality, which was the reason
for the above two commits. Problem here is that the cost is not paid
by the driver authors, but by architectures which don't support HAS_IOMEM,
specifically s390. Driver authors tend to enable COMPILE_TEST but never
test on a system with HAS_IOMEM=n (and/or ignore test results provided by
build robots).

To a lesser degree, we see the same happen with 32-bit targets. Driver
authors often don't compile their drivers in 32-bit mode (just look
at 32-bit i386 builds in next-20210224 to see an example). Then it is
often up to others to track down and fix the problems. Fortunately,
there are still more than a few people who are still interested in
32-bit builds, and problems with those builds tend to get fixed quickly.
This is not the case with HAS_IOMEM related issues, where the burden
is on very few people.

With that in mind, the dependency introduced with this patch seems
to be a workable workaround.

Thanks,
Guenter
