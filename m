Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D33468C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhCWTQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhCWTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616526983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzzsxO+/RfVNYyJ9yVIRqP2Pb3Z/0Xf0ayACN5hk9Gc=;
        b=CnaTbtiTTCwuUA+nPr+Xgp1c1qN26onAah7SY/uH4IufiQOBCof5UGYrTzpko1JdCXgdsi
        kz/ZfGsjGzH5GD1kaz8nofGq6wKoYcUDEc8TT8TLICeiSMdv1haswqk92MKgOO/LEjQ5oC
        JswHco9k1hVWXdVnJDTQA7ytSW0PxPA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-ZVVXN3OZPO2VNsJq4QHzqA-1; Tue, 23 Mar 2021 15:16:21 -0400
X-MC-Unique: ZVVXN3OZPO2VNsJq4QHzqA-1
Received: by mail-qt1-f198.google.com with SMTP id t18so1841483qtw.15
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzzsxO+/RfVNYyJ9yVIRqP2Pb3Z/0Xf0ayACN5hk9Gc=;
        b=qhoVu9+td9gw+3ZFcL3yeb9EAzGW8cIf9NZYlX+J8Em8hOaBgslPbca13UTAbWDtVu
         DmjDPiNO7GEMsPOHeIaYIxZ32nhPRUswclNgUGYLm2ECnQV/UR0Lw+1Z0EkW7cecWEVc
         0vhSVWkG1+JADIc99OAYcMFttsgBaHXcokld9IHtuhvvveaNNKsgdHPb5AUCxdMCGLBX
         u41pRW7vCZdJZd37fMr/7qtRJXiLloLdB2ZHOnpsAoc5FEBr4ztnmGG1luzcEORsdK1n
         ICDFC5jpYV9VSizwTfy7RWdxhtzP5+zaR3E9eEtIL5KZcvzJ2jFgyDdP5CJI3E+Yjsr8
         4XVA==
X-Gm-Message-State: AOAM533uCw/uBuK3vpWvhmiZQP3h11xWQwXhtSIkDnRLGREZkcQ2xab5
        nDvCVEMhf60N092ABJkR0oSX9+Fiqf1MBPgsryNW2wYRCMOm0u5KBA72bY38v7MsxzH5ysqyRSI
        VnOMZ2Dq3UHlCQE83GETon3Wc
X-Received: by 2002:ac8:5cc4:: with SMTP id s4mr5746087qta.214.1616526981083;
        Tue, 23 Mar 2021 12:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHY7AQpSRZ5sUCEytixnvvAU37W64P8ZvCT5RyjQklc7t6g0fRMp/6jlGC8fQFAZSP3c28BA==
X-Received: by 2002:ac8:5cc4:: with SMTP id s4mr5746070qta.214.1616526980827;
        Tue, 23 Mar 2021 12:16:20 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id g4sm7523813qtg.86.2021.03.23.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:16:20 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:16:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/4] ioctl_userfaultfd.2: Add write-protect mode docs
Message-ID: <20210323191618.GJ6486@xz-x1>
References: <20210322220848.52162-1-peterx@redhat.com>
 <20210322220848.52162-5-peterx@redhat.com>
 <c65b5f04-4620-4c7e-e71f-91fc8394d164@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c65b5f04-4620-4c7e-e71f-91fc8394d164@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:11:04PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Peter,

Hi, Alex,

[...]

> > +.TP
> > +.B UFFDIO_COPY_MODE_WP
> > +Copy the page with read-only permission.
> > +This allows the user to trap the next write to the page,
> > +which will block and generate another write-protect userfault message.
> 
> s/write-protect/write-protected/
> ?

I think here "write-protect" is the wording I wanted to use, it is the name of
the type of the message in plain text.

[...]

> > +.B EAGAIN
> > +The process was interrupted and need to retry.
> 
> Maybe: "The process was interrupted; retry this call."?
> I don't know what other pager say about this kind of error.

Frankly I see no difference between the two..  If you prefer the latter, I can
switch.

> 
> > +.TP
> > +.B ENOENT
> > +The range specified in
> > +.I range
> > +is not valid.
> 
> I'm not sure how this is different from the wording above in EINVAL.  An
> "otherwise invalid range" was already giving EINVAL?

This can be returned when vma is not found (mwriteprotect_range()):

	err = -ENOENT;
	dst_vma = find_dst_vma(dst_mm, start, len);

	if (!dst_vma)
		goto out_unlock;

I think maybe I could simply remove this entry, because from an user app
developer pov I'd only be interested in specific error that I'd be able to
detect and (even better) recover from.  For such error I'd say there's not much
to do besides failing the app.

> 
> > +For example, the virtual address does not exist,
> > +or not registered with userfaultfd write-protect mode.
> > +.TP
> > +.B EFAULT
> > +Encountered a generic fault during processing.
> 
> What is a "generic fault"?

For example when the user copy failed due to some reason.  See
userfaultfd_writeprotect():

	if (copy_from_user(&uffdio_wp, user_uffdio_wp,
			   sizeof(struct uffdio_writeprotect)))
		return -EFAULT;

But I didn't check other places, generally I'd return -EFAULT if I can't find a
proper other replacement which has a clearer meaning.

I don't think this is really helpful to user app too because no user app would
start to read this -EFAULT to do anything useful.. how about I drop it too if
you think the description is confusing?

Thanks,

-- 
Peter Xu

