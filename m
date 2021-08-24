Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB33F642E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239011AbhHXRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:01:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28550 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238479AbhHXQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:58:39 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OGFa7G025062;
        Tue, 24 Aug 2021 16:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=96J0qna43EU2rWrysX5S+AvyGPmLo7FgrLSnF5zzrAU=;
 b=cfWtnY0OmwAvukRzXCPxkRBu4BXyGuNOgm5baTUL0H0Nk64aJuvBOA9pULgYAOMG8dkj
 9OOe1mR8QDQ5NjzGiIe1fhY/Jaux9o5HKu9ayqZel4JuUQjA6aTl33ipL/JIckpnV5IN
 e1kBPqbDRiMPzJE0gkzMd2faKD2AyUDTePY32dFbP9WnE4iCPc2v7PnUZF83vpyLKtfw
 uv/ccTZXIC39RT3kO2DzQ1wXowEKB+UNrjHBkoYNxwckgK6z0KJ1CMtNP478n8/bo7dS
 8QbpisQNALAtWujcB8JDwYi/Y+sbhfi5u5/mLcGq8ti4Lc0VDjugVbnhmrGjs7CGyurN yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=96J0qna43EU2rWrysX5S+AvyGPmLo7FgrLSnF5zzrAU=;
 b=xMWM3lTBhK42Pp9qYypYrrNzuqkryAWtTDyBjAno1aK6JiL7n4EMgvccwS43+Wao11LE
 AjGadXYbTBemt57tMNtiGJmox3kRPITdvbo+cylhj95FHgCdny549RjeBf31c3Hezi2J
 PLv0TwzHrHRQVCTkq9b6U6cs+0kfjlZkBzFedYkkQPjsPfjPedmcH3jVxqRECoTPRwVl
 IugNTk4+X/5byRidiOApdmtiuVMDdGtaCireWgL+Jm4k6SGIJylHPOJvbY6oUijgmW6b
 /fuHQ5zrkauwx/YWDOGmJUDUiQBI7FuEM0Yg5YkRLfry+srfJ4gPPM5k1iXxzVS0JETu FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amu7vsnap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 16:57:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OGpEgT064700;
        Tue, 24 Aug 2021 16:57:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3ajsa5m94g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 16:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghViRtKsdPiGS32RNHRVWYJ03CI7OmwYpIre86E/t8ryBdKzUsI4jdGXL9vdOMnsSFEQr+JOqTAEdaLrPV30BB95hUBvWYOg/ULWnRRIWZc0w5z/k9XwqseuSYr7lFvBktRkSRxyFXhAPSlQhac4qdTVIHHWbomfO4rwZGU1JrZL8gjkTJN+GTT7T3uLupr9nXfkMGqnirgBTOPQH2ag2Z8EDcP3WtHQfR7aoh5EpfIG3sKmN/Z/n0cBDjfxO1MyWiM1DGu0qbZvvzMKnEulR0tHlODvH+3zMlqdr9dtt0zYlFz//qy1CRWZzWRx+2o+GiVovRZ13/q7PTZrxcaBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96J0qna43EU2rWrysX5S+AvyGPmLo7FgrLSnF5zzrAU=;
 b=jvdUfQUorxdRBLmE+bGOZq3lnw1LBouehp9zsBzdUtq3sxgKjfGLaQ37IVJrUkU5MY3XUifmVlF5YCeyFunH66Bv1NsOJ8wC+V93bltwpwBQjbUvmfDpAVsSsQxBEFt+lRCiRwUn0Iu4mhnSLZXOIIBchKCMHYhVOqyWW0v6T91oSM7KyPhNjkVgltCH8+vjdm2JdM5DPjc7XKXdBJWwbRmxBADD3rRlsXyFcDWrMa5K0DzQF9eUazFHrT7LKiMNjAySD6GWMIM+l6ee2z4eHGFVBISaauulbwxfkOvoPincWmttImG7RoKKjYbtNmXQBDX6Ykg1toGM+gNgJpeJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96J0qna43EU2rWrysX5S+AvyGPmLo7FgrLSnF5zzrAU=;
 b=w/1+JvtMeI3npqfb0Vo39N8EVYQLgmPe4rLga5Z+g59rAclUwep1yS5LdUsE1TotcNYxMWudZ4xRpAq7lIWyYGeJhIDlATQXegPT40X2zqE+2xx7/jdumd7+RyYjRG/1zUyzRx6rzyVByYcp1nf660FwH13IBfRqhRGauWVMia0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1638.namprd10.prod.outlook.com
 (2603:10b6:910:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:57:44 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::784c:a501:738a:143a%2]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:57:44 +0000
