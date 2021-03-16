Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122C533E5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCQBLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:11:08 -0400
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:58468 "EHLO
        18.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCQBKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:10:44 -0400
X-Greylist: delayed 8398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 21:10:43 EDT
Received: from player760.ha.ovh.net (unknown [10.109.143.220])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 811AD248AB4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:34:18 +0100 (CET)
Received: from RCM-web8.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 1D3B91C2042E0;
        Tue, 16 Mar 2021 21:34:12 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 16 Mar 2021 22:34:11 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: broadcom: BCM4908_ENET should not default to y,
 unconditionally
In-Reply-To: <20210316140341.2399108-1-geert+renesas@glider.be>
References: <20210316140341.2399108-1-geert+renesas@glider.be>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <461f72384c6c98c4e44e60ef2f058613@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2619406135522528831
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefvddgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejffdufffgjefgvdeigedukefffeevheejueeikeehudeiudehvdeifeduteehieenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-16 15:03, Geert Uytterhoeven wrote:
> Merely enabling compile-testing should not enable additional code.
> To fix this, restrict the automatic enabling of BCM4908_ENET to
> ARCH_BCM4908.
> 
> Fixes: 4feffeadbcb2e5b1 ("net: broadcom: bcm4908enet: add BCM4908
> controller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
