Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34B7379C09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhEKB2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:28:16 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46941 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEKB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:28:14 -0400
Received: by mail-io1-f45.google.com with SMTP id o21so16244984iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=50IDS4YNVOO9SbXJy8hRyOLGmUiMw8zqjB0WM/shXKM=;
        b=F7Bjlxb9fuZuUtrvPmrj8eRIZ9rFzltWDgzBz89DBqDANRXcuounVYsi1nBypa+M6f
         CTqi/PyCk71QVd6dw3ks4cME+t/POxZuMr6DE4p/jQ6PtoPzj1whePkpmNqqCWDQirxC
         onomi1Snepor9GoJlfQcfb2cqd0ZTiRcA0Ap4sj1JTEac15u7Eu9u8eKkzCUfKReSe9G
         vJQU1wyepQhlZZkVA1GJLDpk6fqAC/wPd2aEc+uRTANjcGM/ZkWygubDmCaZ0daNSeJq
         dLWqGJje6+dOLR/0qPsTpB9t4BAiUvQplWwkv6RT27/zqRbXo4F4wPkTeOL4xdFw1CkL
         hVeQ==
X-Gm-Message-State: AOAM533S3P2UR1q6IIWvPgoH51KryK+1/nGwRhVYW79XrkxtSpvs7jUk
        KvLVNtxbPeVqMcUR83GzHxY=
X-Google-Smtp-Source: ABdhPJzbL46eucq58mJvJLkkoszaiKz0cTBC+AZRiIRUj0MZyz3tQJzYmxj7slPYslfXnIObLYwNmA==
X-Received: by 2002:a6b:b48d:: with SMTP id d135mr20507815iof.107.1620696427992;
        Mon, 10 May 2021 18:27:07 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id l9sm4443015iop.34.2021.05.10.18.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 18:27:07 -0700 (PDT)
Date:   Tue, 11 May 2021 01:27:06 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJndaqy7AbBYnjPh@google.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
 <YJWQE8AFjyYpsLYA@google.com>
 <YJnRHhK+2AVTMOfh@carbon.DHCP.thefacebook.com>
 <YJnTYicu2TaVqVmi@google.com>
 <YJnaQcgZaC8qJhOB@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJnaQcgZaC8qJhOB@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:13:37PM -0700, Roman Gushchin wrote:
> On Tue, May 11, 2021 at 12:44:18AM +0000, Dennis Zhou wrote:
> > On Mon, May 10, 2021 at 05:34:38PM -0700, Roman Gushchin wrote:
> > > On Fri, May 07, 2021 at 07:08:03PM +0000, Dennis Zhou wrote:
> > > > On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> > > > > On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > > > > > hi Roman,
> > > > > >  
> > > > > > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > > > > > Ping
> > > > > > 
> > > > > > sorry for late.
> > > > > > 
> > > > > > the new patch makes the performance a little better but still has
> > > > > > 1.9% regression comparing to
> > > > > > f183324133 ("percpu: implement partial chunk depopulation")
> > > > > 
> > > > > Hi Oliver!
> > > > > 
> > > > > Thank you for testing it!
> > > > > 
> > > > > Btw, can you, please, confirm that the regression is coming specifically
> > > > > from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> > > > > I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> > > > > I can confirm it.
> > > > > 
> > > > > Thanks!
> > > > 
> > > > Thanks Oliver and Roman. If this is the case, I'll drop the final patch
> > > > and just merge up to f183324133 ("percpu: implement partial chunk
> > > > depopulation") into for-next as this is v5.14 anyway.
> > > 
> > > I doubt it's a good idea. I reran the test with some debug added and it looks
> > > like it doesn't  trigger any depopulation at all. Everything else looked sane
> > > too.
> > > 
> > 
> > Well that's awkward...
> > 
> > > Dropping a reasonable patch doing a good thing without any understandinding how
> > > it affects (or even can affect in theory) some benchmark sounds like a bad idea.
> > > We'll never learn this. It could be that the regression is caused my some
> > > tiny alignment difference or something like this, so any other change can
> > > trigger it too (I can be totally wrong here, but I don't have any better
> > > explanation either).
> > > 
> > 
> > So I'm not 100% thrilled with the final patch anyway. Particularly the
> > lock dancing I'd rather figure something out a little cleaner. I'm going
> > to take some time later this week and sort it out. If I can't think of
> > anthing better I'll just reapply the final patch.
> > 
> > I've currently merged everything up into the last patch for-5.14. Should
> > at least give us some very preliminary testing.
> 
> Sounds good to me!
> 
> But if under final you mean the batching, I'd include my locking optimization
> patch or something similar to it. We shouldn't grab and release the pcpu_lock
> many times for no reason.

Yeah, I have that in mind + a few renamings in addition to the batching
batch.

> 
> Thanks!
