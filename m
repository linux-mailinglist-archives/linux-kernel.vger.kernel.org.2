Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938733909BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEYTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:38:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44028 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhEYTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:38:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14PJb7lI121159;
        Tue, 25 May 2021 14:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621971427;
        bh=DolYArbp0HZumY7mM3GVvqW3O6bsRZdINLR+TTJqqwI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AZwzdG1krYGOD7pJjvCS2DgjWaneeZQnZcsH6ARcf8Wd7DHRDVLE32CLg8tnntPbz
         /XfFnm7MXEy46g6NvQ1EO/xdA/82N1YpEGKN5EHMEY78o2GeQByqc8IcZnukCBNCP4
         G8JqvqkrJD/cZxHzWdzCMrFGhKDPvz4/digf/hNQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14PJb7tG084075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 May 2021 14:37:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 25
 May 2021 14:37:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 25 May 2021 14:37:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14PJb6LB069660;
        Tue, 25 May 2021 14:37:07 -0500
Date:   Wed, 26 May 2021 01:07:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/4] mtd: spi-nor: otp: implement erase for Winbond
 and similar flashes
Message-ID: <20210525193704.d2eeum4p4gbkkwuf@ti.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210521194034.15249-5-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 09:40PM, Michael Walle wrote:
> Winbond flashes with OTP support provide a command to erase the OTP
> data. This might come in handy during development.
> 
> This was tested with a Winbond W25Q32JW on a LS1028A SoC with the
> NXP FSPI controller.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
