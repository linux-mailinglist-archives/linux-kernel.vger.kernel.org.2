Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0941F3772F1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhEHQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 12:29:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35130 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 12:29:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 148GSnX2045349;
        Sat, 8 May 2021 11:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620491329;
        bh=R4AEAR4Q2jlh2pQrn3wkNPw0QXvndpxnxqagfXAENWo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Bqib1FuywtXw9a0/UAE3n19/DZNySJpLTzCJibh/qgkPL3BBTFvSB0UpX3XRJxEeC
         67JJ4rtYUWnafTQ/xZg3Cg0XcQ1K8wCjfCc9YtS30WqK8l3ODbHYS3J6UpWbWJFmjI
         hBtHFK4xKnZN4PBcPz3HTm+x1UQ4A5JCndw+lGJg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 148GSnEi050200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 May 2021 11:28:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 8 May
 2021 11:28:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sat, 8 May 2021 11:28:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 148GSnQc122781;
        Sat, 8 May 2021 11:28:49 -0500
Date:   Sat, 8 May 2021 11:28:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] platform_data: emif_plat.h: drop a duplicated word
Message-ID: <20210508162849.zxaaxiadaxvxi66r@empirical>
References: <20210508065557.22224-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210508065557.22224-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:55-20210507, Randy Dunlap wrote:
> Drop the repeated word "if" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> v2: Drop bad Cc: Aneesh V <aneesh@ti.com>;
>     Add Cc: Andrew Morton
> 
>  include/linux/platform_data/emif_plat.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210507.orig/include/linux/platform_data/emif_plat.h
> +++ linux-next-20210507/include/linux/platform_data/emif_plat.h
> @@ -98,7 +98,7 @@ struct emif_custom_configs {
>   *			as type, bus width, density etc
>   * @timings:		Timings information from device datasheet passed
>   *			as an array of 'struct lpddr2_timings'. Can be NULL
> - *			if if default timings are ok
> + *			if default timings are ok

LGTM.

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
