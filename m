Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A133DD93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhCPTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhCPTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:31:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AAFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:31:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p21so23282863pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ekMKxv3xoEv56PIX/8u6+v+e3tG7LJLMlBeqZEO46pI=;
        b=iouit/h+6MqphTGzWcQ8N+tNTFxpPm8zhlVMVH6yh3QXNXaTzgAH92BSeqUkabxVVG
         Bz7XXzgV1OhK1f+sf6ggCh/m26z/h7goie6JPNqNEA6ZWeffPt7IrIxw0Ko8Hs5+/qKl
         xUVS8/U6IdUSV2TXm5nxf9V7w1jDrfc8rpiygjP50ADf/r1at+dct8MeOpC6jfeRaG7N
         sCZgwIl7lKP5uoyGPUqkXHYFoQ744alahJdlhbQ950koKsMRyocE8j6I7GaxUoVuCvo+
         mzpyGkSnl6hmPQqiXFfDzumOgA932tyl4Da6eHXPnQWBtV65AXfzcxPYhRAkiCiGcBLX
         4BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekMKxv3xoEv56PIX/8u6+v+e3tG7LJLMlBeqZEO46pI=;
        b=LDW9pJNhaomyrw+QFUyVrPCF4ZbTvP49SW937pzeOiELKa9yV151e2M8wpTrbLsixi
         tHHLq91OQ2vHL5eh88GbJhD08oyqt48gROmZkRwoe9ILrqiLh3+vT93lVBsCTWNM/obP
         0FveJA9hThyXXKmvLwEHPsnVruRbTiBDJi/zhYjTNQ1qjgqsih+c1KD+1/9bkTh10OxH
         Lg79WSDtnyM8OWLqHJrqu6HQ/Eo9QozMdYrOUGLrcxL5bzUMPiFuPYlQx4p2P2nRIKvF
         4W5XESyVh567amAMZAhXcCoRKn+yAzBzn4jT3oT1112iGcuuqekQd16hJaarDwypEx0N
         BY5A==
X-Gm-Message-State: AOAM5333YPmXOrpzB3peophjlvrFC2U02xppGLtBhcyZpiImm8aop2fa
        Tfj+8Hv/hA5RnuUHavu/mgYPxA==
X-Google-Smtp-Source: ABdhPJx3vy5Om6W53Jw+2UZUw99YwawZ3UKAZ4rXRb27866O0JGa9hH+eG64CaVVdyO7TwbO8Vm5AA==
X-Received: by 2002:a62:3503:0:b029:1aa:6f15:b9fe with SMTP id c3-20020a6235030000b02901aa6f15b9femr955714pfa.65.1615923072796;
        Tue, 16 Mar 2021 12:31:12 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id u24sm17928529pfm.214.2021.03.16.12.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:31:12 -0700 (PDT)
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
To:     Brian Geffon <bgeffon@google.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
 <CADyq12z+o0Rtziprkfs=PX2MPRPZyWBSgONYrRggZ8TEifq2sg@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <98716204-0440-9550-e067-41a984a29512@arista.com>
Date:   Tue, 16 Mar 2021 19:31:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CADyq12z+o0Rtziprkfs=PX2MPRPZyWBSgONYrRggZ8TEifq2sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian, Hugh,

On 3/16/21 7:18 PM, Brian Geffon wrote:
> Hi Hugh,
> Thanks for this suggestion, responses in line.
> 
>> A better patch would say:
>>
>> -       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
>> -                       vma->vm_flags & VM_SHARED))
>> +       if ((flags & MREMAP_DONTUNMAP) &&
>> +           (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>>                 return ERR_PTR(-EINVAL);
>>
>> VM_DONTEXPAND is what has long been used on special mappings, to prevent
>> surprises from mremap changing the size of the mapping: MREMAP_DONTUNMAP
>> introduced a different way of expanding the mapping, so VM_DONTEXPAND
>> still seems a reasonable name (I've thrown in VM_PFNMAP there because
>> it's in the VM_DONTEXPAND test lower down: for safety I guess, and best
>> if both behave the same - though one says -EINVAL and the other -EFAULT).
> 
> I like this idea and am happy to mail a new patch. I think it may make
> sense to bring the lower block up here so that it becomes more clear
> that it's not duplicate code and that the MREMAP_DONTUNMAP case
> returns -EINVAL and other cases return -EFAULT. I wonder if the
> -EFAULT error code would have made more sense from the start for both
> cases, do you have any thoughts on changing the error code at this
> point?
> 
>> With that VM_DONTEXPAND check in, Dmitry's commit cd544fd1dc92
>> ("mremap: don't allow MREMAP_DONTUNMAP on special_mappings and aio")
>> can still be reverted (as you agreed on 28th December), even though
>> vma_is_anonymous() will no longer protect it.
> 
> I agree and if Dmitry does not have time I would be happy to mail a
> revert to cd544fd1dc92 as we discussed in [1]. Dmitry, would you like
> me to do that?

Ack. I was planning to send a patches set that includes the revert, but
that's stalled a bit. As the patch just adds excessive checks, but
doesn't introduce an issue, I haven't sent it separately.
Feel free to revert it :-)

Thanks,
          Dmitry
