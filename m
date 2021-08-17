Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2A3EE937
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhHQJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:12:25 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49272 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234347AbhHQJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:12:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17GML8cg012206;
        Tue, 17 Aug 2021 02:11:37 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-0016f401.pphosted.com with ESMTP id 3ag0qxhx7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 02:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7D11WdbXbs0fA1q1r/xtvGaI+x8caLf/xk8soV4FnMM5SrLGMqSVQe2ljpY8+KwOct/MrZcg4AmisJYmg7WpQIp1P74dM5QIwYNfzm2lMD4OEK6aNnZ46Vi35Icg25k88pVsnEwcbbO9DE/4GRM8GW+3hm/k7mUgcWYmIE6UegYBG/MWc0LqPf3anPxcac5NZEwZ357mm89XB0S6ebduFVFp/FBSNX4DdBGpzG3waEJyfm5gcoibwp1QMHjUArs/RCu99jC013xjNq4o9eMjB6Rclc7J3kvxSUHP1H/y/mRsUGBfVGRP8APiNjLcbYpD2D/08f+3tzqMDurG10zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dv1Xyp60daB0Xc640lfSfLJdWCz1KFdWQQezRW6j/A=;
 b=fyEAGi4hqCPnJh4AbUfWiM5gsYkbgpEUiRQ+3Si3RbgATTwIe8owX4a5IKQaeOBECZgqMILnhMKug9KvMOg+28pVypHGO7Wt3OoL5tdjIhw7fpxs2/GRYd8g3cmNd9CAbdbK5XBdAzrPzHBsfMko/5TYefb0+xwx8dumochj3VfKJQ4h6jyUAbN3MvQAn+eMO8mE5H89lT3OHAcdcNKBZBzsI679EzNe1WQu97bROt1Eh+VCi+vQpjVY3oRux4YsEZ6278qdfn5NxWmgMi+rDL3MdN23bngfhe3cKRroT4ER6BuzVZ9aOGYEK3ngRerhbZKqSFyJ8dQLGOd2hYNSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dv1Xyp60daB0Xc640lfSfLJdWCz1KFdWQQezRW6j/A=;
 b=uwEbLRL0l+ZUQ/0V1LWLu8NxFjyt8LtrYbDpPYw0MHo24tlFXyntjEQVCB7+eO/bk0oYTkjKtwp1iPbibpPCkTHdIYE99Mux646FDA2eEWfDIbetaZFi/S3WqV8IAtjvvdmSBgIrqD+jcAgJv4sozi+BtwDoxxmuvSNwV9+2vyQ=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1061.namprd18.prod.outlook.com
 (2603:10b6:903:a8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 09:11:34 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::5e4:5ddb:27aa:f57e]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::5e4:5ddb:27aa:f57e%5]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 09:11:34 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for
 Marvell CN10K LLC-TAD pmu bindings
Thread-Topic: [EXT] Re: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for
 Marvell CN10K LLC-TAD pmu bindings
Thread-Index: AQHXj6Fp5LolcUS7E0m2UFEK4lERhqtxWVSAgAYT1KA=
Date:   Tue, 17 Aug 2021 09:11:34 +0000
Message-ID: <CY4PR1801MB207047A1D761C136C9B18E76DEFE9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210812174209.1970-1-bbudiredla@marvell.com>
 <20210812174209.1970-3-bbudiredla@marvell.com>
 <1628856667.648308.3179071.nullmailer@robh.at.kernel.org>
