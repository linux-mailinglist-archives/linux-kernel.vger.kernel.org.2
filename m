Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D951B32D681
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhCDPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232435AbhCDPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614871386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYTbMDYctzXTP1lGI/qs74mYbcaSxVhdB7MYXTA57UA=;
        b=OgO4XN3EAOXrvrEJXx3UPBJIndm0X0kGMMSn/PmYNuFMtc++02qSDnqgR56FsdOjX023dl
        gxr9fRuNoStikq1qO+yUQlkHPCBvs0/ZaKnmPawSrq4WwuYIblc5EzC76P5Rc7Cgv2or/+
        c8PQvwO9eCB3m+p6QliirSK6z6OJrzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-ExhyfEDbNged7uvoRwke3Q-1; Thu, 04 Mar 2021 10:23:05 -0500
X-MC-Unique: ExhyfEDbNged7uvoRwke3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D737F19057A4;
        Thu,  4 Mar 2021 15:23:02 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1CB5C1A1;
        Thu,  4 Mar 2021 15:23:02 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C52FB18095CA;
        Thu,  4 Mar 2021 15:23:01 +0000 (UTC)
Date:   Thu, 4 Mar 2021 10:22:59 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Message-ID: <669736422.59715790.1614871379550.JavaMail.zimbra@redhat.com>
In-Reply-To: <1614850640-63803-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614850640-63803-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] gfs2: make function gfs2_make_fs_ro() to void type
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.225, 10.4.195.13]
Thread-Topic: gfs2: make function gfs2_make_fs_ro() to void type
Thread-Index: tP8ZFycLfqsXQRyPZDKwsUS7L7wEUg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> It fixes the following warning detected by coccinelle:
> ./fs/gfs2/super.c:592:5-10: Unneeded variable: "error". Return "0" on
> line 628
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/gfs2/ops_fstype.c | 4 +---
>  fs/gfs2/super.c      | 9 +++------
>  fs/gfs2/super.h      | 2 +-
>  fs/gfs2/util.c       | 2 +-
>  4 files changed, 6 insertions(+), 11 deletions(-)

Thanks. Your patch is now pushed to linux-gfs2/for-next.
I did one minor cleanup: Function gfs2_put_super in super.c no longer
needed the variable "error" so I removed it to avoid warnings.

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/fs/gfs2?h=for-next&id=0e787a0bfabb8be323f575d5cdda48e607840eb5

Regards,

Bob Peterson

