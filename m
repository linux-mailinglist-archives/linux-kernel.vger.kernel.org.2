Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19FC3AAF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFQJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:15:24 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20208 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231390AbhFQJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:15:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15H97bKm015813;
        Thu, 17 Jun 2021 02:13:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=aLJRIvF23mKYK8BFKh5fmT5WPZZA4exKC2Y2PtbTqko=;
 b=tjSRsDYV6SyX6x5lGdJUxp3i0cBd8cXMZR3j1eK2okKPEsuV0YzqbXU59xLlB2aUVNxM
 5tzCV6fiJyci0Zq4eAr1RAORFHL/8HuJx7BlmnUUDEg16VyHnJ1rmcrjxDtCPR+jbde5
 HQhxKZqDHKis2dSMAo3sv3GLeGmulqbThLIY+RSs5+4VtctYiPkMmHkG4FRQoFnRRU+V
 UKboW6XItj00SD+cUHvqgnDdK8K59r9G2Hdw+jMtbb6vVYWwAU2lHh67UrUzKb/psW0k
 qAtt6yXrD8NVfGXddlsd1JxmxlBc9PVf6K86sKDJabZAIwiQ3PC9qX/8UtVfz/OLCrD0 VQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 397ajd6467-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 02:13:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxcQR9haPj1SLS521Kce7qDmcstjjSZNQbk4orrj3LUc0Jt0gsC3ItTU+q9Sdkgw+rXj3qvxzlwopdhJSFgbVrdE0Flm5vHsGSNr69yZ3XRTFw6Gj++pl83rQ9y6Bx2UB3FDoqUuITPUOMFHQiJF33Ja3gPmieQXWtPUHRYGcxLT92wwxMGaKon4nKwbJJZBfA+kemnC0+QY2j7Y1+cEQJDNHNg1u6ODOvwz7Bo3zmQtv7dO5lcdZIw2KJ9z3/4+12x7ADmecX8OvFX/XShiEgc69Ed9AgvDnB8GZB0Hp9xC9CCiU1PL5g3/ERa0Ax9qON9AKWG++xjsuUNAyUQyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJRIvF23mKYK8BFKh5fmT5WPZZA4exKC2Y2PtbTqko=;
 b=WaQiP2vayI3JvTYzyf6G2fisPCoegF3umnCyN8duwwv1wzxmfjV5mNCDYsJ+xi3rlrM/vKL3Bfv4p5c/figqunLqlcqeezEMjuRVjMB0Ko7HrxrF+UpIbndfkqMWFpeSv2VglJh0rsQaMzl5O4/lEPLgbM/kbb1P3K03n8zt18irHcfzZVBq1GnhO76lYF39fIuU6mN6QmT2u8/4h6Je+mwlX4mAeqJcEjzVa3AEaxYDkFYOg5RRh8qfGgI9r7/h3WVtGqmOuHbPNKx8RCXlC099AEWruVwgeynx6ZcpmDAaAi7mLbqI9G+uJy0pbIPSFndaYdf05NGjple1CbfxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLJRIvF23mKYK8BFKh5fmT5WPZZA4exKC2Y2PtbTqko=;
 b=jn8jpo1ewGpFFuSnbZaksu6ygfARYyW+6kJEqIe522rds/iM3BvcIVsih03XjaJ5q1xp7BXxFdKCB20c0yuzKztcq6vQC08qBHrxstIyP+5ILLVLRGPNrnOwKV+iSnzTJui+rj+StCMGDQr9t0a1QB/Nv06muMM75rxrSuNSr64=
Received: from CY4PR07MB2757.namprd07.prod.outlook.com (2603:10b6:903:22::20)
 by CY4PR07MB3512.namprd07.prod.outlook.com (2603:10b6:910:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 17 Jun
 2021 09:13:03 +0000
Received: from CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46]) by CY4PR07MB2757.namprd07.prod.outlook.com
 ([fe80::4096:aaf6:cdb7:ba46%9]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 09:13:02 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "slongerbeam@gmail.com" <slongerbeam@gmail.com>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v10 6/7] i3c: master: sysfs key for acquire bus
