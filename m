Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BC38CCF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhEUSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:09:59 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:46518 "EHLO
        13.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhEUSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:09:57 -0400
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 14:09:57 EDT
Received: from player726.ha.ovh.net (unknown [10.108.4.183])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4F05728B54E
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 19:53:16 +0200 (CEST)
Received: from milecki.pl (apn-37-248-218-55.dynamic.gprs.plus.pl [37.248.218.55])
        (Authenticated sender: rafal@milecki.pl)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id CB0301E50B410;
        Fri, 21 May 2021 17:53:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-98R002b7378bfe-4074-4308-8238-a0549ece8f55,
                    4CBC7BFF0D712EF435A3407F9D93963C24D256AC) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 37.248.218.55
Subject: Re: [PATCH net] net: dsa: bcm_sf2: Fix bcm_sf2_reg_rgmii_cntrl() call
 for non-RGMII port
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     zajec5@gmail.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210521174614.2535824-1-f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <e972abcb-54ef-19fa-d7a8-f7b98eeaa4bc@milecki.pl>
Date:   Fri, 21 May 2021 19:53:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210521174614.2535824-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17549401848744807959
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeekudehjeehffdufefhgffhgeejjeelteekveeuleevgeekhffhffeiheellefgveenucfkpheptddrtddrtddrtddpfeejrddvgeekrddvudekrdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.2021 19:46, Florian Fainelli wrote:
> We cannot call bcm_sf2_reg_rgmii_cntrl() for a port that is not RGMII,
> yet we do that in bcm_sf2_sw_mac_link_up() irrespective of the port's
> interface. Move that read until we have properly qualified the PHY
> interface mode. This avoids triggering a warning on 7278 platforms that
> have GMII ports.
> 
> Fixes: 55cfeb396965 ("net: dsa: bcm_sf2: add function finding RGMII register")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
