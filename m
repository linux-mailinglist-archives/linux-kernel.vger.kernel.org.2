Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A3412A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 02:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhIUA6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 20:58:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3033 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbhIUA4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632185675; x=1663721675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r3UqcrYjGRRowHHJUDRiYhEBq/N8xDC7JNN8kQ0QfVw=;
  b=WjeNepy/z1E8amz2gVAHpXP6SSMhQkfcxVSQq1y1QL+jrrP8htUgXtfB
   EfYlz5ms6SdXg344VhB4foFkuJumJyzeuIm5CUCV7qYSofHe/uioKVArA
   J5dgDhdOxSRnGRyuXLxZqMIEN8OP1GwPnmK6R0gU0uXpgLep/0qlb5WzE
   uFWzZwFOyVshG7JU6SN3uoYxLE2OJ5i/MKiSaOv7vmS23TiTL1p1mcPnJ
   b6HN7PUpuFKFWGGhYBM5wfdJ0QEbG1bi0H6E3f4T4Jwpb0iScEodZ5GRE
   iI1gPaiufAofG3vGK10vt2MG17xiYCQMKiry8zErxR3QemVQx8Yz6FnPo
   g==;
X-IronPort-AV: E=Sophos;i="5.85,309,1624291200"; 
   d="scan'208";a="185282138"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2021 08:52:35 +0800
IronPort-SDR: oGkvbd5wl2TaBzltNgaD1j3S9glnabfBvAlsjLXIUxlmiirwXgiPGCEoX+S/qbAx9w40XP2jno
 Tb1/WQIv1TCs5inapmJR+CbmlBxQM5aeUeogWT8gPeWCk9i8F8oIfGWgG0gzzxtW6ALto0J4Il
 Rgi8QF+iVSjrcc9rSbhh3janNA+zIvph44sjQdK2Ay4MPjiFWtnAd2URrVO9qPfq8V+UHfkK8y
 33B45kBCmVQ/N4PeogANxLXuna7uYariH8rhH7RU9Bw5//ESmdog7Q76xusMY2S7VkAPhM23ey
 GrtgvjPyiYo1ZqxmHgUesqy9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:28:50 -0700
IronPort-SDR: QzdyakQEjZGgYwmZWqyrG5FJyj7ggJKzcIWfUWT4hXZySUFu4hFRMXurpUbrA+Q7kjGkVfI5NW
 cDN4+6HSfw0VSpyCWdvL3jQab25Po2xeJA5oVwK5nFwtZSkUujEFFPsUylQbzAVRRs18vMPoa+
 Qw1CxtTo+dZZU15z6HHekWGbr2//wHyqOGdRXv5AKx3IRhhic7DbX6/QloDx3H0ToO+4UsjYeO
 jpsZLBua/tEhXNLh/1zJVG2nQWVAF7qw0yl4Ib/btpItbWQ3nKc81BSFgOaU2N/zwrIWFZH2C/
 6+4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:52:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HD2vl2xQ8z1RwsB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:52:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632185555; x=1634777556; bh=r3UqcrYjGRRowHHJUDRiYhEBq/N8xDC7JNN
        8kQ0QfVw=; b=XBJQL0kFfc5Igr6t+smcZ3DMIskibTSMBjYtMs/qXLVoICPJUo2
        pVYFZunaHv29DkQHGM3wxGZ2FP3e5un2p5Eea3OIN+Rt+h2afLkwl38f2LMYUpwN
        EucYxjhHn86xh+KjBlNoVLVdcI5gDyHv+7FtHD2Z7s1XDs2NOL6BIZxl0y3wgWTg
        ysx5g2TQAwfwSF7lHP4+f7NIEq7P/tU3L878q4QLiorizmwMan+J6KZkDz1spPXB
        lvIrY0II1gvA2CnuJR7ZRli1PuD5dh5D/1RPpL2mLFz6SJ/gC5bT3EcubFyXjdoP
        +Uclj5TGToMwwUcAFiFc2dCWG3GEKOFcAaA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 25pgCo_nvXHV for <linux-kernel@vger.kernel.org>;
        Mon, 20 Sep 2021 17:52:35 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HD2vj4t0Bz1Rwry;
        Mon, 20 Sep 2021 17:52:33 -0700 (PDT)
Message-ID: <aba1ddad-0450-f4f8-796f-abcfed25403b@opensource.wdc.com>
Date:   Tue, 21 Sep 2021 09:52:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] ahci: remove duplicated PCI device IDs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandra Yates <alexandra.yates@linux.intel.com>
References: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/21 18:43, Krzysztof Kozlowski wrote:
> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
> has board_ahci_nosntf (for ICH8).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied to for-5.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
