Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A473DFC70
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhHDIFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:05:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhHDIFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:05:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gfkj12P05z83qs;
        Wed,  4 Aug 2021 16:01:41 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 16:05:32 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 16:05:31 +0800
Subject: Re: [PATCH 0/2] coresight: ultrasoc: Add support for System Memory
 Buffer device
To:     Linuxarm <linuxarm@huawei.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210719111737.47891-1-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <41661d60-d8ef-9d50-57eb-8964c6f6eef8@huawei.com>
Date:   Wed, 4 Aug 2021 16:05:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210719111737.47891-1-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...
Hi Mathieu and Suzuki, can you have a look at this patchset? thanks.

On 2021/7/19 19:17, Qi Liu wrote:
> This patchset add support for SMB(System Memory Buffer) device, SMB
> obtains CPU instructions from Coresight ETM device and stores these
> messages in system memory.
> SMB is developed by Ultrasoc technology, which is acquired by Siemens,
> and we still use "Ultrasoc" to name document and driver.
> 
> Change since RFC:
> - Move ultrasoc driver to drivers/hwtracing/coresight.
> - Remove ultrasoc-axi-com.c, as AXI-COM doesn't need to be configured in
>    basic tracing function.
> - Remove ultrasoc.c as SMB does not need to register with the ultrasoc core.
> - Address the comments from Mathieu and Suzuki.
> - Link: https://lists.linaro.org/pipermail/coresight/2021-June/006535.html
> 
> Qi Liu (2):
>    Documentation: tracing: Documentation for ultrasoc SMB drivers
>    coresight: ultrasoc: Add System Memory Buffer driver
> 
>   .../trace/coresight/ultrasoc-trace.rst        | 193 +++++
>   MAINTAINERS                                   |   7 +
>   drivers/hwtracing/coresight/Kconfig           |   3 +
>   drivers/hwtracing/coresight/Makefile          |   2 +
>   drivers/hwtracing/coresight/ultrasoc/Kconfig  |  12 +
>   drivers/hwtracing/coresight/ultrasoc/Makefile |   6 +
>   .../coresight/ultrasoc/ultrasoc-smb.c         | 722 ++++++++++++++++++
>   .../coresight/ultrasoc/ultrasoc-smb.h         | 142 ++++
>   8 files changed, 1087 insertions(+)
>   create mode 100644 Documentation/trace/coresight/ultrasoc-trace.rst
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Kconfig
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/Makefile
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.c
>   create mode 100644 drivers/hwtracing/coresight/ultrasoc/ultrasoc-smb.h
> 

