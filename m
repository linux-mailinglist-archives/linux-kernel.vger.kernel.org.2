Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C630C760
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhBBRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:20:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42234 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbhBBRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:18:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 112HHNDQ121038;
        Tue, 2 Feb 2021 11:17:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612286243;
        bh=ngjdgLS5lH7NPD7utCz0txbpdYnjVfvjYMCy81JpTmY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GKzgGSAh5c/V61SvI6SrlOzDO1O60eZ78aGnpDvKzVji7NOSF0M3heLwdt8qng9LE
         Ht4K6O4A8alEZ7IBxGEWkAFGYDjLiKftf+AOm6/AufEvNemaPQs+reWhWkHJKsSJld
         MhAdGf0DpbOimpRC7iYHQArBJB/lu+5f0mR+CnnQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 112HHNaj112075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Feb 2021 11:17:23 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Feb
 2021 11:17:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Feb 2021 11:17:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 112HHMAX025954;
        Tue, 2 Feb 2021 11:17:22 -0600
Date:   Tue, 2 Feb 2021 11:17:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: rm: remove unneeded semicolon
Message-ID: <20210202171653.yvyazvuhzhqrq2eh@regain>
References: <1612247013-17381-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612247013-17381-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:23-20210202, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/firmware/ti_sci.c:1762:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/firmware/ti_sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 235c7e7..5ae2040 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1759,7 +1759,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
>  		desc->num = resp->range_num;
>  		desc->start_sec = resp->range_start_sec;
>  		desc->num_sec = resp->range_num_sec;
> -	};
> +	}
>  


Uggh.. thanks..

Reviewed-by: Nishanth Menon <nm@ti.com>


Santosh: I know you have send your Soc fixes for merge, but will be
great if you could pick for a future version, this is minor enough not
to bother the stable, I think..


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
