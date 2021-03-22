Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FA34468E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCVOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:04:53 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:34127
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230224AbhCVOEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9g4h/EKWuCW3WqSKIj6mIRADUHYjGbkQnlGxiEvOousMzPvAhpG7uJGJ5WuTtJgyrGS9o+2+pDF+rH4k7Rk5UbUl6Cw4bNLBVdm+ynDcrX3KQX241jPr69M8uGtpCdgc0Y4wahrIMsQU1QPZYkZgjyAzdgnMEDgGv9TjhRSwaoddMa3bhwlLqfWnmgnjqlZiTrGc1tIbPtZH7BBhlQrA2UQ53Eb/Ib4wbjdfSxJOMFRl6XaFLR53SF7YmY7Gq488JaupL5Ibd/pjM08L0P7jMHA59oQDOYujwSApnXBpZsO2UGU4KzMBXGsAwSEdgE4b9v+30Z03qJPupBhyDzg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWMsYDPUh88Ei1PsXF4R1XjAiJIXJTcTeAUTzs5MRb0=;
 b=FcsqRF25csvWYwjJDd9JisydXzK0ICyHrAeRAZBLZkCkTAohooToWkVlcydXYxPoSYyga2yR8fTLZnHr3h08q/lMRm2dzQt38Z9fUD4Vm/eS7a/MgykSAl2UjGFnzQFtx0ICMvuu82mDpBTATpkbqew1CTLhSAz3gonqQHUeT2fCc77SciVZII3kb0lm/vPdfzXWozxWUAhD1N0ws/yY5vWo0GyEpwHSRsIYaLjMxtezSMsAwAdDDazYihT3Ys1EUwsEL64NKjrjWodN3zq6+FySBh9FIa24m6DoadjwPrh05Q9uPJMrWHjYbKbj528dILFwjo1BQevpcVuImMzPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWMsYDPUh88Ei1PsXF4R1XjAiJIXJTcTeAUTzs5MRb0=;
 b=OAXAq3JZjPK1E8IuCLxgEeluhysjrISFFeb5TjruwDrnjF1xDd0TJ86PKxZo6iZnX6HWtnMO1ut0FND9EUgktflrhvfnqmMVKi0j4Mp4ucspX+sr2HAh1nG+/DNEgijH9t4fKHSAIuvesN2ZMZJRqyUMe2EzCQX837/qdIn5iII=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 14:04:31 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 14:04:31 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drm/amd/display: Fix sizeof arguments in
 bw_calcs_init()
Thread-Topic: [PATCH][next] drm/amd/display: Fix sizeof arguments in
 bw_calcs_init()
