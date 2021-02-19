Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DABE31F61B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBSIzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:55:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12928 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:55:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DhljB2ByCzjNVp;
        Fri, 19 Feb 2021 16:53:18 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Feb 2021 16:54:24 +0800
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
CC:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Yanjin <yanjin.yan@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        Huxinwei <huxinwei@huawei.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
Date:   Fri, 19 Feb 2021 16:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YA/E1bHRmZb50MlS@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2021/1/26 15:29, Greg Kroah-Hartman wrote:
[...]
> 
> I want to see companies _using_ the kernel, and most importantly,
> _updating_ their devices with it, to know if it is worth to keep around
> for longer than 2 years.  I also, hopefully, want to see how those
> companies will help me out in the testing and maintenance of that kernel
> version in order to make supporting it for 6 years actually possible.
> 
> So, are you planning on using 5.10?  Will you will be willing to help
> out in testing the -rc releases I make to let me know if there are any
> problems, and to help in pointing out and backporting any specific
> patches that your platforms need for that kernel release?

We(Huawei) are willing to commit resources to help out in testing the
stable -rc releases, and to help to backport patches for stable kernels.

5.10 stable kernel will be used for openEuler [1] kernel and also inside
Huawei. From customer's feedback, it's very important to see the stable
kernel we used to be maintained for 6 years in the community, and we
will use 5.10 kernel for at least 6 years, so we are willing to help
you and help ourselves :)

In specific, we will start from the testing work, using HULK robot
(reports lots of bugs to mainline kernel) testing framework to test
compile, reboot, functional testing, and will extend to basic
performance regression testing in the future.

And we will start from ARM64 and X86 architecture first, and then extend
to other platforms.

For patch backporting, will send the bugfix patches (from mainline)
we spotted, but I think this work may not doing in regular but will
be triggered as needed.

Does this sound good to you?

Thanks
Hanjun

[1]: https://openeuler.org/en/
