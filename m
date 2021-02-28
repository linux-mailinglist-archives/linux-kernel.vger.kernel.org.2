Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244153273D6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhB1Skx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 13:40:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhB1Sku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 13:40:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11SITScs143579;
        Sun, 28 Feb 2021 18:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qsVNZPFyHlfdXVX8kR8YcQEKuwp5L2h+z8A6XxN+OC8=;
 b=WhZoGngw8rrfahE/S5KuCbaqp10uqgeTkqJ2J7jvuXZafoGBaASiez1wR7PTB8W03tLJ
 06CT2Hacy7RtC8ntKDJY4jeEnSLExuGcL+VP+TPfeoIviXZuadE/6+0hNmDgZhRkOWRX
 axot5lTtC8D4x9aRIrZmh91AknlRAKX1oxRzGhRnewZBs7+JP345/PGWPeecPkJtrOHW
 pU+A9oh5jdpKjMExsttLYEkrV53PT6FumChdjOi+IblxV0qs6yg6PD8vUMHkbXIK7gqw
 FGvo/2fvW1Wfv5865pgnDhpquf3d2Xzm7kLAGbnIdMoijbTaFM/pabckwJAodJncBIir kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36ydgr20hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 18:39:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11SIOri0134341;
        Sun, 28 Feb 2021 18:39:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 37000un3ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Feb 2021 18:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaSIusGXY0Iz7WU4FFY9tdUJiCEUuSIuSYBk7QvTeXhqzVCvw6q9SiO3MFSB6vU2vCd/AlPElNA2KnBNNGvfMVU58vtwAHccPE+/ePN/0FVjpZlHQ3zyAyj2tDJRa14vatySbAwCxinxqtL+CeYcUI3+JaJ/hb/4WBkGaYrmTVeHtvLJu03z+9oFfoo1Eltfmm3hz+c5heNlgWvnYoY2a1CgRvwjHs/wR+otZ2e+eUXmuMODuL01YLUsw/zAN1guKoOkFlrD8L7GOXxKxnGHHlz/+tNehngNabwMGArRIjJG05tPjewc0PxK99ltKwukn63KK/XXwtwiwYYJvojGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsVNZPFyHlfdXVX8kR8YcQEKuwp5L2h+z8A6XxN+OC8=;
 b=mPMvagXbeEOEKPlBkTEnuBe/sdEia8j4E+YMib3ha5C06PXjnw+j5SbJqP2LW9g40nt5kTu6i5KNcc9PnMT8CHJChIEBI1cbYcg3wz5fwUubMXRyG1uFrJL2OR7jiZ6pz/hC1GAT5UgUxoJKm6glXz+P1T8rIXPeWdNvgxYXK0jhfpWv0WiPOPwnh/+EG7XeEfV7Am1bjwYhyppZ/TtcS+DEOAcn6NOlieyLN1FSA7oAA2vpPFCTRL7CF47Jw9FHWJ4D4E2oU/9IoLACEjk4UadG4qBNZPqeXdwPMUc8QBO6aEM+Sg20A73Deq9YdyRGQdxg1h17yuG2LDePC2pXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsVNZPFyHlfdXVX8kR8YcQEKuwp5L2h+z8A6XxN+OC8=;
 b=DIS9gasnUJwZbAvHnQSQX6Oucu1M4ivgsBWlLTZr570B/wnvxU1po3wgww9RRJRaLOoX9Ifmagl+JzS6HlEXBFS3XvFIdt4lxiPzBdFWOlEuZKyLJLgyyDl5GoqN1ZN1tNQsyH0JvNfMfxMK7mThz0e5Eho+YOz1yIcUhbtiVdg=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32) by MWHPR10MB1342.namprd10.prod.outlook.com
 (2603:10b6:300:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sun, 28 Feb
 2021 18:39:36 +0000
Received: from MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c]) by MWHPR1001MB2285.namprd10.prod.outlook.com
 ([fe80::b94a:32db:11f5:d65c%4]) with mapi id 15.20.3890.025; Sun, 28 Feb 2021
 18:39:36 +0000
