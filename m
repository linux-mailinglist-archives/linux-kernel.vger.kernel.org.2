Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2632431864
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhJRMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:03:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50796 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhJRMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634558472; x=1666094472;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jr6MSQpq3y/ZkNOUuLFMDSkZtNAhm5mKOpvVprC0aCs=;
  b=v33/PED5MJi+j7fqKl+s4MrXK+mATJysTm8uL697ox7Xi3u/dD9Q+7Ql
   /yChVqbMZy+Hb0D9GWv3yZ7pJCZLl5NosswAkMBuiCD/9EfdttTjcFlB9
   FwDUXvJdUAiW93SciVHG7ljiyXDm2EHITRO1BVAGydmPIzR14+ZQQVVFc
   gCelSUBl9HkUdrTFZOryZNOtPi3CaK6p7X2gjwpRkds3oY/MxSv3KGCgD
   at7aKghSdHvXqi7LdF5kp8uC2rrCbw85TfHfdPQeEAaTHw7OvIGS6Ct2J
   lFaYqOolSkiBZTIgwLujuiWoA9c0k6livLuEUnZ2GgCiErGDsZHuO3fKS
   Q==;
IronPort-SDR: vSbaoL9jcVsseWI75UVq/weDcBclJjEne15vFOST/OQ1RrgB1LnFYnNRM/Lx73qhoy6PFV9K60
 Om+EJR5MshyeMMOByv4RZ4STGypoRvmNzrIqD7W+/Pl7cRkVDEuhpFojGZvawysIWyx0Ahoi+b
 9CgPzCAi3jSwKJmHe/bsVLvRQ2wCpwK+rw2wvnEc+ca5wMzO6QRT+MiYR3w1avAr95nxyupGxp
 J9ucnbbef/34Bz8dqYEDlbxfdPFlvYgt9tMElEZhLWd/N9nhxn0LoEYHYaYEzu0OtqWovAuRG/
 CtJ+c2oz5Vp0EK69hmt3M7Mo
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="148538464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 05:01:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 05:01:11 -0700
Received: from [10.205.21.35] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 18 Oct 2021 05:01:09 -0700
Message-ID: <d88f46ec206eecafa7f503724bae1063b7a16211.camel@microchip.com>
Subject: Re: [PATCH v4 2/2] reset: mchp: sparx5: Extend support for lan966x
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        <p.zabel@pengutronix.de>, <UNGLinuxDriver@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Andrew Lunn <andrew@lunn.ch>, <robh+dt@kernel.org>
Date:   Mon, 18 Oct 2021 14:01:09 +0200
In-Reply-To: <20211018091522.1113510-3-horatiu.vultur@microchip.com>
References: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
         <20211018091522.1113510-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-18 at 11:15 +0200, Horatiu Vultur wrote:
> This patch extends sparx5 driver to support also the lan966x. The
> process to reset the switch is the same only it has different offsets.
> Therefore make the driver more generic and add support for lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Steen Hegelund <steen.hegelund@microchip.com>

-- 
BR
Steen

-=-=-=-=-=-=-=-=-=-=-=-=-=-=
steen.hegelund@microchip.com


