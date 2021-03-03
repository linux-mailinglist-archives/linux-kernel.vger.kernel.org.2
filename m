Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6916F32BA71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbhCCLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243230AbhCCBsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 20:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614736022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jww8cJUaHupInq+mcq792xsD8zG8qjbu6h0omtjQTs=;
        b=gXuiriBaZR5G57DaSPwEVKgKsBrSCEXRxUdVk2x8cgXKlqdp9eYuCfKWqIZaY8QtsF5rlL
        y10S7MyuElCD7nUNj1+qrgameMfkC9rAEPEX9t4lRYEKiynNetMtS0gaJj4Zz4Cc0g5153
        Pg7NBQoQ++D6v3LbuodxtG0QPWMoltg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-to7Q71B_PCaFp8zUgLOiyQ-1; Tue, 02 Mar 2021 20:47:01 -0500
X-MC-Unique: to7Q71B_PCaFp8zUgLOiyQ-1
Received: by mail-qk1-f198.google.com with SMTP id g18so8487459qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 17:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jww8cJUaHupInq+mcq792xsD8zG8qjbu6h0omtjQTs=;
        b=nTeIQx+19eCBUzg/qHFZnqHWj0mvFPcArZ15jO3lxVvKc7KEr94DGohqNmL4Y0Rkvq
         mfdSdblR3odZWv5dtQ5mK+DwKmWxBHJul7E5ZGsbn86f5fyN2VvZ5Bqax9LR7yzCd2qq
         Ex418sH1WVKJF9G3ZfJMDb84HSlGeIPBczU4xJaEDHfU0fpCzhZilm4OnP2GS6Lku6eW
         IoYb5b8hQ/wPeB7211jI06dJRolPMjLjonod+zh8r61V6GEK1pg1Qs+eszXDp5o5biZE
         ri1C8w651nP/wBHGNAH17ZQnbe1QgvnJOvqOI4ALV7jvR3LUN1WA3Ue2MOny2Yim9NE2
         XRDw==
X-Gm-Message-State: AOAM530wFb8KeDCcoRYpNRq9zyurEh8CMVzCsA3JCHJTI5J8u7zEH+FR
        h5xESPhXMwd9T4VxHUWkD/ib642BbPKut+Pt50L+Mr6Yhxhqy3axm1yzVBOVaPHt81iwumwnS3e
        gUBptjGMXk4WxgVVVouO4g9gs
X-Received: by 2002:ac8:5808:: with SMTP id g8mr20347631qtg.159.1614736020699;
        Tue, 02 Mar 2021 17:47:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJqvKivbL+ftJyBD74SYEbCkaHJW8G2wl0jwT1Tz12T51fGb3u8A0l5Avyj76j7ysHh+28eA==
X-Received: by 2002:ac8:5808:: with SMTP id g8mr20347610qtg.159.1614736020463;
        Tue, 02 Mar 2021 17:47:00 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id g21sm5407018qkk.72.2021.03.02.17.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 17:47:00 -0800 (PST)
Date:   Tue, 2 Mar 2021 20:46:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Message-ID: <20210303014655.GS397383@xz-x1>
References: <20210217233547.93892-1-peterx@redhat.com>
 <20210301141151.GA397383@xz-x1>
 <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:28:46PM -0800, Andrew Morton wrote:
> On Mon, 1 Mar 2021 09:11:51 -0500 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Feb 17, 2021 at 06:35:42PM -0500, Peter Xu wrote:
> > > v5:
> > > - patch 4: change "int cow" into "bool cow"
> > > - collect r-bs for Jason
> > 
> > Andrew,
> > 
> > I just noticed 5.12-rc1 has released; is this series still possible to make it
> > for 5.12, or needs to wait for 5.13?
> > 
> 
> It has taken a while to settle down.  What is the case for
> fast-tracking it into 5.12?

Andrew,

As Jason and Wei pointed out, I think some userspace still got corrupted data
without this series when using hugetlb backend.  I don't think it'll suite for
a late RC release but it'll still be great if it can be considered as an early
rc candidate, ideally rc1 of course.  If you prefer the other way, I can also
repost it before 5.13 merge window opens.

Thanks,

-- 
Peter Xu

