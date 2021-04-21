Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED62436757C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbhDUXEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343612AbhDUXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619046243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UmtHR6B+oXPHYT2L60drMqrNVwo6SWNjkWX1by19Tg=;
        b=XtMoNZY/5JJlhguvt9xnrn1bUjl75F2rQj/dhMEv4K/YMpRq5dsuX7IVDM6YoqBYsIQGda
        Ptjt6I0aD/y5tClCXYydtrwDO4e4mR2W8LxbagYeJXw2IYjbof53IXFlp7HygmOCLhq/VN
        E/XU5ZUczJvwHwijeWIdcAUdxc/kJOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-d2LMjUsiNryraJJ1ydfueg-1; Wed, 21 Apr 2021 19:04:01 -0400
X-MC-Unique: d2LMjUsiNryraJJ1ydfueg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EB6B107ACE4;
        Wed, 21 Apr 2021 23:04:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-21.phx2.redhat.com [10.3.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A66FB6E400;
        Wed, 21 Apr 2021 23:03:59 +0000 (UTC)
Date:   Wed, 21 Apr 2021 17:03:59 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 036/190] Revert "vfio/mdev: Fix reference count leak in
 add_mdev_supported_type"
Message-ID: <20210421170359.1b8f481b@redhat.com>
In-Reply-To: <20210421183634.GA2290758@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-37-gregkh@linuxfoundation.org>
        <20210421183634.GA2290758@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 15:36:34 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 21, 2021 at 02:58:31PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit aa8ba13cae3134b8ef1c1b6879f66372531da738.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/vfio/mdev/mdev_sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> I recently audited all of this mdev stuff, the original patch is OK,
> though I would have written it with a goto. Please don't revert it.

Agreed, the original commit looks correct.  Thanks,

Alex

