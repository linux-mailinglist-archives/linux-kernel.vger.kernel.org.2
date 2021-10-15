Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5060442FA73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhJORqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:46:03 -0400
Received: from mail-bl2gcc02lp2109.outbound.protection.outlook.com ([104.47.64.109]:19936
        "EHLO GCC02-BL0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234784AbhJORqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmPiQtqdDPDsstL/rz+rIm/7Sg/sirfcisP+CKfxuvLPnBBgjeDwC3yxpxtqpcAzCJwPBcLQvVdN+iRDVHYe/cZKWFgbm7sTJ3ZNJmfbhw7krvNpeazdPBknzjrEy7FN5QO5i2fpoJVRZXMFk3m3E+s4MKjNsuop0O4R2BjQEHWnQgFgKt3TSlQ8OylZWLf+5l/p+23Z77+CZQzmacjbiKtDjmgidXgivnIDVn+D1cm14mN2SMvNTZbyXBzBQGmWPrx+vcJQV3ENpKRQwI5MRdkKEOCjHzO4lWedd573YjkQNVfAgtmwQH1i3wwaw39LuvfrNwdLUqKRP9olluLOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfC05k+APWHicYH1RHyXdWiZKWwhFn77gOWlIUYj54U=;
 b=Quhm0Y3HUqAJo7WjPLwE9STAPaMN5czEdCKbOYuQKM0i71/zu854z+OLH7uZLN2q87qJzRpLRrEua8ax5OViKctKiYxeWiAUlMpjGVy6K28/rP3nNdaNy9M/ds7O5tzUvyFEOJ/c42Mr0mMtAJpX8c+iwfkWtvxYA55GkYSQpwDU3ByZUAdthrdosdPhrf4PluO5lnq4ey+SxSaVY/7RostFpaodxIxrYyO+QC4EeqEIS0SuvzMaNYv90Q/PeLA46OJMMEACLnegzRWKUfq7GCXVr7pKBKQtt3UtDU38AclEbr4wxlY/EpiwSWTsGrbwgv37U/OKTYkQgi6djy2s5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfC05k+APWHicYH1RHyXdWiZKWwhFn77gOWlIUYj54U=;
 b=a2/NalwDq0NCmegwsGBGNzHlZm+1q+1MRrNgpypP49EBb0jHBvOq8ckjYS0pYDGXYYOiY5nRxUEuX9QnfmuuVcv3oEk7mECSerIf42jICB/kriMmlbqQ28U079kEP/Zbe1+K531ZR43+l1Hhbn15FRh1pnPus5OarZv7q0iqf5I=
Received: from SA1PR09MB7440.namprd09.prod.outlook.com (2603:10b6:806:183::14)
 by SA1PR09MB7517.namprd09.prod.outlook.com (2603:10b6:806:177::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 15 Oct
 2021 17:43:54 +0000
Received: from SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995]) by SA1PR09MB7440.namprd09.prod.outlook.com
 ([fe80::b0d6:a789:37f1:1995%2]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 17:43:54 +0000
From:   "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Potential issue with smb word operations for tmp461 device in tmp401
 driver
Thread-Topic: Potential issue with smb word operations for tmp461 device in
 tmp401 driver
Thread-Index: AQHXwevE+jBPDZzzYE22a/VOYXutsg==
Date:   Fri, 15 Oct 2021 17:43:54 +0000
Message-ID: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: dae7ba0a-07a3-bd5f-6771-52f632042864
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nasa.gov;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cddd6cc6-271a-42d5-82ce-08d990035b81
x-ms-traffictypediagnostic: SA1PR09MB7517:
x-microsoft-antispam-prvs: <SA1PR09MB7517551DB6B023A7A74BA53EE7B99@SA1PR09MB7517.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAT//GwNqndj+iOvYoe7f3OEsjo2PRY5nDulE8/zzZdMj1lCqL3fayGAzvxqwq3RwtOGEF7sAfZxsiIbbTE5RTq+Ty35c8XiXH1z6qlcKCi9B7NuqEdYlBTKu6CC7ez4Cf/J1cDJvp2HPRTiJYLLd80KMhqrE6/HoAvnEYZNJXfw9oLBn/BmCfRNNRIbBbj0toykQoUEpWoo+UL590rLyltLzlUZdV/pOi4Xu2IHQOSsPxPpoVgqG2LZtMIcvhQ0XGdDyk75ehCP3eWqhp/rFpvA7096ELG29LbdHrE7WCj3E/BQeEbGPUeqiMRWWNohsl6V5VPA9FoOOZNhDjJz35QbZWktCHahIAhoS7K0yAsRCZ7Qjl/bR4qXYJnNU+wZUj4RKPvMTXcL9z7Rc0OnhRD42dCeqamA+QrHejMzAAf+7XC7PGN/VmN944hi0GPZauFFCgjhXg3TVX3kQbg19MfSuNktHBrRQYs1whBCQ8nnYTP7ckIOzHy4SLQaytBkKvWjS0v/O5Uh7Ptz9rfLHbnd1XtQxAIwobH9gNyJ+iqzH3sl/deClMOW3WjMkjwfL1xwcex3XdCcDkqs5Tv0igHcLB4yfRJ+SMF0k2/ppTlvqxAkrF4ZfQ8yOco5XWRWyQE+ZxVEVgUVRp36U5z19njUZvLKUeXIoZ+Pe7heneU9Cp9l19aJNSkIQkp8FkSIqRmmBwO0jhJ1xWAGsI3QPe6Nqnz15KifJPp9oslR1GxBDH79Ob6U9q/jYJ9w3fDkh702FqmuiEjZ3XYUndUksfGygxL15pFNeTJdT987baE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR09MB7440.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(55016002)(186003)(86362001)(9686003)(4326008)(2906002)(508600001)(54906003)(66446008)(52536014)(122000001)(66946007)(76116006)(316002)(66476007)(38100700002)(26005)(91956017)(66556008)(64756008)(6916009)(71200400001)(38070700005)(6506007)(8676002)(7696005)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2lvHc5YX3n4n2V7vxX36TCR5JmTinQqt6OSS3CYMV5bRHx2piP32QcH87j?=
 =?iso-8859-1?Q?P24ZHCK1mLnrMvYMpws2/a0Mil0KWrJFTUHwIpUBt9tATmTRWGfmY2hVLy?=
 =?iso-8859-1?Q?U/DmCnznDu5C1nRU0yp6vbdoTVCM76fJHZhYeTFzytP3G2/K43zPMr9mq4?=
 =?iso-8859-1?Q?6y+qQ8DnKQ1PNitlQ79iMZQ9+TAX6Ybx7khGPXqCbZNNDJxdOZkxt5tlW2?=
 =?iso-8859-1?Q?wTH35iumuxv0ushq8O1S8hhiG0qBBI/C7UrWImN2qE2G+aBnRMDElm5DLS?=
 =?iso-8859-1?Q?g+pnak25LaqM4FcRciFRs+NL9kiaphPpORp6rNEC7zEs1l2K8lwv5yqVmS?=
 =?iso-8859-1?Q?KiEMIGI3cuNLfIznjP+Z3EkHxImrYGctIdP38/0bUYky3psgaO02k2Ea1y?=
 =?iso-8859-1?Q?3/LZPDJIpuoG1JWKldPUgRZrVpivYIpmHd3gLtXi3fqWbjx8lfvEmgXi9L?=
 =?iso-8859-1?Q?1VVX8H86FIxD1eKbaRv8ChyVM3CIDyDNjCSexgwaVKUqF3jHxi340PrEvn?=
 =?iso-8859-1?Q?F02UzdmGJWZHOMN9TQq1FxX2BuNNq+Uezkvfjzz+djdtlBxa542r/I+E8R?=
 =?iso-8859-1?Q?/UyQJWFG3hIXYqApSEFhWKYc7c9Y0jB4/PxyzPFG9Rldu1L3mhxiF/5FBc?=
 =?iso-8859-1?Q?U++SBbq9FrAO0vnpD1TuOtx0KcdTnejnvDSJvY71K60lBP1tAb8dLL/4jI?=
 =?iso-8859-1?Q?UTMaz4eCuKM6R9yWEPE5KEWyLrqnwbPRBS/SFmfgH7HqRMt1Kuk7ndiDEa?=
 =?iso-8859-1?Q?jRqkGgbTynooxqJ59JpJh7nKMnP2EQyQ6PcYs4arwOIgK8Xy0aWjkQuYY9?=
 =?iso-8859-1?Q?GIXfROkrkifVIAv2+HPAK6gN94Br4DmxOIy309svTd9AgfwBDzL1Gy0/gD?=
 =?iso-8859-1?Q?UMJXlfAHIQvGqjgMr1q2kAcrYvEi7WuFPvPVRMRA/UwfhgKhRr84/v/Ksg?=
 =?iso-8859-1?Q?M+rPbbbnjMXpFYQGIlmxV800aNOVFHpKd452kZAMwkiiruHrwM8BCLoMOi?=
 =?iso-8859-1?Q?gclPD3C0EZ2UAQxHgw9PdoV0MPl9PiwwKy6/YNSI/BuACnff4LaX1+MNWE?=
 =?iso-8859-1?Q?tfrIUkTZpSMY8eK7QeB+Q7UR9ACO+yFJKCnLffHpHpNHu+udjaWPS8nrI+?=
 =?iso-8859-1?Q?333jvFYZYnKYzHxuSNS1meii+vd3Yds/lubreXcqu9NOX81775UhDWzmhi?=
 =?iso-8859-1?Q?aU+WjrIP/0sXiOl3DdnMvIT8VyRgvv+aeb8OoR1SSguW3ka3XuGlq+XUWk?=
 =?iso-8859-1?Q?WiD6YLbzlS9tDidhTxq7wh0eKI7zVsB1eyYSnyxKFiI3++SuS7aWWtx1ch?=
 =?iso-8859-1?Q?WWIA37+lKfaa8n6EH0LV6YVER4dRnzG5LzxSDKzg9FxRxRFhI6ELWW8Kyx?=
 =?iso-8859-1?Q?2PVmoA+9IM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR09MB7440.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd6cc6-271a-42d5-82ce-08d990035b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 17:43:54.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB7517
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
I am reporting what I believe is a potential issue in the tmp401 driver for=
 the tmp461 device specifically. I am new to reporting issues, so I apologi=
ze in advance if I've provided insufficient information for an issue report=
.=0A=
=0A=
The problem I'm encountering is that when I use the tmp401 linux driver to =
read temperature values from the tmp461, all of the read temperature values=
 end with 996 (e.g. 33996, 38996, etc...).=0A=
=0A=
Looking further into the tmp401 commit messages, I see that the driver was =
changed to use smb word operations instead of separate byte operations. Alt=
hough the other supported devices (i.e. tmp432, etc...) are noted to suppor=
t 16-bit read operations in their respective datasheets, I see no indicatio=
ns of 16-bit read support in the tmp461 datasheet, which is supported by my=
 inquiry in the TI forums (https://e2e.ti.com/support/sensors-group/sensors=
/f/sensors-forum/1044935/tmp461-linux-driver-support-and-16-bit-temperature=
-register-reads).=0A=
=0A=
Reverting the driver to the commit before the smb word change, I am then ab=
le to read temperature values that do not end only with 996. As a result, I=
 believe that the tmp461 support may be partially broken by the switch to s=
mb word operations.=0A=
=0A=
Thanks,=0A=
David Wilson=
