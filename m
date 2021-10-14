Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F842D10A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJNDh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44902 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJNDh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634182552; x=1665718552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BTQ/FBytJkYeAe/W11YgyjFoLQZK3TyIHOuIxod+jto=;
  b=g2mvr/PX6/8f8Gc1J7PyX4+WdCkA/6IYw5Y/dn1EIQSOWIhcz9u5OaGT
   PkRiBOUN2zCBKy+H39xM61biaKZVR4atDYqIm/n8ra5+4tAaSiFvPcQ+k
   KzQNBScx2/PvmDHUlNjR81+yY6B8kfyWHz9TSVrp2HdjmlsRSz2NeosCc
   Hs6KzTzQfK+lpbNrPd/t9laS5pi8dzAgRha0fprZRXkV5tu5hs9Phd4iR
   6XcURIb/Ts/UcXKgxhR+gqNmIyEme00qM535r8+Xs4ketmHbu037PximE
   wkaix2e6QocIjtueeWHre4PJBuLzfFCRFIUHd+GN5EoJs79/2p/7z/b/b
   g==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624291200"; 
   d="scan'208";a="294521777"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 11:35:50 +0800
IronPort-SDR: Obmjmct6wScHDh6d8TTjw67y1N3usSNW/eOodhUgbwIQOSO/4wphYh8+xnDTwMuHQSERIStArK
 7EvGcW/kGtvndImDHjhQcHeIEKg9lhmYL8LxuVXGlgbI/rsRc+VnfqudEsTa1u7gQXYFSlJKnp
 dvI4X8Yd+4zdD4S3kI2Phe1Ta2EtQrDKxmZpWsB+gw0wVpnANgX6Dg9RVzm8NmK3U2Uk6wOg/X
 CV50BcojGF0Ton23jfcrB4vuFhbfC7eTxuM/DRmS0dx1oJ+wjGBdrDFO7x8pUXuPsmhx7zU/AO
 2O8PCGksZFcgGZD4X3SklFwr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 20:11:36 -0700
IronPort-SDR: S7f0Hwezw6fgjri5ljwIhypYY8F0+2cC6UkDNUBaVvEJJHUXB1LFUwJwgK8cSn7EOviRMLdYsq
 JfpXL1/0sBVmjofqUX4xf0HLN5JGOps28udEL/ckQb996P32v3pQaRP2F4KgNqzRpw1LkXx+s1
 aIfTpwGKSuETIgLu4LakgKdvlCtMdee/9oV5xHE1BFedrN5cagERxypLR8h7g/jX71e6EJqf0y
 ENv7GL9A3JDeGAwgQfYnBvjzzptvIX9/UsefTkqaS/pco19Rb0Kw3pBGlaUuvEGj1KbveEsE7X
 psw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 20:35:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVFRV5Ny1z1Rvlw
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1634182550; x=1636774551; bh=BTQ/FBytJkYeAe/W11YgyjFoLQZK3TyIHOu
        Ixod+jto=; b=a/BJuufDY74w5DB576fPRVgDJIPEN8OQRlJOWziAll5ZuQRM79/
        eEzSfEvP/tAsISf30RA8GTrZXxawQXWKpKvwHchHd7OCFPjGjbn3vX10DGjh1SPF
        wi3Hyym+ridca8EBir6v5jqxzpAQ/tp71fzky/etEDM8S/WTM7ssUZTtOiLg+aQy
        SWxOn5kRSycbFN6OhYDrX/7Ce78qDfr0G1zLlMmC+tDPaJH6KlDehBAE5EtY1M9P
        lzitx9sZkQLJWhdLt+68S9bIUOgHBO60fUFOn5oDk3hZBCgcc/KxXtJaQj76ORyg
        NaOvS5mbIUX0gsSZw+lVV2Lel1mdqC+ZV2A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kNs7oTAZAy-P for <linux-kernel@vger.kernel.org>;
        Wed, 13 Oct 2021 20:35:50 -0700 (PDT)
Received: from [10.225.163.59] (unknown [10.225.163.59])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVFRT0Z7tz1RvTg;
        Wed, 13 Oct 2021 20:35:48 -0700 (PDT)
Message-ID: <0a7afa9a-db24-910c-314d-2a6f7c43c5ea@opensource.wdc.com>
Date:   Thu, 14 Oct 2021 12:35:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] ata: ahci_platform: fix null-ptr-deref in
 ahci_platform_enable_regulators()
Content-Language: en-US
To:     Wang Hai <wanghai38@huawei.com>, hdegoede@redhat.com,
        axboe@kernel.dk, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211013061631.2958938-1-wanghai38@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211013061631.2958938-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 15:16, Wang Hai wrote:
> I got a null-ptr-deref report:
> 
> KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
> ...
> RIP: 0010:regulator_enable+0x84/0x260
> ...
> Call Trace:
>  ahci_platform_enable_regulators+0xae/0x320
>  ahci_platform_enable_resources+0x1a/0x120
>  ahci_probe+0x4f/0x1b9
>  platform_probe+0x10b/0x280
> ...
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> If devm_regulator_get() in ahci_platform_get_resources() fails,
> hpriv->phy_regulator will point to NULL, when enabling or disabling it,
> null-ptr-deref will occur.
> 
> ahci_probe()
> 	ahci_platform_get_resources()
> 		devm_regulator_get(, "phy") // failed, let phy_regulator = NULL
> 	ahci_platform_enable_resources()
> 		ahci_platform_enable_regulators()
> 			regulator_enable(hpriv->phy_regulator) // null-ptr-deref
> 
> commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional()
> misuse") replaces devm_regulator_get_optional() with devm_regulator_get(),
> but PHY regulator omits to delete "hpriv->phy_regulator = NULL;" like AHCI.
> Delete it like AHCI regulator to fix this bug.
> 
> Fixes: commit 962399bb7fbf ("ata: libahci_platform: Fix regulator_get_optional() misuse")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index b2f552088291..0910441321f7 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -440,10 +440,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
>  	if (IS_ERR(hpriv->phy_regulator)) {
>  		rc = PTR_ERR(hpriv->phy_regulator);
> -		if (rc == -EPROBE_DEFER)
> -			goto err_out;
> -		rc = 0;
> -		hpriv->phy_regulator = NULL;
> +		goto err_out;
>  	}
>  
>  	if (flags & AHCI_PLATFORM_GET_RESETS) {
> 

I applied this to for-5.15-fixes.

Note that the code right before the hunk you fixed looks like this:

        hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
        if (IS_ERR(hpriv->ahci_regulator)) {
                rc = PTR_ERR(hpriv->ahci_regulator);
                if (rc != 0)
                        goto err_out;
        }

This looks very strange to me. The "if (rc != 0)" seems bogus since if
IS_ERR() is true, then hpriv->ahci_regulator is not NULL, it is an error
pointer. Some cleanup seems necessary to me.


-- 
Damien Le Moal
Western Digital Research
