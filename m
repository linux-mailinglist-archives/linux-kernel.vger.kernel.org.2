Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54203396937
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhEaVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:15:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7274C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:13:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i22so590467pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LW0vl/hPnVGSly3VDkGIzhu2V9/k+bcQNfCUTpERlgM=;
        b=YWhF1lBk/tLmGWtD5cy8ck7UqSAiRSXGygv3obAjb1C3oRikFyW6m29zQJxQeMzorV
         N2QTxnSTXrYkgZS7lL3QkLFHjBEnmD45o4fvJGHwlyAAowgUvXGf0PEWnADScA6sBlBR
         cJrG87p6Fry51970S10NjqiSUuh+QZNkJpFHEw8b5BOnk//6FbnAxK3TBIpLe1QdaHUA
         UqM7KPQWZXaak6TQwY/XDDNYXDYnMqcc1Cwa78QBG937BZNzZyZ+LM/EEBbnb5uN/sU3
         xnYbaPUPnoI6NphARwkya9+ZmxoHTL4kO+EbP2+PFsUcgXS3ENNB0e9l1WiRicW56kuL
         njxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LW0vl/hPnVGSly3VDkGIzhu2V9/k+bcQNfCUTpERlgM=;
        b=KuAbrvgNZYLIEKVuZ7eOzmCus0jN1i0d42B6FgnshgFkOyK9t8GUOtBoJakYJjdpqh
         t0AB+xb4GJzg7KHBEFudphxpzQ+es+UN0FK3F7RFkS1dYHFHaHI2HnzmzKuO8WbvYgPP
         IkISuL/UoLRUfTxWTDNv59/bJI5MzOAM82yDPwZDodgNiJjmVXOsuqDPkMIt9ggfWJ/9
         L4XFq6IaFVzfbvH0uS8It/PfS6RL1Ym6gcqJwIHdknoCz3XDSGq5rDUjipeppiLYmh1p
         ANhv/QNRn7u4ZO9UZCN4lPY69YzUa0cuStHAvJ1naMWOSD35YmFJM6QHBBBlTeMcb69Q
         oajA==
X-Gm-Message-State: AOAM530+psxmNNhyh3WUlv2E9nEKxlLa71dZFiR4Kw2bSoL6vaaHB8S/
        uq2GFMxaWQnrLMz63mCsXkY=
X-Google-Smtp-Source: ABdhPJxCLtShnBPDLXPOGS1BZnwVS2Ie+0dADGTjOIXza/EKKNfRoepruWQQGHjOfOb9NJx3fP47sg==
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr1004969pjw.129.1622495615154;
        Mon, 31 May 2021 14:13:35 -0700 (PDT)
Received: from [192.168.0.15] (c-73-158-171-241.hsd1.ca.comcast.net. [73.158.171.241])
        by smtp.gmail.com with ESMTPSA id bv3sm501772pjb.1.2021.05.31.14.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 14:13:34 -0700 (PDT)
Subject: Re: Sealed memfd & no-fault mmap
From:   Ming Lin <minggr@gmail.com>
To:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Simon Ser <contact@emersion.fr>
Cc:     Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1>
 <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
 <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
 <hnL7s1u925fpeUhs90fXUpD3GG_4gmHlpznN8E0885tSM40QYb3VVTFGkwpmxYQ3U8HkRSUtfqw0ZfBKptA4pIw4FZw1MdRhSHC94iQATEE=@emersion.fr>
 <CAHk-=wiY1BL-UHPMEAbd7nY3vu6w41A1hhvjg1DoBXWuRt9_qw@mail.gmail.com>
 <7718ec5b-0a9e-ffa6-16f2-bc0b6afbd9ab@gmail.com>
 <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
 <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
 <CAHk-=whSGS=R8PtrfNcDTkCKOengEqygqeWjOZa2b8QkuOueDg@mail.gmail.com>
 <alpine.LSU.2.11.2105291315330.25425@eggly.anvils>
 <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
Message-ID: <e7454046-c071-888d-f673-276f9c24d9d3@gmail.com>
Date:   Mon, 31 May 2021 14:13:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <36fc2485-11f1-5252-904d-f26b63a6cd58@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/2021 4:36 PM, Ming Lin wrote:
> On 5/29/2021 1:15 PM, Hugh Dickins wrote:
> 
>>
>> I believe the correct behaviour would be to unmap the nofault page
>> then, allowing the proper page to be faulted in after.  That is
>> certainly doable (the old mm/filemap_xip.c used to do so), but might
>> get into some awkward race territory, with filesystem dependence
>> (reminiscent of hole punch, in reverse).  shmem could operate that
>> way, and be the better for it: but I wouldn't want to add that,
>> without also cleaning away all the shmem_recalc_inode() stuff.

OK, I borrowed code from filemap_xip.c and implemented this behavior.

Simon,

Before I send out the patches for review, would you mind have a quick test?
https://github.com/minggr/linux, branch shmem_no_sigbus

In Wayland compositors, you only need to pass in MAP_NOSIGBUS in mmap().
For example,

//fd should be received from Wayland compositors client
#define MAP_NOSIGBUS    0x200000
addr = mmap(NULL, size, PROT_READ, MAP_SHARED|MAP_NOSIGBUS, fd, offset)

Thanks,
Ming

