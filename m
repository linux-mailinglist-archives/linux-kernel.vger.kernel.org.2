Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566273D1793
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhGUT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhGUT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20521C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:09:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x14-20020a7bc20e0000b0290249f2904453so1423017wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=76LcptXaCIBejIMohO/LEgsjJoJqDRg1CGid93g9aNU=;
        b=K66wTEVV/HKjdw4XC6QRH6POs57CuuHsGM774+hcpDZH9fD9M6Dj2LxSH0SbT8aRnq
         B1ibvRAfhcddG3bXFBtprIAwfp4I99C6ho/kWlqjglH8nnfaTjCJEWju37B+FQvp5Wy8
         l0U/bZ1t0V4r7DtFEywTaqyyng/v/TddB8Ac+BL9Wd3aJ3EHuMNxhdz9VhFeBteTQPJN
         Xj9Qaw1DUljFQfmaW0O4+vs9yj9uhYTpWcM4fyCph6vfN67ROG8f5vHgl6E5TUJv0gTN
         MgbJnL1drSu/b8GhxAuSMC4CvDUVoz5dcTrfNIX4kafrxPvdUpTqW4nOOwFHLuMKalLC
         c1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=76LcptXaCIBejIMohO/LEgsjJoJqDRg1CGid93g9aNU=;
        b=AqS3MQv3P1sd0ZNd5do4v7BmgFlXpjLw2y5971thWfGQSSFrwNSFSrcDVuejh33/8U
         1QWgIa/rcrOcJNxIkldYag7yxjSO5DXCqMPwa5i4Xw8jy7uESnlJiY1Z6hQsswH1/rZm
         YTqTvOnsrFBsiU57lVcyPd18809JCEuLSaOd4G9ymPTRpy5eeYlPuxcf/f5t7utGZfW3
         JswkxOtkLHe9BzSHw7nndt0V4SpOpQx6xoD9Z3hTRyHG/PtYL3nB8a5YGyyJk4hORFSL
         2qF5D2gr64aN77WWN++MguxditPDDlpwuQxEDMhOxt4lwO3+5nT/8IezqBDcXMES15WR
         g9+g==
X-Gm-Message-State: AOAM533lPzaVDUjujsOLkBpMDWEMEZ4I0E/K5Qgbd7fvpEDHd08R4Jfq
        W+A7rkffVO0WTUdTuSvVVJ4OkA==
X-Google-Smtp-Source: ABdhPJykxruQgTfE7LQQlzBXrCb6qyPmIgTO9JfrChX/lHBfD0agh2VMnbsf4NldB1TpRdMJ4aMqCQ==
X-Received: by 2002:a05:600c:b42:: with SMTP id k2mr5901314wmr.45.1626898140701;
        Wed, 21 Jul 2021 13:09:00 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id z7sm14712541wrt.94.2021.07.21.13.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:09:00 -0700 (PDT)
Subject: Re: [PATCH v2] mm/mremap: Don't account pages in vma_to_resize()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
References: <20210721131320.522061-1-dima@arista.com>
 <77e28552-7a13-0981-f921-cd027cb73525@gmail.com>
 <20210721130551.bbdeae56ca3ec2d0f28b0bac@linux-foundation.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <48ba72b8-3da2-e438-6148-5ec22172d475@arista.com>
Date:   Wed, 21 Jul 2021 21:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721130551.bbdeae56ca3ec2d0f28b0bac@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 9:05 PM, Andrew Morton wrote:
> On Wed, 21 Jul 2021 14:21:54 +0100 Dmitry Safonov <0x7f454c46@gmail.com> wrote:
> 
>>> Let's not do this.
>>> Account memory in mremap() fast-path for growing VMAs or in move_vma()
>>> for actually moving things. The same simpler way as it's done by
>>> vm_stat_account(), but with a difference to call
>>> security_vm_enough_memory_mm() before copying/adjusting VMA.
>>>
>>> Originally noticed by Chen Wandun:
>>> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
>>
>> The patch by Chen Wandun still makes sense with this v2.
>> Heh :-)
> 
> Should
> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com
> still be applied then?  Did you ack it?
> 

Yes, please keep that patch with
Acked-by: Dmitry Safonov <dima@arista.com>

This one comes on the top to correct accounting for MREMAP_DONTUNMAP.

Thanks,
          Dmitry
