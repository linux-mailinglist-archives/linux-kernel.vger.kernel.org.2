Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A914166E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbhIWUuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:50:10 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229]:53469 "EHLO
        4.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhIWUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:50:09 -0400
X-Greylist: delayed 2231 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 16:50:08 EDT
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.132])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 5640620152;
        Thu, 23 Sep 2021 20:11:24 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 23 Sep
 2021 22:11:23 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-104R0057bf54811-d272-449e-8315-28873063832b,
                    F074DE1CA8FA81A286F8DD829A03E539B0491988) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f183c017-7a60-bce5-a440-7010ea3d90b8@kaod.org>
Date:   Thu, 23 Sep 2021 22:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/3 v2] clocksource/drivers/fttmr010: Be stricter on IRQs
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210922195656.1822268-1-linus.walleij@linaro.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20210922195656.1822268-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 24508be9-d98c-45a4-beaa-652b64acba55
X-Ovh-Tracer-Id: 16099242770043538214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledgudeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeigedvffekgeeftedutddttdevudeihfegudffkeeitdekkeetkefhffelveelleenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvght
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 9/22/21 21:56, Linus Walleij wrote:
> Make sure we check that the right interrupt occurred before
> calling the event handler for timer 1. Report spurious IRQs
> as IRQ_NONE.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I think we should start by dropping all the AST2600 code which
is unused.

Thanks,

C.
