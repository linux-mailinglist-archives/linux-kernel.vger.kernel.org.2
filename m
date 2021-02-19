Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0395931FB30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSOrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613745953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4c+qZYHckGTx1tTFDNJ70MwWPI4v8lbqr4E8l5bbSS4=;
        b=XVMqciK8Pbq9ZB+3ZN90YE18YbDJ1Ud82Tx+3tWI9hLBsijSNQlxk32WIqzK0/vQOozRg9
        Xvsryg7DupZaGq+AHT+VTW9iZ0KYrZcDV0xtz8CbvprkmmlGZ0dqzSTS4D/2bzZsZHli6d
        Xw+AHt4Y4rNEt7z13vYjLvLK09d0lwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-1acmZWfYNwaAHYpTRUjdiA-1; Fri, 19 Feb 2021 09:45:49 -0500
X-MC-Unique: 1acmZWfYNwaAHYpTRUjdiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BBCB3FFC;
        Fri, 19 Feb 2021 14:45:47 +0000 (UTC)
Received: from [10.36.116.11] (ovpn-116-11.ams2.redhat.com [10.36.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7255D5C1C2;
        Fri, 19 Feb 2021 14:45:44 +0000 (UTC)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Huxinwei <huxinwei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanjin <yanjin.yan@huawei.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernelci@groups.io
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
From:   Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Message-ID: <2a7ff382-1d35-0eeb-6fb6-bad37aa4c1d7@redhat.com>
Date:   Fri, 19 Feb 2021 16:45:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

On 2/19/21 10:54 AM, Hanjun Guo wrote:
 > In specific, we will start from the testing work, using HULK robot
 > (reports lots of bugs to mainline kernel) testing framework to test
 > compile, reboot, functional testing, and will extend to basic
 > performance regression testing in the future.

I heard about Huawei ramping up kernel testing from someone at FOSDEM
2019. I wonder if it was you :) Nice to see your progress and the company
stepping up to help with testing!

Would you be interested in working with the Linux Foundation KernelCI project
on submitting your build and test results to the common database - KCIDB?

We are working on aggregating results from various testing systems so we can
provide a dashboard, and a single, aggregated e-mail report to subscribed
maintainers and developers.

We have a prototype dashboard at https://staging.kernelci.org:3000/ and are
working hard on making the e-mail reports good enough to start reaching out to
maintainers.

We already have ARM, Google Syzbot, Gentoo GKernelCI, Red Hat CKI, and, of
course, KernelCI native tests sending data to the database. Linaro Tuxsuite is
starting sending today. We could use your data, and of course any development
help you could spare :)

I wish I could show you my today's KCIDB presentation at DevConf.cz, but the
recording is not out yet. Meanwhile you can take a look at our presentation at
last year's Linux Plumbers: https://youtu.be/y9Glc90WUN0?t=10739

Or see our intro in an older blog post:
https://foundation.kernelci.org/blog/2020/08/21/introducing-common-reporting/

Anyone wishing to contribute to KCIDB gets credentials and permissions to
submit to our "playground" setup where they can send their data, see it in a
dashboard, experiment without worrying about breaking anything, and decide if
they like it or not.

If you're interested, take a look at our Submission HOWTO:
https://github.com/kernelci/kcidb/blob/v8/SUBMISSION_HOWTO.md
and send an email to kernelci@groups.io (CC'd), or come over to the #kernelci
channel on freenode.net!

Nick

On 2/19/21 10:54 AM, Hanjun Guo wrote:
 > Hi Greg,
 >
 > On 2021/1/26 15:29, Greg Kroah-Hartman wrote:
 > [...]
 >>
 >> I want to see companies _using_ the kernel, and most importantly,
 >> _updating_ their devices with it, to know if it is worth to keep around
 >> for longer than 2 years.  I also, hopefully, want to see how those
 >> companies will help me out in the testing and maintenance of that kernel
 >> version in order to make supporting it for 6 years actually possible.
 >>
 >> So, are you planning on using 5.10?  Will you will be willing to help
 >> out in testing the -rc releases I make to let me know if there are any
 >> problems, and to help in pointing out and backporting any specific
 >> patches that your platforms need for that kernel release?
 >
 > We(Huawei) are willing to commit resources to help out in testing the
 > stable -rc releases, and to help to backport patches for stable kernels.
 >
 > 5.10 stable kernel will be used for openEuler [1] kernel and also inside
 > Huawei. From customer's feedback, it's very important to see the stable
 > kernel we used to be maintained for 6 years in the community, and we
 > will use 5.10 kernel for at least 6 years, so we are willing to help
 > you and help ourselves :)
 >
 > In specific, we will start from the testing work, using HULK robot
 > (reports lots of bugs to mainline kernel) testing framework to test
 > compile, reboot, functional testing, and will extend to basic
 > performance regression testing in the future.
 >
 > And we will start from ARM64 and X86 architecture first, and then extend
 > to other platforms.
 >
 > For patch backporting, will send the bugfix patches (from mainline)
 > we spotted, but I think this work may not doing in regular but will
 > be triggered as needed.
 >
 > Does this sound good to you?
 >
 > Thanks
 > Hanjun
 >
 > [1]: https://openeuler.org/en/
 >
 > _______________________________________________
 > linux-arm-kernel mailing list
 > linux-arm-kernel@lists.infradead.org
 > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
 >

