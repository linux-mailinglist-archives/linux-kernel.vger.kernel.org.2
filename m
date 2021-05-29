Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703AF394AEA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhE2HdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhE2HdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 03:33:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 00:31:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5795802pjp.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8hnKQslTlCFAXMU0SU12N+3wAln8HGC0k1kgerLe04=;
        b=g07la02VDigfQGfYXusUErVBXEqW/nfiNlA6+fhu+MDLl8T9bRG86a5I52sQrawM5f
         p8EKm0gxCqX8GVdxztfGa0CPWuTyVDV2FNHQj2kx/2rNeOSam+uVeGF2GtkbGL/DEzWg
         YKVS4/T4mNmc1g/yF5LIIqMsrNDNT8V1B6V9VlXG2VwjOxlZdPhj2slDSphOR9UpXNrH
         82OLTi+9oS3QDig9OO5wI5Ywo9UlDk2mIChqUjMjNph8OwbdBJHhPDyJa3jv1od9/LAA
         yNK9Vsv+jEk2fFMJlL2DL2z/Q7e08an9YPBfjjCEYTku17T9Z3hAlKk9WNhaQXMELqW2
         T8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8hnKQslTlCFAXMU0SU12N+3wAln8HGC0k1kgerLe04=;
        b=DgePXavN2TLHd2DXePv2EN4MONjZoKF381zMW1I6ZxUMf/KHIX9oWHwQKwKthekfGq
         sWcbQnlzQ0GrTozG4arrRkVyOddGePJYwKQ9yhc53zaQcxDim3kwb/1XkPsP4TnqbJOb
         u6Cy1AjSOyoEtrvRW/WA3YJ+m8BXy/V2lFasGQ5nPSjigAh+rueez3clEcGLd4/mPmWs
         3B2WfBhPZUBdweUgqCLW54hkivVcnbBZvZOV8IBvwL+LQBs+8mloeE2dDIRGAUKD1gVH
         h9D3c3ytIS76tWszvjZ2fKBJGhrgom/ycY8y64Xki7ak6XlutN6BK9jcTDHC/CVi6DIR
         1QkA==
X-Gm-Message-State: AOAM530y/ZL1ZoA++MJKgYfR/WohYVwqzul5uM/bY6Haq1rLa+haHEx3
        YQuAyrT9qGUWaG/kSq7sNHi17JwFaIsPqgo6
X-Google-Smtp-Source: ABdhPJyHPKpRPYh5wUru7rxax096s0xqCtdJqCrV+4qziNZ2p4kKskRoQDXXz5nPktrgw5Hmb0iSCA==
X-Received: by 2002:a17:90a:5995:: with SMTP id l21mr8404304pji.79.1622273505234;
        Sat, 29 May 2021 00:31:45 -0700 (PDT)
Received: from ?IPv6:2601:647:5380:8c0:858e:9ae5:3ea5:20eb? ([2601:647:5380:8c0:858e:9ae5:3ea5:20eb])
        by smtp.gmail.com with ESMTPSA id t19sm6195113pfg.70.2021.05.29.00.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 May 2021 00:31:44 -0700 (PDT)
Subject: Re: Sealed memfd & no-fault mmap
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Simon Ser <contact@emersion.fr>, Peter Xu <peterx@redhat.com>,
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
From:   "Lin, Ming" <minggr@gmail.com>
Message-ID: <80c87e6b-6050-bf23-2185-ded408df4d0f@gmail.com>
Date:   Sat, 29 May 2021 00:31:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjv3-eP7mSDJbuvaB+CbyyKc4g_nEzhQLcueOd0_YuiBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/2021 6:03 PM, Linus Torvalds wrote:
> On Fri, May 28, 2021 at 7:07 AM Lin, Ming <minggr@gmail.com> wrote:
>>
>> Does something like following draft patch on the right track?
> 
> No, I don't think this can work:
> 
>> +               _dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
>> +                                        vma->vm_page_prot));
> 
> You can't just blindly insert the zero pfn - for a shared write
> mapping, that would actually allow writes to the zeropage. That would
> be horrible.

I should check the vma is not writable.

diff --git a/mm/shmem.c b/mm/shmem.c
index 856d2d8d4cdf..fa23e38bc692 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1820,7 +1820,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
                 spinlock_t *ptl;
                 int ret;
  
-               if (!IS_NOFAULT(inode))
+               if (!IS_NOFAULT(inode) || (vma->vm_flags & VM_WRITE))
                         return -EINVAL;
  
                 _dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr)


