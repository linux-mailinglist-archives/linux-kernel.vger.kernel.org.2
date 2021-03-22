Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AC3438CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 06:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhCVFwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 01:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:52:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 22:52:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v2so7906173pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jrTlyfiRQP0Jt7kq8QZFoM4VuMzt11eSTk3pvqVA7QY=;
        b=YAeNiVm0owARRZ8J86zOqgnrs/sywKok5qVDj67SztBIB9IHR+PwOEh/aZCWUCpE3L
         F16yrKLIthrKYhKCdHO1EAbhiFxaD72nFnwexy3ox4A7HBdijzE8VHG7jtptmM71QbQO
         Kl2vG24WjLENgZYdss4cmjq+iaeYGZfc5rHjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jrTlyfiRQP0Jt7kq8QZFoM4VuMzt11eSTk3pvqVA7QY=;
        b=O0FkSCFg4h11jQdhx772p4kbIJrZy7fbLxKKCE8maPTRkRrn3ZP4ty6TH6e46UuzHc
         yKM6UYbpIjiK0vVja3IOMB67b+YLSbd422ogC3W1hpBIqPO1tZJ8X31n/Zo7sik+jPzc
         pUuEnfxNwbp704cUJrMSxJbvo2REEdwOfrhKokRMvng6AvrYHfY3ixxFqnhfO9n7jw5f
         s7jo2nmXJwsORaFRUF4pBeKal+AnLe8FhipE2YvF0JIyzNAhjSQZCDR75p8Dui8DOhNp
         2VjbsdHfuNte8RD0ASs+QHccGaoCmJHx6ggVBno7rSP38S1OBzV63ULjOu17vNyiPQAy
         FCVQ==
X-Gm-Message-State: AOAM531OWunGk+3g6XfIqlW2ZcNY/g8Omg2DqwU0kaYWBJAWP+/6r5Bz
        twkfVfMeiX0En4AtZ4KlTH26hw==
X-Google-Smtp-Source: ABdhPJxYnbJhRJz/PWii4fLjBsRW4wnnSFzmMWXqQj/ARd+zZPwmpUweQXWSFt4ROYZs7QIZ2x4FPg==
X-Received: by 2002:aa7:9852:0:b029:211:6824:6c7d with SMTP id n18-20020aa798520000b029021168246c7dmr17530016pfq.19.1616392324492;
        Sun, 21 Mar 2021 22:52:04 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b3b5-fa56-fd12-3c5a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b3b5:fa56:fd12:3c5a])
        by smtp.gmail.com with ESMTPSA id nk3sm12514893pjb.17.2021.03.21.22.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 22:52:04 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v11 6/6] powerpc: Book3S 64-bit outline-only KASAN support
In-Reply-To: <20210322025934.GG77072@balbir-desktop>
References: <20210319144058.772525-1-dja@axtens.net> <20210319144058.772525-7-dja@axtens.net> <20210320060259.GF77072@balbir-desktop> <87o8fcatxv.fsf@dja-thinkpad.axtens.net> <20210322025934.GG77072@balbir-desktop>
Date:   Mon, 22 Mar 2021 16:52:00 +1100
Message-ID: <87lfafburj.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> writes:

> On Mon, Mar 22, 2021 at 11:55:08AM +1100, Daniel Axtens wrote:
>> Hi Balbir,
>> 
>> > Could you highlight the changes from
>> > https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170729140901.5887-1-bsingharora@gmail.com/?
>> >
>> > Feel free to use my signed-off-by if you need to and add/update copyright
>> > headers if appropriate.
>> 
>> There's not really anything in common any more:
>> 
>>  - ppc32 KASAN landed, so there was already a kasan.h for powerpc, the
>>    explicit memcpy changes, the support for non-instrumented files,
>>    prom_check.sh, etc. all already landed.
>> 
>>  - I locate the shadow region differently and don't resize any virtual
>>    memory areas.
>> 
>>  - The ARCH_DEFINES_KASAN_ZERO_PTE handling changed upstream and our
>>    handling for that is now handled more by patch 3.
>> 
>>  - The outline hook is now an inline function rather than a #define.
>> 
>>  - The init function has been totally rewritten as it's gone from
>>    supporting real mode to not supporting real mode and back.
>> 
>>  - The list of non-instrumented files has grown a lot.
>> 
>>  - There's new stuff: stack walking is now safe, KASAN vmalloc support
>>    means modules are better supported now, ptdump works, and there's
>>    documentation.
>> 
>> It's been a while now, but I don't think when I started this process 2
>> years ago that I directly reused much of your code. So I'm not sure that
>> a signed-off-by makes sense here? Would a different tag (Originally-by?)
>> make more sense?
>>
>
> Sure

Will do.

>  
>> >> + * The shadow ends before the highest accessible address
>> >> + * because we don't need a shadow for the shadow. Instead:
>> >> + * c00e000000000000 << 3 + a80e 0000 0000 0000 000 = c00fc00000000000
>> >
>> > The comment has one extra 0 in a80e.., I did the math and had to use
>> > the data from the defines :)
>> 
>> 3 extra 0s, even! Fixed.
>> 
>> >> +void __init kasan_init(void)
>> >> +{
>> >> +	/*
>> >> +	 * We want to do the following things:
>> >> +	 *  1) Map real memory into the shadow for all physical memblocks
>> >> +	 *     This takes us from c000... to c008...
>> >> +	 *  2) Leave a hole over the shadow of vmalloc space. KASAN_VMALLOC
>> >> +	 *     will manage this for us.
>> >> +	 *     This takes us from c008... to c00a...
>> >> +	 *  3) Map the 'early shadow'/zero page over iomap and vmemmap space.
>> >> +	 *     This takes us up to where we start at c00e...
>> >> +	 */
>> >> +
>> >
>> > assuming we have
>> > #define VMEMMAP_END R_VMEMMAP_END
>> > and ditto for hash we probably need
>> >
>> > 	BUILD_BUG_ON(VMEMMAP_END + KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);
>> 
>> Sorry, I'm not sure what this is supposed to be testing? In what
>> situation would this trigger?
>>
>
> I am bit concerned that we have hard coded (IIR) 0xa80e... in the
> config, any changes to VMEMMAP_END, KASAN_SHADOW_OFFSET/END
> should be guarded.
>

Ah that makes sense. I'll come up with some test that should catch any
unsynchronised changes to VMEMMAP_END, KASAN_SHADOW_OFFSET or
KASAN_SHADOW_END.

Kind regards,
Daniel Axtens

> Balbir Singh.
