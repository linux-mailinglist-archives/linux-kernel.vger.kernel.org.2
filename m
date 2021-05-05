Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B970C374B92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEEW4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:56:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE92EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=6Sib80IUnQYmSYbcXgX9QZ+o6dCexEvCaj2tu9CyIiE=; b=fO4xzBUKzr8Ys3fOwaXwpyE2fO
        qriwIxij2JK6KMB1Z+BMxJ0aezEntGAtC5oWlQ7PWd2leGaLBlMmvQuh868xMoc/zYwlQAAwp2Zj9
        0GfIXKDIykxIexFfZLIOMXnM0nqZ3G8g0rac/SClHS/qtjBao0e8gAQj4vpu0JwXJf2BJBxSt7gZR
        1aUNo4DEvlrIt4nfOvUFdaBaITU5WdZIj8KzxUoZJRYavrq5HM2LmbrE3DLyC67DMIz7zm9ueo4ca
        9yMxrcJRGIoAqyUHe+kg/++ybGlXXXfm85Gx5kF0LvyWDr4fVzfYomQV+7a5fW8gltYGeRzXSwGEz
        MUZ0RG9Q==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leQPl-001146-T9; Wed, 05 May 2021 22:55:09 +0000
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
To:     Carlos Bilbao <bilbao@vt.edu>, corbet@lwn.net, hdegoede@redhat.com,
        mchehab+huawei@kernel.org, Jonathan.Cameron@huawei.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
References: <2219636.ElGaqSPkdT@iron-maiden>
 <de6f22e2-3f3c-0ce3-a73d-fb881646f1e8@infradead.org>
 <4341223.LvFx2qVVIh@iron-maiden> <1810583.tdWV9SEqCh@iron-maiden>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70a547bd-1c64-611e-f487-3f1dd76f9526@infradead.org>
Date:   Wed, 5 May 2021 15:54:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1810583.tdWV9SEqCh@iron-maiden>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 3:28 PM, Carlos Bilbao wrote:
> Fix the following typos in the Documentation/ABI/ directory:
> 
> - In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".
> 
> - In file removed/sysfs-kernel-uids, change "propotional" for "proportional".
> 
> - In directory stable/, fix the following words: "associtated" for "associated",
>   "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
>   "wrtie" for "write". This updates a total of five files.
> 
> - In directory testing/, fix the following words: "subystem" for "subsystem", 
>   isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
>   "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
>   "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
>   and "transaction" for "transaction", "malformatted" for "malformed","internel"
>   for "internal", "writtento" for "written to", "specificed" for "specified", 
>   "beyound" for "beyond", "Symetric" for "Symmetric". This updates a total of 
>   eleven files.
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---

This patch should have something here (below the --- line) like:

v2: corrections from v1 and additions to the file <whatever the new file is>

It should also have a modified Subject line: (e.g.)

[PATCH v2] Documentation: ABI: fix typos in all directories

Anyway, the changes look good to me.

Thanks.

>  Documentation/ABI/obsolete/sysfs-cpuidle            |  2 +-
>  Documentation/ABI/removed/sysfs-kernel-uids         |  2 +-
>  Documentation/ABI/stable/sysfs-bus-vmbus            |  2 +-
>  Documentation/ABI/stable/sysfs-bus-xen-backend      |  2 +-
>  Documentation/ABI/stable/sysfs-driver-dma-idxd      |  2 +-
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io     |  4 ++--
>  Documentation/ABI/testing/configfs-iio              |  2 +-
>  Documentation/ABI/testing/configfs-most             |  8 ++++----
>  Documentation/ABI/testing/configfs-usb-gadget       |  2 +-
>  Documentation/ABI/testing/configfs-usb-gadget-uvc   |  4 ++--
>  Documentation/ABI/testing/debugfs-driver-genwqe     |  2 +-
>  Documentation/ABI/testing/debugfs-driver-habanalabs |  2 +-
>  Documentation/ABI/testing/sysfs-bus-fsi             |  2 +-
>  Documentation/ABI/testing/sysfs-bus-pci             |  2 +-
>  Documentation/ABI/testing/sysfs-devices-system-cpu  | 10 +++++-----
>  Documentation/ABI/testing/sysfs-driver-ufs          |  4 ++--
>  Documentation/ABI/testing/sysfs-fs-f2fs             |  2 +-
>  17 files changed, 27 insertions(+), 27 deletions(-)
> 


-- 
~Randy

