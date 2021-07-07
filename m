Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFD3BEBCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGGQQq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jul 2021 12:16:46 -0400
Received: from mx-relay02-hz1.antispameurope.com ([94.100.132.202]:43251 "EHLO
        mx-relay02-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229475AbhGGQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:16:45 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 12:16:45 EDT
Received: from unknown ([185.80.187.2]) by mx-relay02-hz1.antispameurope.com;
 Wed, 07 Jul 2021 18:08:06 +0200
Received: from grp-ex01.Vivavis.int (192.168.17.53) by grp-ex01.Vivavis.int
 (192.168.17.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12; Wed, 7 Jul 2021
 18:08:00 +0200
Received: from grp-ex01.Vivavis.int ([fe80::b524:e95:f072:33b7]) by
 grp-ex01.Vivavis.int ([fe80::b524:e95:f072:33b7%9]) with mapi id
 15.02.0858.012; Wed, 7 Jul 2021 18:08:00 +0200
From:   "embedded (VIVAVIS AG)" <embedded@vivavis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: Voltage and current regulator: usage of 'regulators' parent node
 in device tree
Thread-Topic: Voltage and current regulator: usage of 'regulators' parent node
 in device tree
Thread-Index: AddzLeJh24+ag2vTQDK05eDkXARutwABkI0AAAU63vA=
Date:   Wed, 7 Jul 2021 16:08:00 +0000
Message-ID: <da45c3f0ff0a4a20b8a6d1c7933b384c@vivavis.com>
References: <a8700cd3e056423cac4e209b8f740595@vivavis.com>
 <20210707152942.GD4394@sirena.org.uk>
In-Reply-To: <20210707152942.GD4394@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.7.31]
x-g-data-mailsecurity-for-exchange-state: 0
x-g-data-mailsecurity-for-exchange-error: 0
x-g-data-mailsecurity-for-exchange-sender: 23
x-g-data-mailsecurity-for-exchange-server: 61419075-592b-4c8d-b7a0-bf1d145a8b8e
x-c2processedorg: 2f045ba3-9b34-4118-a5bd-6c10d5957477
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-cloud-security-sender: embedded@vivavis.com
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz1.antispameurope.com with 0790211C67C9
X-cloud-security-connect: unknown[185.80.187.2], TLS=1, IP=185.80.187.2
X-cloud-security-Digest: 3bcd77938e1985952505b9bc17d141e3
X-cloud-security: scantime:1.609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jul 07, 2021 at 05:30:00PM +0200, Mark Brown wrote:

> > Should I avoid the parent 'regulators' node?
> 
> You should ask the DT maintainers, I don't really mind either way TBH.
> My understanding was to avoid the parent node but can't remember why or
> if it was important.

Thank you.

Carsten
