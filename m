Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC431C7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBPJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhBPJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:06:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54774C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:04:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z7so5141279plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hix40Xj1oUuEJXyWgpErtznzZizVsi/XpFAKnYjHmQY=;
        b=eCXmzNSbiTk7i4WkXniq28m9G37QrlWzW+DY39V8ZNK5WTP7spj9JBNl/75AUeXslS
         pJixcJGyqDLo4/gX0Lkr+1LUgrtreYH6pDPPHtbPLnLkeQx/1x9tDVzu0zNv77WPe+uF
         QM23Y4vse2SXdXjhaYvzlAGwnbVJnKqbsBbszex9XCw8oV+SmfE5m6RQXxoFgr5eVZn/
         qINrIHGW1sADmAiL0WIfXKeZ8p6SxtIV13mV/bwjr35huaocQRV4X7kDW1oPkdZE79ZV
         Nbja5Hzu2TLV6H4VkmcjRP+LCxUc2OcC22SZjbz8IJ8OdTlvir4xzCcY9KhtszgDIiwM
         fSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hix40Xj1oUuEJXyWgpErtznzZizVsi/XpFAKnYjHmQY=;
        b=JG1jXtjjy6Ynn/pJ4KXTT++kZE7PcpvzHKS2+MlybVavxHZx2hJZ5dPbQRW1a7IHgB
         yEeB38o97dsHnJ0Riv0DviINmBgHc/VNiG73X1JNreo8/QiYZ7fobginHqPk1VEB+N3k
         Z/r7+j1ASW6IpdwksyY82Z/f612DO7TczJ+wqwWx9bgsLgF6mQg3G5ThsnzCOesjLPqy
         XOFYAIxO9R+OtdvWE83E7rElr4ofIl+vQC5d8bhQuotO9JpmzM3ifjWRg5hupOeIHXw5
         1fSPI+226SMFgjS7ceFB/U/eOss2Xdhe7qFkeLaVnDJ7RWJaRbGMu+ln4mwNdMgNKDEx
         p7wQ==
X-Gm-Message-State: AOAM533i23qqLUTrirCY5DIsAiyXhO3ityjpA4km1RyXg4Q8chc+PHcz
        Lar17cUTihapRu8ljpOXjv6+KAVKIN7pgI9BQJakmA==
X-Google-Smtp-Source: ABdhPJwC+CdCVmurJuKhxiNJoI3GMzP36B8CJFWc2NOLZbqlE1QsTOfDQR+oZ/rFDU9LQIN8Yydx6cwaPCiXV/F65I8=
X-Received: by 2002:a17:90b:286:: with SMTP id az6mr1469474pjb.147.1613466258888;
 Tue, 16 Feb 2021 01:04:18 -0800 (PST)
MIME-Version: 1.0
References: <CAMZfGtWT8CJ-QpVofB2X-+R7GE7sMa40eiAJm6PyD0ji=FzBYQ@mail.gmail.com>
 <YCpmlGuoTakPJs1u@dhcp22.suse.cz> <CAMZfGtWd_ZaXtiEdMKhpnAHDw5CTm-CSPSXW+GfKhyX5qQK=Og@mail.gmail.com>
 <YCp04NVBZpZZ5k7G@dhcp22.suse.cz> <CAMZfGtV8-yJa_eGYtSXc0YY8KhYpgUo=pfj6TZ9zMo8fbz8nWA@mail.gmail.com>
 <YCqhDZ0EAgvCz+wX@dhcp22.suse.cz> <CAMZfGtW6n_YUbZOPFbivzn-HP4Q2yi0DrUoQ3JAjSYy5m17VWw@mail.gmail.com>
 <CAMZfGtWVwEdBfiof3=wW2-FUN4PU-N5J=HfiAETVbwbEzdvAGQ@mail.gmail.com>
 <YCrN4/EWRTOwNw72@dhcp22.suse.cz> <CAMZfGtX8xizYQxwB_Ffe6VcesaftkzGPDr=BP=6va_=aR3HikQ@mail.gmail.com>
 <YCt/N9LkJT1VJEW1@dhcp22.suse.cz>
In-Reply-To: <YCt/N9LkJT1VJEW1@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Feb 2021 17:03:42 +0800
Message-ID: <CAMZfGtVLv7_7sRO0tXiVY_RuAWxTEHz6G=-r7mOXViNhRNPf5A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:15 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 16-02-21 12:34:41, Muchun Song wrote:
> > On Tue, Feb 16, 2021 at 3:39 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > Using GFP_KERNEL will also use the current task cpuset to allocate
> > > > memory. Do we have an interface to ignore current task cpuset=EF=BC=
=9FIf not,
> > > > WQ may be the only option and it also will not limit the context of
> > > > put_page. Right?
> > >
> > > Well, GFP_KERNEL is constrained to the task cpuset only if the said
> > > cpuset is hardwalled IIRC. But I do not see why this is a problem.
> >
> > I mean that if there are more than one node in the system,
> > but the current task cpuset only allows one node.
>
> How would that cpuset get a huge pages from a node which is not part of
> the cpuset? Well, that would be possible if the cpuset was dynamic but I
> am not sure that such a configuration would be very sensible along with
> hardwall setup.

Got it. I didn't realize this before. Thanks.

>
> > If current
> > node has no memory and other nodes have enough memory.
> > We can fail to allocate vmemmap pages. But actually it is
> > suitable to allocate vmemmap pages from other nodes.
> > Right?
>
> Falling back to a different node would be very suboptimal because then
> you would have vmemmap back by remote pages. We do not want that.
> --
> Michal Hocko
> SUSE Labs