Date:   Tue, 24 Aug 2021 19:57:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: add checks for allocation failure
Message-ID: <20210824165730.GN7722@kadam>
References: <20210824115236.GJ31143@kili>
 <20210824160244.ruutwl3nq6b5feec@kari-VirtualBox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824160244.ruutwl3nq6b5feec@kari-VirtualBox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 16:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a275ba0-eae2-4c88-e477-08d967204aec
X-MS-TrafficTypeDiagnostic: CY4PR10MB1638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1638535EDF5E2677D1DBF0D18EC59@CY4PR10MB1638.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rU+o6aOHqs+ZuPQAIayI6d8EbEUHzeEQNSSbAeu44JW8yppnnsyEwIdrr5tTDs6svXvgWd1p02/GFb3uExFvvV+V32HwjbMWTapqmeDrk3JdiAhgQ51xvJE+VfMiMXxib/JWV8XrU0KNipAjpRP+WlVw7UVR+Ui/LOcTcqTKPJhPR7dH5f6AmibPVoo1xeKPA+0VnjXMQ7ehPIyJnsdTMO5RJo0o/D00PMrhX7Z5+XlXjaZh3lcsBeDi3yBfcQAuK58WP1aBYDsbF5Dn77aPO171H7kwehLxPnsjc61t1/+nmDynSgRZ8bVa9KhGVKMW7nGKRIs7CP/WvemMIVZq3kWqracPtrhIQNvVmR3jcvBk6L7zQPAE36EDELT4mnumnlbJaKQYH7ppZbczeiZSJzsrULhmMh6QBhYCPiONZvl27FzKb//OBEQHZ1zuBcDJ9GpuEU+MC7HRLC4A6PXEh1Uqn6z3esutS9YUSa+Pp/YeXyTreFyV1tJ4cvbUqnZzo4tt2xpms6XQgLo0tP3wGdy7g3n/oGrhDw/qbZWOGn/3Vo4vbdJS9hdGrgXoMZdJZ+wBIraGNSsDMP1FQ3fWiESRQ/GwozrWngHfF9GEg4gA79jBD1DcSTGtMrvQIvg3pUELkpcBCOH3NOnVm71zIMh1UHd8LqIIiGN0DtI6ZY3OMnfO7uWOBu2V9x5b4wKRuQokRxFeGVjxgBgLiUloZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39860400002)(346002)(4326008)(1076003)(9686003)(6496006)(186003)(26005)(8676002)(4744005)(55016002)(6916009)(478600001)(5660300002)(38100700002)(38350700002)(33716001)(316002)(52116002)(2906002)(86362001)(33656002)(8936002)(44832011)(956004)(66476007)(66556008)(6666004)(66946007)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hE8eEa9vxXBcBz4Nb63lBsRMG3wM6J7u/UdEdTrnWDlUevKfvI0mg1QkJXhI?=
 =?us-ascii?Q?x3hKyZq+CMD2DguVLCA/LuNSDUIJyNhplYodfiRqcexG62qy7teUIA0BoUnA?=
 =?us-ascii?Q?/Z9fCANfhhFKp1xhiXcEmfYu3QLZkoCyRNSnZ5FJWfO9TEIH/hcVJ16WlXwv?=
 =?us-ascii?Q?FPap05eq72KtLxJMe5V62umyYAOhLuGsvVf0RLbYktSuhBMhSUrCHZQu5f/E?=
 =?us-ascii?Q?8+JAIJqPsEske3XCHMtpPpjQ/C8DfZDV4uE5F+rHZR7UxY6ESSZdLaFlPGj7?=
 =?us-ascii?Q?lOrLvyjRIF+TIxewGITWQtV7roT0F5g4Tb8xmIYRFXx0t4XUN82R9/y6Ldsx?=
 =?us-ascii?Q?eapaBUAN1nPGx+2kTf+7EDqfXf5X+a24Skphc7b1AYdoVlqmEh0kA1MP0PLX?=
 =?us-ascii?Q?nXx3toAjsC3gQy167CRpPf/DYCzzjTWefuJa3zLHFPVmLCYnWgOFZ0za5nod?=
 =?us-ascii?Q?oZdTzx2tQzJLOm/LoXm9nVv7nTkILzTpMJVPfT9k28qYSvQEBKSRPLBBaXr8?=
 =?us-ascii?Q?Sd7y1WJssh6pv4Oc9gwOmJICUsb0tEe2IUVq666x83eOSIVWcUmhEcecgDvF?=
 =?us-ascii?Q?nC0yQUPiy85QdzgZgRxjojHieCC//byTfsyQAAbW8rYgWF2j3y8zIzos1E4H?=
 =?us-ascii?Q?Rf5eMISBseJHyt7KBItjwXcSvMH6qhvJMSsNc5rQP8yEbtOvskn4kBA6T2pc?=
 =?us-ascii?Q?AMLvbWEx/FCy9o5nZetMDh+RlYIywMyCBSzfmKEsd7S3ayJTJCpFfoPG7LFN?=
 =?us-ascii?Q?9K0qPzVGU0U/NtN/a1zqhxLrNVBEDn564fMZwlQkMzGs8umoUh1j1iYONwrF?=
 =?us-ascii?Q?fGSUX8M/NkizspfISC5bm5mOEOlk+SR+GuIuis5FnS6PSilKR6pSt2I7lGYc?=
 =?us-ascii?Q?h1S/alxV2KI4s7k1yvhJeQY9+VvgbbZDkRKYFnMBfGDiBAceAGPHljfHf5R9?=
 =?us-ascii?Q?X4vumjHskd/H2OD6hz+AmBAKuPdxik74YqweBc3Qx009jgTFwZeWf+Fdt1dR?=
 =?us-ascii?Q?HnzF1NbgqNqmt7SuJiRIa/G2CaSPvjRiQj3I86LKwa8Sd/9Gs9/469tcVtjX?=
 =?us-ascii?Q?nNnPoY0tO34VuJPunfz6QlTiPxnJ2YiBKGgl8ZOz+IpKJeINWAFTASy96zrW?=
 =?us-ascii?Q?TU1QhWJJrKa3duMNG8MTylfonedIudcym0Ptu9oEJBrlH67zkmXgW5YjlTC+?=
 =?us-ascii?Q?WrtAuBb7WUIWqX6DhEvXe4NeRT8n1eW/UxqzkfRuG0cbUBI2i8bKestYcb8T?=
 =?us-ascii?Q?3NwZHrncAVUS3VFrtlN12rbfv6fcVQ0oG2tmqexVIasdOeuNjwkDT/bZp+gn?=
 =?us-ascii?Q?0F1MiBdzDHtKLYJgsJKz2P+b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a275ba0-eae2-4c88-e477-08d967204aec
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:57:44.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HLT5de/c7YhS/HNu2WH0klZzTGFuahjyQDspWGG5ZnYqF2U7gTL7TxExkLJNwaXILWH2Ppqw/8BLm/QfhD+4cx0AylCwWY+zlOkAosIiSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1638
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240111
X-Proofpoint-GUID: b9lUN4Iyepyl9q6_Q3gtpFRbqsD5RRLC
X-Proofpoint-ORIG-GUID: b9lUN4Iyepyl9q6_Q3gtpFRbqsD5RRLC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:02:44PM +0300, Kari Argillander wrote:
> On Tue, Aug 24, 2021 at 02:52:36PM +0300, Dan Carpenter wrote:
> > Add a check for when the kzalloc() in init_rsttbl() fails.  Some of
> > the callers checked for NULL and some did not.  I went down the call
> > tree and added NULL checks where ever they were missing.
> > 
> > Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Seems ok. It is not easist file to follow. log_replay is monster and
> it should be refactor in some point. I'm certain that many more bugs
> will be founded there. Also at least community does not have very good
> testing interface for this. 

There is a way to do allocation fault injection, but I haven't messed
with it.

My guess is that syzbot will soon start reporting a ton of bugs.  ;)

regards,
dan carpenter

