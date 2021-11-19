Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98692456E27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhKSLYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:24:06 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:58715 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhKSLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1637320863; x=1637925663;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zfGvPXpDm44g/oRu7pmKzij6Wad4Vk4MxBLABd5rBGE=;
  b=mqe7ODSxRnkJ9DhSJoHLlVX7NnQwmcXnmy6SKlpviKRjFJxLyf1B0kDl
   PCWFCxbkIFJoFRgBBwAywGiSSj3eraqdlEMwzYR99Eepe7Y407h1HT98y
   1IBNuCwSHRONJnG2r3cNHX0A2Mde+I0s3KRT4yqaPI9Bi+mlEgHurtf1z
   Y=;
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 11:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eClSXIvypYlAT38uORz0PJ8WwMhDhZOWlCH9gakeTfD6/vrL3woIBL6/IHdbMFTUkqrQX59gENQsOfj7XOxbvMLkbpwbYaQvB0mmtSvD7UKZAnrK1BCaFqDlDDk5DlxrJh9GgZ/cvpmtlwj74dsW0FsOBiz4OwXKNVKQS/88PM/i7WbkKz/jHUrv3fXN8POY8elhupZgb/U4ijfrP9JXVm/lx0zKr73lAELUMyo6iW6jxjcqATM+zOeKWpaQPgXU6sChPoHw8V3V1yTIHtTH2fTBJKZ0N1t7F1LqVV0uaMMqPI4htpCohHE8jYIGTbqgpdKfw9Gb1txOdZjI1EgOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfGvPXpDm44g/oRu7pmKzij6Wad4Vk4MxBLABd5rBGE=;
 b=Yd9Dkjzo9zHEVL2ThyuVjitDdBtaxN019Nyw3vQ7ky4cfphroNGj8Qunp7Ax7eHICZpc8X3oiPym1OfSEBzkRFfBoHcfM0Tz7N0ACHNbkHDYYam0Eq1gD3p1BB38u4m0Z8uI+d0AfmufKGC/3EZ9Cp5misKkW/ZCnOvsdGtjBf5XSrK+L08B81JfdefSrVqw7U4/xlpEm0gHhjVJPUsWPZMCA3Zd1IaKbu3GJQm1BMiKDO0fkGOy7L0s2D+Gv+Fhg/wLtmFMfFmBcu4WxsOUme9tj27wwidC9ys9cT7cFGPBImun73LYMTLchO8efb8xwK0FK7wuJTy0JNbVKlRcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8247.namprd02.prod.outlook.com (2603:10b6:8:d::19) by
 DM6PR02MB4379.namprd02.prod.outlook.com (2603:10b6:5:2d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Fri, 19 Nov 2021 11:20:59 +0000
Received: from DM8PR02MB8247.namprd02.prod.outlook.com
 ([fe80::7049:5fd3:2061:c1f3]) by DM8PR02MB8247.namprd02.prod.outlook.com
 ([fe80::7049:5fd3:2061:c1f3%9]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 11:20:59 +0000
From:   "JianGen Jiao (Joey)" <jiangenj@qti.qualcomm.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "JianGen Jiao (QUIC)" <quic_jiangenj@quicinc.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Lochmann <info@alexander-lochmann.de>,
        "Likai Ding (QUIC)" <quic_likaid@quicinc.com>
Subject: Recall: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
Thread-Topic: [PATCH] kcov: add KCOV_PC_RANGE to limit pc range
Thread-Index: AQHX3TeHWEZhC3t63U2kVih2i1ADAg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date:   Fri, 19 Nov 2021 11:20:59 +0000
Message-ID: <DM8PR02MB824702D8ADBA2D3C3BD83C6EF89C9@DM8PR02MB8247.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f117a25-8713-4d38-b6e0-08d9ab4ea9a7
x-ms-traffictypediagnostic: DM6PR02MB4379:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB437955AECE6D7486952534D6F89C9@DM6PR02MB4379.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bT3U0qVGmXEdu7Lx7nvjr/LSE3JJgwvBgxmRUWw4LGAVHo8jZDU5GT1HqwenkaDvJZ3jiXTxqSmEaXG9MLsrYdctnz7srDJIQ1T6ACmHlmf3zc7XdTm4sqinZHTZXjLjrnc+WaxFvUyUWrMlZ9whZNvTh4wOlb0cfL9ZeY6oK8gTjpXZn2Cr+ofDqrJ47TpLqZlN++qMzNxxobdYv1NS3I3VNuC0wYkisKVOu/0g9l5N43D7Xzbbk44zJilW3jOLXd0gKY9Vd6tBk5wQADpx2TYpFdAjXJRRYGlWDtRftDpElVn+RLAF01Z0G/PEYHd0XYq5xZ8vqx0UuWKIElL3hqEGCjFAdOmoukRQf8rIc5Wq6B6PHpZIhcm3Fqev20fEcun4U5ShdT/MVhe/tYAv29abCpJaTwpsfixaWgFE+3fLr9H/SUXlAwVR+QdAVeZ3Ejya77iGUGi5iKfShPovcfwWt0Q+IC53O/xp/xfDrGHOsSqkAbgHPoUvHgsysN0884VzaOa8GS/KUodigq9Ll4jI6F4ldmNiD1m9TUERMt8oT0oblJwT09pJjb6qWID4Sh8TMJYVrOSu42jTXG9ZxHQqeIWNGdweLaNbIPlPu0/3H9e4wNBuYG3DfF2GkpFxoJ9CpVZDH5xFiTkzK+tE6J+SmH1okVGE5wbjAdAlwtyTdsmR2NuXuppj9BY2IP9HbUnTl1c2zMYWYC53qdkZpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(186003)(7696005)(107886003)(83380400001)(5660300002)(54906003)(4326008)(110136005)(122000001)(8676002)(8936002)(38070700005)(9686003)(86362001)(55016002)(71200400001)(6506007)(76116006)(64756008)(33656002)(316002)(66556008)(508600001)(66946007)(66476007)(26005)(66446008)(558084003)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OWh9yDybstAErY1ryxYxbvQCsmLa/+TQcLbStNO/uvGFHsB3eqnQwupCyn3G?=
 =?us-ascii?Q?bizqsaTK8j4TCKskAwoE/u7tBoQ6dooqrvOr8t3uU5FNvjuyrE55JHrqCbsT?=
 =?us-ascii?Q?d45fJgxAaFgFerF2kX7sAkuM7aeLAN2wZtjaBfF529hSyrFscBBTJCuDyW7+?=
 =?us-ascii?Q?V9U9gXztkbp7+CfsQmUMNadK/lJ+6Xag6JJr5Ws5pCxCtyGqMGy97XFcHLA9?=
 =?us-ascii?Q?7t2XMBlO9IobmDEQlRtQXwX7uJxLRluuSvG+7/eSYWwvPvYA2smNm1cwfxeD?=
 =?us-ascii?Q?o5e+YxCDwOFccoteYoZ4FxBh58tK3cd9tg03CYW/gy6QVA4bpii0c00kPFmJ?=
 =?us-ascii?Q?jRjUpls0jq3XsvcrwqHE0nU0fpbZMC6wulMFv9VrXNMOa/mmfQuf31UytTSn?=
 =?us-ascii?Q?LUkCYXq+gc7lPi+w3DyAbOgpEoag7Gq+tvUhM2r+AkvWESAqyeccJP7FBqNr?=
 =?us-ascii?Q?XJF6/FJttFSK03qQaqi25neupVGBk13e83JZTIe+sisEWIyThgEi7RtXEydl?=
 =?us-ascii?Q?MbyqWvoRWg1aIm6YXbxnvBEGQK7qO5edKNOQGil7dLDUPeuphYHim1Az9CU0?=
 =?us-ascii?Q?h7RjR9E8PrmCgkBN2XpcSILYdfavJXwJrpP/zxWtflTrNdGbKqmnATTPryxt?=
 =?us-ascii?Q?9FhFKHJcV4eGZQk3au8laEHwF2pT+zA/sNgKMsRuUwG2EH8MdWSNb+Kxi7Zx?=
 =?us-ascii?Q?uJ1wA1YOxqsKJGkC4y2mAOaFshmWMwASts+FIS1I+/wjAJg7Bk5FSrbQTkWX?=
 =?us-ascii?Q?FWqd63PFWuQug+ZrUa1fBCKk1jaBXE3ntzjOKpW9OhLlR5B/cn6VbRbYMRdg?=
 =?us-ascii?Q?4eaWvN9bGusKrkX2CTEE7jt3GgROOlQvXoQbTTG6vMnF3x/nXqRDJgqoaU0+?=
 =?us-ascii?Q?nDxnw1K0yH7lsQDEgxwVS7oQpq71cMwvKuk9ZCxst4rzsizXmzwlNcjrMkxl?=
 =?us-ascii?Q?rJo0sGS9y7oeQNZVoVRIadmV6DX2R4akkyYAwASl76VosDl5riIZ6zM9dQR+?=
 =?us-ascii?Q?PoXph6MYLOBzKpjq68A9CBXNt1PhFVBLHUkbj4vXnH2FQH+9DPR280FEYcXZ?=
 =?us-ascii?Q?aVu+nD33nZb/drlWcDEQ5Dsff+avY4p/bx1O3rL8TnBm+iuRngOXAoEX0a+p?=
 =?us-ascii?Q?k82LD1BunVmxBlqSlwdR4dKAgcnhE4zU6TJuLphWykP0GICe8fGqRVME4WwD?=
 =?us-ascii?Q?6/NyRAUTwFMvTJnLgz52feyGZp8/rVQja+X8ZAW2jl61v340zuQioHWFYjHJ?=
 =?us-ascii?Q?esuMVkO1ZOTvbZ04l+8pLKJrnnKc/LBk2+Z4jpON9rkhUGf+6I7H+e93nXCU?=
 =?us-ascii?Q?gA/ykCKOqmH/aEMKrcFe6gW3EMIAxKwfJgATh5BQbWclafTqJ1NiahLHQVQf?=
 =?us-ascii?Q?NUCEfxGNT844v5tmtLXETL5EjJXelH9YxPrU2eMKATcD263NQPf4VQjB54fA?=
 =?us-ascii?Q?Sl2qxwd3mX6NedRP05VJsJLFsryoPOZNG24yjSEbaGonj9C6O54bsKWq6vh5?=
 =?us-ascii?Q?NeEnZ58rb0StnEojtXqNStDBeJMF/zHlapPP2u9EJ2rj/98r4MV2AG7ds10w?=
 =?us-ascii?Q?lHxI+pcpKgbzHR5sjlp/wzn80gb5cxX6ijMDYowt3ETW7nmxDk/+9sB3lW8X?=
 =?us-ascii?Q?PA2X6sNRTrYU7FFTK7aBG113Gnp2e5FVqcUbnY2lnAuQa+xxcPPc8jVM+7qe?=
 =?us-ascii?Q?qQ8YhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f117a25-8713-4d38-b6e0-08d9ab4ea9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 11:20:59.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAerHZgDD6EPDQk3DF/EpXU0Lea9/fYy/CMkqK1Lhhs4TSti9qPqab/gr5nM7TkN/3sfTHF+w1sj/zJYJOWNEIWXkvFHhCY8zlNmad10eYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JianGen Jiao (Joey) would like to recall the message, "[PATCH] kcov: add KC=
OV_PC_RANGE to limit pc range".=
