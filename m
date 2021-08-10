Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001103E849A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhHJUvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhHJUvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:51:14 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE7C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:50:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c3so465716ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9J86AJkM0SgjMI5lLWkCNhr060Mfr5eCjO1FJrYPFI=;
        b=e361z9bIGL3trwA5MJqldspICgOpDYTB7FTTvuBcwYQqYom6u+KUW1dCBMdhHDPwUd
         u7f2ZaMQyF+BF+S8mrlygBQkS1I2KlbiMbUTsrL1UszMHkrCh/CUQfPH0zFS1Cpyt5g+
         tDQTZMRIa38r2rXTCMip7dw5FY0GWPnaK9k/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9J86AJkM0SgjMI5lLWkCNhr060Mfr5eCjO1FJrYPFI=;
        b=d2SXISLeFoUD3WR1lFbKYjjxa3E/JKBvE256Gp9jcf75RFXVSf/C3zWMDpxACdwyOD
         1HMr6jBrxQY89EJgaIw8Jkm5EiBLrTOIfOk8NHfi1GjWog7AX7Whxod07sk+m86PPvfX
         hthoqcE0nSu18JTqB+zxYtFSNSn6hTat3A8uEHGBSLiWkmwBPEXEDTzLyXUzk4Pi6nfn
         izTJ0KgVVwfh+WwKIvTnTZoXc+uBnNG/QbPUYjmPGE0g5luQH8ohc3gNzQ5tC2ssX2XH
         C5XTXUe6hP1skcwSvhSIqdoRuDFSd3cNcExzajA3OFsNxXD/E/wE/W7epybKi5Qru902
         HxlQ==
X-Gm-Message-State: AOAM533OlQcOb0dgaBADpyg1/QoF3Rmaa+81iBScJlR/2tXf4LDYPbBG
        Xf4af0laE+QhPhSRmpTqku7V6g==
X-Google-Smtp-Source: ABdhPJySJXGR110wRXGY3CxHwveH41AuwDZOY9qOKOY3DOI1vt3kZ0eId/Q33wXFrl1SZh743mmb3Q==
X-Received: by 2002:a05:6e02:893:: with SMTP id z19mr89633ils.237.1628628651848;
        Tue, 10 Aug 2021 13:50:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r8sm13285075iov.39.2021.08.10.13.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 13:50:51 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210805043503.20252-1-bvanassche@acm.org>
 <20210805043503.20252-4-bvanassche@acm.org> <20210809145953.GB21234@lst.de>
 <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
 <20210810165029.GA20722@lst.de>
 <9b1e5c35-1d11-0afa-d382-6f5dc0b14a23@acm.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e329b0a1-ffe4-9bfa-2bea-33e17da70f58@linuxfoundation.org>
Date:   Tue, 10 Aug 2021 14:50:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9b1e5c35-1d11-0afa-d382-6f5dc0b14a23@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 12:45 PM, Bart Van Assche wrote:
> On 8/10/21 9:50 AM, Christoph Hellwig wrote:
>> On Mon, Aug 09, 2021 at 11:31:23AM -0700, Bart Van Assche wrote:
>>>>> +config CONFIGFS_KUNIT_TEST
>>>>> +    bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
>>>>> +    depends on CONFIGFS_FS && KUNIT=y
>>>>> +    default KUNIT_ALL_TESTS
>>>>
>>>> Why does it depend on KUNIT=y?  What is the issue with a modular KUNIT
>>>> build?
>>>
>>> The unit tests calls do_mount(). do_mount() has not been exported and
>>> hence is not available to kernel modules. Hence the exclusion of KUNIT=m.
>>
>> You should probably document that.  But then again this is another
>> big red flag that this code should live in userspace.
>>
>>>> To me this sounds like userspace would be a better place for these
>>>> kinds of tests.
>>>
>>> Splitting the code that can only be run from inside the kernel (creation
>>> of configfs attributes) and the code that can be run from user space and
>>> making sure that the two run in a coordinated fashion would involve a
>>> significant amount of work. I prefer to keep the current approach.
>>
>> But userspace is the right place to do this kind of pathname
>> based file system I/O.
> 
> Shuah, as selftest maintainer, can you recommend an approach? How about splitting patch 3/3 from this series into a kernel module (the code that creates the configfs test attributes) and user space code (the code that reads and writes the configfs attributes) and adding the user space code in a subdirectory of tools/testing/selftests/?
> 

I am missing a lot of context here. I don't see this series in my inbox
except patch 2/3 which says:

"A common feature of unit testing frameworks is support for sharing a test
configuration across multiple unit tests. Add this functionality to the
KUnit framework. This functionality will be used in the next patch in this
series."

That doesn't tell me much other than what happens that it is a common unit
testing framework without explaining why it should be done this way.

Taking a quick look at the original message on lore - I agree with Christoph
that this code belongs in userspace. I would like to see the division of
kernel userspace.

Why do the unit tests need to call do_mount() - can whatever the unit tests
are currently doing can be done from userspace.

If part of the test code must live in kernel space then kernel test module
approach can be used.

thanks,
-- Shuah




