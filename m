Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E245E43E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357570AbhKZCB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:01:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9786 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbhKZB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637891774; x=1669427774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VAqsQec0+Opf3JDtqaY8hCVI7L6tRNJGyVRiDWoI49o=;
  b=p6iCbvd5gprpxEvdOWgXnRkQ93vomsPOpJEUDoZq08qW1k+5c9V0JoJL
   lWnLdqj2CgAGiu+eeJR5kMCFlcXRfYKp+FX34+blehqs+jayOEpuZCU/c
   vUNbQq58rDN/D1kz7gStBkNkfIEmEDVLzfhP3Geh2Qo854ty5EeR6XR3t
   Vb5CsSCIZZWxwD+zM5f83sXk4Yqaj+mud6P5Smcr1hU+dwvUYA9VdjmDl
   tHDWOZkx48RMKQTHEOf+a2ypuSE9NVFwLOaDDpAnL7zTxkds+m2JxF/yr
   hzQWE/CFycYgVcFDVmjmj3hOtDla0sSZOt8E9KMl4vVrax2l+Hl4o7M4V
   A==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="186679701"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 09:56:12 +0800
IronPort-SDR: uowJBo2GuYyHcPY3UzZzYPlWvjwW7i8sVOGMhB+YSm5DNwZGBlUL6EiZuLCxgOX06lKdIW+W92
 zXSzVHEY/KiFk1RA9XTnXz4Qy7A0mEPfbD9NnXZOLR5Ztv0AEInDQgaUwReHeIGCqs5wJDo6/7
 fpv6yo+0SeAE8iH4omMKHPD36BP6/wRwqoZCRkQjieHYv50spxDraXbuZnSWRAYcwV6coXyuxj
 39vHBUOIdn3FbxVju5i0hQxanU16YdoOszSwaeZymj0ej1kfuj3gyqLBYnrhEazosXNH5K6hH5
 At812f8+ZQslT7fLbDXKtKQd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 17:29:30 -0800
IronPort-SDR: YYHebSXqKpmGAnthtZZzeZSKo/VafYQn/st/5mpmDN0AsywPht989XPT4fqsu4iEhVzh5yXGb6
 8BSZu+YagCa8gYHWOuWVjH7C8SiVg/JKGX/qQMo+p1UxX7ZNnI3xW3iBeZGcsS8E8e7VtBPckn
 8pdVsu3HMbc7uueKUXhNC1vIDD28dD2GpiX0CR9YMskKkFxCKyyUxbyRqjaxZ725hpyUxN6lPK
 yFbwF37RdUi5/Y3RNb+zeQVOueltr7tWWkIqCI6gUXHKteeONWR/lHpJ7mBRVitGDr6Sp2MGI+
 aoQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 17:56:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0dBg5mP5z1RtVp
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:56:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637891771; x=1640483772; bh=VAqsQec0+Opf3JDtqaY8hCVI7L6tRNJGyVR
        iDWoI49o=; b=TTv9BSpGZXAwCwy/uUxejuv3mgrA0Im9V5RaLYWJiujmkTNz7N4
        zQTSNcVnX/Bs1TaEbsEU/xrJPW7I8uJbczqmTf9hUgEWe8WJLTSEWcBpd/4wG3vP
        Gq8W5pdmfUqYnW2uYalM2DlZopdpEGf7EZN7tJcCRrJuuBKniKWSOaRzlOXyAh3+
        jy5VHs/ylyvhX2d7/pTCGvI9dBQw9R48d51UPBTcmhW5fZo7Lpa5b655aEtfjz7L
        VnftgB699vAZNtinJaveFj+acqE6g17SRspan9EinKA5VYK9c2G5IBoe/6aE11fr
        J0jsmuVBtENrUi5on581GmxLDVg93FBuXWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AZmoEvQ_ESBv for <linux-kernel@vger.kernel.org>;
        Thu, 25 Nov 2021 17:56:11 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0dBf2L22z1RtVl;
        Thu, 25 Nov 2021 17:56:10 -0800 (PST)
Message-ID: <4469be5f-01a9-5d10-9dc3-b703f36a1ea4@opensource.wdc.com>
Date:   Fri, 26 Nov 2021 10:56:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH -next V5 0/2] fix two bugs when trying rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, yebin10@huawei.com, yukuai3@huawei.com
References: <20211126020307.2168767-1-libaokun1@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211126020307.2168767-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/26 11:03, Baokun Li wrote:
> V1->V2:
> 	Fixed the check on the return value of platform_get_irq().
> 	And propagate errors up to sata_fsl_probe()'s callers.
> V2->V3:
> 	Add fixed and CC stable and modified the patch description.
> V3->V4:
> 	Use a single structure.
> V4->V5:
> 	Delete duplicate dev_err() message.
> 
> Baokun Li (2):
>   sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>   sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
> 
>  drivers/ata/sata_fsl.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

The series looks good to me now.

Sergei ? Are you OK with it ?

-- 
Damien Le Moal
Western Digital Research
