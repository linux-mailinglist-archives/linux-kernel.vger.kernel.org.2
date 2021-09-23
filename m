Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23DF41586C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbhIWGsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:48:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:26100 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239320AbhIWGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:48:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N5q24O017901;
        Wed, 22 Sep 2021 23:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=6qlFNQx/kTxZVBwTpFEZfCEpcgaRNzlUPFD6VwzrzZA=;
 b=YuWLF80IKlars94vlzhhn/uX20+dnIWnLKVCz0d+iL8Y5x+E5Rt/oRllR0flfBjHRuW+
 DMspzbPI5WWtfKWtjVrkm+A2x2OJfKHiZnqNyP4tfslXGPgG45WtOkKa5NSdKvGmQ72i
 H0e2gTXdzXEeXbaFA1qW8Q1toUPGNViO6SSpaCFclklPzTZZjn7A7TK9DWlhfi10PBUp
 ZmeLr7FkVStaGBS5Zmlm4n73BJNO1XuI5zhhYv1XGNMyXNWb4YAajYOIE9EP1bxEfcbG
 UCcH1mX7DOxJsnH/UO5l4c+577iP94Njp01dlZ+4qKMBx3onBVyXU32rEIVfqcDcAKjg NQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b8am2925g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 23:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGKE0bbwL+7x+3Zr5yVoHtR8C+0tDGJe2hKpaePzLReWXZ7boqiY4k0wSfnPI9VzxfHEOkAOwz0ItSpBp/h6xGcgOGqiGdKWtoTUa6jRo1gb1w1Cqs6Pe9JswL/SF5Fzh+8YeJ4blXUElynlvt4NYqsQ/gkxyNekj+IPeURVAh8XJPnd94yvjZUqUIGiu4NM4rBmqMUbC+uJ7ma2T+cNPcmkF3kx0M4VQ2hupVTe2iSAjAgoxz3IhvPjbiJCbhfREwGp6yxVp+Nvy9v1vpiAkLZ8M9f3YqZ6HJpANlpv7HVIdi0y/IdhzHP4nc45AK5cKHhj2vBn4P2y2Li2zuJefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6qlFNQx/kTxZVBwTpFEZfCEpcgaRNzlUPFD6VwzrzZA=;
 b=G/lPathqg9xMWl1RtgneQRjh/lsVnFir0WPey3JYrC2EHyXLj4qwIwfAnTCFg9PS+i4fYxdPHed958B+IwtJX9dicobpn3lKEMuq28cJpSzZHF/XGvyvDlnFYF46V0I2M3gzDkuG+gkRc8O4VSogtg1WlrkzL6MwYLpHvdtMpOFK2kic6eMMySOFPsDZ/31dbKtu+vmAy1INaJk9b9cyMFmPx/UeSW20qPg/b8Z8R9bvOLUeTDmlogktSeJ24+RtpZf12fpkuwJbHHsTSgPdUwBlkwdMonP40Ruc3IxQL5VbCqkohAZxEglaOWCj0U0oNT19+1gi5HAasFhTi31kEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nutanix.com;
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB4924.namprd02.prod.outlook.com (2603:10b6:5:11::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Thu, 23 Sep 2021 06:46:29 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.019; Thu, 23 Sep 2021
 06:46:29 +0000
From:   Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, peterx@redhat.com,
        david@redhat.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     ivan.teterevkov@nutanix.com, florian.schmidt@nutanix.com,
        carl.waldspurger@nutanix.com, jonathan.davies@nutanix.com,
        chris.riches@nutanix.com,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Subject: [PATCH v3 0/1] Documenting shmem as an exception case for the pagemap
Date:   Thu, 23 Sep 2021 06:46:17 +0000
Message-Id: <20210923064618.157046-1-tiberiu.georgescu@nutanix.com>
X-Mailer: git-send-email 2.33.0.363.g4c719308ce
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::40) To DM6PR02MB5578.namprd02.prod.outlook.com
 (2603:10b6:5:79::13)
