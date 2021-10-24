Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2A438C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhJXX1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 19:27:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30047 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJXX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 19:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635117877; x=1666653877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSni6iXUGiVL+1tgcIkRcK5iNkHL92fz77zC9anEhZE=;
  b=a2qPUOL1t1PP7JC3Q9tkXq1fZH8ym38OXsKOi9Dy5Qqjjhu5iDfPN6O1
   zY//uSoO6CV5dscE2kIktOzuVml+lJDZZX6Ryv5KGAPsKSCyBZHuRU4Bn
   lCIqbaq0xAWldqjYumUrND1NtoFq6aA7R+5eS2FPdLo9nXx/eIFXFS9gA
   0eFu97Vl1NoA4OeFXUGmc6pcYhaGaMIHo6jYKDvkAERFZNpb49FmRnHjY
   IW2Ixjo3m4Nne6N9Np+nVbT/L+M2Eonw65CvbgtHszJ+hGNcKImWbElYu
   Nomw4xsqe7wp3hm7LFKVe2p3FsBUq56TTx75xZKy2scbnjx7tK5o7fVF5
   w==;
X-IronPort-AV: E=Sophos;i="5.87,179,1631548800"; 
   d="scan'208";a="295458768"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2021 07:24:36 +0800
IronPort-SDR: Y+ajx90M2R8IgpSiMgapHeqBPMXDw1iqGszdMarowIsr07ulCrQJIwhIlTp7t0CiLaCxGQU7tl
 gi0WANpmyvjI94xR7NgQXu9hgJX0Imcd3wN/C/6e6pF3X4gsItFvwyNo9cqs7b5SmRAtR5ft/1
 jN1477dEzKr0689r4l5zmDekhxGCc6KdlkGuyxsQ+efX5oVcYyOg3kUkp5sPOs6fDfqQuyCBtT
 MjiI6KLuzTAeaaE51uj4SoyQuRj85rg/TSGi/WJ+sYSv/a/+E8N5LjShv3EWEOIQRCIumqJAx8
 g/e1qqnJYUv77ixp30NGqpUn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 16:00:09 -0700
IronPort-SDR: jj+dBBQzI0mRBKniAQpXn9V361QkYTXw94SbbcTmkgk4wukGOtRC3mRlDETCmjLzS4EAKWkkQK
 jHLkC6mdyYxr9Zpfj8yAGEf6mpwjqDDTd/ISvObU7uxdNX6lGptvjqNbeqH7xqLskoSsWfWgHq
 TC8s71ViRwevqQ0T7A31C4YBJanQoWdzIO6o3S7V2Gl+SoPpzLWyGY9e/Z05zUMB+tksHNE/Ao
 qTGYEZczjHYBHUJa+vd1d3cNc9IfTw5S+G+/waFgw70heBbfKOo2hIR0VD5RAj34LZoOByoavv
 MnI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 16:24:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HcvLX2tgbz1RtVp
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 16:24:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1635117875; x=1637709876; bh=JSni6iXUGiVL+1tgcIkRcK5iNkHL92fz77z
        C9anEhZE=; b=JZVk+DDg32P10gpbwUNYp6mURWcXEhDjBQJ5ZpYWUUviakSuBsh
        VYiWCDeKv1bOKrmPIv+jWcRCVuTOEveVySVt1Jme1eXByiHZiOOkAkLdlY3TlD1r
        7rPZXL6lq65Tc9J/Pr/Nn1LSR80OwKU9eudlZcXAi3PFqKfMAaE29oIZFyUg0TiS
        6eBDR2Dy0sz3KOUe4zkPLLTqPFXxVVS2rHR5GV9fshr9UVrVflMqJ1pahZoagZ+3
        N0qbhQGRD8fiHX1NXUEr88USFiY28NU4QDq/nVla46o5Wbtg+rMSpwkgwZYIcF4u
        6nU1ZanOkOdw/1UhukVvSqzidxw23jRuwSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id umBxvH_KDjo7 for <linux-kernel@vger.kernel.org>;
        Sun, 24 Oct 2021 16:24:35 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HcvLW2F9Dz1RtVl;
        Sun, 24 Oct 2021 16:24:35 -0700 (PDT)
Message-ID: <02571fc0-9c08-3e2b-124a-17fdb2262050@opensource.wdc.com>
Date:   Mon, 25 Oct 2021 08:24:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: Potential null-pointer-dereference problem due to missing
 null-checking for ata_timing_find_mode
Content-Language: en-US
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYCP286MB1188D47BA1A976E4090AF2B88A829@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <TYCP286MB1188D47BA1A976E4090AF2B88A829@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/25 3:08, YE Chengfeng wrote:
> Hi,
>=20
> I found that the function=C2=A0*ata_timing_find_mode *could return a nu=
ll pointer in
> some situattions, but some call sites of this function don't check whet=
her the
> return value is a null pointer. Could it be a potential null-pointer-de=
reference
> problem?=C2=A0
> https://github.com/torvalds/linux/blob/master/drivers/ata/pata_acpi.c#L=
145
> <https://github.com/torvalds/linux/blob/master/drivers/ata/pata_acpi.c#=
L145>
> <https://github.com/torvalds/linux/blob/master/drivers/ata/pata_acpi.c#=
L145>
> =09
> linux/pata_acpi.c at master =C2=B7 torvalds/linux
> <https://github.com/torvalds/linux/blob/master/drivers/ata/pata_acpi.c#=
L145>
> Linux kernel source tree. Contribute to torvalds/linux development by c=
reating
> an account on GitHub.
> github.com
>=20
>=20
>=20
> Best Regards,
> - Chengfeng

The ata_timing array last element is 0xff, which is the initial value of =
pio/dma
mode. So an entry will always be returned. I do not think the NULL return=
 ever
triggers.

--=20
Damien Le Moal
Western Digital Research
