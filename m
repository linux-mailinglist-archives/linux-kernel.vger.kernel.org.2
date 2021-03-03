Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30832BFF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386316AbhCCSOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1448626AbhCCPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614786026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/B/vFyvdim6DFmRje+NahSs84+dybnbCq6JUenc1xY=;
        b=ItMHXpErGvN4CKXrf6lJpI6lEL5BPg7Jm7HsAbvtoNGd/fC4BManeJ9yeKLEeFrt+Ify86
        uiaAYbi4ewFhH3YLtLhIcE6UlIJqfXDgZ9ShlIFbTLeTbwc9NRPrpgEnzBGg0O2N9nCDSn
        yNP6QxCWlQBHHfgDI3v5kyzwI8dOWzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-w_Mi8ygwMry9mxWUUsfKvA-1; Wed, 03 Mar 2021 10:40:22 -0500
X-MC-Unique: w_Mi8ygwMry9mxWUUsfKvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F047CC621;
        Wed,  3 Mar 2021 15:40:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 760FA60C15;
        Wed,  3 Mar 2021 15:40:21 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8B93718095CB;
        Wed,  3 Mar 2021 15:40:20 +0000 (UTC)
Date:   Wed, 3 Mar 2021 10:40:20 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Message-ID: <270744488.59307524.1614786020378.JavaMail.zimbra@redhat.com>
In-Reply-To: <1614676526-102967-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614676526-102967-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] gfs2: Remove unneeded return variable
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.116, 10.4.195.12]
Thread-Topic: gfs2: Remove unneeded return variable
Thread-Index: 3VuNkBJDA75kU/6FZuU1wYet5NWkVw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> This patch removes unneeded return variables, using only
> '0' instead.
> It fixes the following warning detected by coccinelle:
> ./fs/gfs2/super.c:592:5-10: Unneeded variable: "error". Return "0" on
> line 628
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/gfs2/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 861ed5f..fe2dae4 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -589,7 +589,6 @@ static void gfs2_dirty_inode(struct inode *inode, int
> flags)
>  
>  int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
>  {
> -	int error = 0;
>  	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
>  
>  	gfs2_flush_delete_work(sdp);
> @@ -625,7 +624,7 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
>  	if (!log_write_allowed)
>  		sdp->sd_vfs->s_flags |= SB_RDONLY;
>  
> -	return error;
> +	return 0;
>  }
>  
>  /**
> --
> 1.8.3.1

Hi Yang,

Thanks for submitting your patch. I like it. However, since gfs2_make_fs_ro
always returns 0, we should also be able to make it a void function instead
of int, and change its callers to not act on any return code.

Regards,

Bob Peterson
Red Hat File Systems

