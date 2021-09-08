Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6273D403C42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbhIHPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230427AbhIHPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631113558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Ad9DFQSsq3fHXyiG5m3BVq+9Z/Oihbev+MnnMwC4Pg8=;
        b=Simn35SbkWzGoPZRlYrvFADlDELIHegvvJ2GOlYvy9BjtmXOuMM1UYhm0B0z7yTSZNzyVb
        LTyqJruDAcxDrIEnuf6iwhjuCVYS10EfN0i/YXT8wNiBDv860a8ouyCqxN2gb/MixiM0X3
        LMfQnvJi46biPzSvzu7k2hWPvfGjcqI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-d2VToXkcPz64spuMtcdOWQ-1; Wed, 08 Sep 2021 11:05:56 -0400
X-MC-Unique: d2VToXkcPz64spuMtcdOWQ-1
Received: by mail-ot1-f70.google.com with SMTP id n42-20020a9d202d0000b02904fc72900a74so1425956ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ad9DFQSsq3fHXyiG5m3BVq+9Z/Oihbev+MnnMwC4Pg8=;
        b=T2GxZEQyx2e9gWiOxErMcFxbjE1XOCaS7GA3canXTf3Yywdi/H1yH3dLkbhXiVTvzY
         lfHKcVnh9zxH271a5keLulg/KTRn959oXthrqdKnm/nKDxVV6+f7zO7rBN9JvwlqmtPh
         OgwXbl6gGyUpF+6ZP6VthNZ21jMAeBhFzvPk9LWWq3MuNdjtUZKD9lXl/ROoGd2BagU1
         YtIQpy0nFHnei3p+Jh/4cQz9pc4gYxOkOSWnadMv5mVfdsKvraNN7SWP/6tXuj6MCDP0
         ESYVj8A20YNfpOPb3FXQv2/iBmyOPRkMh+NnRdZ2jcNACXEzXkNHojLbEQGR9GHWNFRu
         gqEg==
X-Gm-Message-State: AOAM530QPhGpp6QPmnknrv267lqyIOwSAVCJvm1j+W2kJu0kkS2DvkI4
        qPtJjfWeObQ6U00aeoIaKt4gHMF5ESIJ62nM7SaAQyBZB34VkORdLbH8wjaBsi+1i6MMzb1BSh1
        gUIgAZlb/v0RcTGijHEh/DcyzX7gSzSNh7ECAcyw0
X-Received: by 2002:a9d:410:: with SMTP id 16mr3508959otc.83.1631113554198;
        Wed, 08 Sep 2021 08:05:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNwhfrPjYz0TBvXz2yBE0Vw4Bvf2XX2PefwsBRuoCSOINCSphhqDxJejdQnNjxD8gCHVJz+22J4TiL+hTiCEg=
X-Received: by 2002:a9d:410:: with SMTP id 16mr3508819otc.83.1631113552492;
 Wed, 08 Sep 2021 08:05:52 -0700 (PDT)
MIME-Version: 1.0
From:   Ulrich Drepper <drepper@redhat.com>
Date:   Wed, 8 Sep 2021 17:05:41 +0200
Message-ID: <CAP3s5k_QNQqjMqLP68KvtchpmUGc9dnfSfmsz2OXh6opFpKW+w@mail.gmail.com>
Subject: implicit dependency in x86/page_64.h:task_size_max
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a 5.14 kernel installed, yet, but from the looks of it
this problem still persists.

Out-of-tree modules were broken by commit
025768a966a3dde8455de46d1f121a51bacb6a77 which introduced a dependency
on a CPU feature macro in the task_size_max implementation
(X86_FEATURE_LA57) without making sure the macro is defined.  The
result is that the compiler generates an object file with an reference
to a symbol with this name.  The resulting modpost invocation catches
this.

An example for the problem exists with the blackmagic-io module. I
name it here so people can perhaps find this post.

The "solution" so far is to include <asm/cpufeatures.h> before
task_size_max is defined.

In userlevel headers we had the convention that any header should
#include all the other headers to satisfy its dependencies.  If
arch/x86/asm/page_64.h would include <asm/cpufeatures.h> first there
would be no problem with the module above but I haven't checked
whether this creates other problems.  And as I mentioned, I don't know
what the convention is.

Someone will know and perhaps we could get a patch installed with
either the missing #include added or

#ifndef X86_FEATURE_LA57
# error "you need to include <asm/cpufeatures.h> first"
#endif


Thanks.

