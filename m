Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165623A5761
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFMJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 05:47:53 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:25952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230255AbhFMJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 05:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmZ0qGKtLWgqlOKy1Bm679xYLfqVZiQZnF/39IMPcUqiLdoMep0o11VB1hp7UdO0ir8J7CRBzPxwAKpiUxsJwfiJj2auGYqC1SIR1c3hzV5UQsimePGaMRgd4d723grjQhRNSseWidSH0RQMBxf+c3wqTBX84V4SlNxQEsSovTwyo3oahcrNg4QHhEtP6N+Yvfkmkul7lC8yii2M5CoBRVw68YK8ThK3/nlISIm3mCseBIAWINnx1wxYKlZtCeeDkj0hlvJzkbCZ71TupizwuVtBmGMHSyvFQ2y82fCBPgaYosrDJuuAW+NrvQNJTtZ7ZUJPSUjlKmZjzp1O/kicdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAU447X1SNHkI6fbDDdsCQCqM3RaAmrmay8SJq3q/Ak=;
 b=U0P9SRSivJLSaNHBqXyGiWXIwHYX4W5V8KJg+tVHmNlEB+GTX6RpaUeTA48T8Z9G39T2z+3nQ0XRXZ0ljXJJPAEHEo6ajFsiAVOSHKn3fPiw0COZQolWMscBrh7IbZBPj4hZmOI7dUwUdlTTOPPDDoAX+P+K0ANrpWpewajZCPAXx1VOd2emtxL9uq4NJXs1+gvIsQBbtPKHlfbpyBS/O7MNF88KGHRiBo+aG1m6Rv6BxgjKTWl+blzOgmI8D8qITAONRKsgP9JqZV9cubj+OICXFPkj3651BXl0MAIKqZfI6hiLyjVOgVViWbQh/bkqtyE556VM/hgx5xSRZ15ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAU447X1SNHkI6fbDDdsCQCqM3RaAmrmay8SJq3q/Ak=;
 b=ZJcag2NFHMf3pDwvwSSd8eKCqFdl7RICGOnYWR+alEt43X0P2NkkHOZyTU/NXebydT0Df1sRTtGflObMXha1yMEEVsEoFKwDM6XfYj+efXuZZ6Nah8RAuPRkmqY4Mk6UB8bn8Nm/luJdvoXRhey5Nqi4OKKxKWpGFOicgRrJNek=
Received: from CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Sun, 13 Jun
 2021 09:45:48 +0000
Received: from CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::c52b:384e:5578:a555]) by CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::c52b:384e:5578:a555%3]) with mapi id 15.20.4219.025; Sun, 13 Jun 2021
 09:45:47 +0000
From:   Tung Pham <Tung.Pham@silabs.com>
To:     Johan Hovold <johan@kernel.org>, tu pham <thanhtung1909@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: RE: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AQHXOnxcEcI0Q4z4TECYFQLt8UPv6qsNg4OAgAR3pFA=
Date:   Sun, 13 Jun 2021 09:45:47 +0000
Message-ID: <CO1PR11MB48824009354B8A336441B86A81329@CO1PR11MB4882.namprd11.prod.outlook.com>
References: <20210426091244.19994-1-tupham@silabs.com>
 <YMITDyLtcPinbHMv@hovoldconsulting.com>
