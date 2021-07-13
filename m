Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EEF3C6A11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhGMGDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 02:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhGMGDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626156044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bCaNkAj4f1LnLkK/10jGnK5QRfAHPC6zgTttqqRfXY=;
        b=NQeE8ieq0O3redIbYCirQRApQl/x3pWngsQjV5nMw7QI3nu/QglSndv+ZPCssNWoRCnPkA
        C5iklFc/cvbqeX+Y2LPW2Fw2vD4lz/7X8q7vMIrNcOgDJYMsXZDgGHU/JYTdPCF11TTeqI
        gBz5ManSoR2mTZ5IrlHIiXgU96D7TiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-M0Ir8aORMGKPCQRGKeCYgw-1; Tue, 13 Jul 2021 02:00:43 -0400
X-MC-Unique: M0Ir8aORMGKPCQRGKeCYgw-1
Received: by mail-wm1-f69.google.com with SMTP id m40-20020a05600c3b28b02901f42375a73fso952758wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 23:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bCaNkAj4f1LnLkK/10jGnK5QRfAHPC6zgTttqqRfXY=;
        b=HrqDfjrUBFeWuStyWc3Np8xPE7VMEjHk/stMS7oa5GGCmRGnlFVvNRQCXr5rEz15Dz
         RRulXP6nLToSSBAMFf9flm2R6xZAZVY9R36Gq+GmHa7HxL2ZmUhsDvhhXcsOKhA7ndAz
         CIBG0bLilttcwa+sjHlFIs+eY9IjByGoNwO9S/BwlgVbZgto1jhdIKaq92ZGTwkzayuQ
         xXvzDoGL3u34ioUH3R0sGXDNgziy/ebiAGJNM0+nmVUo+r4xXBjGTRXyjOudttMyZLEA
         LmLDvgySAn23DWoYn1rZPvAnK0xcNxdgjiReDFsORGzKCpQ6nwkW5zAqnwl6LwjaldkL
         45RQ==
X-Gm-Message-State: AOAM533/xdIFGDH4d4jAyzDaXbeGzJmNZa1mKW6OFFBxkZ3ag3dKnlqN
        cDaliDxiM/W2bL8KPTklvL1jk+LK+B0S8lmszONTQUOQbhF5sJEEgOMbYqJLh7OF8xmU+sL0Pbj
        9jEE6PAf22dSfvZXBJwpSDoBXG329TfTbn6ETp/Hr
X-Received: by 2002:a1c:62c4:: with SMTP id w187mr3060491wmb.27.1626156041676;
        Mon, 12 Jul 2021 23:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCzQbgh9kCPy6bTMehMxShnwdK8pEgvMZNUVi0DDbMegUNP6IeRgE3zmDkHYgleDuxud58cKPgdT3TkAFz/18=
X-Received: by 2002:a1c:62c4:: with SMTP id w187mr3060445wmb.27.1626156041061;
 Mon, 12 Jul 2021 23:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210712162430.104913-1-colin.king@canonical.com>
In-Reply-To: <20210712162430.104913-1-colin.king@canonical.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 13 Jul 2021 08:00:00 +0200
Message-ID: <CAHc6FU7oj0j=YC9Y06S8jwT_mew+hbbvXSZo55xxuOKZgSEAPA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix memory leak of object lsi on error return path
To:     Colin King <colin.king@canonical.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, Abhi Das <adas@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Mon, Jul 12, 2021 at 6:24 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> In the case where IS_ERR(lsi->si_sc_inode) is true the error exit path
> to free_local does not kfree the allocated object lsi leading to a memory
> leak. Fix this by kfree'ing lst before taking the error exit path.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 97fd734ba17e ("gfs2: lookup local statfs inodes prior to journal recovery")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/gfs2/ops_fstype.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 5f4504dd0875..bd3b3be1a473 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -677,6 +677,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
>                         error = PTR_ERR(lsi->si_sc_inode);
>                         fs_err(sdp, "can't find local \"sc\" file#%u: %d\n",
>                                jd->jd_jid, error);
> +                       kfree(lsi);
>                         goto free_local;
>                 }
>                 lsi->si_jid = jd->jd_jid;
> --
> 2.31.1

added to for-next.

Thanks,
Andreas

