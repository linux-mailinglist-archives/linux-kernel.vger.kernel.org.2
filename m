Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA331D1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBPUn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:43:56 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:11538
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229767AbhBPUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:43:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flg0HX+spJd2heDWEb+uCPj4Eft0bP0YqPMHVUVYPktPTTLCrEhch9ZK0Dqbl5o23O+b5orI7l+Zfq95gppD7OXXoMMfmYzot4nPkdwBvaIR0QPhVuaZuJOyoaPYh3f1imC1jWWa3NJ+GJfpuYhBwK0uRixhRxj1+8OhaP+RkLj+0o2pebnK2JzqNkuFkM0RxNk1kSrisiLNNXai6RRdQ5unTcCS5MIolhb3QFkWURI3MECnddwufdQMWIrbc4DcidgiVFEHgQC64C9Q1d2Tk2JjDnDzJDYwkeNpfo6Ap54XroxlHZkvG9ACWftpszwZVvCnf9fkMhgmX+HX6leT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkEbu0dRZlAVbd261hVABQNbf2uGTgYRyqy8X3LpZfE=;
 b=jc+DqXA2nhr80BfnN4pT+XLTbuw+W1xSkatFjWF+8ggxU0cgPJfQP/My1kEQjDuUA97nr1BDy+vGb4AeG1yxOgOpbL8A4YU720eEcLt0IpxPC1LIGai86UyYrdNYXF6U+w9wLEb5gSbdXcDzCmbPmt0Xk00YOjoWP7oBlzBHxR1oaa2N4YPNHY22ObIc0UGkbOm76HcekIm5s24jTJVFU9GgzFltdaSXinOhYIF6AUlS0cs7MKK+1Z4WfPbCv19n7Pi/AuZVZIAcjRiFHRzGIthbLOvm91XQDnvtZTLd4tD6hn79GdZkW5ky/+t+bvEoWWDxpWuZOvc75A2GYsAazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkEbu0dRZlAVbd261hVABQNbf2uGTgYRyqy8X3LpZfE=;
 b=0crr2guB3ar/gL8CtrWek7d25qiX02RHesLdvFCbm2D6OVQrpV0V/VFW3JgmaeffVYwDLFt4WBYawMAO7Qb25Fp9eTMV/aJPSqE31MSbm5cq1Gpuz9Gvpy9dQN8nj0Xk8KuTtfCPb53lmLtEATOpWgnYmQ1ICf/vw3zaTDN15Gs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB5256.namprd05.prod.outlook.com (2603:10b6:a03:a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Tue, 16 Feb
 2021 20:42:54 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 20:42:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers: vmw_balloon: remove dentry pointer for debugfs
Thread-Topic: [PATCH] drivers: vmw_balloon: remove dentry pointer for debugfs
Thread-Index: AQHXBHYitwItKcMYT0OrYMzq0WUdnKpbP6yA
Date:   Tue, 16 Feb 2021 20:42:53 +0000
Message-ID: <3B46EBB3-3BB5-438C-9576-151052A368F4@vmware.com>
References: <20210216151209.3954129-1-gregkh@linuxfoundation.org>
In-Reply-To: <20210216151209.3954129-1-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22294ab8-45e0-45ed-50a0-08d8d2bb6f4b
x-ms-traffictypediagnostic: BYAPR05MB5256:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB5256FEBF4A90A63859F5C77CD0879@BYAPR05MB5256.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beXfyH6Ddy5i/Q4pVKu57Nyz55Nutw06yRjt8B5unU5ORo0TAMmqnWOuTShJu3WRchq5apC5HL0j2bfSbVYoWH7zN6T+oHWV4uWaJinMxAM9BTdHwi9Ri7M2UyRjUFs7/CdID/HQWNmlGBAKaJBcP5gTfuFluSFda1cEs6x60VJQLtkEqOTkeqepRxcHsY5PHcj2lZ4LnU2/TddKuc7fKpZObIbNKs4uDwAR9t0M5d41oH3HOP3/IxaeJtw2DjDjmwZ3iLhf2KOLB5LX+0R1P5PZCBqnhVNbZK5ZTdnm5AQlArKAkE2qNBEovdO49XdSgh0KIPKFKNQJ32ijI6BufTFcpHXOvaq6Ta7tuPotvytpCKzo86KTEnKI9voXWKNHI2gWOaGd0jbdTLOR0t5T9HWfQ6SO+qBkio7N/3o6J7NAOhwlOONoKCkIUVUSUHi+cqqoH3iotLecs75lNokhXCm/X4qQeDkpfZn9plLS08VOMqqeD7dSiGa3CFjXn5pMCbCBca8HpBYJdYEMakPFtuiojyhWN7cmLAVhBuJO6wn0uZ2lbLMfm83xV8DRtbqIH/kTdfskZrKEhzR+Pi5EeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(2616005)(316002)(8676002)(26005)(71200400001)(66446008)(4326008)(5660300002)(186003)(53546011)(86362001)(6512007)(2906002)(76116006)(8936002)(64756008)(33656002)(66946007)(36756003)(6506007)(6486002)(66556008)(66476007)(54906003)(478600001)(4744005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?t5qw8hl0EfjVjtn4cCkPu1h5ecNsXfnEf+Y41RwmRshjZCy5ghOSAvRb+R9L?=
 =?us-ascii?Q?dfYdgTYNaIkEoCIHCbQMw39cuqmX1Yvi80P1GSuhj4kUS+SkldqGzy/ED1qg?=
 =?us-ascii?Q?Tm6XVSebIybRTUuDfZEWNjwBYlubB84PvP5sRej1dTLnSly8rsQgW8Cglnik?=
 =?us-ascii?Q?i8wjlmfvLhYm14e2+g2Myqq7cwAmdWBftefQ6fRPO84eJW5kFBPvR84srClI?=
 =?us-ascii?Q?lpacB9qfOW/GgW+HDkDsD8tGxvDnZX0xZBDYb4LsH7Ge6CBbkYs6a5WfuO3J?=
 =?us-ascii?Q?Rz8cLBzvtLdeTOxPWF4EjJKkbcX/YJAPonEL163LnmDyY4kT2UGkDM5/mlxK?=
 =?us-ascii?Q?7gvrgvY34zixrZo88g0tK/52aSCr6Fv+OhV8kolqkvKarI9ddm2qgtr85bzE?=
 =?us-ascii?Q?80+QeExnreTpQ3UBZjPKmhN2h0Pktej8/fB1dtW+mtwRErWX9CDtxiYJR+uc?=
 =?us-ascii?Q?1BGQdRjCTfQYUeKzTUYlFr8UKQhA6usl6cokv4P7qH+n1gP0reX3dzDI2boP?=
 =?us-ascii?Q?1vtZ3dD59gcQRgJqLqbyxfoDXRu0y/jLhnPi79hr7TVZZYNsXYio9eVvIigK?=
 =?us-ascii?Q?fCji3EvNHQL5KRYCvzztZ9dilFyWx0wUCJUes4rkbLgUkX95PtTlnKcfxEDn?=
 =?us-ascii?Q?6fea2ddlaQ70CgtpTs+am9qoyVBcv1ul0hU1SobMY3zQh/T+hsO1fy7PdPI/?=
 =?us-ascii?Q?sbDWosPrbXwW8ZyBTHL/aQGU4iEv8kHI0zs2nV4w0jb6UVvlCDIMnTME6z4k?=
 =?us-ascii?Q?XtHAbH9oMFatLTU5KJHD5KIxH+RfAXqWqVi5EYqpbX36ZefouEHhqflE/7gz?=
 =?us-ascii?Q?nmBdN0lgJ9zAg7yFGxiM6hH2LM02CGrUZwxYtCZBgE7lw2VcUL89IPq4IDz7?=
 =?us-ascii?Q?+aQHnSEBPufQcQB4tuJKxIhnraWhxPEnXSo1ZG6iLyozjNz6Ebu6fdJoktAX?=
 =?us-ascii?Q?ByK7VxYxRmEau8h4qCw6oAsxqLSXHwTiJ5BrHKQrcK5jWBzj681idvjxUi2y?=
 =?us-ascii?Q?3ZkUertWJiLI+oGVi+e0PQz+kPmxLFrwwfN1bI4b37aWkJw5SOdDnEn9FMZ9?=
 =?us-ascii?Q?Q9ntOjtxabx0oP/cGKkjHQiyft23JqJ03GaPByRCONxxS2I05mhXXssGkDwY?=
 =?us-ascii?Q?+sVNx0GLXLByPABQtsjy5nBInuO8r9tddCDpcp+lBnkM8ajjRxQNeQtbG3vI?=
 =?us-ascii?Q?FUlxtwE3CDPfmB0cNzQZNNM2/bTkCc3tk5JGN3L/xaYnBgedQyB3nMPWOIzm?=
 =?us-ascii?Q?0dXCNNQUjy1S7gpQ+33FOM4O2YcHRh9FE3NvRldW+8+hP0B2VdoQ8XTSMKGw?=
 =?us-ascii?Q?Q0IWjR0IQEuHpaEZvB4hj+OI?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF0AC10706CEFD4EB66ED67C2BC7D0FA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22294ab8-45e0-45ed-50a0-08d8d2bb6f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 20:42:53.8758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsPAk09vn10uDZ4AuzQG4AgU1+bBpBtFcrAyCQxKo5wjKoEQUyp8G5D/0YtR95NSOgcrQ8ZsQ52728w68fK9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 16, 2021, at 7:12 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> There is no need to keep the dentry pointer around for the created
> debugfs file, as it is only needed when removing it from the system.
> When it is to be removed, ask debugfs itself for the pointer, to save on
> storage and make things a bit simpler.
>=20
> Cc: Nadav Amit <namit@vmware.com>
> Cc: "VMware, Inc." <pv-drivers@vmware.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Thanks for the cleanup.

Acked-by: Nadav Amit <namit@vmware.com>

