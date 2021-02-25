Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243C3250D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBYNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231960AbhBYNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614260858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgjC+rf5BpRHQVKEWQzIdMLice8BLuA8Q1gYTkfD844=;
        b=Z/uQbHjNHfaoKzGrK2Mtkc0fBrdysKOd7WQjN8gLuRQMcj1EKslQfHDb64CJ6KOXtt7bQU
        omf/KRU3PZsRiYl5UnNTnpM36yhjrRJcHmrjjWTHQen2oonDZtocfB3A+ORPy89zHtCFrh
        ZbJR2NyADTMIIBz5/XTsITU+a2Fgc5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-f7r-gXxdPe6w62d-1y8HYQ-1; Thu, 25 Feb 2021 08:47:34 -0500
X-MC-Unique: f7r-gXxdPe6w62d-1y8HYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E40A8799E0;
        Thu, 25 Feb 2021 13:47:32 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE4919C79;
        Thu, 25 Feb 2021 13:47:29 +0000 (UTC)
Subject: Re: [PATCH] memblock: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210225133808.2188581-1-arnd@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <60989b76-1ae6-6be3-0277-df9f0cc8dc3e@redhat.com>
Date:   Thu, 25 Feb 2021 14:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225133808.2188581-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.21 14:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The inlining logic in clang-13 is rewritten to often not inline
> some functions that were inlined by all earlier compilers.
> 
> In case of the memblock interfaces, this exposed a harmless bug
> of a missing __init annotation:
> 
> WARNING: modpost: vmlinux.o(.text+0x507c0a): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> The function memblock_bottom_up() references
> the variable __meminitdata memblock.
> This is often because memblock_bottom_up lacks a __meminitdata
> annotation or the annotation of memblock is wrong.
> 
> Interestingly, these annotations were present originally, but got removed
> with the explanation that the __init annotation prevents the function
> from getting inlined. I checked this again and found that while this
> is the case with clang, gcc (version 7 through 10, did not test others)
> does inline the functions regardless.

Did I understand correctly, that with this change it will not get 
inlined with any version of clang? Maybe __always_inline is more 
appropriate then.

(I don't see why to not inline that function, but I am obviously not a 
compiler person :) )

-- 
Thanks,

David / dhildenb

