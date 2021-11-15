Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBF44FC83
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhKOAGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 19:06:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64264 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhKOAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 19:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636934632; x=1668470632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gTlG4y8PIaaaGzRUmCMKdDVyddI7uk0biQazOncrHPQ=;
  b=MDf8JCMGdD+ixw0AMctSeW9PJbpcs//o1DlqLjULgrGCc0PcAIHRVSPT
   cDf/A3PGOL8I8byJTFh90UztnBVJOpAR4BHj4hQ9t8Ot72FFZmLwjQRQS
   rpkiEbyE0Z1H+ywPyqdxjaBQDHheWHFUBl5nx+iB0/go26ZShuPhDuVv5
   B5a+x54fJ7nuvKaivXNEEV4fY4fnWUcAj5NK7/sODIaaD7ox1o/GC2DEd
   6O5ncWqbLy3IpoPZ/4EfEN9m34LK/AG73WhmeOeTT8HGD8+NT3PnEM0Gr
   8j9a/guk6xk23qe9eWAw6Ucv82B8thenXhQi11qOBZPng2y+LGcrNcPn6
   A==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="184565627"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 08:03:52 +0800
IronPort-SDR: RBkPBArHW5R7c5XiYZgftH6bJN0j895hr4Q2WLtY8lHLJcbvWtEK4cvHHHckeD3wmvnC5Dp/s4
 RGpoASGrHWXC8/lpAfoT43unHByH/H2OLctiQ3I/7n2dAHjoxM9V6VY/CQukZTgLtmN6rcnjRq
 DQaPpJmJxJn7Mm6ix2grse4oApRpxLpMJrhGTFYD2lfosUeI7QmYohNePMsDeVru4bL/5oG+Qi
 elYQ3o6RtXWVpEfD4c2h9J4+XuUot/qoLg7HLwwR+s3DLUiqQOWLUGF4VJFKpwGM/qKqHJpFAc
 WLctg9ynXO4H86fe1QYZNGdE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 15:38:57 -0800
IronPort-SDR: WTgxqIkt9Xn3HS3HyQYjlW32rMdpFifNSp9uHSxI/Ce3bfrw5BtiGt+iZD+ZQrUqElMRj4OrfO
 2h3eGqRVhRnbdn7JI9d0f+Rkk7fn8kqtodySEUsUrgEzQ1zC+xagrOVwDlK8wvGdmh6jFlFeJM
 65pLl/tVyF7xdVVwJNAE9v9PWd7nHJEa36XQBmDOskESfaT18359WHWct66+TEOsg2mJTRfxV/
 LJGgM9OdGIhF2oVug80zuFebfA5di0afoivFPeRO8S3nYCchqX+rXHvRm2BXBrEuH7Y9S+vO9S
 ubo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 16:03:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HsqD74jWkz1RtVm
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 16:03:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636934630; x=1639526631; bh=gTlG4y8PIaaaGzRUmCMKdDVyddI7uk0biQa
        zOncrHPQ=; b=jK4uU3h9W3N7qNArvsA44JOylpqw11qjb7J0g1VcfJwE5xeBXMW
        MavWpSgpcGl/j0a9ZBZtz1iaIKyRDY1Rdy3tNZ1XaeVHAyxvGOPBYbe2kJyItwFT
        84aHvVWPs7Vi8ogf/XyYsphctY4u6NLB/4WkVGKL/wHQhVloPimNhtgGYzYFZufu
        FO4rckTU6jAlwQD0N3kcBy1EDUAlRX7+3oO1s3tTo3YP32zekSQTJF2ztRYruQ67
        2xvoBPqU68t3KdS246cdFwTFDXJe7rY9MYSpUrQXfvtLTYaiPeDl9nl7aKCjtD9z
        ALz+bk9EZ0fX70AIDqhzTlzukxjqWCS1hiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wgSwlJE8rqgC for <linux-kernel@vger.kernel.org>;
        Sun, 14 Nov 2021 16:03:50 -0800 (PST)
Received: from [10.89.84.145] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.145])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HsqD55YMhz1RtVl;
        Sun, 14 Nov 2021 16:03:49 -0800 (PST)
Message-ID: <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
Date:   Mon, 15 Nov 2021 09:03:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
Content-Language: en-US
To:     Nikolay <knv418@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YZABtvQab/M2CCQd@msi.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YZABtvQab/M2CCQd@msi.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/14 3:19, Nikolay wrote:
> 1. While booting system, the following message appears in dmesg twice:
> ata6.00: Read log page 0x08 failed, Emask 0x1
> 2. Error comes from libata-core.c:ata_read_log_page()
> if called with page = ATA_LOG_SATA_SETTINGS (0x08), 
> i.e. from functions ata_dev_config_ncq_prio() or ata_dev_config_devslp()

This error is not fatal. It simply means that the drive does not support the
INDENTIFY DEVICE log page. Nothing to worry about.

Attempting to read this log should be avoided in this case though. I will send a
patch to fix that. However, the files you attached show that you are using
kernel 5.12. That is not an LTS kernel (it is EOL), so this kernel will not get
the fix.

> (latter is new since v5.14 tag).
> 3. drivers/ata
> 4. /proc/version, output of scripts/ver_linux and kernel config are
> attached
> 5. Not appeared in v5.14
> 8. /proc/scsi/scsi is attached
> Relevant fragment of dmesg output:
> ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2: SATA link down (SStatus 0 SControl 300)
> ata6.00: ATA-9: WDC WD5000LPLX-75ZNTT0, 03.01A03, max UDMA/133
> ata6.00: Read log page 0x08 failed, Emask 0x1
> ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA

Your drive is still detected as supporting NCQ, so I think this is all OK. You
can ignore the read log error, unless your drive is not functional ?

> ata6.00: Read log page 0x08 failed, Emask 0x1
> ata6.00: configured for UDMA/133
> ata1.00: ATAPI: TSSTcorp CDDVDW TS-L633F, TM02, max UDMA/100
> ata1.00: configured for UDMA/100
> 


-- 
Damien Le Moal
Western Digital Research
