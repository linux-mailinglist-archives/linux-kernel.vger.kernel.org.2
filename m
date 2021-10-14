Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38EF42E4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhJNXsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:48:35 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:51894 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230371AbhJNXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:48:33 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EL6pPh015392;
        Thu, 14 Oct 2021 23:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=KtBQNw4/hDVM5Iui++FUYYMIOeLwZ5qkfJfZVK/j3eU=;
 b=FCIaPfd8jWWFsu10zmUffIrn3mR8E3BmB5WKuOoAPXfN/Y9BTisblyqwfnNi6a0aR5PQ
 eTzksTqlTDchFtpbPiC8A41yqIE3/WLTQWO27QkJQ89lCKs016rASfR9euhNM8YXNghx
 QRL9btgJKfDXb8a45ZjJkO6FO4qyZiqHi77O9LXTTU7u3jHp+jsJFgjCNa1ozs2CMd3O
 KHxDhT7J472L9t6O+dnjME5ViS+ZAIZ0e5LRsb7O8Dcv8vSDSbIcVsUYXaCZRA8S9vSE
 +cayKVvyqoP9ssxQsS9NRzoMUeHDY/yyfDk2IZxSY4o6gbzSSW2Pzn1rF8Zk2fDeH1kz Cw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 3bpb86142r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 23:46:14 +0000
Received: from G9W8453.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 7229785;
        Thu, 14 Oct 2021 23:46:13 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 14 Oct 2021 23:46:13 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Thu, 14 Oct 2021 23:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgHRDjCGVNTGMmFX0QtotoXpBleDfP0h1Wlb6Lr1fqp6U1nQPe1hQ0OwBto5IFO3GdeGUABLCmI5o7gQTm5XlPECx108FxsGhZcmytUR2xML0J65qePDS2CuN3fT/F62Mv8C3Ddv7Ft0QA6Rl0yFMnqF94Wu79wFx32O2N7LUczLWvb9H/a15TJO7vFZfPk6YSZt5jRmlO11aZhz4UqV/QaXdPvXUX7yDHG+GN7Ig3/VfGFQBh/jlen8YBJELoszUrogFu40JN5bAxYYm7/G1QyBVs0Gun+M4RAPVE95XRZUBZPtcbPoO4UOy10tu1F4CgEBdM5XJv4XaUvPTvg9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtBQNw4/hDVM5Iui++FUYYMIOeLwZ5qkfJfZVK/j3eU=;
 b=QCyPRUD0Zx0PEDlxuLUA6WljzdCb8aUpOsIWpUdrXfBvHkaQmBxVPw5zQJtkUPcFer1OjeVg2Vt1fN5N1M6xGScyfp/Z/OF3Ts5Zkh8bO0PbE1OXKJqw/EwajuS1zVqXgwk2zUa/rtPqZtOcV8wJJY82Pr8auvQN726HUYnCbR4iRUcC9FO6rxdMjJSSpNJaZi0pvIX8tAuSwFD51ICPn/OsMbPx3UJvjz+nkCyNhggp0WPpBPNAYvLrKvOmsUo/zDdTaInINqyPJ1JY1qh3RShtkyZLDLGpJBH3LFnX9MQ4a9bCgpHW/IJzzWE/dLRQ49lwlhx4AgWrauUi9a3+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.15) by
 TU4PR8401MB1102.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Thu, 14 Oct 2021 23:46:11 +0000
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e038:63de:464a:4228]) by TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e038:63de:464a:4228%5]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 23:46:11 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        "'john.stultz@linaro.org'" <john.stultz@linaro.org>,
        "'sboyd@kernel.org'" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Is CLOCKS_MASK macro obsolete?