MIME-Version: 1.0
Received: from tiberiu-georgescu.ubvm.nutanix.com (192.146.154.243) by BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 06:46:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35112846-391f-499d-47b1-08d97e5ddf6f
X-MS-TrafficTypeDiagnostic: DM6PR02MB4924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR02MB49245BCCDEDFABD321E592FBE6A39@DM6PR02MB4924.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VCUprICHDQjexOrwRlThHnSXyKf2bKdzgpjmGONNBKODGpVA1JGT71ZEs7OsNdu2iNvUl8oh47fuH4l85tSP05X1Cbat79ClDpAvgsCHt554oPbpUl02F2TYPafo9PRBrZWQx0FhMlGsK1hQjk4YFLWgETfOmC9TqObCLPMffZemDTLXC1YiFq4ub6O6DgYgBRUhQzjcHrBqHw8QmL0Q9RkB9gZSAmIZPlKgJX19R/GI0eaqsbOy/EQkJlSNx2rymF9bwlUe+wPnbuYXVYyX/NPTNuy8V/FkleBE4YbQ5JyMSKcI01sI1jSFc4pkBxNqPzBCL1qAGhp5gR/3W5Per4VQqtylw6xnuorB0KaCjbiedIc8zKF44Km5AuqXRSBhGuBG1NuLS7X94p7+90tXsm6fbbqdhUFseiedaYlgkrpxC5UMereyoOzJ5e7CrAKiTWt1ayXXaazYoIUwZhI51nnl0I2ZbwOQTUqBaHZNdeJUf2KMnHZmDlvlo0/BuJKCq+9AqQ7ZTzEHlIcDYSRKo5SZUl2dkcWmwYNlPy9LkCaNmCYtgZK1ioIQufvSAllKY3Bh1xijZ/JlE8m8JjRewzdtpOhDoEYom3E/8e/Sqnxou+smaxHPlNkGWudP6JqKrXmZBpG5ZsD/s51ex5UflANXWTSuaH7rKDu44vbyFYXMVzpNy6Xyov+F+Y8ec4lyIOU/qiAz9mS66NP9hvJS0AHn3BpzYhtSXDoNgBWt2U7kZc6URvUr8zhUWa5r/h4kq5R10AQ74ehh4WtQri1tPKmHEjiW5Du+dSYVKtWDvHzKKrf8fpe6LqWH5uu3mpXG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(52116002)(4326008)(8676002)(38100700002)(186003)(6486002)(956004)(5660300002)(26005)(6666004)(36756003)(107886003)(66946007)(66476007)(83380400001)(86362001)(1076003)(316002)(2906002)(966005)(508600001)(8936002)(38350700002)(66556008)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyWkZZmmsgFUuQy+SU0LEe4ySP4YApDy/t1rxfnnalVGlsfVGOf/7dlghYFQ?=
 =?us-ascii?Q?R4t3yW+zqeyuyF4DJKNHbRYc669vCj55SufRFmr3RyNTJ/ujdAtx44OH3FbQ?=
 =?us-ascii?Q?j9XD0hAZJNwzQdcaqe/imJsttlT06Jhk1jWypCQ54NYkKiIvz223MWBipuD1?=
 =?us-ascii?Q?TeR/7AdCWTELoZVdBaIGpMppdpsx5GEjzSJoUsxwLGG5ti98HeYFGeBew83D?=
 =?us-ascii?Q?3ufxE5QMfNmaObr71BKgBThpiVuudhIsYj3bAcF9bP1ML32LmOErRRiAkb9l?=
 =?us-ascii?Q?pHpdlfSZLWvTX6IaBiAV6rcp83aWr7dfjx4PUVBmrt75dgKg9dGfEBjHgBnh?=
 =?us-ascii?Q?Bvmyz9R+121EEiLWvv90e6x/Fj51yLbPw86JMZGSNRkNrwlLNiEsmeMz8s26?=
 =?us-ascii?Q?Feu3qp8qHVbqLL4p/R4UU6+X7MFnZHuGv2UYQGVEH6zwo25v1fm/5bq14lFB?=
 =?us-ascii?Q?+n5JP1IRThuSfjYkpO3yqKVETTLbkOhIVMexzdJntBxUWCMtYU8YCWJnRJhg?=
 =?us-ascii?Q?ki9Oy9b/Ny6gvRqDI0rmxtKMeIVHfwShGFIRSbxLgWPnNhxaCGAsKokRh8t1?=
 =?us-ascii?Q?U/6plpUN4yFzFi21uFZ15MrS7I4q3uXm+N3VjS/kLuZt8LZs2mizY1EHo/FN?=
 =?us-ascii?Q?uyqQodPZVhc2Cm5zhWTgYGvRWFIQEvoRkmswF8NuUcQr7S5fq1yc1Ywq2wkU?=
 =?us-ascii?Q?a6YiuU4JoYN7+DmsFOAaAVaO4jEVpfRWOD4Zkqb2Yt+HO8wELPBC9Ad4efae?=
 =?us-ascii?Q?0i+DuQF4kcCNw+wHaqpkpBKl3/p7pD1kUJaiUHsWgaSw7ICG+dWpQcTfneUX?=
 =?us-ascii?Q?ytAW5pjsoK4jDEZ5F00fox9nw4GuzY8zUn+08S+7ujtx6ZvRjKo9VC+5Nchy?=
 =?us-ascii?Q?PWExSoicQNZBcEgU03l2Ju07AGFj8n/eFk0mxdh6dKT3jYPi+PDFiGjbc+Gt?=
 =?us-ascii?Q?V4scyJIsY22zx3GZq1TraRNomuSuFCkkse79CHvbWg5sHrTbe275OW9yaY3x?=
 =?us-ascii?Q?5fMF/K3RT1cQhfauYMmjFKw+ZAP7yhJQhRjTO4r9V+ynw7VvlMaAu+gm/wyu?=
 =?us-ascii?Q?NNmAvlHIUxHPCnTTLkfPuyY9iL/QU3FwMIdDPivsnPbe3teK73O4CGj4TLb6?=
 =?us-ascii?Q?l/F2EMTssN3BKkQToOaC6OkD7aNbZepFH4I39jaXYY/YBdsWu7bvEQent4H7?=
 =?us-ascii?Q?Ay0G+yCojpAHWgrWuY+k2mz0GaXI3PSeptKKlh6LLzGqDbiSXA3KmDZ133VF?=
 =?us-ascii?Q?WfCQFBjk47JZOptGAqCj5t3to65YRYVuAnXDZ9fhNjdwnBrjoYIZViADfvI2?=
 =?us-ascii?Q?+cb6Vb2of/DYF4zQnr6sXYXx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35112846-391f-499d-47b1-08d97e5ddf6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 06:46:29.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EL5YKXEq4XtBNUWkvb8eYcuk/0oHNCg/XNoNnny7umxtc9eloKspfon2TaV84sZQZ6WeBnffQu9SOhZp2lP+RqoqvBAYHLGkE0MNdNTS+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4924
