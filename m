Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC94C45B202
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhKXCXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbhKXCXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:23:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7BC061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:20:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n8so608870plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vPzUdANZ6JjrPyy1OAsYCcoJwwnBIkZtVB6H/wjuicc=;
        b=Jl7apnmW67ouAcAMhWkZ3ZDTYRQHUDtmlvcs4ReNvb6uJreZlU/Jr9YOLWBQmLPN13
         +4kir69qyldny4EM2J1Jznpzn1b0UYNoRwEFBekpR72SuqNTppiAJuQjyaDcBfNYKsZT
         tGM0uQpc2mGtEF1vjCBQMJ8XYdtPTpf5WhzbhIXQTN9emJDtSGswTwkH1RmbNWuAYb2A
         WEBDTrvQqb8xcUXaL+AwcwUSvjoqZhNN45L18d8tIDYVvKSPwqBcRd777Vh44oUTNs6V
         k5eFY3ijmwwYht8PNS59xt8AQlfuo40snjUHh+iv2v70PKs53PI7MzYO6UNflIsN/t0l
         Er0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPzUdANZ6JjrPyy1OAsYCcoJwwnBIkZtVB6H/wjuicc=;
        b=250SIge8SjXcLzGbdbLoHddKsmIVDa5StFcfmn1bMvto8q6R7c0t+E18qACHRDZFU4
         kqP7mzThkqak/Fx5SwBMgPI2vS7yEcCxEGZbp8vAZZSGfXsKalDwpqaQ0cnM04JZ6LX8
         Y4JZpsLUpenq7/6geuSqVL63Hsql3pcGL8ogcWlTTa2Lq2SqkMeAvn0MOkYJxYDZMkGS
         uBAXR4ODrg4Hf5Z8z5HoegG24zF5f1Zy4xZvDvEDTC4sAkvWrjbcgf1Dd4Q7tLvC6bGy
         7V16H0ZU/QuGqWHWU2zbym542TDyoqfZScHcY0JMRD20QH3PAZ3lzmlpZxRP0exysjV9
         7OdQ==
X-Gm-Message-State: AOAM532+LuuILBbCNoDScNuUO8fzdjtOTmEt2GypRCABDEtwCYRhy0K3
        aZjJp2nV9NYtMH/JmNYRi5th2CT9pHi/iXG2GHR2XMvgOSJwug==
X-Google-Smtp-Source: ABdhPJw//6jHYsiw6J2hv2rMhFqeq1yedUp1wZmkuP2ypMFfAhC9OCP6NIDZ9FCqxEV2bc7pbH3Q4ENqHTIecYmBzJc=
X-Received: by 2002:a17:90b:4a01:: with SMTP id kk1mr10009142pjb.7.1637720405664;
 Tue, 23 Nov 2021 18:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20211123204644.3458700-1-yosryahmed@google.com> <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
In-Reply-To: <6ebcffe2-9513-cbea-a206-15ba927416c7@oracle.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 23 Nov 2021 18:19:29 -0800
Message-ID: <CAJD7tkYZY1g_b9E4ZP3yqHhT36nF57c4bzKRQM-SLftDCYNQ9A@mail.gmail.com>
Subject: Re: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 5:08 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/23/21 12:46, Yosry Ahmed wrote:
> > The hugetlb vma mremap() test mentions in the header comment that it
> > uses 10MB worth of huge pages, when it actually uses 1GB. This causes
> > the test to fail on devices with smaller memories.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'll let Mina comment, but I think I know what happened.

Thanks for taking the time to review this and explain what happened.

>
>
> The original version of the test did indeed use 10MB.  However, the mremap
> code must 'unshare' and shared pmd mappings before remapping.  Since sharing
> requires mappings of at least 1GB, the size was changed to make sure unsharing
> worked.
>
> In the end, I believe I suggested adding hugepage-mremap to run_vmtests.sh.
> The script does not try to configure a GB worth of huge pages.  And, I think
> it is somewhat unreasonable to suggest users gave a spare GB to run the test.

Alternatively, we can pass an optional argument to the test that makes it use
1GB instead of 10MB. This way, if the test is run with run_vmtests.sh the
default behavior would be to use 10MB, making sure users do not run out of
memory. Otherwise, an interested user could run the test without run_vmtest.sh
and provide the extra argument to make the test use 1GB and make sure that
unsharing works correctly. Thoughts?

>
> I'm OK with restoring the original value.
>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> --
> Mike Kravetz