Subject: Re: [PATCH v4] add support for pci in the pvpanic driver
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
From:   Mihai Carabas <mihai.carabas@oracle.com>
Message-ID: <d35f5afd-6067-313e-ac1f-0d1b23fcb531@oracle.com>
Date:   Sun, 28 Feb 2021 20:39:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
X-Originating-IP: [141.85.241.41]
X-ClientProxiedBy: LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::22) To MWHPR1001MB2285.namprd10.prod.outlook.com
 (2603:10b6:301:2e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.0.254] (141.85.241.41) by LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:152::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Sun, 28 Feb 2021 18:39:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ea51e5-ade0-48ef-9694-08d8dc1832e6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1342:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4891
X-Microsoft-Antispam-PRVS: <MWHPR10MB1342A8BE3D0F7D947A6D61E8889B9@MWHPR10MB1342.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSkyLtOtQnMvZvqv9ymWckde0En2Pih9ih+0oTM8jpNYq1IcHx+yVTOW1WbV5ME+aCkjQocflv2g6wKOtfz5eBAyRw3Bm6SxP1lI1ig8jDkEGvU0BAYHWno4I8vgG2CSOcKvoR27YcgIYjC4XWG89d5bWylf7QPBg2QqLiUsnzEP6+ulfiqeHUZmG9XEMccva1w3N3gi+xG4gR4BDr44+1kaqKF7wJV7iVQ5hukMcCNQd6gsC2+RC3cBaJws+ugixbqW7nfZejA5cxcxKeir1iooOnrOLZ/F5sMZRsskfD3J9/i0sKLdKrzMwn5DBH6OFap0Qcu/shqaG+moBvUNsxniNb9aDDCECl4lqNifcHkMC9bcdfb1L4lxMEvPyZSR13TLEaHdHOk47bcyECiGgnWfpFHQdPV+7SDVg4cC329cUK6WlDZT8MvX4x74UFe2+R7lVzEddYSmXcFdx18uRqZ+xRbDXjSufO+x1Sgmr+l3mcXYZAXcq7h0h1JfiEMDtJN52d9FBPd+EbRY6K4zgtUuYIAKvPcmI/HvKHNslFU/lRpw7qdXVlmpbw9ssnAjx6iNqQd0H+qxgPaxAxutX29X1NR7sZ0zJ7BEuWIaIsJCDeN6aYM8pHind7cuY+nTLvmXJR2qnYbGdSxZ4gNvV+igA2xyiEOKveuhZ+yRUzwjiLYv037vwQX7niqZ6XUn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2285.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(2616005)(16526019)(66946007)(36756003)(6916009)(478600001)(2906002)(8936002)(6486002)(83380400001)(956004)(44832011)(6666004)(8676002)(31686004)(186003)(4326008)(5660300002)(66556008)(86362001)(316002)(16576012)(26005)(66476007)(31696002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWlhU1QvTk1jZ3hob091WEQ5ZnJoRnh4SG9QejZFMjlSY1VpV0thb0lCU3NF?=
 =?utf-8?B?REwyS2lBT09ONXNOeURWNy94KzRpU1JnU0g3RDRTNGhXeWRnZDNlMkZYeEUr?=
 =?utf-8?B?SUxVMlowU0dqUlhmcWJOWW8rTWZvQi9NVVRyTDFiRk9TcmJuMDM1R0Z5Y2RJ?=
 =?utf-8?B?TlBDMGRLYjlhL1JaWEJhNnFsazR5MXlKV1ZISUVNZFJHWDlWMGQvZFh5VFJS?=
 =?utf-8?B?bDNTMSt0NFEzK3RtVjFYMWtEZW5VOE1iU1hGaHVpM3VOeWpxbEQvWVNKcnY4?=
 =?utf-8?B?YWFMZmozSlVDbGUzSW5FWUp1Um82UVZaU3EwMFoxUE5GNW5yUEZSeVV2OW9a?=
 =?utf-8?B?T1NXY0FRNGlrdzBtdlAweDFTb0U2eUhobnlSNkx3TGZtYUo5VmZqN1hzZEVS?=
 =?utf-8?B?ZXRtUWp3UDY3NVphV1JVTGNiYVZOeWZQSGpDZTlCam9aUHRLZld0blpkOFlU?=
 =?utf-8?B?VEFSbmJzWksvRkRTTGtvQWFicmxubWswSS9GMnIrTDNvdzVNNERVQyt3eDdo?=
 =?utf-8?B?SnlncFpMS0pIT05TQnJxWFE5S3VXYXI0STc2R3pSdlNZVWNKOGJOY3JwTW9I?=
 =?utf-8?B?azBIUkRnYjFWOTBNQ0NycXdscGFQSXVaWkxzbi95ZHlCcWExMUxnUEM1Z2li?=
 =?utf-8?B?QmRCdEo3OE9KbUZWOVdWdVlueXE0UDUyZ2U5OWJ1OXNxR0tJdU5TTzh3S1U0?=
 =?utf-8?B?VzRNa0RwNktxcEtyQlJESTRnYTF5aUl1MUZlSDF3bkc5Ky90eHBNbHZuVGEz?=
 =?utf-8?B?OGZ0STFxMzVQZC90eVVWU040NWpvUm1nQ0pScm9MVkpZN3krN0dhdWN6UlI1?=
 =?utf-8?B?R3NxdDYxYUxDdnZvai9xOXFMZEN0c0tCckh6bmQ2aGV5ZGtuajBwRVZncEQ1?=
 =?utf-8?B?NmEvVUJ0cGtubXRLTldEM0xGdHYxZnF5WVJkK3d4OGJ4SVQ1dWRHK0R3Tzhu?=
 =?utf-8?B?R1FQcE5kcDRXOFQyWExkdjVWLytzR28vbkEvcVRFNHZpWk9pS0drSlhodXAx?=
 =?utf-8?B?Z0tocjlMWVhTeUZTNURZQTlCYWlPem5ic3hIOEVGaHNzTDU5VXY5M3c2cVlT?=
 =?utf-8?B?ZmxCbC9aY05zSGdKckR2MHU2UFRwejN3U3dFUVRQdHIySXhUaTZYOVp3aC9W?=
 =?utf-8?B?YzVGcVRoOEUzZ1J3SnZTOEVFVXJOTnNmeDAvVkZlZGhrNXNpdG5qNFVua3dn?=
 =?utf-8?B?WFBuamJncXBlN0lYNndXbURXVThsemt2TjdxMFNUK3lrdG1YN3ZiQ0xOak8y?=
 =?utf-8?B?dFBOTG1kbHV5SGxlYU55YUlkb3dmM3krdHZvMUJXb1B0QThnSUgrZGJLMlZP?=
 =?utf-8?B?RlFLZ21aUWNjdk1lblpjdGN2dzlXWmpEY1pYdkZrMlg5V2xlNDZHUnFBS1A0?=
 =?utf-8?B?a2NUVWRRL2NBd2NsUXh5Y0lBeklZTWJXb3Y0NGJWUGpENG54L0UwbWdpc1Vr?=
 =?utf-8?B?N0JXSElnR1RpZUplVWdxL2ltdklHUDB5UTNKbUFOTCtDcDNYODhhYjZSQXpL?=
 =?utf-8?B?THBnSForem11Mk5LdzYrVXJ2cVUxUmhVOEhReFVCSEduZU5VVElJMjFZMCta?=
 =?utf-8?B?cXN0N1llamowTnl6ekx6bkcycXgrejl0OUxKazAxQ0RKUGdwVE9PZ05zcGsv?=
 =?utf-8?B?aGZ4aW9aOE80eUZGZTVpRWliK0czVlNmRXFXQ29qUi9UTlZuL1l6NU9QOEEw?=
 =?utf-8?B?cm9kYjhhdzBQOTVnd1g3dXZ4VEF2UkZQV1NUMW9Fc1lVODBNMm1ReWpNU0cr?=
 =?utf-8?Q?RPdVaNAFG9ZtqoyK5J/4j5LftbDMI84KfokFwkL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ea51e5-ade0-48ef-9694-08d8dc1832e6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2285.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2021 18:39:36.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra2xp1tD2rETrvsMlcArE3md5TnMGTp6BXU7RJni3zvDRubLjrIGidSmsnc3d8jjMb1JC4QGLUTklXjnXT8lwp7qGO0ihBuu57NmBJRsgZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1342
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102280158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102280158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Any feedback on this last series?

Thank you,
Mihai

> This patchset adds support for PCI in the pvpanic driver. The device already
> got in qemu [1].
>
> v2:
> - mmio -> MMIO, pci -> PCI suggested by Randy Dunlap.
> - group pvpanic-common.c and mmio.c in the same module. The intention was to
>    have only one module and the common code splitted up to be re-used by the
>    pvpanic-pci module in the next patch.
> - add a new patch where add the licenses for the new files (when I moved the
>    code to mmio.c I preserved the original licenses there)
> - properly clean-up PCI device when driver removed.
>
> v3:
> - drop patch 3 with licenses and add them when creating files
> - create a new patch (2/3) which allowes multiple pvpanic instances
>
> v4:
> - fix Makefile in patch 1/3 and 3/3 for pvpanic.o as suggested by Arnd
>
> How to test:
>
> Run a VM with latest qemu which has the pvpanic-pci device:
> qemu-system-aarch64  -device pvpanic-pci
>
> Generate a panic in the guest:
> echo 1 > /proc/sys/kernel/sysrq
> echo c > /proc/sysrq-trigger
>
> Observe in the QMP console the panic events received by the device:
>
> {"timestamp": {"seconds": 1613122186, "microseconds": 141729}, "event":
> "GUEST_PANICKED", "data": {"action": "pause"}}
>
> {"timestamp": {"seconds": 1613122186, "microseconds": 141833}, "event":
> "GUEST_PANICKED", "data": {"action": "poweroff"}}
>
> {"timestamp": {"seconds": 1613122186, "microseconds": 141896}, "event":
> "SHUTDOWN", "data": {"guest": true, "reason": "guest-panic"}}
>
>
> [1] https://github.com/qemu/qemu/commit/9df52f58e76e904fb141b10318362d718f470db2
>
>
>
> Mihai Carabas (3):
>    misc/pvpanic: split-up generic and platform dependent code
>    misc/pvpanic: probe multiple instances
>    misc/pvpanic: add PCI driver
>
>   drivers/misc/Kconfig                               |   9 +-
>   drivers/misc/Makefile                              |   2 +-
>   drivers/misc/pvpanic/Kconfig                       |  25 +++++
>   drivers/misc/pvpanic/Makefile                      |   8 ++
>   drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} |  43 ++------
>   drivers/misc/pvpanic/pvpanic-pci.c                 |  54 ++++++++++
>   drivers/misc/pvpanic/pvpanic.c                     | 120 +++++++++++++++++++++
>   drivers/misc/pvpanic/pvpanic.h                     |  16 +++
>   8 files changed, 232 insertions(+), 45 deletions(-)
>   create mode 100644 drivers/misc/pvpanic/Kconfig
>   create mode 100644 drivers/misc/pvpanic/Makefile
>   rename drivers/misc/{pvpanic.c => pvpanic/pvpanic-mmio.c} (67%)
>   create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c
>   create mode 100644 drivers/misc/pvpanic/pvpanic.c
>   create mode 100644 drivers/misc/pvpanic/pvpanic.h
>

