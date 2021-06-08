Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42A739F81E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFHNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:52:45 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:52833
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231162AbhFHNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:52:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoM/t4ieFXKsGWdv4gsaDFOTsFNPEPmWoMnVd8ZwZkbeRUVICjPrnD8YUwLP2fyNYupdebl55TiaDMnHR8zRNpc9XAeD+PscfgdCsWkyspB3d6wIIztRujfxZPJ4cWEH6sb11HTvVMkOqt8KtK9R+a+dmafItIkjEVbaOojTgw0jnzfjb+S2KshPMcu/aRZ3sv4NHmcW+2VUiTtEAjOWVW//BpUnL+Y2u4f/MPU3EWx8zGYWMoX+47OBVAS5FSY58H1+VjLMvEeZL3cqlVnfzFsJjyrRnB6/YIv9Oi2Jysp02VVq4gJGr2es0el6b4yY2dco7mI9w1IT/UTLnTe4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9iumgn2+CZstef4kO/UBwkfJKwqZJapfp4utkmSnMU=;
 b=aPfMFOdjcpwxIfNlLk87uPGQw37/oK2STHj9K7az5J0aZgKnzftX/8qSndzMmfwy5aaTs5PhbvKmURd9d3f1/ll9oQAFcgukdjiYycjzy5EeIcAfJ/wwIicu/8Hk50i74FPNAmRGfypBRKCc+5dtVGx8k37HtHEhZso9TmSI6XYQ8kcJcv0Yq2476e9bKsGii5cit6/mrwKj6/1KDOa0L+O6F3jNGmFj6IARUUD+uNyTEz85nuNk81IbNkYAHi0NCezYdIw1H+RT+0lW1+G7vXa4+cNbNBz3oDizSnZlr34TBf3HXzpBjJrusn+T6j8eHLsIT6PAsFPRiE9R8XkgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9iumgn2+CZstef4kO/UBwkfJKwqZJapfp4utkmSnMU=;
 b=sSxcetdRQTz0lBDU3uBnQhX0k6b1P84iY2o8VnbAt2FzmMoMtgRBMlHnbkxE0TBssGkYW84pxt4m27zB9xT/Bp48KlRzaMtN8AvNDX+CG6NJRWIN+PJpP5Vn3knQrgJQpSu5zi5EzQy81hNOMfTIyDweACFnpU1b3NgMaquDcQI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 13:50:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 13:50:49 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: RE: [PATCH] iommu/amd: Fix section mismatch warning for detect_ivrs()
Thread-Topic: [PATCH] iommu/amd: Fix section mismatch warning for
 detect_ivrs()
