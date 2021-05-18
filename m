Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A98387032
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 05:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbhERDT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 23:19:29 -0400
Received: from mail-sn1anam02on2064.outbound.protection.outlook.com ([40.107.96.64]:56320
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237929AbhERDTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 23:19:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQANGEfRS+AN/wIjnMgFWBrT0dmD3zZoELeGlidWERtsYo41Cy169nj83Hw5qqmAxwhq996zsGNApmsX1Z+BnEMv4vbtBvevxPl+wX/cFQ6pziOGA8owLB9msJw6vu5Nu3j13H1Hcy6gCRrb8NK45dwNg2tq4qWmdJ7V2+4IXnBPhX5DpRQ4Da07QkYDJDTk4eg4HW84iU4X03aErAp+LLTvyqvTHieDkV8z1MdQkbnLmUDjEizHmnXdSVGX8qTDbBvSFr81YfEbAxYkDKePg/KIr4mrfKujpKY0vtFgR/rJnUA1C8TSx6VpR2y3D90ydTLzPMxVR3HrEUcmkIaEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FERwiirENwNMJz5rfwnz5rPZanXfMJfbLp39pEOzqmI=;
 b=VKlGaWlWN+2kVxVFvgsW5Xbs9wALeGEB1mTPMXKOiC67o7BzHxz7bRzsIjJ4U6ELbWUHktj/k5JhkaI9xlcHvqQh9AgUCbS7MY7fJkHEdmBDqgfev4owh7r+CQPYkzWVh0Q1tNna9N8i3Y6xZ/HdMcvSq8fGFLue9TGmSt7J1+nvD3CkZoRmP5Ja+H/4/Tiha5RAvnbp7aijELtWvy/M62QtTq8hwzJl7hGtOcWj3pUXFHzly0hrgz1KBKydhiVihCu6wkFm5WrOM+NSR59Lb7umntVIQg+30ENr70PgUG7whuMzvRTz35g2GJd8jXAyz5KJRUobXp4WuhMM+UE21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FERwiirENwNMJz5rfwnz5rPZanXfMJfbLp39pEOzqmI=;
 b=Gk8IyhfPe9a28xCWolDTP+IYS74SfpT3TVz+QmZhliU8YYXAXAvYbxEBB/2GPfpdQQleoRLmqtAVHbla/5sA+qxIwnhQJEQE69RrylQhDbdMHfTq2E+f3zMREnv5bMop9zAuWpUN3tUGT86PUHK72pNM14szyG4WIoISNyJMbR4=
Received: from CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8)
 by CO1PR11MB5011.namprd11.prod.outlook.com (2603:10b6:303:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 03:18:06 +0000
Received: from CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::e1b5:13ed:1899:7ee6]) by CO1PR11MB4882.namprd11.prod.outlook.com
 ([fe80::e1b5:13ed:1899:7ee6%5]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 03:18:06 +0000
From:   Tung Pham <Tung.Pham@silabs.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: RE: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Topic: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Thread-Index: AddLlBYVYOD0xuQ3QaOKYNc+ovdaUA==
Date:   Tue, 18 May 2021 03:18:06 +0000
Message-ID: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [210.245.53.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3209cb80-d153-4f11-e04d-08d919ab8e20
x-ms-traffictypediagnostic: CO1PR11MB5011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB501174CD3122FC513E2A435A812C9@CO1PR11MB5011.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igvZ71ps/YSqz2X6sqO8qqET955nd7ORC2+30nQmokJztcynGN6xxblMVMdeMwj+M9g6qFVtMLnnZ7O42Km5l5AQz46/z3WqGpmLUGT0/sHvi2l5uZUFShW10x40vjjGSTClNqIszUdmEiuuWVYIE0DN3mVrvzo8orHlwqUc8H3oAhY2wCOBgJm6Hwa8UxsHJD4uSpotgxcwxQGU43A1vHrTixMqZCQYNheLAvcNjqe8ULMMx91m47D5Ib6M8dbOsdzVNE3SUrazQ8EFC+5r62aTQgx7TCL18m2PTf5lpPHd8GSMJCRDw39UvYb1qDFdxK7EBW5Dt+6CDAYAekzXnGi7B22q/MMBZG/ZpnN1JBeaQQ4T22DaHReLwRtCKVywz+I1MjqP1vF0RtAwsXXrfrVZKOZ1YuK1MMjSEznQsRgVPHJVQsqthCaupYuk5KJN/quPrucrvlezZNcjuBFm+HQf8uiQeEOHO0S8DCZVN3HstNjXGhap/rokPFx+6RqxpGnhlzTD1Htp6fF+UzQcnHVMlf0VhB3Q2xhFGDYMUELgT/cD8UYmE7JkuscuTmz44TUs/SsqCZoUXImKgd7/a2lRcEZV2t5DZrx+6UUOdi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4882.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39850400004)(9686003)(122000001)(4270600006)(7696005)(5660300002)(186003)(55016002)(6916009)(4326008)(2906002)(478600001)(26005)(38100700002)(54906003)(66446008)(52536014)(83380400001)(33656002)(8676002)(66946007)(8936002)(316002)(86362001)(64756008)(66556008)(107886003)(558084003)(66476007)(6506007)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5FRYjIfTH6kN5p0TUK4nGeQfPpgeJ2ZTygXbMV50QD0dFWVcb2D/4lh+LxJ9?=
 =?us-ascii?Q?ueGp4jL8XSOcf4c8O/Uo7gf0uLQF0adZiMxHtvGOGU+3dl3+4jvoVFfmLihZ?=
 =?us-ascii?Q?g4YBdVO8DEJjKCm5FG86C3rMbNE5tNfQN9VTEoXoK9LBupyiK5hBR9tDUBcB?=
 =?us-ascii?Q?EdT0v3CdwF3h4aeNofLRv0VJ6NVn1E3mH4iFAg9pamU1Oz0RUkJCTAEeMkxe?=
 =?us-ascii?Q?zj41Md1eebWaN4MO133dPTYxAxOD+ppM7TsEfR9B/l0Us65ajveGB5qinxzo?=
 =?us-ascii?Q?VFY0pW2N3GLeGZexpDSklIRM39SFqsxH/8uUNOmMKJQRXtgoxJdA1QRbaW4w?=
 =?us-ascii?Q?eevLWczAxg9xKnydI9pAWG3WlzdeJx8M5ukRnJG9IGVCmorZlgWRAth3YkX8?=
 =?us-ascii?Q?DdPzGk08sYZMsBLk20SBkvUYEyWiSbS/CGJ8ZCuUzc2Rym5BAhF6fnUX7S6K?=
 =?us-ascii?Q?R7HOOxqkSuDG+oNgn1v4obRwYsj7xtT1KXxv7Cyw0iQHSIiWoFb23xPR4TG3?=
 =?us-ascii?Q?sHly+k6vssa8baly8oA9rgK+LmTpB6UQclswiu+ZlJk1Jire9Nh3RRV15+s6?=
 =?us-ascii?Q?goKhswQCOfeIflmgiqimrz6S9B1nXemzW5HCiAcBD+RNy3cf0Elj2gvolLPv?=
 =?us-ascii?Q?oyBepPLRuWTMt7fPspI6ALLkeshF+m6+adBPGN0/UeUbprmWbDgUXwaxsJJy?=
 =?us-ascii?Q?pJ9Wo+6wuDxiO3HLmaO6TBYzN2AhzXqY2wKmjelHfbs1FbOU5Mgo5ZHmKKj8?=
 =?us-ascii?Q?ckciuhW+wfZGO1I0UBXZ8AeGf621htf41lqrGzugsCHr6q2b/6WBNFhSdOQ4?=
 =?us-ascii?Q?vcol47+T8u3EcF3SRatRq1a9u712MJG/4XMqvxoymfJ0US79LqYlqOznczvP?=
 =?us-ascii?Q?n1mLw+FL1MrcoEO4C2UdJE5z/bjn8ZAmyS0N/8SxyckaPA9ar7z0BXwZ/rGZ?=
 =?us-ascii?Q?7s2akS//sWSRC6mHqiuLCDOVOD/pBmoOl/WqLoBKASCyaq4A5nxIQU/E4JFd?=
 =?us-ascii?Q?CO6Sz4q97jDA53s6dlhVMaT9wlYT7fq3p0QXRgLsVPySlyd6O7o9+yCu+8BA?=
 =?us-ascii?Q?hYtEdtZMiJpxXjYmlNRTMm5O+b26X7bm+MY4mlQBTcUJpq16k3Dx0HDuyltw?=
 =?us-ascii?Q?ttbBRHJe1Ir5KCIx9G9oaJYpA9v5Oi3pgZQtxiVAC+BLtet/JV6rpdphf1FK?=
 =?us-ascii?Q?1AfjbsSoYdFxrsXUzz1aCNwq2jrqiSAHpfgdgA9qswDgZOTvvp82eUMU1kPM?=
 =?us-ascii?Q?0M7AUzx2CAMuJveJ+lP+OLtJvvlbzFGi941JafQuL8+nag3WovBKxBlojARz?=
 =?us-ascii?Q?Kog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4882.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209cb80-d153-4f11-e04d-08d919ab8e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 03:18:06.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ2/MfWLPdtYDny2zshT6bUtfzG4Jpl2oN1X/9uZ9vX5moPAKIrtMX8pA5d9g6stlZNE1pCThY8F+EQmM5spCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Johan Hovold.
Do you agree and approve with this path?.
Thank you,
