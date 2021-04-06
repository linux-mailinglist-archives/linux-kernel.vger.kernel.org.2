Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7968355299
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245719AbhDFLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245739AbhDFLoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617709449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0SvoTNm1MW+BEeloqqC2ZxbRkRo5twA3v77+9Yqtz8=;
        b=CxQchKA+o6yWHdJS68YCylOlSDI9LnSInNouDWns95nv+8xD1zfeVNY5Smkzn/Oks1492v
        XgFd62idmoMtD5Li9ax5peSgAQkrlmM4XoURNAvfQ/k2amkpTF05Yv2P7Bjj7MOdytnWVD
        /a2uwIQvjnaAl/b8ow6tWYq95CVygFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-SxAs6776PJqGOvOB_QUgcA-1; Tue, 06 Apr 2021 07:44:08 -0400
X-MC-Unique: SxAs6776PJqGOvOB_QUgcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57CD3800D53;
        Tue,  6 Apr 2021 11:44:07 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 504D95D9F0;
        Tue,  6 Apr 2021 11:44:07 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 438D94BB7B;
        Tue,  6 Apr 2021 11:44:07 +0000 (UTC)
Date:   Tue, 6 Apr 2021 07:44:06 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Message-ID: <468723920.4255981.1617709446972.JavaMail.zimbra@redhat.com>
In-Reply-To: <20210406091126.GT2916463@dell>
References: <20210326091151.311647-1-lee.jones@linaro.org> <20210406091126.GT2916463@dell>
Subject: Re: [PATCH 00/18] Rid W=1 warnings from GFS2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.15, 10.4.195.19]
Thread-Topic: Rid W=1 warnings from GFS2
Thread-Index: et3iDmvu5KFsTjhUwPZS5qmJAiwtVw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> On Fri, 26 Mar 2021, Lee Jones wrote:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (18):
> >   fs: gfs2: dir: Finish off mostly complete headers demote others
> >   fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant
> >     ones
> >   fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
> >   fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote
> >     others
> >   fs: gfs2: log: Fix a couple of param descriptions and demote
> >     non-conformant headers
> >   fs: gfs2: lops: Help out worthy kernel-doc headers and demote others
> >   fs: gfs2: glock: Fix some deficient kernel-doc headers and demote
> >     non-conformant ones
> >   fs: gfs2: aops: Fix a little potential doc-rot
> >   fs: gfs2: meta_io: Add missing description for 'rahead' param
> >   fs: gfs2: inode: Fix worthy function headers demote others
> >   fs: gfs2: file: Strip out superflouous param description and demote
> >     kernel-doc abuse
> >   fs: gfs2: ops_fstype: Fix a little doc-rot
> >   fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
> >   fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
> >   fs: gfs2: recovery: Provide missing param descriptions and remove one
> >     other
> >   fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
> >   fs: gfs2: util: Fix one conformant kernel-doc header and demote a
> >     bunch of abuses
> >   fs: gfs2: lock_dlm: Demote incomplete kernel-doc header
> 
> These have been on the list for a couple of weeks now.
>   
> Is there anything I can do to help expedite their merge?
>   
> I'm concerned since -rc6 has just been released.

Hi Lee,

Thanks for your patches. Andreas and I have a slight disagreement about them.
I wanted to merge them, but Andreas is concerned that there may be some
cases in which we should get rid of parameter descriptions altogether.
So I've been waiting for Andreas to review them all before we push them.
Also, the dir.c patch might be out of date because of a patch I recently did that
was recently added to for-next. I'll work with Andreas to expedite them so
they can go into the next merge window.

Regards,

Bob Peterson

