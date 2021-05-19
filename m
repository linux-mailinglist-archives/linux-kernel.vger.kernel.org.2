Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4133738959E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhESSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhESSkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621449572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0F4ybP9RhzRATHuQqtGSmF4qbw/pTZZvReBWTg3s2gI=;
        b=QhsHl+6O0dAodScruJSkN2W8EYWAsRUxugE8YnFAhWO28QSBZlBS1PrttuJ4mFPJtBxtyo
        syGns2lrVhMcky9bO9R8M9l2FwDRxzhepiw2LEKEit7b7Vhh1oGlqF/zviRu8KFG+yTUKE
        H+2nX3aaEroi5jeAC/+rDIBsQfuhWKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-4LlfOC7HPQ-NqHcmwBDNIQ-1; Wed, 19 May 2021 14:39:30 -0400
X-MC-Unique: 4LlfOC7HPQ-NqHcmwBDNIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76128501F4;
        Wed, 19 May 2021 18:39:29 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 018485C1CF;
        Wed, 19 May 2021 18:39:28 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     bcrl@kvack.org, akpm@linux-foundation.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: add missing dcache flush
References: <YJRLAPfYuNaCWq6T@localhost.localdomain>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 19 May 2021 14:40:22 -0400
In-Reply-To: <YJRLAPfYuNaCWq6T@localhost.localdomain> (Alexey Dobriyan's
        message of "Thu, 6 May 2021 23:01:04 +0300")
Message-ID: <x495yze36uh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> Ring page is mapped by kernel and updated so dcache must be flushed.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
> 	Not tested but the usage looks fishy.
>
>  fs/aio.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -653,6 +653,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
>  					ring = kmap_atomic(ctx->ring_pages[0]);
>  					ring->id = ctx->id;
>  					kunmap_atomic(ring);
> +					flush_dcache_page(ctx->ring_pages[0]);
>  					return 0;
>  				}
>  
>

Sorry for the late review.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