In-Reply-To: <YMITDyLtcPinbHMv@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [118.70.81.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbfef9be-9562-4ebc-f2ae-08d92e5005df
x-ms-traffictypediagnostic: MW3PR11MB4745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47454F0E9FB4AE0E68BE13A681329@MW3PR11MB4745.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yZ6pV6/+djzVYs1iv1REtN/IP1xJ7XhizPs6BeDtJdI6hzcz3GtFSBMS7hmE5V1/5MqW7wjB4JktbEwJ596zNd6dvvP+TeXSCLbULUOdQjSw2OCNR1ms2q3jXtF6tyStBYe7Y4GpIv7fjuyXa2Frm32yIf6Px7Zzk0Uda4lH6S2QM+Oxo0vfBX8IKsdwzACyds3chvSytNFbVJHDKcDNa+kqeaFDmC/x3cTQMfUh4WoKMaHQ+gnRMYZyo0TLsMBwSSdQD6W9VJt8UCl28LHbXAAipSC2KjGP4Gs/2RmJX75XngnVC4sKg69ckI5aZhaAP6T5rCgTGI4r3YlczVtwQ60MtsfIMTaXDD32lTFMiJpf5yB+6CxgoNzmgrLN1tGyi/eQGBegWEsYb83UHbxDaaTrE7RjpVnP4xBIONHsWwV5uShEBFY9xLU7lnfOVxTZNeOy8pBTa40yRDgFmUd/anCh+DYu5wluVcCVmJ5dbBW1ylW30medMIeLof0kYIStltsJF5zICmhNAOSJAYHHQgEAfV6ByYo9syamoy2jpngCEmHhBvQ6oIL8+i67oM4UFYPaO53Pt04832WbbTSCjwXwO3V5cTFptxscgpOkVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4882.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(136003)(396003)(346002)(366004)(110136005)(7696005)(33656002)(2906002)(26005)(107886003)(71200400001)(9686003)(558084003)(54906003)(478600001)(186003)(316002)(52536014)(83380400001)(86362001)(4326008)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(6506007)(8676002)(55016002)(76116006)(8936002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iOr+f5QSFB6fcQT5cdUCT4yqGPLXyNrAaoIaK8LAwhRLvxisbD/P8t5Fcqhc?=
 =?us-ascii?Q?CbD3Jc4nuGIuMzZen5cArN7OKCnhkuevilxNownFRFD/whO+Gkdr5mUGRXsY?=
 =?us-ascii?Q?4DudxQNQeS5IU20eT6ulCA/YAnQ7VJP3dVBT7IIXjXro63AftCGOl0BMlxcW?=
 =?us-ascii?Q?8XtqRAZRgK51qzLkKc1pTpL9Aj9/i4xCXUiuaKq7basaCgbBodheWOZV5b6A?=
 =?us-ascii?Q?Xg2RDrfnPjg40zPiEPU009o5xG3hAqUsjzEpba5E4fxtG5kRJjj1Mi0JloGj?=
 =?us-ascii?Q?wETgOq7PF+P19YNGUV+PL+mu8zg7TFFvlIe3FCEEYDosT0qjoxH3Ut7tTTKe?=
 =?us-ascii?Q?6OD+iUmbjtFVIAEmU1sv7bK+Jokb4txSApPktYbAc8jDLcVqFZojTtrA6jGw?=
 =?us-ascii?Q?iENMbpojQn0S0obQZ53CszZpxmkPkRBc0pG9hZcG76wpLzRLQJT19qS/LEQ1?=
 =?us-ascii?Q?IJ6VM9VCMIppcvxl4/kbLKgRKEhfOp7HvfkLKYWbkpQtTGHTNXCNhEWZgw4C?=
 =?us-ascii?Q?wC0wXsMa0x35j8tQyz3Buohpdhchm86/NcoANGtwSyZy3xxW5/ibhDtliW8d?=
 =?us-ascii?Q?fNQ1gTxsNbuzObPHPAqBSPRccWGQQpAN7hTXiB33YXhPTYpmgVQz2m4RHTGP?=
 =?us-ascii?Q?uJ/xgNgkEOs0lUpDA/PwmZdoz+2Ws93F044S9umBSVoCGb8Cbj3qnDgNSUst?=
 =?us-ascii?Q?CAgrKjudrmoThFv9NhPWyc2s5/dYThwj6PFD+IoOm5vtGTFSLDn1KbkDivg0?=
 =?us-ascii?Q?/PMj3jp1U6DInffU0EqEm8z3IggiKmBCT60ssozmuq0UJVZ93yQr/5b8AdBk?=
 =?us-ascii?Q?W4z5BOQ9XLYsuWOoXaI+6lb1Ea4LOx4hLwRAvYgLZtmwkgQlVyOryEV9fewZ?=
 =?us-ascii?Q?4dwF+vxQ4PpeD93KstPNCuRP3myig7K0BlomScbFbSkF6pv4JKcwxkhhuOSC?=
 =?us-ascii?Q?UvFlTPKSxSjN9yKw8L34wmggJk6T+bqGHQhjyjVxkDh1eWu9eEO5/KZ/EMon?=
 =?us-ascii?Q?V8qXH3ItFS4CWkBsTK5zQh7gdnrXbQmvf8Wsp1Q9zzE7zEVjKnwllxR7obat?=
 =?us-ascii?Q?qFjZdVqELC+LvfnuTdwpt9SiYj9QlW/0VMe6FkhJ8kfCUaiqcuTrIhiPMqJ6?=
 =?us-ascii?Q?TKL+D8iDJFT1Yg8LnrT0UQKshjaRCuVXeUFvW+NsgaIh02p1bB1h78OQXsTC?=
 =?us-ascii?Q?XdqG5wQmf0/gRJTjTMpMhCzudovRpsHSriiPjZPzy5YIDR5DkFrf+oUb+Qx1?=
 =?us-ascii?Q?wvPI12/2eHDlK2OoUBjjBJkvw6OJMoTrHWs5m4BGkaniFJO+35RlpkArrGos?=
 =?us-ascii?Q?RDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4882.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfef9be-9562-4ebc-f2ae-08d92e5005df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2021 09:45:47.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7I0Mz6IoDFkFCIBkDyYzFmThKUWQOVU2bCizD3YdXOEwWHrIS0Cc64HNJrj67nYhj9HTHjF5zC6qFh4NveYaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johan.
I 'm sorry about my less of experience about committing patch to Linux kern=
el, causing you take so much time to review.
I'll document your comment and last commit by you as a reference for my nex=
t commit if I have in the future.
Thanks you for your effort.

