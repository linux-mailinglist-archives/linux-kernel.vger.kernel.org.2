Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F5E4192A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhI0LAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233906AbhI0LAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632740335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DU2tEKUAlY+ocYQsPyHaalbfi4Dl+tChnbA8pJC5NVY=;
        b=FAI4nWvNQDraIzCzudkp7sv0Lt+2QjHGdkQ2ZsgIZnuC+HKxoLUZ/EDKhoS79hOawxITgV
        W6wKgartU27LnsAw/ao5yvY3bdLhN4hyfvxpNpKjDwpxp6VMA1FZW3iL8lBYxQ/SkwjLAW
        piLlsJH477wuCZtBF8ksFbAOm8evwl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-dVd34zldM7KRJYkhYAGILQ-1; Mon, 27 Sep 2021 06:58:54 -0400
X-MC-Unique: dVd34zldM7KRJYkhYAGILQ-1
Received: by mail-wr1-f72.google.com with SMTP id a17-20020adfed11000000b00160525e875aso6408321wro.23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DU2tEKUAlY+ocYQsPyHaalbfi4Dl+tChnbA8pJC5NVY=;
        b=sG4AfsI0EEgXaJy1W+SNIFyD7LzPSVScsihkiLgMd8zm3J8S0Gq6af0pzM0kPrd7JK
         z3Mgzr+7E12AtSgJa4wE710KppJ/v41ARNp8ESz+ZHFtKSubRwLqGLApfGhONM+fsfO9
         Yl5L6Wq8SQsirqv00vwiJGAThOinqpoGnajYKE8vg70Cd6/MyzjcY/mCXL547+gLlhPA
         ijwJlBnCb8OI9BGEKAOsC0jIR5IY36uKbwtUZGcWfvnbI/SplKV8eN98ujxQ0MGBz6m3
         BbdRKz2Y0Q8Pq7sBXS2YSAQ7Nqhrz5cqtIBX/MkSmcJV0utENpNwJZeRtNxkyn1xQMC0
         BpjA==
X-Gm-Message-State: AOAM531fT0PJsVymzpAU2tHzt+BVF0sEjSXCLBIWnFIz1h+pKhfAkxLA
        RCvEkcuwEbye9qbS91yRa/t4LJIUX9JcRfmiIvTG4OHhgJpbE9qrTbT0RntG63samklG8Ks6AFo
        Mx3iLxfvmTRM00kj3oVa6DHKH
X-Received: by 2002:a5d:510b:: with SMTP id s11mr26530696wrt.79.1632740333592;
        Mon, 27 Sep 2021 03:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyHr82sy5zMMJXOCRj4t1rZ7szWVDTeIxrDOVbQcYPewiT/8p5Ja0ykY8XorKK8O1oAU8gtQ==
X-Received: by 2002:a5d:510b:: with SMTP id s11mr26530684wrt.79.1632740333417;
        Mon, 27 Sep 2021 03:58:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id w21sm2755866wmk.15.2021.09.27.03.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:58:53 -0700 (PDT)
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Message-ID: <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
Date:   Mon, 27 Sep 2021 12:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 12:41, Nadav Amit wrote:
> 
> 
>> On Sep 27, 2021, at 2:24 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.09.21 18:12, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>> The goal of these patches is to add support for
>>> process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
>>> useful cleanups, a bug fix and performance enhancements are performed.
>>> The patches try to consolidate the logic across different behaviors, and
>>> to a certain extent overlap/conflict with an outstanding patch that does
>>> something similar [1]. This consolidation however is mostly orthogonal
>>> to the aforementioned one and done in order to clarify what is done in
>>> respect to locks and TLB for each behavior and to batch these operations
>>> more efficiently on process_madvise().
>>> process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it allows
>>> userfaultfd monitors to unmap memory from monitored processes; and (b)
>>> it is more efficient than madvise() since it is vectored and batches TLB
>>> flushes more aggressively.
>>
>> MADV_DONTNEED on MAP_PRIVATE memory is a target-visible operation; this is very different to all the other process_madvise() calls we allow, which are merely hints, but the target cannot be broken . I don't think this is acceptable.
> 
> This is a fair point, which I expected, but did not address properly.
> 
> I guess an additional capability, such as CAP_SYS_PTRACE needs to be
> required in this case. Would that ease your mind?

I think it would be slightly better, but I'm still missing a clear use 
case that justifies messing with the page tables of other processes in 
that way, especially with MAP_PRIVATE mappings. Can you maybe elaborate 
a bit on a) and b)?

Especially, why would a) make sense or be required? When would it be a 
good idea to zap random pages of a target process, especially with 
MAP_PRIVATE? How would the target use case make sure that the target 
process doesn't suddenly lose data? I would have assume that you can 
really only do something sane with uffd() if 1) the process decided to 
give up on some pages (madvise(DONTNEED)) b) the process hasn't touched 
these pages yet.

Can you also comment a bit more on b)? Who cares about that? And would 
we suddenly expect users of madvise() to switch to process_madvise() 
because it's more effective? It sounds a bit weird to me TBH, but most 
probably I am missing details :)

-- 
Thanks,

David / dhildenb

