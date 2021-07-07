Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B33BE8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhGGNRs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jul 2021 09:17:48 -0400
Received: from mx-relay36-hz1.antispameurope.com ([94.100.133.212]:36463 "EHLO
        mx-relay36-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhGGNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:17:47 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 09:17:46 EDT
Received: from unknown ([185.80.187.2]) by mx-relay36-hz1.antispameurope.com;
 Wed, 07 Jul 2021 15:09:33 +0200
Received: from grp-ex01.Vivavis.int (192.168.17.53) by grp-ex01.Vivavis.int
 (192.168.17.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12; Wed, 7 Jul 2021
 15:09:25 +0200
Received: from grp-ex01.Vivavis.int ([fe80::b524:e95:f072:33b7]) by
 grp-ex01.Vivavis.int ([fe80::b524:e95:f072:33b7%9]) with mapi id
 15.02.0858.012; Wed, 7 Jul 2021 15:09:25 +0200
From:   "embedded (VIVAVIS AG)" <embedded@vivavis.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>
Subject: Voltage and current regulator: usage of 'regulators' parent node in
 device tree
Thread-Topic: Voltage and current regulator: usage of 'regulators' parent node
 in device tree
Thread-Index: AddzLeJh24+ag2vTQDK05eDkXARutw==
Date:   Wed, 7 Jul 2021 13:09:25 +0000
Message-ID: <a8700cd3e056423cac4e209b8f740595@vivavis.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-cloud-security-sender: embedded@vivavis.com
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay36-hz1.antispameurope.com with 9E5E28AAEBC
X-cloud-security-connect: unknown[185.80.187.2], TLS=1, IP=185.80.187.2
X-cloud-security-Digest: 966d240c89d870d849cb0391ebe0f129
X-cloud-security: scantime:2.299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see a lot of Devicetrees wrapping the regulator nodes within a parent node
like this

regulators {
    compatible = "simple-bus";
    #address-cells = <1>;
    #size-cells = <0>;
    reg_p3v3: regulator@0 {
        compatible = "regulator-fixed";
        [...]
        regulator-always-on;
    };
    [...]

Contrary to that, patches exist removing the 'regulators' node, because the 'simple-bus'
doesn't really exist in hardware. Unfortunately, the documentation is unclear about
wrapping regulator nodes like shown above.

Should I avoid the parent 'regulators' node?

Is the given naming schema in fixed-regulator.yaml best practice to follow?

    reg_xyz: regulator-xyz {
      compatible = "regulator-fixed";
      regulator-name = "xyz";

Thank you for clarification.

Carsten Stelling

