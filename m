Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF984104DD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbhIRHnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239213AbhIRHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631950896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qZ0q7jGoVtY4ZMBCmaCJZ9Lj5o1dTxVecz62PCAbAM=;
        b=GV4Yu43iwupBB00aPiTe+5cRgrZjCRXqFEbsTzC7x/cVHzD9lVG8wM59r2su68aEwPdF8A
        /6b2mMCBnhZh+QBXN3hU5J15Cw9G0dz0THiEKkbEWT6oXzagEB3HfQ3F609EyJ5wIW56ba
        a6nMQTvJw48cH8ZDVfTe/NEwc6A8NIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-lgPjHCDjMCaZpU1xxdLqbQ-1; Sat, 18 Sep 2021 03:41:35 -0400
X-MC-Unique: lgPjHCDjMCaZpU1xxdLqbQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so5862820wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2qZ0q7jGoVtY4ZMBCmaCJZ9Lj5o1dTxVecz62PCAbAM=;
        b=mRGfTFif6bO505RzPNu5r8hpv1Gk65GqXZz0xvYQl8K2hzxAr+4ScVRFtozykQ7WSM
         Uh0vwcmSdLGs0Hg0ET6Qr7Wcv2k6iG0SzlienRGvXzwqEK9lPFEiKTH/x3vGCjE02ieF
         WPmvLqBsgMejnGF/PMEwM+nGcr6vfWCVvbuZe0T7GqQcQNgLsmDGfkLs/N0BSkxZIxIE
         tqzoTrWCRd3EPHSSPGjDSeMZAN0xPRbTM0NvQCGaGKDE6buMPO/UodF/J5BeITL2b2Co
         +ZetHRSMkEtuBIHe4lIFtcTyagORpwNQZRIPexjq+miVZl6dkdmlg6+NH0eqtGB8k64e
         H1ZA==
X-Gm-Message-State: AOAM531zBSoLXKN+uWQ/fBRwdIHRDV6UTcYnwZCkXjg5jYMtNaRnKMaM
        sCeVCAMLbAnSHkzQIGZ3M+fr4aPfOnFfZPx5TGqrP6hf0hDA1r9JVyxOGriveydGxGeoQBp4AQm
        yvvLETPJVUrEPBOwmh6s9pKGjT45VfwV1Y/oj+K/k0FXkDlJESz8oOTsPUTBAHzJ6h28pxGeh
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr16527971wrs.11.1631950894074;
        Sat, 18 Sep 2021 00:41:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4r8qudiCLtIjJjNNObukZbXRKOnQLf9a3sX6t647z9DO2vB28aagV4kROBa4Dq9CRulEp4A==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr16527941wrs.11.1631950893753;
        Sat, 18 Sep 2021 00:41:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff239ba.dip0.t-ipconnect.de. [79.242.57.186])
        by smtp.gmail.com with ESMTPSA id v8sm8995164wrt.12.2021.09.18.00.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 00:41:33 -0700 (PDT)
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: selftests/vm madv_populate.c test
Message-ID: <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
Date:   Sat, 18 Sep 2021 09:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.09.21 00:45, Shuah Khan wrote:
> Hi David,
> 
> I am running into the following warning when try to build this test:
> 
> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>         |  ^~~~~~~
> 
> 
> I see that the following handling is in place. However there is no
> other information to explain why the check is necessary.
> 
> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
> 
> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
> 
> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
> 
> I do see these defined in:
> 
> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
> 
> Is this the case of missing include from madv_populate.c?

Hi Shuan,

note that we're including "#include <sys/mman.h>", which in my
understanding maps to the version installed on your system instead
of the one in our build environment.ing.

So as soon as you have a proper kernel + the proper headers installed
and try to build, it would pick up MADV_POPULATE_READ and
MADV_POPULATE_WRITE from the updated headers. That makes sense: you
annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
that doesn't support it.

See vm/userfaultfd.c where we do something similar.


As soon as we have a proper environment, it seems to work just fine:

Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@vm-0 linux]# cat /etc/redhat-release
Fedora release 36 (Rawhide)
[root@vm-0 linux]# cd tools/testing/selftests/vm/
[root@vm-0 vm]# make
make --no-builtin-rules ARCH=x86 -C ../../../.. headers_install
make[1]: Entering directory '/mnt/linux'
   INSTALL ./usr/include
make[1]: Leaving directory '/mnt/linux'
gcc -Wall -I ../../../../usr/include  -no-pie    gup_test.c ../../../../mm/gup_test.h -lrt -lpthread -o /mnt/linux/tools/testing/selftests/vm/gup_test
gcc -Wall -I ../../../../usr/include  -no-pie    hmm-tests.c local_config.h -lrt -lpthread  -o /mnt/linux/tools/testing/selftests/vm/hmm-tests
gcc -Wall -I ../../../../usr/include  -no-pie    khugepaged.c -lrt -lpthread -o /mnt/linux/tools/testing/selftests/vm/khugepaged
gcc -Wall -I ../../../../usr/include  -no-pie    madv_populate.c -lrt -lpthread -o /mnt/linux/tools/testing/selftests/vm/madv_populate
...
[root@vm-0 vm]# ./madv_populate
TAP version 13
1..21
# [RUN] test_prot_read
ok 1 MADV_POPULATE_READ with PROT_READ
ok 2 MADV_POPULATE_WRITE with PROT_READ
# [RUN] test_prot_write
ok 3 MADV_POPULATE_READ with PROT_WRITE
ok 4 MADV_POPULATE_WRITE with PROT_WRITE
# [RUN] test_holes
ok 5 MADV_POPULATE_READ with holes in the middle
ok 6 MADV_POPULATE_WRITE with holes in the middle
ok 7 MADV_POPULATE_READ with holes at the end
ok 8 MADV_POPULATE_WRITE with holes at the end
ok 9 MADV_POPULATE_READ with holes at the beginning
ok 10 MADV_POPULATE_WRITE with holes at the beginning
# [RUN] test_populate_read
ok 11 range initially not populated
ok 12 MADV_POPULATE_READ
ok 13 range is populated
# [RUN] test_populate_write
ok 14 range initially not populated
ok 15 MADV_POPULATE_WRITE
ok 16 range is populated
# [RUN] test_softdirty
ok 17 range is not softdirty
ok 18 MADV_POPULATE_READ
ok 19 range is not softdirty
ok 20 MADV_POPULATE_WRITE
ok 21 range is softdirty
# Totals: pass:21 fail:0 xfail:0 xpass:0 skip:0 error:0


Note: I can see that we are generating an /usr/include, but
I think <sys/mman.h> will default to the installed system headers.

-- 
Thanks,

David / dhildenb

