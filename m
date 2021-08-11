Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0733E8CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhHKJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhHKJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:01:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409DC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:00:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4405762pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kSyI3SmELqQa8PcfQwpbR3tVKpwCAsftvqYV3r6gJvw=;
        b=AmCcYc7GFMsPKwA1HAYYq2L1ZaTSxdDekOqcFv665ZxeFUoMsJ//vFShTbDUX09v8G
         ER/R0Ck+yvOKY2i+e1jt9dZ9KsV/82Mz/df3u1ecSKWAclbDl8aO0tri8LXSlN2tKB8d
         euTuxgrMMbp/5/pY9W0o+M9+EObyK6bh0sCLDBqS8Vaxxw3DHuagOFXzsr/+fzHtNO78
         Mv2A3cgNuFYBXv7ZG+V+82pDVEjHdqJLuHDqyUvw8a6k0OKB3S0v2Q6oWqfKZeetA1OC
         GcgKqpUy33ZKsRtBoWCawEV8CqIfuYOOwKYCKOKVhStRLB366zGPEN9gOYyObwMG4GbD
         BVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kSyI3SmELqQa8PcfQwpbR3tVKpwCAsftvqYV3r6gJvw=;
        b=I69yBmWQiuH2Hxhj1D+LS2th6kpPTC10PK+AgE9Kyv8OfQWCbCoi42q3i8OZ6uNXJl
         O432ni5tudYBVmmTc+Q6kII/NpUGekAkeQhminOAj23LrquAZnyw5s9AzOnNLMv1C7Bm
         OCmoS/wR0uqpL56RLuE5b27aSh4Spu30k6ONRxlqF9/6zMBUA3WqB7eRLFgBWqtw9+pv
         Es7d1b520Py4Ue8BkIIXquiYwbF0SU3xgGTwoFHQem1UFwTf4qFfjUDLVsNWk8DPvcSO
         4OTu5sKREhvxuFDudAQHqU1uxhqwGeZTzPHeuWL9S7zVrS/iJ31ZYTHBxjftOrzy8YPt
         njsw==
X-Gm-Message-State: AOAM530k5lAiROWvAn5YeIn0YTVB/XRxvbOo4i/lbuofpxWgFOitgp8h
        9nqYDNILRCCtNHIU9LkhBABkGYSKWVkJe42X5F8JnhZjiloYjQ==
X-Google-Smtp-Source: ABdhPJwyeMPM88Rz4hDcTJfg+x6fnIEuuuWa+KurCtL+RVOTbY2GsmgFZ8qzQv8SK/9C+JC6vj+QQ8MC9jLINHDSKFg=
X-Received: by 2002:a17:902:8ec6:b029:12b:ab33:15d4 with SMTP id
 x6-20020a1709028ec6b029012bab3315d4mr28715822plo.80.1628672453462; Wed, 11
 Aug 2021 02:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210805043503.20252-1-bvanassche@acm.org> <20210805043503.20252-4-bvanassche@acm.org>
 <20210809145953.GB21234@lst.de> <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
 <20210810165029.GA20722@lst.de> <9b1e5c35-1d11-0afa-d382-6f5dc0b14a23@acm.org>
 <e329b0a1-ffe4-9bfa-2bea-33e17da70f58@linuxfoundation.org>
In-Reply-To: <e329b0a1-ffe4-9bfa-2bea-33e17da70f58@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Aug 2021 02:00:42 -0700
Message-ID: <CAFd5g45hMt9OwAVDVuxLNa2EfkTH0tY=KS_qxoUmndPYDvnyig@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:50 PM Shuah Khan <skhan@linuxfoundation.org> wrot=
e:
>
> On 8/10/21 12:45 PM, Bart Van Assche wrote:
> > On 8/10/21 9:50 AM, Christoph Hellwig wrote:
> >> On Mon, Aug 09, 2021 at 11:31:23AM -0700, Bart Van Assche wrote:
> >>>>> +config CONFIGFS_KUNIT_TEST
> >>>>> +    bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
> >>>>> +    depends on CONFIGFS_FS && KUNIT=3Dy
> >>>>> +    default KUNIT_ALL_TESTS
> >>>>
> >>>> Why does it depend on KUNIT=3Dy?  What is the issue with a modular K=
UNIT
> >>>> build?
> >>>
> >>> The unit tests calls do_mount(). do_mount() has not been exported and
> >>> hence is not available to kernel modules. Hence the exclusion of KUNI=
T=3Dm.
> >>
> >> You should probably document that.  But then again this is another
> >> big red flag that this code should live in userspace.
> >>
> >>>> To me this sounds like userspace would be a better place for these
> >>>> kinds of tests.
> >>>
> >>> Splitting the code that can only be run from inside the kernel (creat=
ion
> >>> of configfs attributes) and the code that can be run from user space =
and
> >>> making sure that the two run in a coordinated fashion would involve a
> >>> significant amount of work. I prefer to keep the current approach.
> >>
> >> But userspace is the right place to do this kind of pathname
> >> based file system I/O.
> >
> > Shuah, as selftest maintainer, can you recommend an approach? How about=
 splitting patch 3/3 from this series into a kernel module (the code that c=
reates the configfs test attributes) and user space code (the code that rea=
ds and writes the configfs attributes) and adding the user space code in a =
subdirectory of tools/testing/selftests/?
> >
>
> I am missing a lot of context here. I don't see this series in my inbox
> except patch 2/3 which says:
>
> "A common feature of unit testing frameworks is support for sharing a tes=
t
> configuration across multiple unit tests. Add this functionality to the
> KUnit framework. This functionality will be used in the next patch in thi=
s
> series."

Yeah, I mentioned this to one of the other KUnit people who said he
might want to post some comments. Bart, could you CC
kunit-dev@googlegroups.com and/or linux-kselftest@vger.kernel.org
if/when you send follow-up patches?

Actually, I suppose regardless of what you do with this patch, you
will probably want to merge via the kselftest tree (KUnit changes and
many tests go through the kselftest tree as well). So, you should
probably CC linux-kselftest@vger.kernel.org no matter what.

> That doesn't tell me much other than what happens that it is a common uni=
t
> testing framework without explaining why it should be done this way.
>
> Taking a quick look at the original message on lore - I agree with Christ=
oph
> that this code belongs in userspace. I would like to see the division of
> kernel userspace.
>
> Why do the unit tests need to call do_mount() - can whatever the unit tes=
ts
> are currently doing can be done from userspace.
>
> If part of the test code must live in kernel space then kernel test modul=
e
> approach can be used.
>
> thanks,
> -- Shuah
>
>
>
>
