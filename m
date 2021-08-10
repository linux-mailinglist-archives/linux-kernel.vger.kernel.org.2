Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CF03E8327
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhHJSqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:46:06 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:54178 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhHJSp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:45:56 -0400
Received: by mail-pj1-f52.google.com with SMTP id j1so34406710pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2A7Xr3+kVTUHpfrw1WstvnmHzqShBa9utLCU+wUZZE=;
        b=jr1krqJNRXo+ZIsiuN6kHE/3WUOBxgnn8H17TOHL3o/OUILmwAoW2IH8dWmniEIKLz
         eghxw/jkE1ljg18FDiCa6in5tSShKm2YQScuzMki5JU7iYtHHZCZ3MyQgd2nLEybL/hj
         AXRmxjo4MFz2dkEaSJSKfMJVQl4ztQ+0pMGz2+ywxJYMuhc6Uddm4KOXfb0XrBLxJhq5
         37Kqy+vTja7jDFvPvipmwjCKim7dOLgVGVYRz6I9+k3wWlLsbJK8ZGnWXGjbtU9s9B4Z
         I7ukCiRGc6pi36nQcI4mxJEKfkHQYAUPhMjiiT+UGvQkhMd+KJBWAJPZxn33SkEFFOSJ
         BnHQ==
X-Gm-Message-State: AOAM5303zWqsxJ2g2ptBln9g0bNert5gHm9lg3pBC41C0ui7KcNsLPyY
        fhXWQkMi9yI4Ox9LsehvnYY=
X-Google-Smtp-Source: ABdhPJyR7UyPWMfdByUXgCZn4OKhRsH5EOamwDqCe3woHhQDxACps6Xhh2JnoZE2gLwh0zTdYL2Udw==
X-Received: by 2002:a62:ea1a:0:b029:329:a95a:fab with SMTP id t26-20020a62ea1a0000b0290329a95a0fabmr25149198pfh.31.1628621134070;
        Tue, 10 Aug 2021 11:45:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:c4:6dc5:1d3:61fa])
        by smtp.gmail.com with ESMTPSA id h13sm5352434pgh.93.2021.08.10.11.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 11:45:33 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Christoph Hellwig <hch@lst.de>
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9b1e5c35-1d11-0afa-d382-6f5dc0b14a23@acm.org>
Date:   Tue, 10 Aug 2021 11:45:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810165029.GA20722@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 9:50 AM, Christoph Hellwig wrote:
> On Mon, Aug 09, 2021 at 11:31:23AM -0700, Bart Van Assche wrote:
>>>> +config CONFIGFS_KUNIT_TEST
>>>> +	bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
>>>> +	depends on CONFIGFS_FS && KUNIT=y
>>>> +	default KUNIT_ALL_TESTS
>>>
>>> Why does it depend on KUNIT=y?  What is the issue with a modular KUNIT
>>> build?
>>
>> The unit tests calls do_mount(). do_mount() has not been exported and
>> hence is not available to kernel modules. Hence the exclusion of KUNIT=m.
> 
> You should probably document that.  But then again this is another
> big red flag that this code should live in userspace.
> 
>>> To me this sounds like userspace would be a better place for these
>>> kinds of tests.
>>
>> Splitting the code that can only be run from inside the kernel (creation
>> of configfs attributes) and the code that can be run from user space and
>> making sure that the two run in a coordinated fashion would involve a
>> significant amount of work. I prefer to keep the current approach.
> 
> But userspace is the right place to do this kind of pathname
> based file system I/O.

Shuah, as selftest maintainer, can you recommend an approach? How about 
splitting patch 3/3 from this series into a kernel module (the code that 
creates the configfs test attributes) and user space code (the code that 
reads and writes the configfs attributes) and adding the user space code 
in a subdirectory of tools/testing/selftests/?

Thanks,

Bart.
