Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768AF3DEF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhHCN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:28:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44070 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236336AbhHCN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:28:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173DFM4P018250;
        Tue, 3 Aug 2021 13:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BTb0GNmXH8p//PQ47H7a9V3i+zYn0ZDwjDqJHRSzXrk=;
 b=hde16Cj8wZqNnNKBO2o2o+pYj8bBNM+K6T7arsy8CubmYgmCB3Nm7oq7EmwAtCpnz3FE
 Vv4nBssQvgrc2gnwtMTDGD9UkjClUkwpEdLX9pT1+YkacidmWbW9kfXFX4h3l901/pC+
 ep1GJ5UuO9ettaooajMQRZZPYBep4ef5iUHX7XiPcfx6dKv3XJn5BH4n6M0eGhJMpYhp
 shHzXkopfNpblzLIvi/oGyDMmrzifccGvFx8L9fdZuc5AqxsEklSeLeaKpkDlChBQPRl
 e89JpjclkUYDfzc8q2RIEo1A5GXyfr/cLFQoopL7uHtJIecMx9HeSBnA6z6LRdJldQv7 BA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=BTb0GNmXH8p//PQ47H7a9V3i+zYn0ZDwjDqJHRSzXrk=;
 b=CT3ruXYt+HKn0pT07Owd/xM8HHjOXLf2v9edZ4PTS90WpE9xtViLk//x996MA/h8pS5u
 stE3wYgSh7lIVqoDo22mgubfUZ8IIV/AlcfSqGnUFxHQWxtsEyQADKI6ZQhh7quonSfY
 2DUuTtCzTFJTHBOcaBVRhkEOkI/7PtHod2hMAIwNo8klr+pWqkQQHtRlxbaKHvyOeQZm
 tzUVpIw1YiecT7jifIhpsZPin+7oP9fxUi0BGQ87JbAu2ikTsL0bSmz+f6/TlJNIsbIX
 jzTN9wvqh9RamKXBMDIhczIE0um/rz/m9ziRd4z6LwKiTeKjrjqEb6lfr2YfuUPC/NwK 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vdc4w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:28:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173DFKdn043808;
        Tue, 3 Aug 2021 13:28:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3020.oracle.com with ESMTP id 3a5g9v2ppr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWsKkV/BMWQyj/aGh3dOV5kNiQzk1pPJaqj46DlhED1i3AM9QKPOU/jKjF8pSD6PfJSmfr9T/Y7L1XLK07VmissRhpBF4Bc7lawf6wVQvnuO97a9dU7Mg2RpJx40zKBB2HxDQBgfRXD+4iKBcgqwoiL/oQXyO0BzeiMT+qYhp8JFK56IbvFNIsh0pHHBwgqObwjumNr4D96KVDOoslN/7GLFVsnd8aGp5ZAGQ+ZiyDgYq3kxFiM5KV1GnHHDZ31msDSWuSpacElAt11tlVKY0vqkgpiWQGpwUl1hpDydWfYdkCZSQilLSGZg1NNTR0f4nEIeW60YyikfU5e2LHdzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTb0GNmXH8p//PQ47H7a9V3i+zYn0ZDwjDqJHRSzXrk=;
 b=Zag0M/2iXs6ZhF/qyiRPl0udXaCUNtG69n9/dr9vfvCILSCF7RcrN0O1Rgwt+iCgsAHV4Jrfp0UdMxMtuV91Fx+YCU8/RSRpmnN7Sw+xM3M14P7qM+ea6+x4hLz5OXcPz8Kx4xJm3mXHBPpq3NKxqnUgYQ0RQW/aO6xlJ7HJHsARbf6Gw/knuCDVzJfWpBxN1L149ZpturthCKYM/2wqjeRVEhM7ub6U+g5aoaF0SULlt7NMNL5Jq2SFnGbIFNwMVWt+Deq7nkdTnTnhGZBtgOzpf8W+h73xqeITaGaaWndRjt3H/xc1VetGfF5Aet0QG6SwqLp6RBDq9BfHbsjaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTb0GNmXH8p//PQ47H7a9V3i+zYn0ZDwjDqJHRSzXrk=;
 b=QVII0O7W8MgMyJjiEZL8I9IJuQ+4Z3EI/riHjWGc4aj9sn0K00QuFzBbpSavK3ejaZ/N+7LlRCN9jSZfBZ1h86Hx4b9qjSqjQ92zJYX58psjBbiIG9WIbg8bX0xrTL46Qu+MPh/0DeZALvWI0zYf+7RGJtb69WuqGIu781gQYXc=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4434.namprd10.prod.outlook.com
 (2603:10b6:303:9a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 13:28:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:28:29 +0000
Date:   Tue, 3 Aug 2021 16:28:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: core: Change the length of an array
Message-ID: <20210803132810.GB1931@kadam>
References: <20210802203020.9679-1-fmdefrancesco@gmail.com>
 <20210803061441.GK25548@kadam>
 <YQjgN/Xx5LUYtzz0@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQjgN/Xx5LUYtzz0@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 13:28:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c445ada9-2e41-444d-1ebd-08d9568294a0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB443474226F187488899094C18EF09@CO1PR10MB4434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXa0SCw4L3bgq82ozSfs7OJZYf5udL+Oz/nDtFfRhTclXajeRXT1fmokTDSBM+hJ3dw8USCrQHbIeHeJlGnaHKDU388Nyz7GS8LB6meH7G8RK7qwR07es72Y6b0Q3UtlfWFeQr5lf+XNgx85YSUPXKtUBLVz4liamSBwhbHuJvnssgZnlBrDLeZoRjlMDln299/wQI3ABnk/NRDtfjBSIuOA5+LZLJAqT30HXD+VUZ5Pa3ysmWxhGAkiQiTG1OL49UTd8B1eeFPRdZ5e2uK4QYlfSyA61ZvUsB/+gHil964MpNcwh6HNmmKpq6WAmCiBYjGYtwV/yhofVTIpavvQyTsCq9TcOqjD+8Svbmd6TWbn2PiwQfaqoxIbukz6+t3De6fvR+dnBcLM4lGA5yuUAIrQohqFtyeMkl8olX6+bQWFBEqbY63bsOwaANnwSRATXFjtH3ihMLRSG4fjrxP/pOmZ6j5GTYgW6/A16OFn515xjilir98mQCA96ShdbnKXTUKEXOD0HKkj3ZJfh0iWzLwKeCSkGY/LO/2ai2DDfR0DwJDrQCA1eUu3jVN0fJ09GoRdJRiwrYVzySVVkwGwJpwFvblqv8RBV9udrPtICSiaHRUSpdboYlY7RIB8B0iLImwA/ykrkHaBzbUd8Us4cdGE6DUbKOW20F44y5Nnn2F3OWdLCEr7iLooVwHmeOmjnunYS24cPhsSxO26kqBmyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4744005)(33656002)(66556008)(6666004)(5660300002)(508600001)(66476007)(66946007)(1076003)(9576002)(4326008)(86362001)(52116002)(2906002)(54906003)(8676002)(956004)(6496006)(316002)(8936002)(33716001)(38350700002)(9686003)(186003)(26005)(38100700002)(55016002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jh1AwlqoZYCuca2QriOGgOUJdp1dsZV1AuPQdjWbVf+ZkTlR+yTKlvYGs9H?=
 =?us-ascii?Q?Ka64ZcBnY1AJojjTVaQ5esxDGtMMYfF3iyK5Euc2oMT6w2EZp0lTHJFleeST?=
 =?us-ascii?Q?HOv+Tp+g8cq/KZdsXpeM7vA3FQMf9G+7IzGeSqKuvZ5fyEgjVDOu4x41nQ/v?=
 =?us-ascii?Q?V+mLGgk846/6pw8K8cYqhXFBEaw/JhC6NPGtaK4ToJGs9rtax+l7yylxj6zG?=
 =?us-ascii?Q?84y95k53atuRWt6AeXLaIf9ziXrAYyqMwb19o03EAsBAbcPFHB4Ek+y3bYG/?=
 =?us-ascii?Q?3GHZZCYG5QQX2KV8ZY7YF5j5axbXcFo2Ulr34BziDTqZRZypKlcaBlXEV+53?=
 =?us-ascii?Q?vCOz4BudXiSjF8QiVU/t5HEs4RUV2qsCJ+Tlzwv7EgPKRSUmjj/ra/ULxGyK?=
 =?us-ascii?Q?Y5H1Dk2mBfNBN5HzD4KUphOFF+XnnQBXis/9Qw/PO7uP+Op2d6IXbz5dUj1M?=
 =?us-ascii?Q?9WRc5EbngGhZEskdcqnBNriwgqb+ST62rYgsJEQ1GPUjmNUoPGBBaQm9ZrHQ?=
 =?us-ascii?Q?29lHa19H7pErqE3ldBELh3GSMlttskLI43Y7aYHSxkvWfyEzs1M8CT/DMXNh?=
 =?us-ascii?Q?gwnckF2fDQnLQly+gyft15FXSSMXYuSQ28PS0zyXqFET9CtQqds0nC9jNAdt?=
 =?us-ascii?Q?ulOmIoccOOyQsgt3/MN+Z12yCulkBeAAPIMOPFMbJU0VWIZKgcKl/BUNt4dW?=
 =?us-ascii?Q?jHeUEmX+By9LLFhYXFVdGBPvQ11d1A0xNUtY7dPZinuu6O8fRgX461QzkurQ?=
 =?us-ascii?Q?Iu7LPYbYenPr5QidQEYgiAtuE0r6o+bJDI7WoOlztre1W0n3JuFDJyXE3Von?=
 =?us-ascii?Q?WiCRjVawDYxek/8YESFGH/n7/uwVbI92wxGekqtVrIn8ZV+aDVFuaP5x+dsW?=
 =?us-ascii?Q?s+wCJEnJze2KfpHu3iZ/+t8VJF2YRX4JKmjt1C2qxU8ytBBMu91EFZW8aKW/?=
 =?us-ascii?Q?d2NJuzLXtauZBBZaHeJ5Qm/cF33VcMvQi0uKLLP2rq4uZ5BYBQQvsHv9zWRn?=
 =?us-ascii?Q?S+jzda3qYHzBtIXolsdhD6SX1pjxGVBAMwfaFJgmSlLSuSi+hIRVLfaP7iSE?=
 =?us-ascii?Q?sJlWv+1k51bet1nyUGUmMT93HeV2g6GxnHX19Dt+/pYKr5JSHI6/S0vXkUkx?=
 =?us-ascii?Q?iTTZJnDUcTzXQFrigtdA2TNPWTFy0Z5/+g9E/bshAaNFv/nYOBbhJH0eXDEs?=
 =?us-ascii?Q?FxOzYsoWybNsDX6df2Q8Y+1bHOMl/wtQjX+kjKE0zWfpYCDmGfQpZKCmM34P?=
 =?us-ascii?Q?LmklUmxnyDzqgzuJ4c1SQswYiZLmEkT9yO7VaZLmH9ZluLM/9xxRrJK6cqTI?=
 =?us-ascii?Q?ZC+T2mgCQ94zdA/Zf9OJmDPm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445ada9-2e41-444d-1ebd-08d9568294a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:28:29.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnEN3lAs9OeFT85c7MIPvo+NVRL2REARy3dgK3wGlUlP1lzpEOGp+TCgqiZUU1Q2dnDJiziX931UiYa8Z2bx3Hgur5UC2/2vXho859J0CN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=658 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030089
X-Proofpoint-GUID: bC5meGCvtx1Xe5fTqRFSx5cJod_gfdyC
X-Proofpoint-ORIG-GUID: bC5meGCvtx1Xe5fTqRFSx5cJod_gfdyC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:20:39AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 03, 2021 at 09:14:42AM +0300, Dan Carpenter wrote:
> > On Mon, Aug 02, 2021 at 10:30:20PM +0200, Fabio M. De Francesco wrote:
> > > IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
> > > Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
> > > before the fields of the union.
> > > 
> > > Fixes: 56febcc2595e ("staging: r8188eu: Fix different base types in assignments and parameters")
> > 
> > Ugh...  I really feel we'd be better off reverting that patch entirely.
> 
> I do too, let me go revert that...

Thanks!

regards,
dan carpenter
