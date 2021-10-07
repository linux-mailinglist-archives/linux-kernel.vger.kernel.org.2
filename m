Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D349A424D24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhJGGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhJGGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:16:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 23:14:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so15594723wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gI5co4o1rYvGRdi2WZK3gX+GZfZ3PfZ5qkVmEV61ypM=;
        b=ipDEUW6fCIZj20IJZstMPYxQ5mXG1IB8w198w1WbBiD70rzgEr3CURVfEnGenTJJ8C
         uxmcxXru1MZ4v2vA5sc6AgUZRHqHm2goP6/NKjqRuQmypVn9DTxrGiWDfdZ0qksjIQVe
         afgs+fOmqP5uKYzoxOyE7U7eur5LObBtvcca7cK1q03L0t3hO44ACd8OofMwpt8dmHOv
         hrj+2yQ79BZ9sD01FXkhgTE8sMBMMWiaGmLd2NfK1zK/GmJDOQzoFexdrN/kCigCb4sz
         otor5Gy84gq1s9Ck2WUKEyaMqG6DMuRONHolPyCmYL0Y+9Lv03sndKZze5kYNPLV194D
         S5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gI5co4o1rYvGRdi2WZK3gX+GZfZ3PfZ5qkVmEV61ypM=;
        b=a9wdaVPExRkCkwlBbfBeuKKhVYKZsqGaNDw+QcDJB3BuPwbSbhwqumO4mLFINrFV6Y
         bKEasKkjj/IWx2evyYKD7CMz6PIRyT9RGXI89VeReIUuRjIvIzgbdtSo75g3w+7pGEPo
         Lsfdulx8bo9MR/odZxdtERK1GQWFsFqIYefN0+MNnDb/rVUobGagrmQjHk9Vd25NmtuB
         jWuXf1d0DbbMoDlzMzi6XqasEOvBoNjcA88p6RHvZcjVjlDjBnRb6CjmbP5MxqG/9Vuo
         QIMOXwQfJz0sTdmU2+hKZ6jZrLHsX89MoHwDVLsdGGVDlmAtqOwZGRniz/Bmc0/msMgn
         bFXA==
X-Gm-Message-State: AOAM532EuZYoVMoOydbw3NZqw79Ld4HTGsEJFGObQu/cGO2RnJvU9xk0
        XxnmyQ3aU/R+nTHyw5sm0Eo=
X-Google-Smtp-Source: ABdhPJwnStOUraV9oDx+23WCZQ+1j6dkJGavjzn+ZPg0qrN1LiCtA29uqSx3HfJKxuDs0PJhy03JgA==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr3033384wra.373.1633587260830;
        Wed, 06 Oct 2021 23:14:20 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
        by smtp.gmail.com with ESMTPSA id a25sm7147675wmj.34.2021.10.06.23.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 23:14:20 -0700 (PDT)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
 <CADnq5_M2y1tUAcUPNOrmB=pHfBGtnqMtTrw24ZC45202hg-kYw@mail.gmail.com>
 <YV351s3Fyhnmen9g@zn.tnic>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d3001b64-7b31-a0ab-d7d9-44b145d412f2@gmail.com>
Date:   Thu, 7 Oct 2021 08:14:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV351s3Fyhnmen9g@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.10.21 um 21:32 schrieb Borislav Petkov:
> On Wed, Oct 06, 2021 at 02:21:40PM -0400, Alex Deucher wrote:
>> And just another general comment, swiotlb + bounce buffers isn't
>> really useful on GPUs.  You may have 10-100s of MBs of memory mapped
>> long term into the GPU's address space for random access.  E.g., you
>> may have buffers in system memory that the display hardware is
>> actively scanning out of.  For GPUs you should really only enable SME
>> if IOMMU is enabled in remapping mode.  But that is probably beyond
>> the discussion here.
> Right, but insights into how these things work (or don't work) together
> are always welcome. And yes, as 2cc13bb4f59f says:
>
>      "... The bounce buffer
>      code has an upper limit of 256kb for the size of DMA
>      allocations, which is too small for certain devices and
>      causes them to fail."

To make the matter even worse, bounce buffers don't work with APIs like 
Vulkan and some OpenGL/OpenCL extensions.

In those APIs or extensions the assumption is that you can malloc() 
memory in userspace, give the pointer to the kernel driver and have 
coherent access with your device and the CPU at the same time.

In other words you don't even get the chance to bounce the buffers 
between CPU and device access because they are accessed by both at the 
same time.

Regards,
Christian.