Thread-Topic: [PATCH v10 6/7] i3c: master: sysfs key for acquire bus
Thread-Index: AQHWxuDh12Y7IqfMlEOh9hbglXG+fKsL75kAgA0zb6A=
Date:   Thu, 17 Jun 2021 09:13:02 +0000
Message-ID: <CY4PR07MB27573869D366E84DBD1BF854C10E9@CY4PR07MB2757.namprd07.prod.outlook.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
 <1606717202-4206-1-git-send-email-pthombar@cadence.com>
 <YL/+RvUEqniqcwRt@piout.net>
In-Reply-To: <YL/+RvUEqniqcwRt@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zNTVkYTk3Yy1jZjRjLTExZWItODYzMy0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMzU1ZGE5N2UtY2Y0Yy0xMWViLTg2MzMtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI1MTkiIHQ9IjEzMjY4Mzk0Nzc5NDgyNTU1MCIgaD0id1pNVTB5YWRzSnVreXM4R1kvZXZXaFNDSXlRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7310d45c-a9db-48e5-2589-08d931701c3f
x-ms-traffictypediagnostic: CY4PR07MB3512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR07MB3512A1C939B8634156E95ECAC10E9@CY4PR07MB3512.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEeUEU+/fXRlJYPaHWM+NrE+EFgj+lHvMl6ZTPKYC2Xi9G80YatV0ccHs6KENUvCsW5W6kTgeKEFuIMCSzChg8dvoWiCrzlqQG75Tl7kqVUab6P9x/v6Fn6xlqjV/mPekCkPDn9KvRrKje4CFmMgkxU/XmEpbDtDoudeC6X4IkWs+CuSdp4fapAdvpVKCbRI8RnWee9fQd7Coufr+SVLg5gxI8zW4+jJmwUl2q+QwL8mQYeOlCem77jlht+WVmf5OErJDWVhlfH6O8DrOY9bbvl3fCB9TTYZrLuEbb3hIoF2EG9Lx4/XgyQ8AUt2ztIy/T6wjvP/3xWupe1QvfhpEczbk1q2tp9kJ1gx1/UgT9RShSz9xuhZkrWP5Hd9GXjLlzC708j1ygBC9AqBABS1G3NcVNSFuoyEnpDEyGMV4SQBv1Be+esh1+3o9pORgJOkV6VEWZpZja9veFNOB5NxE+vIEBsSEt15T+f9Wpzr70o6CecYNNsztZHXDQumMkdfHkZA2ID2UVlB7ZLR9WcnDc1TVxo3dXnVT6E9tC60Ils2C79qxu3hK3vtFGnfRwIWNOOXmZgNsSLyxpVaFmt2pRSLXDaD0UgKL5FpsIfbsiebPiSqiTkcXQhDBCYfhb/pxwZ+J/chbUhnPNJISBM8mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR07MB2757.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(36092001)(33656002)(66476007)(66556008)(66446008)(66946007)(76116006)(64756008)(122000001)(316002)(4326008)(52536014)(71200400001)(4744005)(478600001)(83380400001)(38100700002)(2906002)(8676002)(5660300002)(6916009)(86362001)(6506007)(8936002)(7696005)(9686003)(55016002)(186003)(26005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eRawhxPFun4DX0r2SD9yNcVk3zfbvApyqrCaVLWZ7gGvuj6h/i++MDYa1O+Q?=
 =?us-ascii?Q?kOyUM0FAh23PV1xT15yFXgIlLPW3QLkL/NhEmftdgGFoMOSNAvSUOorjMCeN?=
 =?us-ascii?Q?+xK9V5W0wLSbMHfCfVPKCb21EMwUxn0fGcII8FlwX2KiBlUzRYYlXIxdtD+z?=
 =?us-ascii?Q?ZKkFA2SOh0SWIPqZ/FmaxHtxFmp8UO5PPHCyel2udxJ0I0Ujvar+37MTC8cZ?=
 =?us-ascii?Q?0ZH2bRF9z1o//1MkayaCukLjjS0QgeGzAhQHuM9dZ45gCf6N+/NV1nml7FBY?=
 =?us-ascii?Q?ctYvei7oG7DYxi4Esetd3Nmg7lQwyPBu8Kq2VC7hlDdvaW9RdteIA7YvqCig?=
 =?us-ascii?Q?cnUcGVjUZExFBbJdy5jYtG166Lq3WVZ6FKzNs2uoA1kf7jyXcXvQb30nk1c7?=
 =?us-ascii?Q?cqb+d3buI+qBBO08ZQxeyUGQ+O2CtdpdQocsAck20LOAwGqvZqv8Se+ayx4W?=
 =?us-ascii?Q?OSgnSFs2mwlr9xsELY2h+bwHDy4eGQd3D8i+Y5SZnUaa8TbZwokKHNcI6P2P?=
 =?us-ascii?Q?0pPO74D530BiiYpltKOToDxuRqmOrAcK+ifAyrCjw4/BvQGpBZDZAgSyAa2q?=
 =?us-ascii?Q?Py8cW7OxfvBFTFY2QSOQVNPE9/BGNe73Qj0oV0i/CIkYzJE7xsQqTRx1PJdP?=
 =?us-ascii?Q?swNOcoVim6HU+d961EStZI0vogXSVkltKrHqjDUeYHNadzHiYMQGVHk+cGXE?=
 =?us-ascii?Q?X2QoqlRk/6vcXbWJE5byZpCOVUxGz9hEiL3/5NJW78Kx4hf2doiOlVb1QHpT?=
 =?us-ascii?Q?mZXi17oSquRAyC0tCRSkZUILrR2PypjX+Du15nmT6jpUnR6UxvKsXK+dxKv0?=
 =?us-ascii?Q?7MVMmUPrKsjnTAy0m0qs+pjbokf+uVzawkj/yGfyGp87FR9XQ9GdwawMbF+n?=
 =?us-ascii?Q?NdfZjsJ3Xem5cDeFJRZoUo8YJ6SkAfFIDaAtwrRys1Zig+bRiT600Z9NKnyC?=
 =?us-ascii?Q?dRvSUvNCeSNV8eyKxUS5iyo0CaMEHhKKZaN0imzTeLlg4/1yQpHlioGhsLlm?=
 =?us-ascii?Q?pLVCBDorY5vyFsbRXctU5MJclFx3iqWzyr56TTCMhdFx7RP5AsZjsAd1rFD5?=
 =?us-ascii?Q?HxvIe0yz4qPVMVUURKPYwcBkWajiDjjGH6UnjYv4q5OEka3DI8YZFW58jFjX?=
 =?us-ascii?Q?hgee7JGHKZHf9VmTOHS3RwTT7QVNnsCI9jvWDzS1wjmYlxouFxvJGpKiLkhB?=
 =?us-ascii?Q?hCJYs8dvdJYbINsSDjFXNKgX4Pd2J0u7q8FxB6OcNcaaLp71QbEBpCXH73jQ?=
 =?us-ascii?Q?UUe4ivIBRPeuc5l8pusUWAc5u07/K0rIRQYtJMYFtoikq1sJPAEhU8HQqouS?=
 =?us-ascii?Q?yask/QBamLO65B4AlkTDG6uB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR07MB2757.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7310d45c-a9db-48e5-2589-08d931701c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 09:13:02.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zC2WGazf+d9g4p61TeaRpGshgRX6UmTpPNXcLlvlKkytKXJqKJqswKrqqXrGLa0onP0cWfu2k8Q9FGrTEHSorog9jwMoHiAf1uU6mOaWLsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3512
X-Proofpoint-GUID: UASfbYiK_SYS8cqJ38WSwsMecUlCeZxm
X-Proofpoint-ORIG-GUID: UASfbYiK_SYS8cqJ38WSwsMecUlCeZxm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_05:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 spamscore=0 mlxlogscore=763 lowpriorityscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106170064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm wondering whether we should allow userspace to actually control
>that. Shouldn't we simply request mastership when a driver needs to talk
>to a device on the bus? Is it really useful to have that until there is
>an i3c-dev userspace interface?

Yes, for now it is useful for nothing more than triggering mastership reque=
st
from user space. It can be dropped and added later if needed for i3c-dev
user space interface.
