Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB042F7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhJOQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241221AbhJOQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634314561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANgdzEfwMZrY1f+S/Dee2vJfo07dffNuMOSQXHBbgTM=;
        b=cZucwVIMTofo+5lSGXaORkX4Wnzs1ZMT8/m80n/uotaQ+fY6z3GLwGNSUSE+1V1eEkOrum
        3Urrwkdz8cls/HDdNH1ucSrObBOK+KaVL5iuWud8vGrgf0W/IpJrcF0j6vFBV3nGKjLZeG
        Gh77Ba3s4dlF/lcJldoP1rH8DEJnXQo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-WImw8JpwMyqDymcVZp9l-g-1; Fri, 15 Oct 2021 12:15:57 -0400
X-MC-Unique: WImw8JpwMyqDymcVZp9l-g-1
Received: by mail-wm1-f69.google.com with SMTP id o137-20020a1ca58f000000b0030d89b84726so703514wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=ANgdzEfwMZrY1f+S/Dee2vJfo07dffNuMOSQXHBbgTM=;
        b=j85KBq21LU36umlhoGJus1F4xmMlCC1Df7Xzu0x0FYlDIHHV8PRBgl+QUXJYPfNVCq
         Rdj0XvdXkM5D9LeGlRM9Oex9VA6Ke2Yixk1tXfsQS+iRveTmcwnuQ6PKeZjHDf88EUAA
         FE5CtJCmkqSp4JSh2giiDWvxzUvuzw+/URd/9zeG/qvh7a8+11PJg8b/ipZDLmP2sDUW
         L0m8LnwIaSXbGjnqP/NvQFRsKFTEbLu/1wt1F0uDDzBb07qUkRxStGO3uHu+oSaZCIPg
         Dd+q+orGmE+qEokI9XOsvZDxuUextF8WJT3qUPDMJLBXwn3Ot0rVlShanFScJDKQ6+xp
         cwJg==
X-Gm-Message-State: AOAM530lpUfciqYJBeZwEXlR2DOcl2V7A7DWBPpnLO6aoxK0x8x8jiah
        0ucmlvSU+frhIDfW4TOq7etB5KcJO5MTMsDCPbcYvbqG0xOMSr+Ak3TZwOnrHM1a8gMeQN3xJG8
        xuJT8yRJ36UZDPHogq/W0y+5t
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr5628100wrx.195.1634314556692;
        Fri, 15 Oct 2021 09:15:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3N1pNaCJVqfelFG7KXwvyx7/In0lYArLCLnuuW+IkTXBKaIi/XKfmKoEQUNcPOE9pi6stUg==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr5628072wrx.195.1634314556482;
        Fri, 15 Oct 2021 09:15:56 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id 36sm4957641wrc.92.2021.10.15.09.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:15:55 -0700 (PDT)
Message-ID: <ccd3b3e4-6441-34f3-a099-392cda82cb8e@redhat.com>
Date:   Fri, 15 Oct 2021 18:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
 <77f4c6a9-141d-e103-7339-0055cc00f752@redhat.com>
Organization: Red Hat
In-Reply-To: <77f4c6a9-141d-e103-7339-0055cc00f752@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.21 18:06, David Hildenbrand wrote:
> On 15.10.21 17:47, David Hildenbrand wrote:
>> On 15.10.21 17:45, Shuah Khan wrote:
>>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>>> Hi David,
>>>>>
>>>>> I am running into the following warning when try to build this test:
>>>>>
>>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>         |  ^~~~~~~
>>>>>
>>>>>
>>>>> I see that the following handling is in place. However there is no
>>>>> other information to explain why the check is necessary.
>>>>>
>>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>>
>>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>>
>>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>>
>>>>> I do see these defined in:
>>>>>
>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>>
>>>>> Is this the case of missing include from madv_populate.c?
>>>>
>>>> Hi Shuan,
>>>>
>>>> note that we're including "#include <sys/mman.h>", which in my
>>>> understanding maps to the version installed on your system instead
>>>> of the one in our build environment.ing.
>>>>
>>>> So as soon as you have a proper kernel + the proper headers installed
>>>> and try to build, it would pick up MADV_POPULATE_READ and
>>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>>> that doesn't support it.
>>>>
>>>> See vm/userfaultfd.c where we do something similar.
>>>>
>>>
>>> Kselftest is for testing the kernel with kernel headers. That is the
>>> reason why there is the dependency on header install.
>>>
>>>>
>>>> As soon as we have a proper environment, it seems to work just fine:
>>>>
>>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>> [root@vm-0 linux]# cat /etc/redhat-release
>>>> Fedora release 36 (Rawhide)
>>>
>>> This is a distro release. We don't want to have dependency on headers
>>> from the distro to run selftests. Hope this makes sense.
>>>
>>> I still see this on my test system running Linux 5.15-rc5.
>>
>> Did you also install Linux headers? I assume no, correct?
>>
> 
> What happens in your environment when compiling and running the
> memfd_secret test?
> 
> If assume you'll see a "skip" when executing, because it might also
> refer to the local version of linux headers and although it builds, it
> really cannot build something "functional". It just doesn't add a
> "#warning" to make that obvious.
> 

The following works but looks extremely hackish.

diff --git a/tools/testing/selftests/vm/madv_populate.c
b/tools/testing/selftests/vm/madv_populate.c
index b959e4ebdad4..ab26163db540 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -14,12 +14,11 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include "../../../../usr/include/linux/mman.h"
 #include <sys/mman.h>

 #include "../kselftest.h"

-#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
-
 /*
  * For now, we're using 2 MiB of private anonymous memory for all tests.
  */
@@ -328,15 +327,3 @@ int main(int argc, char **argv)
                                   err, ksft_test_num());
        return ksft_exit_pass();
 }
-
-#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
-
-#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
-
-int main(int argc, char **argv)
-{
-       ksft_print_header();
-       ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not
defined\n");
-}
-
-#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */


There has to be some clean way to achieve the same.

-- 
Thanks,

David / dhildenb

