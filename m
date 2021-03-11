Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF881337FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCKWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhCKWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:00:44 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:00:44 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a9so22314076qkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+qikVGVG5hLfF30nwClUfcmwlrnzXvd9jwAMMr1ktGs=;
        b=LdnAQcCDegAC8TFJOWY/3a6omf89kxqALwz24Q57qRRR/9nXroFKittCkYoglJrbHS
         lHLHk4R0lXXutHT7LELW0QwVxgIAroDVsHM3NTKggsm8Lu9bO83GQqNbp8iLd+M8UwsD
         mjmh/xY8+mzTMbJj7CQuRhByxYPB9CwwBwiP49WxwNI95AneNBV20nkWW6ZRpSnK8P3U
         uC1CCit2IiEKuYM68th69wV6rbE837dZXwem04BnZpqMJCHfVTcZjsornmdTSSEPkum8
         nvyPEFgacNjuJe7QiuIbGSNTKxQ8nBpSTCWr1QM/vyBL1e9oxzq6m/fzienCPzpEYlpU
         wYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+qikVGVG5hLfF30nwClUfcmwlrnzXvd9jwAMMr1ktGs=;
        b=i9bzB8b1VW0MB2n0N3hwvCXNELFS7yvah/t6XfrqnxOALDJ/zjjXSZbAGm/pl40H9x
         U+F+Nw0mEB+fZ8Ff4FIOQY3rYOvPqLWwB4naXC8ozQbgMhsq3BDIiicOxtGDB/XZIz/l
         XM81TP46kvErrSKbjIlzFOYDi4LqwEMDYPjxrOBgTzvH/STHn00UckkTiT4wCVikhACC
         eqq2gsO0VfjlJRIa2/X21qSVQHwFrzH0/HsulfDNLESUiPSTokMk3mU065/v1O6dXaIx
         em2OQvw9aA+McueLCp78JzftplssffyHpI9ufRWNb8Zop0JWpRQDfUN5qvhX/fpt+qNm
         dGOQ==
X-Gm-Message-State: AOAM533mtNqZkyVNsCDTnXdI1P0OPpa8MxEx1FlnIkR37mySXq0VC3t3
        sVT24Ggj73ri8xZmYf6EMGkatw==
X-Google-Smtp-Source: ABdhPJw3RlY2CHEEFEeJxHbV6ajFeaifqXpG6xNWj2AJpoE6T3rhn60txY6ti0sGZcT5KrRyj+kEjA==
X-Received: by 2002:a05:620a:53d:: with SMTP id h29mr9696179qkh.29.1615500043393;
        Thu, 11 Mar 2021 14:00:43 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q65sm2852930qkb.51.2021.03.11.14.00.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Mar 2021 14:00:43 -0800 (PST)
Date:   Thu, 11 Mar 2021 14:00:40 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jue Wang <juew@google.com>
cc:     =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3_=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Greg Thelen <gthelen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
In-Reply-To: <CAPcxDJ6D5OS+XRYbqpr-7bhYCySX=jdPZdZvQL1ecSrQoDEieg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2103111312310.7859@eggly.anvils>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com> <alpine.LSU.2.11.2103102214170.7159@eggly.anvils> <20210311151446.GA28650@hori.linux.bs1.fc.nec.co.jp> <CAPcxDJ6D5OS+XRYbqpr-7bhYCySX=jdPZdZvQL1ecSrQoDEieg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1804095697-1615500042=:7859"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1804095697-1615500042=:7859
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 11 Mar 2021, Jue Wang wrote:
> On Thu, Mar 11, 2021 at 7:14 AM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
> <naoya.horiguchi@nec.com> wrote:
> > On Wed, Mar 10, 2021 at 11:22:18PM -0800, Hugh Dickins wrote:
> > >
> > > I'm not much into memory-failure myself, but Jue discovered that the
> > > SIGBUS never arrives: because split_huge_page() on a shmem or file
> > > THP unmaps all its pmds and ptes, and (unlike with anon) leaves them
> > > unmapped - in normal circumstances, to be faulted back on demand.
> > > So the page_mapped() check in hwpoison_user_mappings() fails,
> > > and the intended SIGBUS is not delivered.
> >
> > Thanks for the information.  The split behaves quite differently betwee=
n
> > for anon thp and for shmem thp.  I saw some unexpected behavior in my
> > testing, maybe that's due to the difference.
> >
> > >
> > > (Or, is it acceptable that the SIGBUS is not delivered to those who
> > > have the huge page mapped: should it get delivered later, to anyone
> > > who faults back in the bad 4k?)
> >
> > Later access should report error in page fault, so the worst scenario
> > of consuming corrupted data does not happen, but precautionary signal
> > does not work so it's not acceptable.

On the other hand, if split_huge_page() does succeed, then there is an
argument that it would be better not to SIGBUS all mappers of parts of
the THP, but wait to select only those re-accessing the one bad 4k.

> In our experiment with SHMEM THPs, later accesses resulted in a zero
> page allocated instead of a SIGBUS with BUS_MCEERR_AR reported by the
> page fault handler. That part might be an opportunity to prevent some
> silent data corruption just in case.

Thanks for filling in more detail, Jue: I understand better now.

Maybe mm/shmem.c is wrong to be using generic_error_remove_page(),
the function which punches a hole on memory-failure.

That works well for filesystems backed by storage (at least when the
page had not been modified), because it does not (I think) actually
punch a hole in the stored object; and the next touch at that offset of
the file will allocate a new cache page to be filled from good storage.

But in the case of shmem (if we ignore the less likely swap cache case)
there is no storage to read back good data from, so the next touch just
fills a new cache page with zeroes (as you report above).

I don't know enough of the philosophy of memory-failure to say, but
I can see there's an argument for leaving the bad page in cache, to
give SIGBUS or EFAULT or EIO (whether by observation of PageHWPoison,
or by another MCE) to whoever accesses it - until the file or that
part of it is deleted (then that page never returned to use again).

Hugh
--0-1804095697-1615500042=:7859--