X-Proofpoint-ORIG-GUID: XQT2luCIjmqByxpPUzq1wOSC9zRESQdI
X-Proofpoint-GUID: XQT2luCIjmqByxpPUzq1wOSC9zRESQdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_02,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch follows the discussions on previous documentation patch threads
[1][2]. It presents the exception case of shared memory management from the
pagemap's point of view. It briefly describes what is missing, why it is
missing and alternatives to the pagemap for page info retrieval in user
space.

In short, the kernel does not keep track of PTEs for swapped out shared
pages within the processes that references them. Thus, the proc/pid/pagemap
tool cannot print the swap destination of the shared memory pages, instead
setting the pagemap entry to zero for both non-allocated and swapped out
pages. This can create confusion for users who need information on swapped
out pages.

The reasons why maintaining the PTEs of all swapped out shared pages among
all processes while maintaining similar performance is not a trivial task,
or a desirable change, have been discussed extensively [1][3][4][5]. There
are also arguments for why this arguably missing information should
eventually be exposed to the user in either a future pagemap patch, or by
an alternative tool.

[1]: https://marc.info/?m=162878395426774
[2]: https://lore.kernel.org/lkml/20210920164931.175411-1-tiberiu.georgescu@nutanix.com/
[3]: https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
[4]: https://lore.kernel.org/lkml/20210807032521.7591-1-peterx@redhat.com/
[5]: https://lore.kernel.org/lkml/20210715201651.212134-1-peterx@redhat.com/

Tiberiu A Georgescu (1):
  Documentation: update pagemap with shmem exceptions

 Documentation/admin-guide/mm/pagemap.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.33.0.363.g4c719308ce

