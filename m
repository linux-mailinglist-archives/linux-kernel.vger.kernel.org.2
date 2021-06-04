Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7539BBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhFDP3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:29:19 -0400
Received: from mail-dm3nam07on2058.outbound.protection.outlook.com ([40.107.95.58]:61482
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230002AbhFDP3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpvoXCd5eCK+AGfAdV7ca6dQQ0Bc/hcL/EmNuBKND/rGBTVEQ8+vN1w7jlWNF/APk97QZxhci5xy7pdbVqzr+jW7S1o8F8vm9omwEgN+O534FYUEn76DxgWEVr4lYRZ4YitFxfbpX0GqK9sQarqkkgarij+UjPsFOIOXYAlTkZ5n5wY5HkbhFj1oLH6Vxhai1O6dZtXRqmH/OvvFmSIIDXtr1IhypGXvczgTpyZ8wRbjXJA929ptZefhueIya6eISJzHyeJgVOiy2t1NAQKhEJLkO356CFRXgNBFKX/u85cCnI9/ilDVosXU+5DvQ/japxDD+R453bMuKwFvHXZpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVoNoLqLTwYfPsf/BZWamuMfq4bCj3F0c2vU01zmmog=;
 b=jjr++LguVbeOHtp1BpsiF/zgPIrxmujUE1H2zqdwa3F3YNvBU7xV4yxyz+r0sjRjxWmcf3K3QFgw77hTNlNGANvHEvL3L64gCbmQNBQYFxo4qYozdX0fG7kka9GOZJsngY2UzeeTuS0qxqxZaGavEGL59hXShrfYGH+uZ4TRJLpo9wRUYo2ecuDRnimc2IxYOAqBc9X1GOF2QD3WQzQyPnuN+qVTQpZAOMDglstyxnbzkbcpYYZ3RiMRsV0xTbOV4Y+ed39h6gzkrdWJcegGBP888JEV4psL9sMVbf7LNpYk64Uhx8duOguJ8Kn0ocElhbBsEJvGfC2zKPXoNDyTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVoNoLqLTwYfPsf/BZWamuMfq4bCj3F0c2vU01zmmog=;
 b=qIcm3d9kwE7DFmX0nqnIeW02+rE9BreDDc/uvGSLUqigzNBsm1fS3W/IWf+Zf12NGiRGmEzyiu80ojw35dnlBh1UQXx6/jFjJPYAcF1qOPVeXSUUK5ObdyS2T0Pn7DBwzrcwlRKDUUelpc+aN55+KRA/E4Q0ZN/bBvGfNXgzVCLUI/xckm4yAN35LyxpNZrcm1Ji/g2sjS6WuGoQE92lIeWe+AQjuDocID3kfpdtecmeNxoF22HPQk+B1CwqGKbBZ0u7daeyTRkd3YLSFhTKeoN/59VI0aHW1Zy79M25C69lxbTmqGtot0eOXcZj0sD4ILx+UXc3k9BFXFh54NaCpQ==
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 15:27:31 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 15:27:31 +0000
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>, Bibek Basu <bbasu@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Rajkumar Kasirajan <rkasirajan@nvidia.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ina3221: use CVRF only for single-shot conversion
Thread-Topic: [PATCH] ina3221: use CVRF only for single-shot conversion
Thread-Index: AQHXWQ6aU62KuN2mR0WLfylQOUXDSasDspMAgABHc3A=
Date:   Fri, 4 Jun 2021 15:27:30 +0000
Message-ID: <BN9PR12MB5129C8D9DE7A35BBC3B6C4E3B13B9@BN9PR12MB5129.namprd12.prod.outlook.com>
References: <1622789683-30931-1-git-send-email-nmalwade@nvidia.com>
 <20210604111120.GA1446736@roeck-us.net>
In-Reply-To: <20210604111120.GA1446736@roeck-us.net>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68d5858e-ba3f-4939-3c65-08d9276d4502
x-ms-traffictypediagnostic: BN9PR12MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5366CAD1BB974266795A98DDB13B9@BN9PR12MB5366.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGlXSE+BolAxfRZdXLr/Ca/Xj1884jyFBLSnrHyHdfL6OtEQG+0lmvzBBfPWgTVj4HFyQIvH2tu7IrEUIe3V96q9yfwdoXZqp7PGu5P6bYiL5O+pTcGwSW/wv2mUHvifmuqToGLaN7BMfDJP+dSeuw0s4erkXPO8H7+U+0tzcLGGzibIIK8ZGdVyVVphIb5hVnBdK1AxAW6fY7JIyMGqofHclYELVKtE5pL6cSVQxtUgaGwGk6DpsMw7/1kdRGZ+R0ApoNp6aRhabrItlyTgOdpzrXIAVf3t051grsknCD3FNOczwCODbmPn/9JlG8CmECjNqSKe4N1K+xdeMRZKVuKDVCggSYWlnQdQ+d51Tyfo1TJtVoqedvEPT8iZA8A+41EQQ1q0ewT9E5jgWIZObNd6cePcRNt7J42852uqzpo51euQdtnL2Kh1zl00djxqFk/x/pIoJzGEnQtRVqFKVfTH9s7AfYH7We2XFMo17PTzPDzPiLcxHJnea1u+IOVtUfrCGJ4x1YGqg1eXj+mvtOdFoQ1AYus8NoKXfJ3TkbFhb0VGiddfT8ovKD4LqqPMFcYtL1fGKsv2pYqRmx7Rk9487EONHSYSKlsIqvpUDL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5129.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(9686003)(478600001)(55016002)(83380400001)(5660300002)(316002)(54906003)(66946007)(66476007)(64756008)(71200400001)(66446008)(76116006)(26005)(6506007)(186003)(66556008)(52536014)(53546011)(122000001)(38100700002)(86362001)(33656002)(4326008)(8676002)(8936002)(2906002)(7696005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p+J27S4kEiGqpm/PEuxQWy75ZwiVztowcwWZ+28dAUeaD+uNzwYB2H46ei7m?=
 =?us-ascii?Q?I/akcvDjMGG1WAEedAbZ+biu0iLDlCLWjf0WBYJYbnMBPNkx/cD+nyNXjcEt?=
 =?us-ascii?Q?kk2dnFMaNoVw5sSBdb9A8NYU+j6W5r7Un2ONJUX6NGr+0XCRcdSORiv//61Y?=
 =?us-ascii?Q?w9WalgQri/MO8kZ/0tOWuznZxHRdHNfxQqvDKXcdEuEVsGQloFFOfMApsQm8?=
 =?us-ascii?Q?LqEVTXesW090Z/DKsJSwwlSOYcpPII3VEOd0Ex5A5JqdA3MIo1qUNirgwjun?=
 =?us-ascii?Q?xpoOQNiHSZdCsJj0+rsUPy/AR3SFTU5JrkAmA86pFmQP66R714GU3gBLO6S7?=
 =?us-ascii?Q?sHFwEvbSh7iqWw3XcvVW+y1tNaHe4U3kXNFmsls6uMEFsACtQ4gCOrldgkTx?=
 =?us-ascii?Q?Nz3oPN13izaPHePSDTWDwOPAK3YYj2STopzeOhTCig1byUViAWwGl5tZqJWg?=
 =?us-ascii?Q?vsE7hjiH6naehL5ygPIGwBeHipCMM46/YndZ05V1OOLqq6PfDD7jwv6dVa3I?=
 =?us-ascii?Q?9X4r5HwycWCrXRA0hh90XLg9u+yhetCdZ5IeYlTrDW2i4NIngJdRgnzSae56?=
 =?us-ascii?Q?KVso0nYqBKtuh6J8eYperPRwp0/GVeAZpjleE/4HZn30f6qa+Xd3SfTmkReA?=
 =?us-ascii?Q?PLoauhy9StjQefOM0N4gpycXVxyfJPPmYwU0cQI4Itw7HyHEdO1Fz7cNEg0H?=
 =?us-ascii?Q?Lk8AEYOPuxZT0p/h8OSnFv9nvjpMctqJFlGk3c8uyHzA4r5AhcFmlRAhNlHK?=
 =?us-ascii?Q?LZjU+cQYQHcMjgsSdtbGLCml5VXapEY6KRMgfOY3jxyrPXrveQRfsUYxR5qR?=
 =?us-ascii?Q?oIIL1dDDk17Tqn9tQuf4k7T5aT/U30x/+roXjZsCRfIU2wRvf8hgtM082s7f?=
 =?us-ascii?Q?7p8mvBEWrUXIiRr3RSuFVvbZxIWMGV6nG4f/1DVsUdy2jM7QmSyTRJXkz8sc?=
 =?us-ascii?Q?U0q4wa7yYyrpzhKFagz7ySESWZGLD0Uc8Oi4mcJABJ1vpPeAexUU3bwCv7Aw?=
 =?us-ascii?Q?hWHK4JUbf9/L2Po+6zzrZ/x7xstPEiUj1WWWnVPVuHRpfDA11nVUdUSY0W0T?=
 =?us-ascii?Q?sF2eqVWyilgQmevhCEt11L+rcae9rJnlPX3vuDWqPzKW8EubVqhmcRZIZdzu?=
 =?us-ascii?Q?f/fjKep/0QpsY+5vf33G5S22CU4o3z8kaf4Uq0SfJVXCBvAxjUJXVa8EyuSW?=
 =?us-ascii?Q?WpIEii3/NR2Xh17QUOJu3+nNuPA2fYZdHgK+RHAG9Rb3RxWyj/v6YhJ6q34a?=
 =?us-ascii?Q?2DBrvyia8AfgLZXJHcF861AuF0MdrLhIBJWmDlrZfPcRWoBoJCTTfjZWHmiN?=
 =?us-ascii?Q?Jes=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5858e-ba3f-4939-3c65-08d9276d4502
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 15:27:31.0606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khNVPJ5VdE0I8Q81N620tv/vGmAu7R+exLbpp29nS/W+cE5D80Jyslv8bDVghBTLTfdxb0A1OVEGSOihaCUTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank You Guenter.

Regards,
-Ninad.

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Friday, June 4, 2021 7:11 PM
To: Ninad Malwade <nmalwade@nvidia.com>
Cc: Jean Delvare <jdelvare@suse.com>; Bibek Basu <bbasu@nvidia.com>; Nicoli=
n Chen <nicolinc@nvidia.com>; Rajkumar Kasirajan <rkasirajan@nvidia.com>; l=
inux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ina3221: use CVRF only for single-shot conversion

External email: Use caution opening links or attachments


On Fri, Jun 04, 2021 at 02:54:43PM +0800, Ninad Malwade wrote:
> As per current logic the wait time per conversion is arouns 430ms for=20
> 512 samples and around 860ms for 1024 samples for 3 channels=20
> considering 140us as the bus voltage and shunt voltage sampling=20
> conversion time.
>
> This waiting time is a lot for the continuous mode and even for the=20
> single shot mode. For continuous mode when moving average is=20
> considered the waiting for CVRF bit is not required and the data from=20
> the previous conversion is sufficuent. As mentioned in the datasheet=20
> the conversion ready bit is provided to help coordinate single-shot=20
> conversions, we can restrict the use to single-shot mode only.
>
> Also, the conversion time is for the averaged samples, the wait time=20
> for the polling can omit the number of samples consideration.
>
Makes sense. Applied.

Thanks,
Guenter

> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  drivers/hwmon/ina3221.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c index=20
> c602583..58d3828 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -196,13 +196,11 @@ static inline u32 ina3221_reg_to_interval_us(u16 co=
nfig)
>       u32 channels =3D hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
>       u32 vbus_ct_idx =3D INA3221_CONFIG_VBUS_CT(config);
>       u32 vsh_ct_idx =3D INA3221_CONFIG_VSH_CT(config);
> -     u32 samples_idx =3D INA3221_CONFIG_AVG(config);
> -     u32 samples =3D ina3221_avg_samples[samples_idx];
>       u32 vbus_ct =3D ina3221_conv_time[vbus_ct_idx];
>       u32 vsh_ct =3D ina3221_conv_time[vsh_ct_idx];
>
>       /* Calculate total conversion time */
> -     return channels * (vbus_ct + vsh_ct) * samples;
> +     return channels * (vbus_ct + vsh_ct);
>  }
>
>  static inline int ina3221_wait_for_data(struct ina3221_data *ina) @@=20
> -288,13 +286,14 @@ static int ina3221_read_in(struct device *dev, u32 att=
r, int channel, long *val)
>                       return -ENODATA;
>
>               /* Write CONFIG register to trigger a single-shot measureme=
nt */
> -             if (ina->single_shot)
> +             if (ina->single_shot) {
>                       regmap_write(ina->regmap, INA3221_CONFIG,
>                                    ina->reg_config);
>
> -             ret =3D ina3221_wait_for_data(ina);
> -             if (ret)
> -                     return ret;
> +                     ret =3D ina3221_wait_for_data(ina);
> +                     if (ret)
> +                             return ret;
> +             }
>
>               ret =3D ina3221_read_value(ina, reg, &regval);
>               if (ret)
> @@ -344,13 +343,14 @@ static int ina3221_read_curr(struct device *dev, u3=
2 attr,
>                       return -ENODATA;
>
>               /* Write CONFIG register to trigger a single-shot measureme=
nt */
> -             if (ina->single_shot)
> +             if (ina->single_shot) {
>                       regmap_write(ina->regmap, INA3221_CONFIG,
>                                    ina->reg_config);
>
> -             ret =3D ina3221_wait_for_data(ina);
> -             if (ret)
> -                     return ret;
> +                     ret =3D ina3221_wait_for_data(ina);
> +                     if (ret)
> +                             return ret;
> +             }
>
>               fallthrough;
>       case hwmon_curr_crit:
