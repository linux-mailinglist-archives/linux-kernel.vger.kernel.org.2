Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEEA358BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhDHSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:01:58 -0400
Received: from mail-eopbgr1400120.outbound.protection.outlook.com ([40.107.140.120]:43392
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232267AbhDHSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWuaVx5bsk6nmNiUzoQG/bDqvlp2zVb32l3COa5Kd8vuihhMgJOS2/Bc+4XFurfjoIF1XhOZVrlCyTGkw5nU6Pb2QjaKsnD6F7yrgBcg+3DROskyfAiI3PdjazF4T+Ada1c8/nwyFRBjetaRLjcDQ0mzyrVvkJVKc7tzIgmilfJlwkaeDoZfu0o+nE+4F1bSjLVINR6oG9slgNVpShvW2qAzoOWydc8kdwveippb8OUba5WrZlDqlxREC2AGCAyy9i+zNcOvaSlJAlzBUrjQrvWC6nFGZ/1L6cuN9yeZHG2N/hbnYVOqJ+BHTROwn9/Eurt3SV2nnASwfi2o1ZwyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3jjV1MisSjB6DFRwwjd4gqxNziXV3iIKlhA08hpyNQ=;
 b=g4+WixXRCxEFf0XwTRZ69L0nua7jsiUXbInpvYdZgcrYCt81SO01ypvJaKCNXIUKSZlnXlLLHmQALMdiq2dfwUFO7Q8/5j85j1K14RP0GkQjL0unFXpjTBBhiLDBukA5eIbJgWRPjjUNiPCcOcfvvdVMC9dVMjgXTdVOJ3r8lC43mZ2408A3VG6v3KFMWLo7bei5S6oN7RxDJ560enyVowyQL4UnsftbrkZ4TsEmfzGe1JeFFsRrAGV+Hxtua0ibCID0sRvH6sEhRdllVy4CqPJ0FPSvcCW0CzZG8eS39LQHusYZDMPdLI7wzNHsmPyhBywN4krYSaj3BnJkmmfbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3jjV1MisSjB6DFRwwjd4gqxNziXV3iIKlhA08hpyNQ=;
 b=Pksi/JhRG7jYdfqeVrnAGxNOfO5Br29roL3CvMzetAN3XuLUFZfSfHXD1nyjKxMFj9Z9kme3ReRXJ6GSx7zbWjJxr8nSAzLP77fS2v5x3JKPvQHNuk1rcc+dVYXAMbxytFznVSKyOmjEaFUr0v+4C+WXOs8+jmOi2JG4oXvqEy0=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OSAPR01MB2836.jpnprd01.prod.outlook.com (2603:1096:603:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 18:01:42 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 18:01:42 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Topic: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Thread-Index: AQHXLBphHjneZXXdB0ur+8N3VlMUXaqqJv4AgAC3vHCAAAllAIAAAJzw
Date:   Thu, 8 Apr 2021 18:01:42 +0000
Message-ID: <OSBPR01MB47730AA300DB8DBE08E74FEEBA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
 <YG6hOuOO5EL9xTwH@kroah.com>
 <OSBPR01MB4773182AF8FD263D65D52949BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
 <YG9DPEyOIXqS2Vss@kroah.com>
In-Reply-To: <YG9DPEyOIXqS2Vss@kroah.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a781445-475d-4479-e57b-08d8fab85da4
x-ms-traffictypediagnostic: OSAPR01MB2836:
x-microsoft-antispam-prvs: <OSAPR01MB2836D13EB1D523FF6534AAECBA749@OSAPR01MB2836.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ik4RbFrW8G9Ya55Pw2NI+tMa8PfVecv0AkOXT3oCPMeilZR+CcLJziOz0wl0R2aRMr1pgSJrPF30dXA7auowVtrctorew1+LMmlPqj9XiM0v94ri4/JiYKAIOdBoQhJu9HI0Oeoa2AyWEnvvuHGJc0UySKXuRJZ0qEj9q+jJXpV1ist1iGfwGTXaQlRn6yjVYkZlIA7LnVq5+2bFnw+vkYbg62bT/0OTOhi/9f6QhDOH7/T8CbgD6QXY4kFfu2gJUT1YVRM3yHUWL/TVsaA4Zrw7imVdfeKQQESRm+HTmGGEjF+RtgqrhEiKhIJN5tPZeE4xdHFqSz9swzsDZpZMb2KqIUIBfGr3yC//RCoAR65mZy6INXRyQ3quL1AtVpxnhyhn3YwgebI5ooZY6eFVNwWyJHeNhGwi9GcleqeOb3VO6suKK5UqXMwTT551O8Rfe1VZX02RfxBDR8wMUllYjQMN3iLynSkDxTSeDNgjFMAlmS4PM/V0sCWzQMeAFB6V5ludPj6MSGoZthF84kUPhsRI4Vra2ToKbhkcA+xU2K8tNgC1CBkLcPKvh+pwHowk9Y3jgopsB5q9spePuhXzdByrgQNGQ/1myndrbtt5TR88s3xlL9gj2kzH31qU4GRsX9yVFjempBb3lDDPv56YxpgWad5up6sl1JOaQgq7qPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(8676002)(4326008)(71200400001)(8936002)(26005)(6916009)(38100700001)(52536014)(7696005)(5660300002)(186003)(76116006)(66476007)(54906003)(64756008)(66446008)(83380400001)(66556008)(86362001)(478600001)(66946007)(4744005)(2906002)(6506007)(9686003)(55016002)(33656002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8di+lmK7yu+3S11FsHXK2R+gKOcF64CmZh3wSN5qhmQie6vewIg9/HFqadRV?=
 =?us-ascii?Q?QBxLRP69G31yS9pkloCjg0CtybX1sUuOROmLqysgkf5+W9Th1wMIJjWaWpi+?=
 =?us-ascii?Q?tc7xRDQHimTcNIlnbCMCNLlGX14VLRT486hZM+sFs0l4/eQDuqn1h3XFhgE6?=
 =?us-ascii?Q?mndgOgt5rfWs2zy596wQTznlZYFu/JLPu4ovZrbk9TVZMlhjfWX6zDFnBQvs?=
 =?us-ascii?Q?PAwRR2oaISCZVE6Vw3JaFhquJxvqyC8EWLVex/hUryWCSiya11n3KZ3pZi56?=
 =?us-ascii?Q?ZSucYvdssTrxfDmHaVfPQ8cDSh3ytKYtrBZ4dt7+YA8KxUsxu0PpsENdXxda?=
 =?us-ascii?Q?Aau/i9ZpmojK7n5/3609BnY4FXZrpTQekM8T2/Gqq126QRYD25xV531WRCjs?=
 =?us-ascii?Q?xOvzQDDtbO4j0aJ5rJuT9L8uQkHuDgUqvYhClrBxnCneYROinDxdSYgTn4Fg?=
 =?us-ascii?Q?3+tyB3kKOxXt56TW5XvnhjUqZNZEq/BFzt7s3Ly6G0MES6mJb6xx10t9iE3Q?=
 =?us-ascii?Q?p7lhItl7A9NL7oVelSh1CMY/82zcuPh2MjTdKeCwmjNRW5Eb4oJ4011iWHjq?=
 =?us-ascii?Q?uY9z4yH/Si6IA2qR7G2mNRKBnrdcCTOaqMkZWIpCSRFZUeFjqMnOX1zcodgH?=
 =?us-ascii?Q?h50nG9rgx9LwKXt/uQbUTbtzdS/Grzab68R3K2aOloOHI88hkiald2AdxUO7?=
 =?us-ascii?Q?uaP4eOIobvlyEshv8bpYKEiVL+aRjHNxsi+hhPBdRlPADIkIGB5lETu6I/eX?=
 =?us-ascii?Q?0r9WmmLnr4Ck5srSNrYmzgBgeb+eTc+DZn3i4rmV4k+t5ddoMIbPmu619bJ9?=
 =?us-ascii?Q?Szw374gcl+1kVdtriewU/EISqTi+sttHjM9PuIdPq+ohRBwHAgasA/T2c++R?=
 =?us-ascii?Q?ZpcIT9vvdv6/AXwW0etpXFXgKLYPVEFJryGiYUC3CZTyPCFUjNvE+2lKZaXM?=
 =?us-ascii?Q?lFJPbOwiEZZo9Nh2doN1LUhtuO10ydbmqyRW5xkHGcSsPApRUWQRbCF0nhzy?=
 =?us-ascii?Q?lVpFOez56gCicRt5W5R4CZ4AiF+8k6V5T6BU69ysiZsppE3FK4KjYecWa5Pi?=
 =?us-ascii?Q?QXFo4KnMfcAuHKlGlJ24L17qMtnMU81JRvg+BhuVJM5R9N2On7LqjdtpOP0X?=
 =?us-ascii?Q?E2f/tFWX0HlVUUXbaU337Z/ObKkYlFm/+H29zQtlGJIQx74VF1H5gbSZdpww?=
 =?us-ascii?Q?fyQFKavJ6naMV0BUJv77Li1qqeuI/UJ0ijXMEK/ZO5RcP4M+v7eEAy8XWZN7?=
 =?us-ascii?Q?iPJdY7VVm+z2xGvhPx29TmzpNP0/TL/tmxWFA3maH/sFlBSwjtVhJm3YxrGa?=
 =?us-ascii?Q?1yMS+zRn2VGNJJlRJCrlijEi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a781445-475d-4479-e57b-08d8fab85da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 18:01:42.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IVkx+Izu9TrIE1aNGV589Qw9mGV0HdysfQo02RPT24vzNxpLA8L7NU2GaFsOw91WAboGgZIgVNDKAvFGCCdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> That does not make sense, this is only one kernel module, with one .h fil=
e in
> this patch, I do not see those other files you are talking about...
>=20
> And if you have named registers that are identical, and yet you only work=
 on
> one device, that feels like a design flaw somewhere :)
>=20

Hi Greg, the register files are in the 1/2 patch for the mfd part of the ch=
ange.=20
The reason they have same named register is because they are all synchroniz=
ation=20
devices and they share some similar features