Thread-Index: AQHXXGHUWBZFth8QvEOMXUEEldlkS6sKIaZw
Date:   Tue, 8 Jun 2021 13:50:49 +0000
Message-ID: <MN2PR12MB44889B6375BBCC0BCF3EC4FBF7379@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210608122843.8413-1-joro@8bytes.org>
In-Reply-To: <20210608122843.8413-1-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-08T13:50:46Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=de20e553-f0c2-403b-8e35-033a8ec5d880;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75eea18e-d616-4bd7-ffab-08d92a846cc3
x-ms-traffictypediagnostic: MN2PR12MB4471:
x-microsoft-antispam-prvs: <MN2PR12MB44713B36B26AB3687E6B22BDF7379@MN2PR12MB4471.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gU7HLMiOgNEQJIpIay3aXnegvskhhekRaYDCz2kCwOcXe+S4Ig8wrhQKCZjvXaFxyPuX/SJtMS3g5GcFw6OEAWmAl3Gag5IVEzhDhMsK1QV//P1xxwPKPTYA9epL2FBICXsIuA9PYo4iQ+oeDkOmA8BN6uilFYQHyFZNkZ+dVkqrcKDCnBalhJD8GvfgkWEn8wK1WekISrgNn00+wWu2Y2XXKBcCQhV5Tnt+6TkEFyGn01wt4qPgvwW43ruQUDHiUg4EJNIk8giTPtmjPUXVZMuzkex5UJfrBT4Xf76lLmJQOM08Nb7OWhS6oSaGwjVfMs7DAdk/7R8fUPHUxl4mF7IxmjdNKuBMZrUzPCdqR3qZo99xsrAb0jZFEX17hdtj0gRITGmEIo/O7lFlztevNmprAfN5TQu+hE5yMXd7xz9lqgrUhvkAtvtYkjNz7wr+aB8f8kAN10R/713ShzOyU49YblYvyrsk6+C6ZrQ9OqPsSrGkKOoGboSkoeyHkP1erK1ztixbVO/H0AxJufHunq/+hS7/KmuOcTAdl0QDWK2mhRp6XqtVaDHenFsz55xNDp22e+txA9TwPpBapSMq/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(9686003)(54906003)(8676002)(8936002)(2906002)(55016002)(33656002)(86362001)(71200400001)(4326008)(83380400001)(76116006)(66556008)(64756008)(6506007)(66946007)(53546011)(66476007)(26005)(38100700002)(52536014)(478600001)(186003)(7696005)(316002)(5660300002)(110136005)(122000001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Pz34AYWm0hB8+fsy7pVydjFUEo63UetZDHbHz/ofXXR0TQe4plMeFcuDHwC?=
 =?us-ascii?Q?r1Rxo3hRuZfWWEpjOS/ZHT+MtI0Kj5JTIxrzACKtzj9w26PYN9eHFx21v3L8?=
 =?us-ascii?Q?nRm1p3DT/GJ2d+QYy5SNv+AOgzXTVM0wBQ4p0irIGM1taWtLNjLhkRueLwyP?=
 =?us-ascii?Q?IurfEe+x/a7nnMrXis3QAj54etiI7AfZZtHDkI8r+MXjDbFdMyvGdAmJ8H0h?=
 =?us-ascii?Q?kMurhDqq8dj+WXltHCCKNwtwMPH66szZj3jX31RM3B/XDFbIq+6t/PfaYu+a?=
 =?us-ascii?Q?QrYU/kj/FmnUnb/QjXAFIqnMPWm5MZjXQQFFvhO662ofCO/3lgq/wmfZ8RZ/?=
 =?us-ascii?Q?hNcJ4x5iEHtNKd2lQw7PtBRPAqgW483yEXR6bQV6PiCVNqCfpk7DnpRFqP7V?=
 =?us-ascii?Q?r1crVYmFp3L2aU/whazTPUv31QHR0qQELmwMWl9Z4JZO2G41PeIttRKUISI5?=
 =?us-ascii?Q?Qe4umt4f7G+nYc7yfgOUxxGMrLMYQxg1W5zTr7ihI0Zq5cxeAyqKWfYmzCh3?=
 =?us-ascii?Q?ROY+b1/yxDLZO0030X6/e5XhjlpFz0+8IobVLCUTya+HMIPsoWDRKGKPpZ86?=
 =?us-ascii?Q?BlEg9KB33lWlRL16gH/EHmNnK013ygJO8+Txo/yC3zim2Wm/euA7kNaPhl7i?=
 =?us-ascii?Q?88AfYhCdGYrY0WtRTM5/s4vfB0O2kHMAy14YJCKDOrzg36HRLCaUrM388o3X?=
 =?us-ascii?Q?hQiXIvbnre01vo2zsH9tO4fEPVeKDu3NZOI2hOSbUY75GEkRjjXtb0ncUV/q?=
 =?us-ascii?Q?WbodHW4Qxu5aDZr48oLRjOdpIo/nI2zjlZPGOOKSAxH4tQFu9hiV4BYC9oJu?=
 =?us-ascii?Q?joOmMkCrNBLkerbqXNRHM9bHW9oTxexN2pwf8vdNouWtuQMIkTeEvmTU9RC3?=
 =?us-ascii?Q?j2edrVHkUJY8ra76azTk7GHiRUeBDqyhZXFXc7LVqqPYJEJ7t1iRS9DbpJJQ?=
 =?us-ascii?Q?/ctHXwTUQkd3Fw+wl7WahupcmdR5/2dQ8Mmwxwz9+jihlXaArBV+FBvpIj+/?=
 =?us-ascii?Q?QfMx7bT7c4SIbxOI1nkJu+BPhhirO8QQHiqmeVJpvNgcaRCD31lPbqE14hkB?=
 =?us-ascii?Q?85CWQMcY0QHGd5cs9U55uQ8vHqd0AOa9A4o7sow2WPbvuIomJaXyHfmmleEO?=
 =?us-ascii?Q?M4wKXpLYNXCxMafqX3uvM74/IC+RMEwXjAeZjLHAQS0zKOIzxdD3311lpH8i?=
 =?us-ascii?Q?rCq6TcYtsEmly1VQOBxlr6vE6tbxM04HjrmzcB3a+m16R1wew3w0lRLI82bc?=
 =?us-ascii?Q?EHB2oV3uql1PsV38+tp9MVdm0Os/KjEVsRE+DCU6RAeW2MSlnhBgjHDus54n?=
 =?us-ascii?Q?/CbVF8i8JJzob0xdCRqAoX75?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eea18e-d616-4bd7-ffab-08d92a846cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 13:50:49.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ve2P/Cnx+itQTCPmPKP1SiSurgVPxJDUJm3ivr34+hnG1NOhEUeSxrOS6BVYVYTpuxJs36iAEBKFXzBHiieaiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Tuesday, June 8, 2021 8:29 AM
> To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Joerg
> Roedel <jroedel@suse.de>
> Subject: [PATCH] iommu/amd: Fix section mismatch warning for
> detect_ivrs()
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> A recent commit introduced this section mismatch warning:
>=20
> 	WARNING: modpost: vmlinux.o(.text.unlikely+0x22a1f): Section
> mismatch in reference from the function detect_ivrs() to the variable
> .init.data:amd_iommu_force_enable
>=20
> The reason is that detect_ivrs() is not marked __init while it should be,
> because it is only called from another __init function. Mark
> detect_ivrs() __init to get rid of the warning.
>=20
> Fixes: b1e650db2cc4 ("iommu/amd: Add amd_iommu=3Dforce_enable
> option")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c index
> 4e4fb0f4e412..46280e6e1535 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2817,7 +2817,7 @@ static int amd_iommu_enable_interrupts(void)
>  	return ret;
>  }
>=20
> -static bool detect_ivrs(void)
> +static bool __init detect_ivrs(void)
>  {
>  	struct acpi_table_header *ivrs_base;
>  	acpi_status status;
> --
> 2.31.1