Thread-Topic: Is CLOCKS_MASK macro obsolete?
Thread-Index: AdfBU6A09mC6jzu0Qbi9a+PqfgPUrA==
Date:   Thu, 14 Oct 2021 23:46:11 +0000
Message-ID: <TU4PR8401MB10550DE1D599CC98E80BDCD1ABB89@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=hpe.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1ca55bd-ad4d-4a05-c0ba-08d98f6ccd36
x-ms-traffictypediagnostic: TU4PR8401MB1102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TU4PR8401MB1102342E5E5824FE2CEE2742ABB89@TU4PR8401MB1102.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbcmH89mCF05x0HGKQEVZ5orohhMvo4jE73XQw00WnsvmCI1tByo0ktDv0Z7eBIzN17CXnzdWzE6sCmadVo5NCgZum8t35ottc2GoHJr6NJyWbjko96GTk0G9zhvMXQC0VQihEb0Bt67MEVfn5F5nb5kq1o8A3OcEujZqK5tH5oite4C8QEHj9Oz21ek/GQegdCCLS+wdlXCKiUmzrB6+NvhltPj3JCk/S36HfQK95JzTGUOHQcmrWrVg41+xQ0+XOaBmogjbycVam0cxicR6C+qvM3yf5IQyjnjgwJaYgpkdbQSbpcYJeNrtL14IBUTG8SsSEIBD+cSSPlCWY9PzlRAAabS0VradbUaNHcQWFaEX6XFJOm6Na+6zZWX6PwL0ZDKNevKU18WKX6O7x1/tITnlJFwTSft1+1ySB3ALXL2P9XU8hz4hYPKZ3e6doxA47vDkQjgCGPVwdsJsq4ZlVAgylzC9PzIxz/PQbqAZjiCVBGKF0ZB04OVqOSK/pafl6mc4XhRTzRAmGATsgquD821AuGuyPmcjO9wPGDgO59FT6bswuBrhyw/cXrwG+o11APT3+41NwTI9ZZGil2srL+Un8gwdyiMRYqYC5Py4jkeYYshifwcE6//kCrpnAJRs/MQg+hkOVrumwaCK3XI1rB+xFsUoati6YX8k5ishQLJX09kW9iYqBBRKwbpyhgTRB5PcapcJBznkut08+R426/Gq5Sx4LyFMgeytODeSck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(38070700005)(71200400001)(38100700002)(8676002)(33656002)(76116006)(110136005)(66556008)(122000001)(316002)(6506007)(66446008)(5660300002)(508600001)(52536014)(186003)(55016002)(4744005)(8936002)(7696005)(64756008)(66946007)(4326008)(66476007)(86362001)(82960400001)(2906002)(9686003)(83380400001)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YlzcV2zIaQsSq24CcWMBtMsCSk9pzMXxrQuyJmKuEWO2GuGyoNq7sFgmRebx?=
 =?us-ascii?Q?LgwU4KqGlqttNMy/kYxu1BcwLgrOsFy5kIetHsj9bpfjFm3MFP2ua5nt9TrN?=
 =?us-ascii?Q?6FqNH66ZVH8DD8AHjXXMekqnmSUlkt3X+PIfFTRxvGVBXcJUMGjG0GsUOccb?=
 =?us-ascii?Q?h+o4JRV4h7NYxgWy91paKPcZj25NNx62mRHmt8AV6mSP3cfMWzPOfCf5hVJW?=
 =?us-ascii?Q?RwvLw/jCYRq1NO6ORn0yAL4v44rUURPmYQopC3nnHecsoDPXScL7WkNxrx9G?=
 =?us-ascii?Q?IgEAmbLrAiAnAr1F0y+2BBT2sdrrbUUwrlwITDVms/KnhKYfckPc3TKls5tk?=
 =?us-ascii?Q?SPBnLF5uLY87PkJZBHI9NDbF/Ulfi64oMNKY63DbugyGcQW17lnmJTgNsDng?=
 =?us-ascii?Q?MD0geFDRYjTks+7x7Jdrffonq9lt+nO/FlKuV41R11gA6+AdzDJIpZ2TpccJ?=
 =?us-ascii?Q?d4JoKN2cy+euQVIKUtWze3vbDHOqiNmGltur8qTVNl/Hb9+QjOy/NQLJjggo?=
 =?us-ascii?Q?rdugx0Daqm+ozIZQRbDO1HNqxvIM6LdqW/PRBhADNXBFAGc6sLGNYOUpA3C9?=
 =?us-ascii?Q?VzkMyeKl1omY1lH/vPgyrup+Y/iaVifP61p2OTQRFZ5rM7bUp+PbevgIu6ku?=
 =?us-ascii?Q?o/EPnGabiT+k5HZE2F5aFVAC/NbSl9XWzPikItim1UUXHF6LiGLZ4C5o4uG6?=
 =?us-ascii?Q?Y5yL/rfEQBsuwDpn50YPhIwI5WhI+Q6bjkor9UhhRdbuLF7jqFop+f5AXJj5?=
 =?us-ascii?Q?QDGSHOgMGFGvKcspar7UsVlvqUBh8La1ezd5qd1LbqDa5DZRQ174D0jeQPcu?=
 =?us-ascii?Q?dbq4BUWaC9VmKB5LpZxfE4by7fwovgV4ktM66AM0fM0zNawzlZxncmyKJ9lD?=
 =?us-ascii?Q?u6AwtzGNR0rSk4uvl2/lS2n4xFONMp04FMRXMcmnDddmzK1SLYcoayowmeHI?=
 =?us-ascii?Q?nQn+dH01NUGfH0Dimz+FiZ4CZ1NyF36PkzFB1tmHEUXkz77vjTjinxqinO6e?=
 =?us-ascii?Q?cPCdtaFIYViJPef8yryonkm8wwGDdDZaW2+EX4FF5LutvBIhc5P9qvMzWPDy?=
 =?us-ascii?Q?vQTAhunNhQ64NVORqiqXB6F+aV2GWKoHQ36s7kC3p5NxpQoCJJUIAzaq2ENH?=
 =?us-ascii?Q?ZluBP1TR0ZO4hQ/5Ui4rtaKYWJGshDSAA9kj5NLsElbacDta6ADzoXYqjvZg?=
 =?us-ascii?Q?PwO8Z1jd07GYtnIwaDh6OlbT9G64Bo9C9GwoEx8p8AsTngmPIJcYN3m+Rlp0?=
 =?us-ascii?Q?Bqp9votO1yfMPaMUdItr1PVfp7jabRZUrwFdUjCF9BMm1mpmwTHaiv8nUas4?=
 =?us-ascii?Q?PxpCRUaYMxhWYXkaR7DM+H0Hz53X5kDDS+nZ/VO6gEOBlJjzAuZitgrCbvAz?=
 =?us-ascii?Q?NEKLoRRGa4YxaQE+WfCKBXrvnJeK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca55bd-ad4d-4a05-c0ba-08d98f6ccd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 23:46:11.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRG58KjdNYS0I/RFZw6LWqPYJ8ZuRwfYgPB3/Y6oV6tUV6Bg+KiLywdk5FHnjZov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1102
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: dMMGpU2FEf9oUp2oyL7BwEYS1c6j3tiD
X-Proofpoint-ORIG-GUID: dMMGpU2FEf9oUp2oyL7BwEYS1c6j3tiD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_12,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=723
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLOCKS_MASK macro in include/uapi/linux/time.h seems broken; it's ORing=
 together
two numbered values, one of which is 0. Perhaps these clock IDs started as =
a bitmask?
CLOCKS_MASK doesn't appear to be used anywhere in the kernel; nor does the =
adjacent=20
CLOCKS_MONO.

Should those macros be deleted?

Excerpt:
#define CLOCK_REALTIME                  0
#define CLOCK_MONOTONIC                 1
#define CLOCK_PROCESS_CPUTIME_ID        2
#define CLOCK_THREAD_CPUTIME_ID         3
#define CLOCK_MONOTONIC_RAW             4
#define CLOCK_REALTIME_COARSE           5
#define CLOCK_MONOTONIC_COARSE          6
#define CLOCK_BOOTTIME                  7
#define CLOCK_REALTIME_ALARM            8
#define CLOCK_BOOTTIME_ALARM            9
/*
 * The driver implementing this got removed. The clock ID is kept as a
 * place holder. Do not reuse!
 */
#define CLOCK_SGI_CYCLE                 10
#define CLOCK_TAI                       11

#define MAX_CLOCKS                      16
#define CLOCKS_MASK                     (CLOCK_REALTIME | CLOCK_MONOTONIC)
#define CLOCKS_MONO                     CLOCK_MONOTONIC


