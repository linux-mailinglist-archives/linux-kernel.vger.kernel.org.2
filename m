Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FBD35E69D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhDMSnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231980AbhDMSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618339395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPSYeIKBVzEQKBOnpvCmluOdFxn+fMVehaHmMM6Y1QY=;
        b=X5izYFcuccMtQ4KPD1w0ci47sBEtcz6hgT8Y+OdQPYVbN3cUSUPR650XGAkMvdUU5xGo3M
        megBbtsQ+vCyEp5seVppktAjHnmBPI97kmOB2eluZL+yPiJ5pYRlkfHk/NfCr6jxmYdEPF
        0rqFDkEscqN9PuZrUtMeWyXBbHBTzuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-g5tbBQRvPb2E4BqUMBMUgQ-1; Tue, 13 Apr 2021 14:43:12 -0400
X-MC-Unique: g5tbBQRvPb2E4BqUMBMUgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 891FB107ACCA;
        Tue, 13 Apr 2021 18:43:10 +0000 (UTC)
Received: from omen (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDBB5D9D0;
        Tue, 13 Apr 2021 18:43:09 +0000 (UTC)
Date:   Tue, 13 Apr 2021 12:43:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: Re: [PATCH] vfio/iommu_type1: Remove unused pinned_page_dirty_scope
 in vfio_iommu
Message-ID: <20210413124308.599d0259@omen>
In-Reply-To: <20210412024415.30676-1-zhukeqian1@huawei.com>
References: <20210412024415.30676-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 10:44:15 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> pinned_page_dirty_scope is optimized out by commit 010321565a7d
> ("vfio/iommu_type1: Mantain a counter for non_pinned_groups"),
> but appears again due to some issues during merging branches.
> We can safely remove it here.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
> 
> However, I'm not clear about the root problem. Is there a bug in git?

Strange, clearly I broke something in merge commit 76adb20f924f, but
it's not evident to me how that line reappeared.  Thanks for spotting
it, I'll queue this for v5.13.  Thanks,

Alex

> ---
>  drivers/vfio/vfio_iommu_type1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 45cbfd4879a5..4d1f10a33d74 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -77,7 +77,6 @@ struct vfio_iommu {
>  	bool			v2;
>  	bool			nesting;
>  	bool			dirty_page_tracking;
> -	bool			pinned_page_dirty_scope;
>  	bool			container_open;
>  };
>  

