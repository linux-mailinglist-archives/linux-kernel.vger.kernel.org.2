Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA934D72F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhC2Sas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhC2SaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617042625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVOyB6KSqzLpGtiP/sJzWrefKdjfbqfFERx39MO85xk=;
        b=ikDgPOCm6i2dD/4/JJyJmpEJoMgRPFw5q5jSlipXquNmkPZ2pmT+9NRyN1mG7eH2eX/EGN
        QH9zbYN6AlbcLtVjERhJXisUggeBUEd012CT9hMGjNWLTVa7v0E9MOoM265xHF6CCuMhPU
        Xe8x59vIJexTNAYGsxhT57KBrbz4/I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-irKc1u6JMpCLIYCxwMHKzQ-1; Mon, 29 Mar 2021 14:30:22 -0400
X-MC-Unique: irKc1u6JMpCLIYCxwMHKzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3DA01084D7D;
        Mon, 29 Mar 2021 18:30:20 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50B4D19D7C;
        Mon, 29 Mar 2021 18:30:17 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:30:15 -0500
From:   David Teigland <teigland@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH -next] fs: dlm: fix missing unlock on error in
 accept_from_sock()
Message-ID: <20210329183015.GE3080@redhat.com>
References: <20210327083704.1092954-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327083704.1092954-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 04:37:04PM +0800, Yang Yingliang wrote:
> Add the missing unlock before return from accept_from_sock()
> in the error handling case.

Thanks, applied to the next branch.
Dave

> Fixes: 6cde210a9758 ("fs: dlm: add helper for init connection")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  fs/dlm/lowcomms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> index 73cc1809050a..166e36fcf3e4 100644
> --- a/fs/dlm/lowcomms.c
> +++ b/fs/dlm/lowcomms.c
> @@ -931,6 +931,7 @@ static int accept_from_sock(struct listen_connection *con)
>  			result = dlm_con_init(othercon, nodeid);
>  			if (result < 0) {
>  				kfree(othercon);
> +				mutex_unlock(&newcon->sock_mutex);
>  				goto accept_err;
>  			}
>  
> -- 
> 2.25.1

