Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FB332FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCIUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231138AbhCIUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615320900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IBVKerwrOvHWwAAtnVWuANWrpDLBOHST0pPeMNmxg/Y=;
        b=gd011kY+kP6XeHDrXerpkeEYo7wJQQPeVWnqoAG6GlBb2FeqMbuLPsUPQnJ+1iOrFc/txR
        zUEuLJFFSsb1aPL9b1QkQGTZ1Mx6VsBSj8ESKKdlZIcdEOpSm7ioCGEUBnHb54DdeHXxLX
        HhWmE53AeDjxgF0wH7KYw0wMcAGSrHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177--oWRsANsMiSdti23yJdK0A-1; Tue, 09 Mar 2021 15:14:56 -0500
X-MC-Unique: -oWRsANsMiSdti23yJdK0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 794271005D45;
        Tue,  9 Mar 2021 20:14:55 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B15A5D9DB;
        Tue,  9 Mar 2021 20:14:50 +0000 (UTC)
Date:   Tue, 9 Mar 2021 15:14:50 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm: remove unneeded variable 'sz'
Message-ID: <20210309201449.GB16277@redhat.com>
References: <1615282320-28246-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615282320-28246-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2021 at  4:32am -0500,
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Fix the following coccicheck warning:
> ./drivers/md/dm-ps-service-time.c:85:10-12: Unneeded variable: "sz".
> Return "0" on line 105
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This type of change gets proposed regaularly.  Would appreciate it if
you could fix coccicheck to not get this wrong.  The local 'sz' variable
is used by the DMEMIT macro (as the earlier reply to this email informed
you).

Also, had you tried to compile the code with your patch applied you'd
have quickly realized your patch wasn't correct.

Mike


> ---
>  drivers/md/dm-ps-service-time.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-ps-service-time.c b/drivers/md/dm-ps-service-time.c
> index 9cfda66..12dd5ce 100644
> --- a/drivers/md/dm-ps-service-time.c
> +++ b/drivers/md/dm-ps-service-time.c
> @@ -82,7 +82,6 @@ static void st_destroy(struct path_selector *ps)
>  static int st_status(struct path_selector *ps, struct dm_path *path,
>  		     status_type_t type, char *result, unsigned maxlen)
>  {
> -	unsigned sz = 0;
>  	struct path_info *pi;
>  
>  	if (!path)
> @@ -102,7 +101,7 @@ static int st_status(struct path_selector *ps, struct dm_path *path,
>  		}
>  	}
>  
> -	return sz;
> +	return 0;
>  }
>  
>  static int st_add_path(struct path_selector *ps, struct dm_path *path,
> -- 
> 1.8.3.1
> 

