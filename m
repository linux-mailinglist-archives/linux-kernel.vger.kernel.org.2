Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1DB451C81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356781AbhKPASl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18814 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356171AbhKOXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637019976; x=1668555976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ksWPLnze/XmDxYhUzJh44fx8XX05D1wp1nWU6YtLIw8=;
  b=U4bgvZuP02zaUDbfEx5XwEBtJShlgYnpL9982AdS0yZSrg+im+lU6x35
   zVHKY4aolJCI6B2miTHNJ9uHmb/3OL/GI6q4rorFKyqB7Li+OQSQ2f6WE
   C9TIOvrit+0OX2xjlFRB6Myw8mXwvAbVJUrIav0U96IWr/v5WjMGYjeHy
   qDsMpNsxl+NUYsVqPXL2VzlD/ojk57HRmCu+x5OCiviUHFftGjxp8N8X6
   +eqfUpuQOaUfzkAwcpc4zog7aYUl7vfUKJ/EzUojvn4w/0lXUWXo77tF5
   VNsXQfBtXIbjWNrrALYMLvwFX6XtUefansw1fK703G+for+HOftqIaUnq
   A==;
X-IronPort-AV: E=Sophos;i="5.87,237,1631548800"; 
   d="scan'208";a="190489630"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2021 07:44:09 +0800
IronPort-SDR: 9z9M6Hh5Gpvj6oSMzzJY3UIdlFacK3rckb1qMZ77+lhN+1ouOHTfrUCKJVv615x18mk5DZCXTg
 s0aVN9YBJYoA4R1B/DeQbH6qmk4sRwjHYn93ygMGT8VR1FLidpm2wscqfZAT4XyGA+eZ9Q8S0q
 jinOZCZLgJWa1dssRCKhWej+ghoqe7QRGr4Z2lD3k8bVcZJh50q8CxXOlD0hAvPMI5xNa0N32h
 3abMiL1ZSqL3qy9ehPjpnT9p6uqjdGC/H1gw9QVDLjNb5UGhB+Th/Ga2y6fSK7BWwvItILbuEe
 aaWWk/K1EDQ9tc0zxe3qEOFA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 15:19:13 -0800
IronPort-SDR: wOFRww4PQM1P4D1Y8+vAoxhF4Td0wSGkT+ZvmGet6pS0CZwWOO+QC9AxLOf9zHRqe+4Qha2eew
 YulmreOqdrkHKKxvHE3Q2Ey6k6wqmJuYbd0oxAmwGe7Or/E6rZbI4mMUKnlENA9d6BTnDToHXU
 1HHR/oBUHsi30wok+Y7dnIvzueIdbvPGx9YxI48GLKUnWNTNlMHumlyBlYCNc0yKY7qIY4DN4a
 iwnhINiSh36NbQeWL1OOXpovTESZn7FvBKRWahJIpTgB1/ZOHKBNFSCqT0abfBJz0ug/vD5bEp
 WW0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 15:44:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HtQkx2P09z1RtVp
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:44:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637019848; x=1639611849; bh=ksWPLnze/XmDxYhUzJh44fx8XX05D1wp1nW
        U6YtLIw8=; b=csF6dHOfeJDvu8GOMojn8iFckdVD6nvUOC4Vsqoa6NR6KXufn0S
        1Kc1eKwrZCzmMXEAP0n73QmU1qQmzdAHBqhGcBk/+hiy0UvHrrK5UJKSRqUy46YT
        GDjXZmb4xfLq3UhMbE0OD2MoVa/LQl/oVHHeRRkA7kycu7WHg9VU+As0gd5igUNA
        9Gg0lJilXbXsglP5AebnnbqS8ZdWzm9mQHZ/1kbBZVIC9PkREvn8rKfa5OXEnWnL
        1tyjvMSDivFjnz3arcwhhxDtIoOR3nzyob6T/yNf22ANbftGTHxnMODsR4XRlzgp
        Nfu8Y3LAbdViAEGCh6BlR6KcwrRYwNXBs4w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HG5sieU5VSB7 for <linux-kernel@vger.kernel.org>;
        Mon, 15 Nov 2021 15:44:08 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HtQkw2YYpz1RtVl;
        Mon, 15 Nov 2021 15:44:08 -0800 (PST)
Message-ID: <8e55f354-0522-de56-2c1e-56557888602f@opensource.wdc.com>
Date:   Tue, 16 Nov 2021 08:44:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
Content-Language: en-US
To:     "Nikolas L." <knv418@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YZABtvQab/M2CCQd@msi.localdomain>
 <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
 <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com>
 <CAMJR_v7Y+o7sFh+ViM-hmZ-AqfEujcTSOYNf8ospvPHuk++wcQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CAMJR_v7Y+o7sFh+ViM-hmZ-AqfEujcTSOYNf8ospvPHuk++wcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/15 22:27, Nikolas L. wrote:
> There is no error message with vanilla 5.15.2 + this patch.
> Warning message about missing support for
> ATA Identify Device Log instead. Seems well.
> Relevant dmesg part:
> ata1: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806100 irq 19
> ata2: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806180 irq 19
> ata3: DUMMY
> ata4: DUMMY
> ata5: DUMMY
> ata6: SATA max UDMA/133 abar m2048@0xd8806000 port 0xd8806380 irq 19
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2: SATA link down (SStatus 0 SControl 300)
> ata6.00: ATA-9: WDC WD5000LPLX-75ZNTT0, 03.01A03, max UDMA/133
> ata6.00: ATA Identify Device Log not supported

Latest kernel will not even print this warning since not having support for the
IDENTIFY DEVICE log page with ATA-9 drives is expected. The patch fixing this
will go to stable too.

> ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> ata1.00: ATAPI: TSSTcorp CDDVDW TS-L633F, TM02, max UDMA/100
> ata6.00: ATA Identify Device Log not supported
> ata6.00: configured for UDMA/133
> ata1.00: configured for UDMA/100
> scsi 0:0:0:0: CD-ROM            TSSTcorp CDDVDW TS-L633F  TM02 PQ: 0 ANSI: 5
> scsi 5:0:0:0: Direct-Access     ATA      WDC WD5000LPLX-7 1A03 PQ: 0 ANSI: 5
> 


-- 
Damien Le Moal
Western Digital Research
