Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75234419EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhI0TO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhI0TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:14:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF664C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:12:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w11so12423556plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JwJyK7N3stT1d99uOVX86AHHjz0tWmo934uZkOorD2Q=;
        b=WOR+lCS1jhG5TSAziWDxoy+7Ec2xaN4xm2hc+ADK5nOPksAvgZgC+3F4Yt/FwKp78k
         O9jDxSIihtr6Swr6+/ShY302p/NlqzrlutmlR9NqxauNElF4x/tibRebfEhGdEs8ELzs
         Tg8ARGS6W2ATDMXhk5HDPRDOSLF4jCM+rxXdL9ZM9HDDApMaZqrF8aHy2Iu3T2WQny/u
         YHnHARsZAh8kH4r7vszFtc9pn/nDZiN6fS3HbcsiI3A/ITufTBKfTApHwTImf9KBV57B
         J8NGoAT+AZCJnPqBYfA/ww/PX1ysvDn/L0bAfadjX80lUa2x+ki/Fzu+gvn4RcdK14jA
         JjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JwJyK7N3stT1d99uOVX86AHHjz0tWmo934uZkOorD2Q=;
        b=wIkwWepHCIV6SjNkh5689PXPVDxkwJwxNQerWc2L/L/uUZcmsajBUGgU7+uxTpV3Tv
         UIeyOTSgkpUw4NMzm5OjgEWTv4uSzqCblxLiJWnhWVHzxd/eHAdNxUqI8Rmnktn8ce9l
         e42X7mjd4Irg3Co00SJqc58Tk6AMS/E2HJrwNVU1ra0MpSFxuDUXOYAMg/xygwE2GGkb
         +1oT8J85Z4iSntbp5T0EZgwg7y/7juRBSEjtHShIglg2rOq6m2r3aNcBHtzjF6y7Lxm4
         n+9REY0oeblAdKiaNA0ZT8owtdbipjPSQDzP7lP6Cy5whfUsqdRSyl5pYA4HiG2axy4P
         QhXQ==
X-Gm-Message-State: AOAM530KClMWNK6j1YOS8LijJXiWFyNNnzLsqwW5BmXiIgvik3J0pt7f
        YqW/ETMXd6lmW/z7tz+XLD0=
X-Google-Smtp-Source: ABdhPJx7oKgHeOh+O/ULmVGeDr1qEHj92573qMh3mONI/f14Nn9OUBuD/qsrczXO14SKYYE2IbP0OQ==
X-Received: by 2002:a17:90b:4b8f:: with SMTP id lr15mr749432pjb.163.1632769969128;
        Mon, 27 Sep 2021 12:12:49 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id v26sm18473558pfm.175.2021.09.27.12.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 12:12:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
Date:   Mon, 27 Sep 2021 12:12:46 -0700
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@suse.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
>=20
> On Mon 27-09-21 05:00:11, Nadav Amit wrote:
> [...]
>> The manager is notified on memory regions that it should monitor
>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these =
regions
>> using the remote-userfaultfd that you saw on the second thread. When =
it wants
>> to reclaim (anonymous) memory, it:
>>=20
>> 1. Uses UFFD-WP to protect that memory (and for this matter I got a =
vectored
>>   UFFD-WP to do so efficiently, a patch which I did not send yet).
>> 2. Calls process_vm_readv() to read that memory of that process.
>> 3. Write it back to =E2=80=9Cswap=E2=80=9D.
>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
>=20
> Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?

Providing hints to the kernel takes you so far to a certain extent.
The kernel does not want to (for a good reason) to be completely
configurable when it comes to reclaim and prefetch policies. Doing
so from userspace allows you to be fully configurable.

> MADV_DONTNEED on a remote process has been proposed in the past =
several
> times and it has always been rejected because it is a free ticket to =
all
> sorts of hard to debug problems as it is just a free ticket for a =
remote
> memory corruption. An additional capability requirement might reduce =
the
> risk to some degree but I still do not think this is a good idea.

I would argue that there is nothing bad that remote MADV_DONTNEED can do
that process_vm_writev() cannot do as well (putting aside ptrace).

process_vm_writev() is checking:

	mm =3D mm_access(task, PTRACE_MODE_ATTACH_REALCREDS)

Wouldn't adding such a condition suffice?=
