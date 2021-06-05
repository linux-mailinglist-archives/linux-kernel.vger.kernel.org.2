Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C939C8E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFENl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:41:56 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46067 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFENlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:41:55 -0400
Received: by mail-qk1-f178.google.com with SMTP id d196so7076483qkg.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Atvk23VAJRECo9gPmro4DFImXIG4NDqEfap1exKlKA=;
        b=GoIlQAOVCIkuM0rDmfLKmend+emu/3tfZr00HzMcgeR2Rzv4LvpAS92aJxNYw+M5UJ
         FpYZiGfjBHmpQ13B6Yx59IKS0oMeH+YImmGxhPlkOW7uMSNjNZ/Ln1IsBYEe0kVtoDlo
         czoe4hs6Itaasb6Xbg+2JJyvtyAnway8sPQVnNylYr4bKkjK14udQP4UMfnCaLncxdeM
         R3ZznE37tkAJH1hykxV6tzyY1j21glrRTKGjkSZgHAUfo1sgdvqo+mdXH50QAUCkfXRa
         uXo2eEZ7zHv52PUj8ibdL6WdToRHdaC+o8oIoeBVk00adqKCYBluQ8tTS0emEF0v6pmG
         IZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Atvk23VAJRECo9gPmro4DFImXIG4NDqEfap1exKlKA=;
        b=YahkKfT+uylRecaAi8gHB+Ik6sMk742twXA9qnC8T1dgw/OO5PtrQ/YIQMtlREqT73
         B1jOz/t/2cusZZt+eEO9R0MsjGQc1Lw4vQluDe7Iwb9xAWEjl1PdnNwF7fVg15+F+8QU
         WId1CyR4GRvriySaSlHbVD+LFQd0NeCOh305UROT411w1YhDewMB2HyHGn0ZkETXENG7
         ksSrng3Y7WNYVlO4xWMEFXry3T/OwaJzSXg8Nsdbm+itzoHkoKoTkINQIHICReuCe4Lo
         lv6eGq1cRM4CEfok1MIX945jYx+dfSvCbXa0XhpYETiR6rs7pRVZh16Kl16s16NaU4nQ
         NbRQ==
X-Gm-Message-State: AOAM530JUV1jzflZjAlsKwkh2GdYrY/hY2QdDu8q+01wHo6rlEprzO9o
        e3K57nSby8kpRFsvBnc75mtcXQ==
X-Google-Smtp-Source: ABdhPJxxQmtZ5zcZUhMN8lSaketJPR9mnwCxRc9RBRcUQivKmWRw06oGdARzPmIk964gpjL9qs0S5g==
X-Received: by 2002:a05:620a:29c9:: with SMTP id s9mr8738237qkp.171.1622900347586;
        Sat, 05 Jun 2021 06:39:07 -0700 (PDT)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a14sm5355058qtj.57.2021.06.05.06.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 06:39:06 -0700 (PDT)
Subject: Re: [RFC v2 00/43] PKRAM: Preserved-over-Kexec RAM
To:     Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Message-ID: <6e74451b-6a29-d0fc-cf26-b3700a099a09@soleen.com>
Date:   Sat, 5 Jun 2021 09:39:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/21 5:35 PM, Anthony Yznaga wrote:
> This patchset implements preserved-over-kexec memory storage or PKRAM as a
> method for saving memory pages of the currently executing kernel so that
> they may be restored after kexec into a new kernel. The patches are adapted
> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
> introduce the PKRAM kernel API and implement its use within tmpfs, allowing
> tmpfs files to be preserved across kexec.
> 
> One use case for PKRAM is preserving guest memory and/or auxillary supporting
> data (e.g. iommu data) across kexec in support of VMM Fast Restart[2].
> VMM Fast Restart is currently using PKRAM to support preserving "Keep Alive
> State" across reboot[3].  PKRAM provides a flexible way for doing this
> without requiring that the amount of memory used by a fixed size created
> a priori.  Another use case is for databases to preserve their block caches
> in shared memory across reboot.

Hi Anthony,

I have several concerns about preserving arbitrary not prereserved segments across reboot.

1. PKRAM does not work across firmware reboots
With emulated persistent memory it is possible to do reboot through firmware and not loose the preserved-memory. The firmware can be modified to mark the required ranges pages as PRAM, and Linux will treat them as such. The benefit of this is that it works for both cases kexec and reboot through firmware. The disadvantage is that you have to know in advance how much memory needs to be preserved. However, with the ability to hot-plug/hot-remove the PMEM, the second point becomes moot as it is possible to mark a large chunk of memory as PMEM if needed. I have designed something like this for one of our projects, and it is already been used in the fleet. Reboot through firmware, allows us to service firmware in addition to kernel.

2. Boot failures due to memory fragmentation
We also considered using PRAM instead of PMEM. PRAM was one of the previous attempts to do the persistent memory thing via tmpfs flag: mount -t tmpfs -o pram=mytmpfs none /mnt/crdump"; that project was never upstreamed. However, we gave up with that idea because in addition to loosing possibility to reboot through the firmware, it also adds memory fragmentation. For example, if the new kernel require larger contiguous memory chunks to be allocated during boot than the previous kernel (i.e. the next kernel has new drivers, or some debug feature enabled), the boot might simply fail because of the extra memory ranges being reserved.

3. New intra-kernel dependencies
Kexec reboot is when one Linux kernel works as a bootloader for the next one. Currently, there is very little information that is passed from the old kernel to the next kernel. Adding more information that two independent kernels must know about each other is not a very good thing from architectural point of view. It limits the flexibility of kexec.

However, we do need PKRAM and ability to preserve kernel memory across reboot for fast hypervisor updates or such. User pages can already be preserved across reboot on emulated or real persistent memory. The easiest way is via DAXFS placed on that memory.
Kernel cannot preserve its memory on  PMEM across the reboot. However, functionality can be extended so kernel memory can be preserved on both emulated persistent memory or on real persistent memory. PKRAM could provide an interface to save kernel data to a file, and that file could be placed on any filesystem including DAXFS. When placed on DAXFS, that file can be used as iommu data, as it is actually located in physical memory and not moving anywhere. It is preserved across firmware/kexec reboot with having the devices survive the reboot state intact. During boot, have the device drivers that use PKRAM preserve functionality map saved files from DAXFS in order to have IOMMU functionality working again.

Thank you,
Pasha