Thread-Index: AQHXHyJm7qN3FM0MYES4Fe946lUdpaqQCaog
Date:   Mon, 22 Mar 2021 14:04:31 +0000
Message-ID: <CY4PR12MB128770E0A2502A3CA0A26650F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210322125050.GA236782@embeddedor>
In-Reply-To: <20210322125050.GA236782@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T14:04:28Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dfc5db4f-343e-4242-8f75-06b58d81060f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.164.215.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4acb583f-aff0-465b-0196-08d8ed3b6a80
x-ms-traffictypediagnostic: CY4PR1201MB0038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB00385B45C2BD8C00422B1031F1659@CY4PR1201MB0038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCq7Ozn2P2ILTocHEZYCwLVAmA6NGt/Gp6oS76Z01+P60cKpqRUv0wrTfiQGT3tbQ/lKbhYHIEmapFCq51uYWV/Up7DsOLTV096vfA8z2rkyQFbT0TrZ0TyO14LN80jjZoSOTlGixcgcm0uXWS/iGRDWPPEJ5JHL5dwub5gjgIjtUIiJ+6bt1S9ohVJHh34GI4Ug3RLX80x4U550ArXIrQrQB4F+DeYJsYwIL9tW7iljezGlPQoNZqeqEcLIhR5xgvGodq4ScqF7dTeDEjHmIv01yTFpHE1WPY+bZqI/lnmcDzxVLPkWAuTWw358T1wKY2tWfBhiTzQVa12Rjx4lowXC2NfuJJ16OZXfZ4Xc0Ug6QVXH5fBCfgu+wY/FlcOoDYBbBLRABz2B5jcCXfk5Lw6tVMqStg+v35LkEVvOY3zUnU34noXuA44W1Zu9qGlAeMAbr1TlqTw5gM60mGx7kklPz4iZy8V+3RzilTGSZh4KqaG1pP6P2FIqeR9gINfi2r7+3ibZJL25jWE31rNzsaA4KogAOEwkBlvtpo+r9gwT5hryVkEq/1WEjZASOT2Xgv6q7Lk3QyVoR+VRVhEBoCPrcGBsr99G7BBHl2IuLKINXDy5mHRfCCt/O08L5GTmQBvbiUUu9EmZwAo+I89XcAseg7yaltwe8kof+ptZrtAgavEn9W1l1FDJEX4w74IPx20SNLyyX/IurJ/GIRmASg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1287.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8676002)(8936002)(71200400001)(76116006)(52536014)(966005)(66476007)(66446008)(83380400001)(45080400002)(4326008)(478600001)(64756008)(2906002)(86362001)(66556008)(66946007)(186003)(5660300002)(38100700001)(54906003)(7696005)(6506007)(26005)(53546011)(55016002)(921005)(316002)(33656002)(9686003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?z7hpPvFqiLbEV0WoJwIeb/jluTOBatn3YPRo8kjuzGyOtjJCZ4NTX1nQHERR?=
 =?us-ascii?Q?3CWtX8YMY+LdWt93t3K2cCVLDXWms50RrfW7BD5IHHXMDH5a9kNijVD4v/6q?=
 =?us-ascii?Q?XAQlEiW+xf9Eliv8DcWY1oUf9+/4OwUcZ37AKf4sb6wPcRTt2B7YWTr/MhBY?=
 =?us-ascii?Q?IozwZIS6lMwkHWW97lNwW4gQKWxV1u5jf5LX0mhtAdkIz0+/f2us7DfSk1E4?=
 =?us-ascii?Q?7vRmqBTz8FmRjmxY6q8pej5K7nWr+T8vKv/ssCC+WPpC0PDK0IEWjOUt2fsl?=
 =?us-ascii?Q?bJ9h8Q541H/RCbhz8m+EdSoJu4IlqwVR8o1rljR0rAwyUleo7mUVKz7YOn3/?=
 =?us-ascii?Q?yEuZwSYDVyKLkXsf+3WSnGXlPETOcKl0i4d1wSTWhWyPbOEe9Xb8L8U1wluY?=
 =?us-ascii?Q?UQWAl83fqdR2VFQhnXSIAzDILLtlMikPpi20TCSZY1qpmAchMlXmaP7D5Rsb?=
 =?us-ascii?Q?Zc8Z7yHZco6U9QCLlhLxm5rJmx+3ujS8rDGZT+ofwPLgv11de4Tnmq+fhZAl?=
 =?us-ascii?Q?Nc8FvH/ZCX8Yt0MNOUlB49OuX72jbwpFuMBWg9BkUtz8iS+uXTOxWU1vCfzZ?=
 =?us-ascii?Q?QLpAqfPwsnvGN4HOzTApAhcUfmKqEcNemM9ex7N8ju24NpvMC5s90gRZ6k8G?=
 =?us-ascii?Q?pgRmlSN3sKqcYqmPyQyJDiogF9Vte5RsEqepb+bcaNfVs2S2MUhuYd+644D3?=
 =?us-ascii?Q?7fnPyRXvSOAAN8/wNz6+aeLGyXDHxXsGuOGsGHfJLZFKFtO1SMDpYovFcpdK?=
 =?us-ascii?Q?OhaSNjmYrEfEu9WQEpy98FzwYDPbEM2JgVZ2AS7GwmfyqheIyPjDnqpSK5jo?=
 =?us-ascii?Q?CLpD6erDbnzL4wYUSf7hlOAqIgD9ARs+wudeY9DkQAMNbzC9ASQ3czHcQrRc?=
 =?us-ascii?Q?cHpBIJo7GILBgER9imSQi275Iu5Wr95iXa4k1rW1H51ThqCSe6umeZjIY16w?=
 =?us-ascii?Q?yVAc6jlbBjAt0njUh/IVtQ0gC7M1yyLDtxzNM475pvlFx+GEixQHFzqM5BSD?=
 =?us-ascii?Q?F6242qx7muidcHNe3zatpBvAPEUjZbukaD7PVQOWMc8k0BESr84aApOuw+JV?=
 =?us-ascii?Q?/SHirFKyLvarF0IujMtsaGJPFppPkQwCeZ1rMqLMCZv8XfKlA9dtckwNtA6N?=
 =?us-ascii?Q?UE+jOgeDzdtMBlJtf/6RieYd69ep6Sk9OdUkl+UPpCh0L5HEidtFQyKxCsiB?=
 =?us-ascii?Q?G/K764OnW08zfXMGjxBi5PcvLZx4fGvPOVJHZh7tVVqcMgixckq9/NAcb1Jq?=
 =?us-ascii?Q?AQdwqmX/PHoPfnvK0GK9hT0IrHLL1giUjwnJrJad7UhR/9F83h5QMRAqWk1l?=
 =?us-ascii?Q?gk0dlOh8fYPEX55qq9wvBOb3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acb583f-aff0-465b-0196-08d8ed3b6a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 14:04:31.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLCNICk8CbsJnWwW5gkx482MFxLi54Io4B8ocndwHEl0R6JE3T/4Yb+kYCjVDi5JXGkfeMrJBZ58ugBnr4O80g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

Thanks for your patch, Silva. The issue has been fixed by " a5c6007e20e1 dr=
m/amd/display: fix modprobe failure on vega series".

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Gustavo =
A. R. Silva
Sent: Monday, March 22, 2021 8:51 PM
To: Lee Jones <lee.jones@linaro.org>; Wentland, Harry <Harry.Wentland@amd.c=
om>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airl=
ie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>; dri-devel@lists.freedeskto=
p.org; amd-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix sizeof arguments in bw_calcs_in=
it()

The wrong sizeof values are currently being used as arguments to kzalloc().

Fix this by using the right arguments *dceip and *vbios, correspondingly.

Addresses-Coverity-ID: 1502901 ("Wrong sizeof argument")
Fixes: fca1e079055e ("drm/amd/display/dc/calcs/dce_calcs: Remove some large=
 variables from the stack")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu=
/drm/amd/display/dc/calcs/dce_calcs.c
index 556ecfabc8d2..1244fcb0f446 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -2051,11 +2051,11 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
=20
 	enum bw_calcs_version version =3D bw_calcs_version_from_asic_id(asic_id);
=20
-	dceip =3D kzalloc(sizeof(dceip), GFP_KERNEL);
+	dceip =3D kzalloc(sizeof(*dceip), GFP_KERNEL);
 	if (!dceip)
 		return;
=20
-	vbios =3D kzalloc(sizeof(vbios), GFP_KERNEL);
+	vbios =3D kzalloc(sizeof(*vbios), GFP_KERNEL);
 	if (!vbios) {
 		kfree(dceip);
 		return;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7C4ec6ae20f70a488fd2dd08d8ed3987cd%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637520178643844637%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DYK=
VR3n%2FnX50dwuP91T1xPxW%2FvgisWDY0dvF8PxO4P4A%3D&amp;reserved=3D0
