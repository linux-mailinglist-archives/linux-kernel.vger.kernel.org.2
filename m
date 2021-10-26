Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B3A43AC66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhJZGtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:49:42 -0400
Received: from mail-eopbgr1400130.outbound.protection.outlook.com ([40.107.140.130]:8514
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233033AbhJZGtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fte9GTixamVU2cSYQExRRqOdz/VNMpriziDlpeJVWml1JB7QTUPx9ORBIrlen3AuE4D0bqlgTegUe9geWyXItA1scY/yGYKlIdUuUVQrZIwnIOp+3TYFwVfylg2UQQ0eR8cpMgMgnFCzSwJ2Ss++D1zGUJtYKRYsHFflxusx1tkduditF18+DNQYYECCpC5O0aQqflTN3fG1ggZ1WpFiYLGnY+tFa4hJunaU54xRoedjI6bB1PH8HWiJHw1pSMWNsB2XOdIDZDex6rrDWpM8jvIJmFjgQ1ecL9gv+9Qw5AcvT+NE/fbmCSU+Bt0e9PqJYCxustj2WP/l/vGj5m1fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1Y7XvKR0qNJRCxNnG8PpiRDKpgtgZMTu2n3vSIvzFs=;
 b=FhL2qxPBbbHcoRXkydBTwlclLbW4fsbhKz0lVISdmUvA0el1x2JIafFARttYB5zSKNbHRJzqt2R24jwP5znsu5bpcpzNX+bJmPhID0VY5qenuFQD59UG9JvLLu36d4DMljwYlQiW8828CIwus89JUAzn5GUSzeLHEl9vZXSUZCctOdMaOZJTbZP2gn9IW8LUnfm55gKuLceY1/lwG3X1TOvC44o+ioozMrfLjrlidIxPdmQIrnKMsLsgxm6HBCCHs6pAkbPwUE9X0wDKaYP91ScYZkVJU1mxE3ASQZ6iAuMEWaDGj+3CXo93iBKDdF93bHVZCLeNvAtLlvSJspTZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1Y7XvKR0qNJRCxNnG8PpiRDKpgtgZMTu2n3vSIvzFs=;
 b=Dv9BfzezlCVTxxYgdadBsZH9BYNDWWclmmCTiL75JSCKWyHIiNLplYHeTfN7SaJ9fbQggrmHjAAV5Xvk0HQn8gtJiYy6SP438z9Yudj/TMychR20F4gJZxZ13inxrnZvZcsIBC/Fn+nxAW9owso/d1i9DlXE6/gQlsXRYx9ClT0=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1332.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:bf::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Tue, 26 Oct 2021 06:47:15 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 06:47:15 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/clk/sunxi-ng: suspected missing null check for callsite of
 clk_hw_get_parent 
Thread-Topic: drivers/clk/sunxi-ng: suspected missing null check for callsite
 of clk_hw_get_parent 
Thread-Index: AdfKNUoa0glysWrhRPmS8LHgDDJ0YA==
Date:   Tue, 26 Oct 2021 06:47:15 +0000
Message-ID: <TYCP286MB11881B25B95E38A0673B3CA78A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none
 header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30ce4c9d-f945-4561-c67a-08d9984c7254
x-ms-traffictypediagnostic: TYCP286MB1332:
x-microsoft-antispam-prvs: <TYCP286MB1332F9B56A6252352935B7B48A849@TYCP286MB1332.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bGAMwz3WobRSxwIkt7TPJCH2OkUuIuHSlZLsryt/h0ZC6dVvSFkCVzbxrWPFkfXGQkbkV8rgpRCXS5YQbjIzZ6cVu8D73lJL7v3E9e2QmHjcxTTdOIiRB986PiO7eyzmsdsmJOLsDr4njOQaifMmL5GwTIHfOz9dd7QkACBXdUvy6Yopz8fAf3dkbN/FPKuuI7sElAhvcMDDgNUsD/MqsENYYNkW6qtMkUMVsRpvWq413exV4NxdhyqAbbMoEBXW+pPxJofxkYH8K8B4f//H6R+yAEz5LEbMIYGuUTor3UiOROsz3iL7N9Nbg07x9QN8FIlSuIlDlFGYi/78lrv3sBLl51RN5bT9MtDhF5/p+GgFIDkQFtO5DBHYSCz5/9Rm0YaD4ZaiNryvz7mEEvbRlYCRUnAnYWaznNvI3fAB8o3ujGTdCskwu9cC2zmzbIQdb3EISce7rcbcflELyi9SkwNPhxpt7KclTHtnx6T3WfIcf4hUnl7cGMZ5/rUUAh77z7fW0SPEKZTGR6jhClIuxDxz6H5h9SUtn14uPLji58rrbnqkw7yVc1lvqdNy+zyhCUYGaWFxgvZLUZOnQmKqbzxGS409ImDy1lJob5vBTup6abDIAMKWPw92Sf2GUUwTesRZex64jLkYFz2ehkjY7cXmLhS9pY/UCj4NOiin3i5shqOrvc704zzSVWKs5vpkEvYv1+bJ1Hs6LLc5WFJl+SQI+kHqOSDlsNBQjeKWZD19SvibctylOAZSADEqQqihMljN4LLAZyvp0c0d1PKSu2sPPzGTmHpkO/45a6Sn7XSR/LmoK3ns2Q9gr3A9fHIiD/TeLPP51281SmAb0+a7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(7696005)(55016002)(966005)(508600001)(52536014)(9686003)(6506007)(26005)(71200400001)(38100700002)(33656002)(8676002)(186003)(83380400001)(4744005)(110136005)(86362001)(38070700005)(66476007)(66446008)(64756008)(66556008)(4743002)(66946007)(786003)(316002)(4326008)(76116006)(122000001)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lJ12cS3+Y5lGoQsmbx9YQRWpa4aEQlLLl+iiHX64IiRB5uMWAD3qvw/CqdjK?=
 =?us-ascii?Q?RrwsiFlv/5efSMS0YptZLk3QNwr5vzfCKf3iUz8tPtY9BK95zmKWneCDrGii?=
 =?us-ascii?Q?pnf/kl3jg8bqTFbuKTu8DLrKr5odytuIMPX73oewYXDvOTFDlFYlJNkbuuRQ?=
 =?us-ascii?Q?4SMbzYPGc9eWxZHtP8YB89IaS5OzAUOtnI/Z1q6dfB+wkoSuyoYptdEegwpd?=
 =?us-ascii?Q?am90ZEMRWN7eqBsUS+mFKsqX3P3NVSWr/8mI455FzgwfAr7GxcymqDsc3oIu?=
 =?us-ascii?Q?aOIiPU+4dto8/TqQ+qoVsRqOn0UYohTAoScLh1afWEa/kKQ2h3pXHO9iFvFZ?=
 =?us-ascii?Q?/8QlfNQ+5xV29uXKhCheSCqYxhdG/dv7LNgMFqpygoaszJlDlF3VHHPfugs/?=
 =?us-ascii?Q?gYfwbZNjUFLwHfAhdtG80HnwaKu85JBc5OrFMIkkPITbK9ytSp5nx64loQxP?=
 =?us-ascii?Q?hj+KJnkfEOxR71Oo16mYRuZPmp/ZeVIC7fW90WvQOPxWlG6JbqEdDiJBrRwy?=
 =?us-ascii?Q?aKFoI0gF28xUhJCGhKiKl0EwCXU9pgVhRZ73IdoV/S8B7c3xU/prC+Q9lJhg?=
 =?us-ascii?Q?4asf+5Z5vX7Uc9Tvb2+dYYJfhuJO5clH5wAhp3soB3siGXISmijn5vqgvE7s?=
 =?us-ascii?Q?bTs556I3Sh5cxj3dybH0yQ3uMNlg5C2Oret0FBwgMaTSp/F6RfO3/hPcOUDl?=
 =?us-ascii?Q?VtV4Hn3hJFI0BfAZch9/D4frJlhsF3IzV+mOQ7jXsoivL2UYTB6nKZwItnMa?=
 =?us-ascii?Q?mWv8vxHPu2+ZV+QyzEeXNG/f1FmHBC8qygVl/9mb/PbIJUV72xffn/Y1pteo?=
 =?us-ascii?Q?78cSTk2vwrwTXeSAjeyOeB8SHdN0QQV1nTqmvME6c+hbG93YU0EOrTlW5utv?=
 =?us-ascii?Q?g7xAV0dLW1x2tVVjdyA3IcKnhegVcW2/2CgYunFCa1V1JOB0Kn+26k+aFWJq?=
 =?us-ascii?Q?iRaHC3m5CoCrLBxUCMPwoUE9dH0QOLpU9++y+ZIb6rkynGk+XpOUYQnle0hE?=
 =?us-ascii?Q?QQqqZigMVG6RqVYgaESV2UpL+KBkKzGnMvW1SmXVEpCIPUj0BGvpfcvO0W7j?=
 =?us-ascii?Q?FPndGTRDVpcL/Ph5vGPvxApcG4nd8+myJREeaiIGaNGwmpqbkW+mybB8Sfp1?=
 =?us-ascii?Q?UBOQ3DnWfbkzjI77BOz86z0LrfehAPolBxHX6YESKZWN66oVlTj8T36Aqqhk?=
 =?us-ascii?Q?l6RlBCBDBjAWjTvmSLed0aCi5hIV7x7i0fUH/QEwqjJ+k6s8gKgtpwYRn8Af?=
 =?us-ascii?Q?nsMvvTHslRWsCbH6oq/f55yuOg+4/999iNECXgWhULhLbxVFWg75kRXj4RUU?=
 =?us-ascii?Q?R9i7Y7BILftaFTwk5ROK/kppQL+ZfV5AE+drpXRi7prKpb38ukCBH4zxq8eV?=
 =?us-ascii?Q?Mij8hsIU1uYUyqxA2E10mnIS8hZlAOdr9pn1lYQznlpd2Hvm/U3hPkzdhGht?=
 =?us-ascii?Q?ieMJZnap5VWuk6ghbsKVneAYnF+NQLthH38hjJQJA4fwuf1dudUkaV708M4I?=
 =?us-ascii?Q?odHe+sZKIxvL6+Dd3+XzPZtJ4pD9n7rwJGGvhV5RyQ+RkgSSMiJeJB3eegDS?=
 =?us-ascii?Q?PFOBzdRlTgKO6p2leJUfzsstHBc7XaZVsW32Zt1c0WiXHH7/xpqjA/ZgWz6Y?=
 =?us-ascii?Q?w5YMiNQSBfRwHxyWDNAqHyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ce4c9d-f945-4561-c67a-08d9984c7254
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 06:47:15.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRHDfDFEPLymYV1IMFJo7TgRruBuy2BcOa/yDWDiQwlZSuVyveLuNazvQTQWMNHfwyZG6I+O+Gou+cv/hIgj6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1332
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d477=
2966/drivers/clk/sunxi-ng/ccu_gate.c#L101
https://github.com/torvalds/linux/blob/master/drivers/clk/sunxi-ng/ccu_mux.=
c#L93

Our experimental static analysis tool detects a null-ptr-reference problem.=
 It could be false positive, we report this to you just in case.

In these two call sites of clk_hw_get_parent, the return pointer is not nul=
l-check. We are not familiar with the code, and don't know whether it would=
 be a potential null pointer dereference problem. Would you like to spare s=
ome time to have a look at it?

Thanks so much,
Chengfeng

