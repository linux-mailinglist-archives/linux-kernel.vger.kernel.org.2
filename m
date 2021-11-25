Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA45E388
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 00:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351478AbhKYXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 18:52:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18570 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbhKYXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 18:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637884036; x=1669420036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w58VEU93/SakwcOauROsTaA1UaTMv/fxIO0+Z9swmBY=;
  b=H4CR/JdVbkkHeuU4MTaSNuM8OOoYO/NIVQ60rCMDZd6JK3lCe0eHp4L8
   yPluPaKTQgxJquZGYrVl/BbnOm0SNGIV9q4J3CksGHhPW+gDZdnlgIzzA
   xRr/lDDgdZy3s68wl8xAzgV6EIeZXMNU/Bc7K0w8xPTJrES7iyGOBK+Tn
   78VGVSEItYOTObalRnG7loQfbCCTEIYRWI1uvYtINzpXffMxqIf8Ot+qN
   4bLe8X//Iqb+s15hOwE56I8yQVjHghImPn/SnTqzxpHamr/XBbBMPQwOp
   lhjojgHJi2wID83FDh+6UDxFHNMWiFp0auolxipdy1z0MUZUSE1Gf8LLA
   g==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="298502956"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 07:47:14 +0800
IronPort-SDR: 7mio7SdmicNkd2mVRKveJ48o5+czaYemxPYHQyl9zOM6KA97ZWbxMR8kv1cx5x+eiWODN00bO4
 ZGjsRLB2wcSg198Oa3aBPiGAHk/FdQanBhCtB+IaBrZHR/CzLse+RheK9NIfjdWgbxqz3qdbWV
 HzDXVpgm6FtL96ZifdhuWdDoXb36n1jfPq/JlQlAPjO2BHn4T9pwd1+mn7TaIx1jJeHC3Gk+Mt
 Xhoolf0T0Lwpmx1V7TvJx1Hlsst3Yac/6OnLTw2cSXgeav5GQG8/YYn8rfXnuF0awCy2HXCdcG
 6wDKlIilFwT4lElqe6Y/P2Ld
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 15:20:32 -0800
IronPort-SDR: JPzBLbGgddOXCS0w2XOa7v7ZV+Vbxy89J94sERnM4+qxa4NzJQ8VtqNtjq8WcmGqrLEYPBjava
 QxEsLDl8RwCM0gTpc4FaBZXjko6MObLgjZWApfdUbK7V0lW/TPHMsUOzs4pW0pHn8PmczFQ0jm
 vVepe2tKFSrWu99c/5kNiyOfXUbJSmVg/ZF2wfFLVKXEgkKH3CHHw487fugb5Bocm1MLF8U3HF
 u4Bm16OHAf53mjQO2OnEa2fqgcG0w0xHksHhu+8i4j3ueheEMXjeRDEDED2rC+8/jc1DTaiXhs
 wA0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 15:47:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0ZKs6XCjz1RtVm
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 15:47:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637884033; x=1640476034; bh=w58VEU93/SakwcOauROsTaA1UaTMv/fxIO0
        +Z9swmBY=; b=iuxGZ3rxhGaPn3rKOKwI5a7msuKaLNM1l9FfuuAnwDI3JmgG22i
        2Lcu8WvZpWq4DGZLcV0RVLJ+h/dQDp8L2eVM7JOolnivNWyauKCEWUpk6pCqyiPG
        /uQ3iDukd9VhpgXUcyJPAiswO2AKNjX908C3F/PvZPywpVGcIstNMqg6X6G/JXwB
        TEYz9V4/dz57QvMBNCMl9dVkw3DYCHW23kGIUlpqT/GSAZDCruPlT8IRG+7MWD5D
        1IdXNNSIyYwNhjqb0MOACZLliEhMZTZODWSAuoiHIRn80mql6WRtzhR4XNR0foDg
        u9Nl0npfMrRBr/P0uM0TaovCEpnuhVzskIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WCGL_AvhgV0I for <linux-kernel@vger.kernel.org>;
        Thu, 25 Nov 2021 15:47:13 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0ZKr1dfLz1RtVl;
        Thu, 25 Nov 2021 15:47:12 -0800 (PST)
Message-ID: <c760f12c-c296-9184-7952-9b76c84fe48f@opensource.wdc.com>
Date:   Fri, 26 Nov 2021 08:47:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH -next V4 2/2] sata_fsl: fix warning in remove_proc_entry
 when rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211123014159.3442998-1-libaokun1@huawei.com>
 <20211123014159.3442998-3-libaokun1@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211123014159.3442998-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/23 10:41, Baokun Li wrote:
> Trying to remove the fsl-sata module in the PPC64 GNU/Linux
> leads to the following warning:
>  ------------[ cut here ]------------
>  remove_proc_entry: removing non-empty directory 'irq/69',
>    leaking at least 'fsl-sata[ff0221000.sata]'
>  WARNING: CPU: 3 PID: 1048 at fs/proc/generic.c:722
>    .remove_proc_entry+0x20c/0x220
>  IRQMASK: 0
>  NIP [c00000000033826c] .remove_proc_entry+0x20c/0x220
>  LR [c000000000338268] .remove_proc_entry+0x208/0x220
>  Call Trace:
>   .remove_proc_entry+0x208/0x220 (unreliable)
>   .unregister_irq_proc+0x104/0x140
>   .free_desc+0x44/0xb0
>   .irq_free_descs+0x9c/0xf0
>   .irq_dispose_mapping+0x64/0xa0
>   .sata_fsl_remove+0x58/0xa0 [sata_fsl]
>   .platform_drv_remove+0x40/0x90
>   .device_release_driver_internal+0x160/0x2c0
>   .driver_detach+0x64/0xd0
>   .bus_remove_driver+0x70/0xf0
>   .driver_unregister+0x38/0x80
>   .platform_driver_unregister+0x14/0x30
>   .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>  ---[ end trace 0ea876d4076908f5 ]---
> 
> The driver creates the mapping by calling irq_of_parse_and_map(),
> so it also has to dispose the mapping. But the easy way out is to
> simply use platform_get_irq() instead of irq_of_parse_map(). Also
> we should adapt return value checking and propagate error values.
> 
> In this case the mapping is not managed by the device but by
> the of core, so the device has not to dispose the mapping.
> 
> Fixes: faf0b2e5afe7 ("drivers/ata: add support to Freescale 3.0Gbps SATA Controller")
> Cc: stable@vger.kernel.org
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Adapt return value checking and propagate error values.
> V2->V3:
> 	Add fixed and CC stable.
> 
>  drivers/ata/sata_fsl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 2eb216792695..8e7c49793f91 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1490,8 +1490,9 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>  	host_priv->ssr_base = ssr_base;
>  	host_priv->csr_base = csr_base;
>  
> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> -	if (!irq) {
> +	irq = platform_get_irq(ofdev, 0);
> +	if (irq < 0) {
> +		retval = irq;
>  		dev_err(&ofdev->dev, "invalid irq from platform\n");

Nit: platform_get_irq() already prints an error message in case of failure. So
while at it, you could remove this one here.

>  		goto error_exit_with_cleanup;
>  	}
> @@ -1567,8 +1568,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
>  
>  	ata_host_detach(host);
>  
> -	irq_dispose_mapping(host_priv->irq);
> -
>  	return 0;
>  }
>  
> 


-- 
Damien Le Moal
Western Digital Research