In-Reply-To: <1628856667.648308.3179071.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f38b7c9-1755-44a7-db21-08d9615f02a5
x-ms-traffictypediagnostic: CY4PR18MB1061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1061E1B952F909B52FCAD6F2DEFE9@CY4PR18MB1061.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qGAx9dwWgmP1yGNZCYfWENKU5MiiaaGztVGpiAuLt8758+mEJ9jOKWrnAYrrr6AD6T7QYXbyhvh8iKFum4M2DrxQjvG0YaQc8rqeo8SxRafe07ILPotV5WNbYsD8pnCSmTUB2pkUQ+vcQZTz1mPAMsHQCwIV43YOQrNReuS/ltq4zPBk6p2CpvuV24gYZj2tSRuuOJpDMcdMcveviXi6E4iW9WjQQikhUHDxE9ovvLUH8vWvxxeLidnGu9IXP/47BJ2fawdRYJCbaIyEHVl/iI1T9UFWP6oALp8sg/lDyb5s99aSdOblsoxvUPVQRzGP83xayNcdRbXg4B5RWr3lDL/yla3v5WOKLpCtq2fq51Xk3v0YMKVw+ci57jxYRKKNQ9YouS8RHc/7gYyWSxQ+NbXGRtsK5EegioSYIIT4R6h4Ktl/O+wxvmyjWo8jl5hA3E2FEawN84mBtQOL4o8+fC3/vQ34BYkbuAr5BtYZyQqqObqzPjueVrBPDPtez/aVXQM/QL/202+REdfX9jyKN9dqeONIOaYmoTgXUih8H1uOi0pI+iH2uZNEGERSW5jqf5/sQw36IRJwjU8CaXDI6+0TNEC21H9hH4CkQh8qFQGAQUz8t5PCqveXPaGMgyUYMyneSLIU+u6RyKTq8VFeQpzjlj/KgKvtr+L0EfFVRKozRcEDixpArtmGlZIB5VMYSrlpikpE9Vy1Nddl8F8IJqnZJadMu7b7Dd/Cf/XYIxK1Zd5eaxy2br47EAzWSe2Jvbqij3jO/mTSSz+o0SSvuDU6FYmTj+3KAADkNgCZMb7BVgiH5h6VtphVucplh8g/+EZWMVqmqNn9lTLQlIHRpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(55016002)(33656002)(9686003)(86362001)(54906003)(76116006)(64756008)(66446008)(66556008)(2906002)(83380400001)(186003)(66476007)(26005)(7696005)(6506007)(66946007)(71200400001)(5660300002)(316002)(8936002)(966005)(8676002)(6916009)(4326008)(508600001)(52536014)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fv8kMjgCebbxVyHETk+b3xdqFtTFNe/VoRH3A1oWSsJ2ZRKhvdMCHUJou3WH?=
 =?us-ascii?Q?eD2GvDRoDxKQctRHTaL9e/C5m/dDNxr5GsT+tmo4S2VfXNljjZYabLq/hZVB?=
 =?us-ascii?Q?T2TwA7ONu6RgwJ4Gi2Vja4+tszRTdwMANMEpcYOtO6IIFIKLBs/Vhw96byCJ?=
 =?us-ascii?Q?03urNvvqwP8Epq7cOQUdVWzU3ShyYfZqbJTyqH7oe/bv7YHMbEJ5y0kaQ0Fv?=
 =?us-ascii?Q?O/Jel/nw7+aY/ODod8qqj9ylNMSfUafsFk1+hXxPiTjMNrZv0BSshfXq3M+f?=
 =?us-ascii?Q?qskSF5VjXZZ1bqxdFClOlcx1rbUcdQ0ymVNYGrgQs8EGJLQBo1dPtKZ2X1n5?=
 =?us-ascii?Q?sbN9EeyZsmI1gC6Tpagrrumh4ZT1sagtxWDd7ZnYqMhHZEI0OFt7cYvy1BOh?=
 =?us-ascii?Q?8mVvIqpoevhbc2V/5W3jnG8zv/WzHvCzH3DB2ugz4lZb7FNJkwn/rpyZaF1N?=
 =?us-ascii?Q?VlPhOOi22z8XbguZ3H7mGMuHcVTDN/ylJdOmOcuMRL2FE3pcCyBhTbievqQu?=
 =?us-ascii?Q?Kvyu6k9JMOOZtaGX64mxjiRmoClwUEOaZ5VwP83fJOgBRVBexR1VxRqb9U9l?=
 =?us-ascii?Q?2F3lGIWEJZk5UYnXqdkDIuK8rYExB0QQmhFpzNC+9hLEomHjEE0fLggeK2Bf?=
 =?us-ascii?Q?JhY41bUwPbrAFgdH+22W+k8o4y+FhC7yD8iYiqyW+vyrpkPVj5QOWRwXGvGw?=
 =?us-ascii?Q?qmx+2x1ZH6rUjrXhQMosGjb0uyTC05TTSteRaNX4KpxOqXM/WpaQ9+k/l2nE?=
 =?us-ascii?Q?c4MUm6N339Eu9UwPJm5f08go760mabEbMqLYmZe2tDSgeQSlNrHX5OzkR5MT?=
 =?us-ascii?Q?bMPkkSN8cBjDOD4mtPIOEUty1i/QHDEXO4zKk6xYPt8ORHEls4cPvKnbrP0h?=
 =?us-ascii?Q?Rfgbp7IsDQwK4hDqLM+Ua2Srl+ksKm78eaxCgfzyw3s3ChlR7luwcBWM/awM?=
 =?us-ascii?Q?CBavuISfuDHMgVg3rVDpgFGK6uGqWBnr18xCfqeRFitZUsY1zmL8Krl4A1eE?=
 =?us-ascii?Q?sYyTQGuihGE5F7Fsi93DuqBcYkX7PeNkwsPI7e1ksD3qErGZiczcG1IowvaS?=
 =?us-ascii?Q?PJnDfhSOUjt8/H+ynvC2iVbZxkmdbdgrAvRn1f4tNepQ71ukSrnlF8heXc85?=
 =?us-ascii?Q?SXCKK7yRyN66sonsucDqsXlZHFTw5hjJYav2/PzyK8drAsuMS5RqMcgNksjS?=
 =?us-ascii?Q?y1ifYLSl8OcMqW1WB3NTZk8oX62kz/ToHucUBFtOeWkYkewGHjhz4qsusk/u?=
 =?us-ascii?Q?T9frlEw58qikm8N1ZF9tbj0/y0t4lecLDBfzF70d1PWo+qgjf7K3CrK2SqX3?=
 =?us-ascii?Q?KpgcRSG33tk6J5UEMxH4RSKP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f38b7c9-1755-44a7-db21-08d9615f02a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 09:11:34.2777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRRS4vlp0nGecztM7krl/S5bcND8/LOBcdTnjgZRsYYeBvQkAgIKgfdg8YAlUsFAyuPL/6nX10v9u0NpR82now==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1061
