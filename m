Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F00419FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhI0UKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbhI0UKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:10:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A23C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:08:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x191so11897848pgd.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7vfeR4njAq3wig4eIDg5vJWu2BlZRMH3u0oFW9QEQ9w=;
        b=SsW7qCUbROeP/CRGUzOa/Br/izmzwYUvqgGPPapsOJUFectwunG0+JKeVS650qdteG
         sIK2gOB+Aj+Z2DH2JSqei6vvko+R2+RJScrsFzHb0Rzr++1I2yxjtpdSIo/7LvVHJkVL
         mYOFe8MSLVBMO61BUfnBzNBKb7myMOqT5cMJIZXTlee2Qw8jp1hl+30JJxmg9aYLyITs
         MFQvQkFPtRcW9mVy+6bpQ4Qrts5XKxte0gRcfqQlcY+XKenStsQRqX4bnc3dU9jpK1TU
         IyiDnYzjMzVGcInhPec7jUHvXInfc5MCIgBacugdGOeQT+9tEkeRzDJoWZc9y85ju68M
         fJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7vfeR4njAq3wig4eIDg5vJWu2BlZRMH3u0oFW9QEQ9w=;
        b=77W9JPM9hP+4o6lJt4+BG60WFFPFxtylO42Tw4WOibuCO9v/QdgyURBcub89D0tY+K
         MoHKroQ+RI1rZY0wYbnvUUhvKoqlUR96JVPKw320U2zvj3UXAE86ojsFkcwO4boPgfpL
         OQ5MFQRrMiCVEFc92548CRvRzFspYnP4HCdKe8J/fcTTrkeViTfjyTnjMpmEzec+iXBN
         ZaStT9jS5PJ2JMViI3C1RyVTCqD8rmbl4Z07uT1XmFuxULDHwkOEzTYRIOniALJIeMg5
         Ahm5reLgPI7EA8PK/TljfDeIVmwyDUJ0GKvW/wnWesjbrdHflL6EJRNeuET4dJD8zZe8
         WbpQ==
X-Gm-Message-State: AOAM531g7YhrDtU0NunRece4CCQyU4TCHvlkV3nn1Q4WI8b1jNGkdTkM
        1Ymp+MJicqVBI7XPiB+JLlg=
X-Google-Smtp-Source: ABdhPJxMhzemCh6titSeULgvX9XVFW7lxrKL7aHyl30hKz1EKVwHYkX4MyOwF6b6eKltSLRKeac3TQ==
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id b140-20020a621b92000000b003eb3f920724mr1517989pfb.3.1632773322625;
        Mon, 27 Sep 2021 13:08:42 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id i27sm17941840pfq.184.2021.09.27.13.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:08:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <21c6a41d-3f65-6a49-f604-b75ef53d2910@redhat.com>
Date:   Mon, 27 Sep 2021 13:08:40 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75ECD9E1-4696-42CB-BD84-FF9C350BB227@gmail.com>
References: <20210926170637.245699-1-namit@vmware.com>
 <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
 <A7E15D2B-FFED-4F21-88F4-227E7228782D@gmail.com>
 <21c6a41d-3f65-6a49-f604-b75ef53d2910@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 10:06 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 27.09.21 12:19, Nadav Amit wrote:
>>> On Sep 27, 2021, at 2:29 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 26.09.21 19:06, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>> Non-cooperative mode is useful but only for forked processes.
>>>> Userfaultfd can be useful to monitor, debug and manage memory of =
remote
>>>> processes.
>>>> To support this mode, add a new flag, UFFD_REMOTE_PID, and an =
optional
>>>> second argument to the userfaultfd syscall. When the flag is set, =
the
>>>> second argument is assumed to be the PID of the process that is to =
be
>>>> monitored. Otherwise the flag is ignored.
>>>> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
>>>> misuse of this feature.
>>>=20
>>> What supposed to happen if the target process intents to use uffd =
itself?
>> Thanks for the quick response.
>> First, sorry that I mistakenly dropped the changes to userfaultfd.h
>> that define UFFD_REMOTE_PID.
>=20
> Didn't even notice it :)
>=20
>> As for your question: there are standard ways to deal with such =
cases,
>> similarly to when a debugged program wants to use PTRACE. One way is
>> to block the userfaultfd syscall, using seccomp. Another way is to do
>> chaining using ptrace (although using ptrace for anything is
>> challenging).
>> It is also possible to add tailor something specific to userfaultfd,
>> but I think seccomp is a good enough solution. I am open to =
suggestions.
>=20
> If we have something already in place to handle PTRACE, we'd better =
reuse what's already there. Thanks!

Just to ensure we are on the same page: I meant that this is usually
left for the user application to handle. The 2 basic solutions are to
not expose userfaultfd to the monitored process (easy using seccomp)
or to chain the two monitors (hard using ptrace).

Since ptrace is hard, in theory we can have facilities to =E2=80=9Chijack=E2=
=80=9D
a context and =E2=80=9Cinject=E2=80=9D uffd event to another monitor. I =
just think
it is a total overkill at this stage.=
