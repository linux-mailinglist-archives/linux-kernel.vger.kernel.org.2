Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9579A429ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhJLBIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:08:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33208 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhJLBIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634000765; x=1665536765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ujozDCylpTjnhRW0fHwwhsw5ux57HbuU8ib0WoqmCRY=;
  b=ktMNwXSe3NbR/fuv6mk3LOHryN1JI2AgUbBygtMN5kCV03Ncff/C1hjR
   ZkFFaB+Wd6HymFyRN4357sOpEbaTC9JfXtOhy5pvWww0EKBVQyUVot/dT
   SkPaw3SD5mPIVWwRumlGC0d+DqmsrKAvu6XkxewXclZLlPudJxBTRCVrC
   gvN5psZUXQsrJ8zzLY6s0xVxhyBSCxtwgH9lQVZdhfFhqBsgE0EfzFLK/
   CCB2i9Yw0Io0IG0HJpqnPzWAMIvWfQj7RBRfYv8xQtBuluH2KcFst3fvs
   JJ48ZEmjQoLdZZcHjP6r5vGUt0CKliGB8VU8dwFyBqfVVpoO6q6r0Wn8j
   A==;
X-IronPort-AV: E=Sophos;i="5.85,366,1624291200"; 
   d="scan'208";a="294274415"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2021 09:06:05 +0800
IronPort-SDR: 24a/DSCUGD5XnCRdR0pimfBvXfIkMeFYbWPoDzFxZqo0h/x9nJ92Vwzq3Ft3KWIa7PjVCOP1Kj
 TzKzu3fFPncNTg+n2Gg63cWIKysqlHgB7Lejyjk7ch8mFUptAbrybYnFBbLKT2kWPbsl68CPDI
 cpsC3KqseIlmpokTMJzBYI9a4Rd4uxGb/bdrBqPmQiCLI25l76umKaphi54edw43bkH4ha/puD
 62+aPNiatQL487+R6vc8VWwOEl2dehDPZCwACiqF9GR/iO9qpSU8aCcmFdmEy+RsgTuwmRcoCx
 FQ6v8VP0aOYxn7pjnMdyylCE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:41:53 -0700
IronPort-SDR: DekfnG3dP8Jy36M6eUhwT7cR1qRubdV6yjEPwXaNhh+SHDWMKqI0uwkOFO0xSZGAxMxEVbfRS1
 LPSDrCoZ+UYgqubJ97kPA0Q+iud70N/7KQ9Ot5VvyWadn5fLdSfK7E8ghLO056RF129UdXtSDb
 sOzxh8TRqSGv3NF2NSW52DGkNNLIictDbmV6vkQ+bOvqN0p6Ca4knamDcJypk1oXxWodX8Y2di
 bsG/whJ/zUqkle7I0V/rIHAWSz60AVf6aOq6HDYAa8vTHkwQu6U6CZCMMe2EiYekVoLR/AxXsb
 UGA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 18:06:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSyCc49gKz1RvTm
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:06:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634000764; x=1636592765; bh=ujozDCylpTjnhRW0fHwwhsw5ux57HbuU8ib
        0WoqmCRY=; b=BBbHg5Jt1pbWCF+os2YrMrzE9BL+p9R1yqdd3n9RmBpwpf7eicE
        UufwA7Jt+lypIJLjPgNPxxGZpz3LIT4dhEp6f72yekmXxKwGg2dIM39k3q+sXg6P
        fACNgISUIPwT6K1YaB/8/r+eiLpd2HBJQZxJPvtgfvz7sZbzMenwDaKKeqKimJL0
        /EZxSKAcYd9b5lCsZbxBl9tJ6oSLNguMjoigaLMog4SI1so9iago1CFHtSmoqQmi
        gHK44wRL/DVwVEuHKk5zmMXDd1LOl9fB7R/KRt47R6j8qJE5eing3wOYhXm4au2E
        8El596k6kX/Pz33xOBmDkvNRo/EyGGc6/XQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uCXPbf_2SVcF for <linux-kernel@vger.kernel.org>;
        Mon, 11 Oct 2021 18:06:04 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSyCb4FCpz1RvTg;
        Mon, 11 Oct 2021 18:06:03 -0700 (PDT)
Message-ID: <974dfba6-915e-c3d6-53f6-473be18faf80@opensource.wdc.com>
Date:   Tue, 12 Oct 2021 10:06:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] ata: atp867x: Cleanup pointer value print
Content-Language: en-US
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20210930030533.1216577-1-qtxuning1999@sjtu.edu.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20210930030533.1216577-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/21 12:05, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than cast to
> 'unsigned long' and printed with %lx
> Change %lx to %p to print the secured pointer.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/ata/pata_atp867x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
> index 2bc5fc81efe3..c32b95f48e50 100644
> --- a/drivers/ata/pata_atp867x.c
> +++ b/drivers/ata/pata_atp867x.c
> @@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
>  #ifdef	ATP867X_DEBUG
>  		atp867x_check_ports(ap, i);
>  #endif
> -		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
> -			(unsigned long)ioaddr->cmd_addr,
> -			(unsigned long)ioaddr->ctl_addr);
> -		ata_port_desc(ap, "bmdma 0x%lx",
> -			(unsigned long)ioaddr->bmdma_addr);
> +		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
> +			ioaddr->cmd_addr,
> +			ioaddr->ctl_addr);
> +		ata_port_desc(ap, "bmdma 0x%p",
> +			ioaddr->bmdma_addr);
>  
>  		mask |= 1 << i;
>  	}
> 

I lost track of this one. Any v3 to be expected to address Sergey comment ?

-- 
Damien Le Moal
Western Digital Research
