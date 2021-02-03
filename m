Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC230E002
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhBCQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBCQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:48:38 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C39C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:47:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id a77so537536oii.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
        b=lrPEG74DOtqh0L7paTBjafFI44X0ikYaEsGMLmHNqbxviTPPH2RmXs68TIGDoMrrC1
         DjwAxBpCyW1/ZZ/A1Mimjxt21m2+NePiopmTdSUrmjhtvyiwZ31SAHWPe++B7SGi6YJV
         dOHc9ig1W+xyZ6263TnU6LVUd8RyDzTwUXkVWh4m0MuUvp7u46NIDMTe1RFSJ03m3QqH
         lhed1HQeGZphcYM/6mCFIxFXlYyKIG4gL4tOl9gr9ChfCJI7lTUqro7G4WXbJDYhRvAW
         tehtMsu6xdSQKpB/mqrFgpd6bs/dy57W3Ay5G60j4GwuamIYASeUDTfiEkTiPdrU6uVR
         yWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZEmNp2ZakxDJznFqcVZ1P80OyQOGPyM6d5UCk5d3vk=;
        b=oY9LmsWLzIn8puLx5B14/st1QFivUfQ4ggLK8i+5V6urdO++K/4WA+wpQE1sD6AAVO
         ImyOVJZo49761ULkgWvQblFvMzb1cAnC+yutrrCsZ+Un/NLnELIpRlBCBh1sVF6EbVLb
         Dd+5hkZPJx/Ry75TKkwE48SzWtPY2lHbhiZseeceFTA8bFtscL5FV/LLjeJ/92UjIQu8
         0z8Oad0zN6bG5FhZ1nEi9tcP9vRN2txqYi5SF3San2B4gHVq3S+whutVkj/KsY2yMqr8
         THCHjQiGVL/YjISJx/bNeFmgf087njZGoXY2TLIEU5cV4ejYyAm6nZdH/BZb1Z84GzD/
         AYfQ==
X-Gm-Message-State: AOAM533zXLikoghdjQv5nDY0PuUK8hFJdnsjEIVqqdRi9N2/56oEW8Eu
        IglNEHc9dJzoOLXMI/QSYIIIPAXl1MAChmMGWGWalA==
X-Google-Smtp-Source: ABdhPJz2RpbhkniHRFTWA/PnemwFxygMLB82C8ofE36DFtyCupwdbGrY9bzMHloCpMlEZy/Z9AXkapfX8D+WwztZi8I=
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr2575743oif.63.1612370877454;
 Wed, 03 Feb 2021 08:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com> <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com> <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com> <20210203133712.GA24674@lst.de>
In-Reply-To: <20210203133712.GA24674@lst.de>
From:   Jianxiong Gao <jxgao@google.com>
Date:   Wed, 3 Feb 2021 08:47:45 -0800
Message-ID: <CAMGD6P1Ksn4DJ0w=O20Ou7BOKAW9yzwJgRV57xaqLdVDK4ATaQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Erdem Aktas <erdemaktas@google.com>,
        Marc Orr <marcorr@google.com>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Please try with this extra patch:
>
I have tried with the extra patch and it still fails to boot.
I have attached dmesg output for the error:

-------------dmesg starts here-----------------
[    6.357755] XFS (nvme0n1p2): Mounting V5 Filesystem
[    6.430092] XFS (nvme0n1p2): Torn write (CRC failure) detected at
log block 0x20d0. Truncating head block from 0x20e0.
[    6.442828] XFS (nvme0n1p2): Starting recovery (logdev: internal)
[    7.272456] XFS (nvme0n1p2): Ending recovery (logdev: internal)
[    7.610250] systemd-journald[434]: Received SIGTERM from PID 1 (systemd).
...
[   10.054121] systemd[755]:
/usr/lib/systemd/system-generators/systemd-rc-local-generator
terminated by signal ABRT.
[   10.726122] audit: type=1400 audit(1612370261.090:4): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   10.751764] audit: type=1400 audit(1612370261.090:5): avc:  denied
{ search } for  pid=783 comm="systemd-sysctl" name="crash"
dev="nvme0n1p2" ino=50789805
scontext=system_u:system_r:systemd_sysctl_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.366607] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[   12.376379] audit: type=1400 audit(1612370262.740:6): avc:  denied
{ write } for  pid=788 comm="systemd-remount" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.413155] systemd-journald[781]: Received request to flush
runtime journal from PID 1
[   12.428917] audit: type=1400 audit(1612370262.793:7): avc:  denied
{ write } for  pid=815 comm="journalctl" name="crash" dev="nvme0n1p2"
ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   12.453006] audit: type=1400 audit(1612370262.799:8): avc:  denied
{ write } for  pid=817 comm="systemd-random-" name="crash"
dev="nvme0n1p2" ino=50789805 scontext=system_u:system_r:init_t:s0
tcontext=system_u:object_r:kdump_crash_t:s0 tclass=dir permissive=0
[   13.306030] plymouth[853]: segfault at 0 ip 00007f2eabca8090 sp
00007fffe94d8c08 error 6 in libc-2.28.so[7f2eabbcd000+1b9000]
[   13.318772] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[   78.782418] sed[911]: segfault at 0 ip 00007fc3540da090 sp
00007ffdb4373ff8 error 6 in libc-2.28.so[7fc353fff000+1b9000]
[   78.794007] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
--------------dmesg ends here-----------

-- 
Jianxiong Gao