X-Proofpoint-ORIG-GUID: Ft-1QVYDsouBVRrGZ5uiCh6jmognutKK
X-Proofpoint-GUID: Ft-1QVYDsouBVRrGZ5uiCh6jmognutKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-17_03,2021-08-16_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the steps. I seeing minimum version error, though the dtschema i=
s latest.

$ make dt_binding_check
sort: -:2: disorder: 0
ERROR: dtschema minimum version is v2021.2.1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'check_dts=
chema_version' failed
make[1]: *** [check_dtschema_version] Error 1
Makefile:1418: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

$ pip3 show dtschema
Name: dtschema
Version: 2021.7
Summary: DeviceTree validation schema and tools
Home-page: https://github.com/devicetree-org/dt-schema
Author: Rob Herring
Author-email: robh@kernel.org
License: BSD

Thanks,
Bhaskara

>-----Original Message-----
>From: Rob Herring <robh@kernel.org>
>Sent: Friday, August 13, 2021 5:41 PM
>To: Bhaskara Budiredla <bbudiredla@marvell.com>
>Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org;
>mark.rutland@arm.com; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>devicetree@vger.kernel.org; robh+dt@kernel.org; linux-
>kernel@vger.kernel.org
>Subject: [EXT] Re: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for
>Marvell CN10K LLC-TAD pmu bindings
>
>External Email
>
>----------------------------------------------------------------------
>On Thu, 12 Aug 2021 23:12:09 +0530, Bhaskara Budiredla wrote:
>> Add device tree bindings for Last-level-cache Tag-and-data
>> (LLC-TAD) unit PMU for Marvell CN10K SoCs.
>>
>> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
>> ---
>>  .../bindings/perf/marvell-cn10k-tad.yaml      | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>>
>
>My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
>dt_binding_check'
>on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
>yamllint warnings/errors:
>
>dtschema/dtc warnings/errors:
>Documentation/devicetree/bindings/perf/marvell-cn10k-
>tad.example.dts:19.32-25.11: Warning (unit_address_format): /example-
>0/tad_pmu@0x87e280000000: unit name should not have leading "0x"
>/builds/robherring/linux-dt-
>review/Documentation/devicetree/bindings/perf/marvell-cn10k-
>tad.example.dt.yaml: example-0: tad_pmu@0x87e280000000:reg:0: [34786,
>2147483648, 0, 4096] is too long
>	From schema: /usr/local/lib/python3.8/dist-
>packages/dtschema/schemas/reg.yaml
>/builds/robherring/linux-dt-
>review/Documentation/devicetree/bindings/perf/marvell-cn10k-
>tad.example.dt.yaml: example-0: 'tad_pmu@0x87e280000000' does not
>match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-=
zA-Z0-
>9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z=
0-9,+\\-
>._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
>	From schema: /usr/local/lib/python3.8/dist-
>packages/dtschema/schemas/dt-core.yaml
>/builds/robherring/linux-dt-
>review/Documentation/devicetree/bindings/perf/marvell-cn10k-
>tad.example.dt.yaml: tad_pmu@0x87e280000000: 'tad-cnt', 'tad-page-size',
>'tad-pmu-page-size' do not match any of the regexes: 'pinctrl-[0-9]+'
>	From schema: /builds/robherring/linux-dt-
>review/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
>
>doc reference errors (make refcheckdocs):
>
>See https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__patchwork.ozlabs.org_patch_1516395&d=3DDwIBAg&c=3DnKjWec2b6R0mOy
>Paz7xtfQ&r=3D9P_lSljSO7KnQNkCGsgu9x_Op4mstSdqWN3Olr4bUv0&m=3DKqfvr5E
>wn5St-
>WmEqTDaMI6uM6H5x0uiuOxZTYd15Gc&s=3DNYt8Ae1pxJhBgLN5asKagq1BUQi_
>gqK_RBkBSmcCvAU&e=3D
>
>This check can fail if there are any dependencies. The base for a patch se=
ries is
>generally the most recent rc1.
>
>If you already ran 'make dt_binding_check' and didn't see the above error(=
s),
>then make sure 'yamllint' is installed and dt-schema is up to
>date:
>
>pip3 install dtschema --upgrade
>
>Please check and re-submit.

