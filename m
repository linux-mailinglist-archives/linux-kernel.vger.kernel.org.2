Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE6435F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJUKkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:40:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24602 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJUKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634812713; x=1666348713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTJ0NWfGSeFPa2HGnoEzteTS3jN1Xezl5YFwCqHjj5A=;
  b=YyBqM94EXmJsq49fe7AvG/dgS04l+cR8iKQzaHJHJiYv77dLpMnNoG9V
   z+YhsEAs2vTynIOsQ+wDY8KSwaBXvvWLIlI4yd8wMYBtZNQmDbDMWrGpg
   yqbWmLbSJhRdT55lbH71hp1RkoFU7wZubtNcNXBolStJc3a8Py2rqREbQ
   emFS60SPyyYtk5k+jQ1134UJss6vRdFPEIkYbeVaDcBA3jLSmuGAar1il
   2FynaTs4Di4V7+cHQbFXPvo9WLBY5n4qVhG5mxxLIf830mHdiUxBiDSdZ
   zNIB03RM+EuhDVj/dnHGgEKm7ymbircyyoXovGGsXiDomag/Ecen7aDtv
   A==;
X-IronPort-AV: E=Sophos;i="5.87,169,1631548800"; 
   d="scan'208";a="188280371"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2021 18:38:32 +0800
IronPort-SDR: PCPp/EQzeM89S0Sw4wHPvwhWOF6tgCnMnZ2M63eImU/3Gu636+Lhr5iXV7aevOiztO+UxQi3sU
 XHq/BkadbA3zRJUBJH5TCZu83x1GE4iVwlGgORNplM9efYlUQhuQfIPDrHI0n8yjpXQQSRIpJC
 J6x7jUPG8fww2iG7l9wlKos9GRT0YfTUMbx1RWA5CWViU1teQBDxM3QA/5vaBTag8A7pff19Qj
 bbRW3DRiLve7oO3dFTBluN3oA5aFWYjojECCeIKMtvnYztyAhdpF92TYGgnaON4GzWK4ZyqzB+
 tJskO26hYIBws7y8aA2a0gAV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 03:12:37 -0700
IronPort-SDR: t6y8j06PgcI6YD6r8xtYtuRtOQ+1zgCyTnL4J/zBGx8OhHVSxMKW92Jmd8Ul1wc27XpdnRPrDK
 8RV/ju075ZdBQJTAQgbD/4FiFktgQn68T0dWGd5jkaqyVMiYt+2ZhHG2gTB9YQh8L6zXY1z1SR
 CCOXjzgCIT5rk9uTHn0IYb9IcLKNR8Gs/HQYautdRYcdNoK+6Pve6s/yejSyfm1BnbIupJn0jY
 9ZNgt5JKgdN/bbpfCwS7KXsAphVdn/idAGkP0w/jeNR4++R4flWpG4evgAlrpZJ/RpKN0DiCdm
 KlI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 03:38:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HZkV120Hjz1SGYS
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:38:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634812712; x=1637404713; bh=gTJ0NWfGSeFPa2HGnoEzteTS3jN1Xezl5YF
        wCqHjj5A=; b=sn4iq/iy+D+2FogkKRK3uGw0ViRXUkn7mRdeO8maO4EPlBg6Zeo
        Ab3EaHWyfea44vS7XF0LyaDUnJzuegGbZgUjtIgs6uOaU6zHYGG9oiyyb60bNSQX
        4trg/7Hkck7h1kDUGSbOl7rmKegP6FHy7c4ieKr2/If4DIOPvR/3V7cFEfKsWA6p
        6ZcySuzgHSkNp0/eZkiAegj7wpapsoBYBRbeUj/NFH8q34SwBNS8OoNgdSbKtMoi
        huVXyxq1Yf74dm1/R59dSapqtcd4mQHUzrAc/xFXhMskbS1WohNtzBQynOzJxv01
        smAISU+t85hv3uErY1O3ugXMJe99KsTMFVA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0HOAyBb5MDWT for <linux-kernel@vger.kernel.org>;
        Thu, 21 Oct 2021 03:38:32 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HZkV007xVz1Rwt5;
        Thu, 21 Oct 2021 03:38:31 -0700 (PDT)
Message-ID: <1d5064f6-0498-c78c-d98f-df7ca74e0a8d@opensource.wdc.com>
Date:   Thu, 21 Oct 2021 19:38:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] ata: sata_mv: Fix the return value of the probe function
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Zheyu Ma <zheyuma97@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1634795836-1803-1-git-send-email-zheyuma97@gmail.com>
 <e1f96f77-cf44-7783-bf88-0814bbabbfbc@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <e1f96f77-cf44-7783-bf88-0814bbabbfbc@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/21 17:37, Sergey Shtylyov wrote:
> On 21.10.2021 8:57, Zheyu Ma wrote:
> 
>> mv_init_host() propagates the value returned by mv_chip_id() which in turn
>> gets propagated by mv_pci_init_one() and hits local_pci_probe().
>>
>> During the process of driver probing, the probe function should return < 0
>> for failure, otherwise, the kernel will treat value > 0 as success.
>>
>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>> ---
>>   drivers/ata/sata_mv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index 9d86203e1e7a..7461fe078dd1 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -3897,7 +3897,7 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
>>   
>>   	default:
>>   		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
>> -		return 1;
>> +		return -ENODEV;
> 
>     Doesn't -EINVAL fit better here?

If the error message is correct and this can only happen if there is a bug
somewhere, I do not think the error code really matters much. The dev_err()
should probably be changed to dev_alert() or even dev_crit() for this case.

> 
> [...]
> 
> MBR, Sergey
> 


-- 
Damien Le Moal
Western Digital Research
