Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5957F33CDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhCPGLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233072AbhCPGLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615875103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGFqJnJPWEoWdqThLFH/fQr5tvLwsqAidPoANR0ZVyQ=;
        b=G84NcFFjKnt2x0P/vKtt/Q+P4kUorRWzXcNqxGsy6SJqgNgCo/IghphM+bqvMcUE3GtXbP
        0bTNJyQA/BGGGlLG0EBklTyruAege4pDdyRBxQpGx2/vDCmMfcF4e4qvD3FVMpxqD/CGAG
        Eoi5bdsnEHtWmFU+AGZXcrVyOMbedyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-zTcCLMXFMAiXbYOA1Eq_SA-1; Tue, 16 Mar 2021 02:11:37 -0400
X-MC-Unique: zTcCLMXFMAiXbYOA1Eq_SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 084A6107465F;
        Tue, 16 Mar 2021 06:11:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com [10.72.12.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6077019CB4;
        Tue, 16 Mar 2021 06:11:30 +0000 (UTC)
Subject: Re: [PATCH V4 4/7] vDPA/ifcvf: remove the version number string
To:     Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com,
        lulu@redhat.com, leonro@nvidia.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-5-lingshan.zhu@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7b46c912-fa81-6e91-f588-3f856177af5b@redhat.com>
Date:   Tue, 16 Mar 2021 14:11:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-5-lingshan.zhu@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/3/15 ÏÂÎç3:44, Zhu Lingshan Ð´µÀ:
> This commit removes the version number string, using kernel
> version is enough.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/ifcvf/ifcvf_main.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index fd5befc5cbcc..c34e1eec6b6c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -14,7 +14,6 @@
>   #include <linux/sysfs.h>
>   #include "ifcvf_base.h"
>   
> -#define VERSION_STRING  "0.1"
>   #define DRIVER_AUTHOR   "Intel Corporation"
>   #define IFCVF_DRIVER_NAME       "ifcvf"
>   
> @@ -503,4 +502,3 @@ static struct pci_driver ifcvf_driver = {
>   module_pci_driver(ifcvf_driver);
>   
>   MODULE_LICENSE("GPL v2");
> -MODULE_VERSION(VERSION_STRING);

