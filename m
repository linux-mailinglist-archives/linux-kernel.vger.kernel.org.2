Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60124451D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbhKPAZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349938AbhKOUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:20:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C235C043194
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:59:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z34so46534839lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bvO6+jUD2mJW1UC7y5qeYQeTnfpZN547VLV7YgyXAGk=;
        b=qqov+BzX7laf/ZvbnmqQgqWQZGU9HYEeiHbsQhDAVGGlv66PY74t+XuKDjedOLrHRi
         LpsXRyr9z0S0IesXCOUBZKjBYMmztagwoaBgalfbRrxhoTKwdlfIZLO3/d/w5x/fKANO
         JCoq7L6l7rBdWlBB1ngUSwUYJU5eRmbhB3DIpOsvNT/IDQJu7xwHUSGJGxcb1QIlW0pS
         qDGPKd3UXL7hHxF6IAzZi6kXmhsYDYDW9m1uY9E42FkqwCObJ/IgOcE2PhsRAhH2B0AA
         nwRcea6Y+rAoKmCWgMfnJDIi3QAprLUQTEjMrKM6OTkGVeBLszE7HOhVlfQaDaeIxOFt
         7eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bvO6+jUD2mJW1UC7y5qeYQeTnfpZN547VLV7YgyXAGk=;
        b=4wypCer9IvwijXNKZhvrBKLsZaS+0Sc3jv9rqkbNsMLnBWY0xm/ImNYAyMXlGZvrsZ
         fC963pumax0nsP3zhIRiqfjyZ0KAUFJm9hKkty5vArjst2Iu+aBLaBzrgDZ/NsHnAsGn
         uJLWRVC+DnRV1lngGT/OqY7R4RR0BgdxPZZAsqx+uv1K0xmeBTXSK8VkjX0XuTCmZUY0
         EkU13JFNDjdHn/MJb9ERIEB5C2bB5YUFojhZEI6bq/pYtFRosCQTAPLVvl6VGyT3mwWx
         toSxFhZJII4b3NZu8lzQ/UiMP9KW2SnpLQ4V79Pw/AqNAdkWCiFS0HMJkDxdPjmJlRfj
         36LA==
X-Gm-Message-State: AOAM533nLnpfN+n05DRd57ZznnHEHGqLqP/ASWYdibqSASsOucS4gU+A
        T43JAm54f2yn05h5Ow/QakLRiv0qDDatQLppMmCiag==
X-Google-Smtp-Source: ABdhPJwPT2yBfWQWiQx2895cp83Iu148A7FQbjPlqJjVMESBp8jP2FgR3QkSFB3K+S80lU80ZBXwECWAoSZumjikBvQ=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr1243783lfg.184.1637006356326;
 Mon, 15 Nov 2021 11:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
 <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com> <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
In-Reply-To: <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Nov 2021 11:59:03 -0800
Message-ID: <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>,
        Marco Elver <elver@google.com>, paulmck@kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

)

On Mon, Nov 15, 2021 at 10:55 AM Mina Almasry <almasrymina@google.com> wrot=
e:
>
> On Mon, Nov 15, 2021 at 10:22 AM Mike Kravetz <mike.kravetz@oracle.com> w=
rote:
> >
> > Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
> >
> > To:        Muchun Song <songmuchun@bytedance.com>, Shakeel Butt <shakee=
lb@google.com>, Mina Almasry <almasrymina@google.com>
> >
> > Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah=
@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@=
suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.c=
om>, Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>, Joanna Li <jo=
annali@google.com>, Cannon Matthews <cannonmatthews@google.com>, Linux Memo=
ry Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org=
>
> >
> > Bcc:
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> > On 11/14/21 5:43 AM, Muchun Song wrote:
> >
> > > On Sun, Nov 14, 2021 at 3:15 AM Shakeel Butt <shakeelb@google.com> wr=
ote:
> >
> > >> On Sat, Nov 13, 2021 at 6:48 AM Mina Almasry <almasrymina@google.com=
> wrote:
> >
> > >>> On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.c=
om> wrote:
> >
> > >>>> On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.=
com> wrote:
> >
> > >> We have following options:
> >
> > >>
> >
> > >> 1) Use atomic type for usage.
> >
> > >> 2) Use "unsigned long" for usage along with WRITE_ONCE/READ_ONCE.
> >
> > >> 3) Use hugetlb_lock for hugetlb_cgroup_read_numa_stat as well.
> >
> > >>
> >
> > >> All options are valid but we would like to avoid (3).
> >
> > >>
> >
> > >> What if we use "unsigned long" type but without READ_ONCE/WRITE_ONCE=
.
> >
> > >> The potential issues with that are KCSAN will report this as race an=
d
> >
> > >> possible garbage value on archs which do not support atomic writes t=
o
> >
> > >> unsigned long.
> >
> > >
> >
> > > At least I totally agree with you. Thanks for your detailed explanati=
on.
> >
> > >
> >
> >
> >
> > Thanks everyone.  This makes sense.
> >
> >
> >
> > However, I should note that this same situation (updates to unsigned
> >
> > long variables under lock and reads of the the same variable without
> >
> > lock or READ/WRITE_ONCE) exists in hugetlb sysfs files today.  Not
> >
> > suggesting that this makes it OK to ignore the potential issue.  Just
> >
> > wanted to point this out.
> >
>
> Sorry I'm still a bit confused. READ_ONCE/WRITE_ONCE isn't documented
> to provide atomicity to the write or read, just prevents the compiler
> from re-ordering them. Is there something I'm missing, or is the
> suggestion to add READ_ONCE/WRITE_ONCE simply to supress the KCSAN
> warnings?
>

+Paul & Marco

Let's ask the experts.

We have a "unsigned long usage" variable that is updated within a lock
(hugetlb_lock) but is read without the lock.

Q1) I think KCSAN will complain about it and READ_ONCE() in the
unlocked read path should be good enough to silent KCSAN. So, the
question is should we still use WRITE_ONCE() as well for usage within
hugetlb_lock?

Q2) Second question is more about 64 bit archs breaking a 64 bit write
into two 32 bit writes. Is this a real issue? If yes, then the
combination of READ_ONCE()/WRITE_ONCE() are good enough for the given
use-case?

thanks,
Shakeel
