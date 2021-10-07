Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50329425902
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbhJGRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbhJGRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:15:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6533BC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:13:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l7so25886596edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2dvXNugsoPW/z2kbg9B0jr7MY21MWdNmDDiosCNYNo=;
        b=NRrjMl40Ai5Wwg6r2HfzNaX7KgC9suCtZTXy6M/Wo51m82Jd2SEJcBGUHrWDLwwD/k
         DOr6dbyEz7eIU1z1djoGaDiRZKbd8buR4Ju9r19VjcX+uN548VOLmwFzQR4392usqwpg
         zytpMv2YLaUtzOaixFOnuRvmisvWHj2sr4goOKJzlm5B+XFddwPmgwdBG1RtXqp3xycJ
         0wddOD5iNkk0pHTcOjU76tc1TvpNoaQmCC53F9BB9u1zDGwYACO/PqQxLGg9dZP1QUvx
         jEnZJojs0dK0DlZPIEoBLeTl1gEVY8M8HgJH5NeWVpUGU/WARR17Mrf2wjCSd18gKlWJ
         rrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2dvXNugsoPW/z2kbg9B0jr7MY21MWdNmDDiosCNYNo=;
        b=q0HqX4oUD9Gnmweodd+aD6eEXJNdnE5VuKt9BF2t4rAr8hmcKbZ+/2nzNmF/kqnzHN
         +gQE9Dj9nj89PIiXDcMoIBv4o3EsFPP6Gn5Rr0UgtCWOKd960DcySJxZFXKgcwiEf167
         mJbYwl4LiBN1d1akoQEswPXW2UQzovCSIP8wqSYE5BPbmw9/8YsgtsN3ISgMmsP06bM0
         A/4XLVReEBdT7bXDEZ1ZeW28oz/wvVT3ORm/LYiPajWRUPAA3VHvJVcUbu7/LMWLOKjI
         27LavUjDtIKadSK0dDgKEN0TTHVvRGg2ERtxM+AtI/WORsU+2kMC+NKrKpvNWjPHLlDm
         EGqg==
X-Gm-Message-State: AOAM531NNDYP/1LxlROmCXq85kkfMPawL0mUu4h2cLm0SoRI40G72Ayc
        wzOHiXT50g+L43uqU/V32H0mZgym0g==
X-Google-Smtp-Source: ABdhPJzX7PqWR0ajzaWdC2wkEf6Z1UOwiddl46AwT86fnXJckjmXCIGKK3g+742gHxSIbSmK1llnZQ==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr7605932edd.129.1633626794018;
        Thu, 07 Oct 2021 10:13:14 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id c11sm21772edw.5.2021.10.07.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:13:13 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:13:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <YV8qp6J+HW0ciLVP@localhost.localdomain>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
 <20211005172129.4092cc4148bbcac36a128b55@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211005172129.4092cc4148bbcac36a128b55@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:21:29PM -0700, Andrew Morton wrote:
> On Sun, 3 Oct 2021 15:11:24 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Kernel assumes that ELF program headers are ordered by mapping address,
> > but doesn't enforce it. It is possible to make mapping size extremely huge
> > by simply shuffling first and last PT_LOAD segments.
> > 
> > As long as PT_LOAD segments do not overlap, it is silly to require
> > sorting by v_addr anyway because mmap() doesn't care.
> > 
> > Don't assume PT_LOAD segments are sorted and calculate min and max
> > addresses correctly.
> 
> It sounds good, but why do I have the feeling this will explode in some
> unexpected fashion?  Because it's elf, and that's what it does :(

Good news, it is ELF, we'll hear about breakage immediately. :^)

Kernel "enforces" PT_LOAD ordering: if total mapping size overflows,
then mmap will reject it. I hope every ELF binary maintains ordering.

But! total_mapping_size() only looks at first and the last PT_LOAD
segments which is obviously incorrect.
