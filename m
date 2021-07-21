Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F93D0F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhGUM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbhGUM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:28:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB6C061767
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:08:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t5so2118261wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p4j+IB5ABbcQqTi2Z9gFZCErxz2KV+Poiy1HA/Do+ds=;
        b=HWGXeogxEr4/cdQYJz3iFSBi5416qINplAbl2FXo/cUGzOEa0+NQTyAFs36U66Eb29
         Vxvt5uqrLGwk6cImlwUYMC+Ew4KHvh6OekyYJCPVFBeCtqGSdYeVILnT1jZaamMvPaqA
         v7Tb2eUMzH+f1sye0KTbGkJgfxTJTax4IKo8Ks0Ayh/z0vs0UyM3Vta96q4/6UvfCUG0
         OnOhis5x4OI8awpdfJGtSIKhwCp19aX0ZOvnlGHSq7Iy6jEgo8vmOpC3x+lDKr6y55bd
         cqRgERRoNM1cSwk5oSSXMB+HqE3MBysvxllbTp1teD4p+SkB5L76mq+wLMoqKxA4VApB
         0Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4j+IB5ABbcQqTi2Z9gFZCErxz2KV+Poiy1HA/Do+ds=;
        b=naw1YiyJAauD/7mU555qeCfzRYMsUxl9DWxAxKdzQotA1PWomjnZfr0UYTSGbd+1m9
         cnkUb3oGPP3KxUrCA7n+i53Zqth98L3sAcct/J9uDqX9h3UMuELukB7fVsPC6BG/2aea
         XNLbtiOOyUeV6Xcfo47FS98G8ipinRLVp90cuHHyeJwDcMGl1NPThrdcPUqIQNr9HLj4
         2PuVVh9ehcQUpgatbspgjCqksHEQokXUYYB8XXOZlbJPHCD/tuyQJpppUab8H6SaEwst
         z9sWLDNs3Su+k0zdQ0QHEMzXWxp4PL7i6pYVSCCjZpXSaRq08lwnU8VxxPR3tiRmMZEs
         4S2w==
X-Gm-Message-State: AOAM5323uMXLkAmEKyYDucTpEgA9PP3GYmJok1roXWrZiVb4ZP1H+jfN
        fDHxTYN8KvdSfS5OhfwoRdQ=
X-Google-Smtp-Source: ABdhPJwKF+b0l7SD4byoxy+kFrWjKbCEMnAsTwNbtXX7B0tbrrKToykQSZQvFTaioimwE04Oavb/7A==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr4958169wrx.234.1626872937096;
        Wed, 21 Jul 2021 06:08:57 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id o14sm27279663wrj.66.2021.07.21.06.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 06:08:56 -0700 (PDT)
Subject: Re: [PATCH] mm/mremap: Don't account pages in vma_to_resize()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
References: <20210721124949.517217-1-dima@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <cd8fd36b-eba7-039b-f823-f62d62c503b8@gmail.com>
Date:   Wed, 21 Jul 2021 14:08:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721124949.517217-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 1:49 PM, Dmitry Safonov wrote:
> All this vm_unacct_memory(charged) dance seems to complicate the life
> without a good reason. Furthermore, it seems not always done right on
> error-pathes in mremap_to().
> And worse than that: this `charged' difference is sometimes
> double-accounted for growing MREMAP_DONTUNMAP mremap()s in move_vma():
> : if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
> 
> Let's not do this.
> Account memory in mremap() fast-path for growing VMAs or in move_vma()
> for actually moving things.

And this one is also wrong: the diff for growing vma should be accounted
for !MREMAP_DONTUNMAP too.
Sending v2...

Thanks,
          Dmitry
