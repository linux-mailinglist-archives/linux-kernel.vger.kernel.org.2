Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7C449F44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 01:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhKIAEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 19:04:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50857 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKIAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 19:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636416079; x=1667952079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CC+71pr0JEcv52gEobJ5aPpe43f/FIZmKX9mSfBQ34=;
  b=OubrYye/ZE4gIUwu5MVczSu6zk6KnUIm1nDq5QSbVHyO4ZLvsquGdr9u
   lGdZIIsgd99PKhGFd5hIIgmh8//swsjo1P9WJb0+IIHvWCiFzZSVwYCmp
   7LO9GDHYdkzxxP2MQ1QHEBOUv2g7MRBEb+7KJvDNMSIE4jd2VhTljufps
   kY5S2CEIuKiqE817Mo2ql6SALXdTwj7RwRzKkOzMwdXNH+c3FM/v90P1m
   J6gtrf3uZ4VctpW2RTIFQmnzVYtm0eZ0XnJHc/FM7vjD79gm5uIJg3tZU
   34rWn/jVYmClueUpRsg/5qqUUGYpG2ERWy2hTsiyEyl+aICe+b2nkQP/U
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631548800"; 
   d="scan'208";a="288987035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 08:01:19 +0800
IronPort-SDR: PYHg8vHfR3PlTNXXafw1JriASwnX2mTgjhFEqOv9gdXExAfmvPHxSUnrgXgT8IeDFy3wBdDtYl
 0YKHFQ2Hj3pE/DhBE3Nz3jnoIgqt/OJk8fCkn45mkVA8M+BNleu6LMY+siPCBKzFuxOT/j8/5j
 EdUx0woEfxQ4PY1GrhbKkDk6aF6Bwn5WGqtGd5XGaxUUxygWeQXyV2qzk7EFi0Qimib7lnz44t
 lmBRQPhySjfwXiX3CXpN9LA3SjLCFbplMbF0x06rGjgTJaNEz0oNwidk0WyyOh22jIuZ3YdbnR
 /pDDmhSdAz3iVeUsFh86QhVg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:36:31 -0800
IronPort-SDR: WgpZaI2C++389i3b1bXcpl0A1770igPgyVM7DEl4douij7H/f/Vy0iVrz0Q7wVoS8/DemjoaIL
 umxQFpgFAL2gkBYgvOeU0y/1zf9vfcLM7kQ3Ywwe6FwujMm7xv9ixvrV/ytuXX2TCc5RgqQ1pO
 qQXsVeJnDrqnhSOQ36YdkMYrcD2uPbYjzNo4hzXoYjMMy4cn9cdsFZPwXLZ802ZkfHg2f35QXq
 9pSSAwt44eNNsgpVf3BZ2R/XWU3q2c03Ww0ocEY8LT3avFv+fHzkwsczMWUVYrwdaqznFgBWEx
 ze4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 16:01:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hp7Ry5dFvz1RtVm
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:01:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636416078; x=1639008079; bh=0CC+71pr0JEcv52gEobJ5aPpe43f/FIZmKX
        9mSfBQ34=; b=ABrmVHvg0vj4rZKyx3qyqfZoApFU5rO379qT6mB4jtL9qyN37G3
        tJxeLpoV+B0Nb+VtjJwdzr+Bamk1y1Q191wvoKrsokIElZaCJd33sJ52a2+OgEYC
        Nt2ZkZZdhZMcqM0OmIlP2lR2gUtzkbBJ6U/uxz/N3oWbd/p6ARzwXHh39Jc4Ww7G
        4U428f6CBU5IF74JUlxSzDO3qq1kZsktWOARhWpkb/aY7hc0FaJIWJLCdQXJLFHh
        sHgvk0xN+TS8d/DsQW4/U5NUIfSiTkLMAZh1Ao7GZkPPZrc9LmO3K8JIzv9TYvWZ
        VgsafU+6J2EDo51iQYmdz0cD4ENnTz6gvIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zFpV-a5Gsco8 for <linux-kernel@vger.kernel.org>;
        Mon,  8 Nov 2021 16:01:18 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hp7Rx6s9Cz1RtVl;
        Mon,  8 Nov 2021 16:01:17 -0800 (PST)
Message-ID: <418b3bdf-42df-c7aa-0e21-fa35484a6931@opensource.wdc.com>
Date:   Tue, 9 Nov 2021 09:01:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] ata: sata_highbank: Remove unnecessary print function
 dev_err()
Content-Language: en-US
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211105015021.38998-1-vulab@iscas.ac.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211105015021.38998-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/05 10:50, Xu Wang wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/sata_highbank.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index 8440203e835e..b29d3f1d64b0 100644
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "no irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  	if (!irq)
>  		return -EINVAL;
>  
> 

Applied. Thanks !

-- 
Damien Le Moal
Western Digital Research
