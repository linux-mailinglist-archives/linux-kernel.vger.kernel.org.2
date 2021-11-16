Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25244532F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhKPNkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:40:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46018 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232201AbhKPNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:40:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGCw83g025448;
        Tue, 16 Nov 2021 13:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3i+ADeIjk8WnNC2XVNwBzRMvOCXOiMD8JcUjImnyOaM=;
 b=B0iasQLEqXJjP4OXIskUC7BOJoovcnz/YJn3oOBL+Jj/WKWPoN2JK0O23Kt34NJwm9DG
 ml2AoZOQDKyWGCL38RX4rCS6KyksPBewycIiiID5ArDwlJ2INsTeXjX/EeUp9QpBrKQT
 RhiMrd3f2KV58n9uTeljqPVMze+zqCVILOqXs6u4iw5r0tGZnoA2fIcdLsHmNvL8+RfM
 910wmsj9ztkJhe12TREGecnaf6RUqYlXVr/e920g3gGNE1wErE/PI5JkUm4c+wKhcWR0
 2nw/mdsnHMUh5TU3qMHkYrGYohMDA9esCQHeUblrNXOQyOM7cbvw09MFN+ft4wlGRqZl Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhmnskrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 13:37:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGDUDRH188361;
        Tue, 16 Nov 2021 13:37:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ca2fw6s59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 13:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX2ok4TQf9DPC+MosH5fQsSwOQdOJy85c19PhXhZJAbd1QKxKw/62NYht2icVH2QNS9QvCLqbHUzXD10WN0d14hVlrVAZBC1oU50cacrPBtd3Pi3lapcCE5Wq2CoI72HoZapsYCknin/UcYgAp/FEr8KbmH7YAIRn9ecIf6uKGNKnY6p5dhl/pRu7RNuI2OWRhQLx4ncIrGOSwgoLYs8ID8Z8u30r+b95pmy6KUKAJe/P4MP7IiG0KC3N6yrpN34U72DfwTmngq2IJATL7PU5kW1XxURmHkb5G9M/Ig5UkPIxVU9tQ9IVKQhFQoyMx7Cs0qCaeBs2pxAQMUdSQRxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i+ADeIjk8WnNC2XVNwBzRMvOCXOiMD8JcUjImnyOaM=;
 b=BAziGM10NV/9TWvBPjNxPXoKlCjtl+5TbBhBQ/h3N88Xyu2+Cak22O8fLrSUIQiAeclh0p7SgrKC6DZToZmVq5sWzXs1nsisLoIclPal5FBBs1dcNIx1itGfMmhwxHWhvNdTx3PiEpuYTsYM8gQ/M3WO7iVM6JxdmL192ISAzbnqcROIMTYMhn6LjF0aFHd0WFB0YCYjyiCL60UclqQ9H37t0Maoqo0M+or7KB10JPBlyOEHPD19iY8TBghop96y8u96RRd/34D3XAPJ15KKfV3mBk1o9kuUrcPAvVmxJnuYZEnz5BvNWqlCzhTTWqRjKhHz+u5Era2Lcz1ISF7vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i+ADeIjk8WnNC2XVNwBzRMvOCXOiMD8JcUjImnyOaM=;
 b=rDP+qv/bRk14Mu/Df3zErMrNv6+DbZJilD1R+BPq/WuA7vyGZvdehJGVUJ9uJxb98MFi0BpzkxqsSXJyJt35RA3aSa5ZiZ9SWNUNO4nGrtIshdQVKSh+vBVuago3kONP/XV6AajPsNMPzgzxT+k4Mg7Y+Vqf/ieJROiy8s9KnL8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 13:37:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 13:37:41 +0000
Date:   Tue, 16 Nov 2021 16:37:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     kbuild@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error:
 testing array offset 'cpu_port_index' after use.
Message-ID: <20211116133720.GI27562@kadam>
References: <202111120534.jZEya5QR-lkp@intel.com>
 <CA+_ehUyjDVdEe=64WbBihqSQrHeKSHx_8C3pcHctgvWy4dvnJQ@mail.gmail.com>
 <20211116063058.GH27562@kadam>
 <CA+_ehUwbUYc6GBGx1VFfqknWrFTk=Xm7NmMUhbyxMSBE4KdnjQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_ehUwbUYc6GBGx1VFfqknWrFTk=Xm7NmMUhbyxMSBE4KdnjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 13:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b12825-6eee-4503-56df-08d9a906435f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23194D6217274B026562A2B48E999@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1ukTJXS+D734zh2stOLxbsd0wRwjRB0uqg3POxAxvLtILqdVgGnI1wiwZrbB1clFHAkq0AUvHlTWwFgtbqgmaL5kBXXqa+bOL6chVy/RtFaZLlpLXoKFrr2qu2AmD9E2c/LOczAhbwQz92o7PbCdhAke9Tsha3UVXzca3h1OuizGXhwVk/M57podXTIK+m2d3ZxNXKVbjdbWQnvGv1Se7naXX+5Mfq80ct82ZsNbJyBHBI9gR24LWkx2Tk9XstEwzW7oa+rEsgcwyWuoSbnhT13DERXoojkPtneTu6QA6qofLotjWm92zjyVvLiHQO5UTF+XL8eUpGENQEUM5cSxcDYgU6jhfVWY0805W+eQw7KIAjvSGNT97Dh5W/ie5jGcpxoXFuOJNuRP0/9dE2EIfGwjWAlgEytwZcqKzIq4HzZObZ3FZ5K5XUdtL3Z5LLqgwZ0llsWs4lkd0yqmytUawXmoL3wWL3kQxzHcQQ9Z7eaGnCodK4xA0BPjQl6m2DvCz0DWOacIpxUJj4rrnueeJ/KZroNx6Zco5t7SQscAU5aarNCW6AuPWEpuDfsiwnj4ruXFJFer2GkchxMlDwcY9JYNBcDe6ZsVhraW+E7kp2BoVmCsvmioFOhVDWCsKvsZrHFyiBSkaszCFTSJTT04ew57t1HvnVk322GHL7t0F8g+v6xL/oZJel5z9zOIEqTs5AjEIA0kFdtAy6t2S7yGg1mf3cxN24rtbjmJ/UEJhuwLBAlHwEqpUKMwcigcYlkVm9nQYuyYQ72RSwdr0Q03ppFXeSwKxUIHdOl0XvJmrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(38100700002)(956004)(33716001)(66946007)(55016002)(9686003)(6916009)(54906003)(316002)(508600001)(6666004)(83380400001)(1076003)(966005)(86362001)(52116002)(6496006)(33656002)(8936002)(9576002)(66476007)(44832011)(26005)(2906002)(8676002)(5660300002)(4326008)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsRkfXFQJKxTeBdzKZ7dl5J59t269mey5avguAe88VsPBIWNX+MEP/YmKVVM?=
 =?us-ascii?Q?FHHfmKnjYlep2UzCprXhwlhb+/8nuCn1c+jUxFZKXLnKWAF25fncUWtNUA0g?=
 =?us-ascii?Q?RE87tT11jhnxL0VZPgbaiHIhYJmSEHnynzKX1Ys0M37BzwDFA3BDZtkWIvpR?=
 =?us-ascii?Q?arwDTchJuZbF6q9sCSEglDWjTEXJXAZtVP7YIU1AWJXh+7HA6dJTZvkz/cec?=
 =?us-ascii?Q?VmFuHVpa3XF0FcqWVu6EXf80vkDW450pzDCgHB0IpP/YibNtpYT+pmJRwZN3?=
 =?us-ascii?Q?7STgjDcnInBfw1WAGT3+5hcVdtjKkyJySkfahK3dwjvmE7z+Laitg3P/p3Ri?=
 =?us-ascii?Q?X2/SgRFz2gAg6xOG7sDKHhEXg5lAa2t0FbplFRk2GJniKF7j8UYxjV68Miwd?=
 =?us-ascii?Q?kN4STcrWNnOOFI17noI8xvTh8A07VuL8p8q+hXmAsrW2g+XbqOVTNWHIAsoY?=
 =?us-ascii?Q?/BPm994Ch7veQ7qedNnankdLJ2jXkJ5+/TvDvpg8tf4wZIvLElppWrRyXf7Y?=
 =?us-ascii?Q?Iw5kwZUgRL5JeaQ3e4OO5flqGwa5XN7Ibe94UfydGFFlFqJ1+P+ZZwOtsJu1?=
 =?us-ascii?Q?QiOZdjFUj0q0qAQ3LNof4NzimLOhyL7oCdDyBtVYNDc/onsg534grIFQTll9?=
 =?us-ascii?Q?RIDmYO4iE7daqQ/dAbyK7Oy5JVY9T70q+CBLb+Oaouu+0XrOZ7Rqp4ZUcad4?=
 =?us-ascii?Q?Cc0opfiIFNM4EwbuU4DGzLAKkyxbtg/4KUmUob6TUV49CUG73evoWh6YDr/2?=
 =?us-ascii?Q?XKSSXWz89ynZAWOndfdYyGcMw0WjzWUUUI1oRy6QtmSGRG+ePmgPzxqWJ8Oj?=
 =?us-ascii?Q?wPvor3UR/r2dQopN+KrMkU64Q4bGLKu4v5bm0N8x6KZ/GAWN61xDdO+H/fHK?=
 =?us-ascii?Q?jjaY8ch40AjlQDvqsr8xGNRtkne2UNeDtmf4mZP0zZorsoey1Fn2E3R5Tv1x?=
 =?us-ascii?Q?rjwWnWY0UB0rieBNJT+wn0A1KcswgfwfSrqRP8tnHSYWA9cot84KT6CbYb2C?=
 =?us-ascii?Q?5ZyTcsLScMsF4jHvsNBLoRS+bOAtOSkFBhVKYPoGP5xyc6nEOqg+wBCwy5ml?=
 =?us-ascii?Q?LuXuC4Eca9triFfDNqjgwlQDkVT5gD4pRxFbgfFeRLLOO7XXiaqR2gE984CC?=
 =?us-ascii?Q?YbOXik7spAeS1HJInubRPXd+WuCi3KUaeyMgLI1RmHLLa/TNam/7eLKPUnaj?=
 =?us-ascii?Q?skENgE2SWvMBYuafTfbjM7vNEasQw6Rc093mAk7GqVwLqVaLwckJfnrWReb0?=
 =?us-ascii?Q?ccZSdgucS0+Mb0bpVXK15hGfPzFcigBPNbxfWkcDCZcDv1efBx8+QWNAjZoD?=
 =?us-ascii?Q?Wim41ZKAlbJN6H1uvbfh7wi71kdpzHuXzprnopwjptJmODwzEsJLH/xvMIQF?=
 =?us-ascii?Q?LXAdaNechhSzmgq0j9N7UQfip/9W2oBa7nOo14gKdSTwWVAknuCdRfemZ3BL?=
 =?us-ascii?Q?i3PwMMfQopPygjqCxKEla9PLDkuEYVhFAGrh6kXSY8CKBUXjVkO9Fj7S7BGC?=
 =?us-ascii?Q?aVU/fCVeCVrZu2hFfINAP1+9gBSW1j0NrQH1VenqV+9YqUnn6F/rOtom87vZ?=
 =?us-ascii?Q?1gAhMGquMDAn2bycR4lE7D5E8LuIVnQ/Z3a/7l0HpbmjZuWDwYy5z1nQ0NrT?=
 =?us-ascii?Q?MwdDll1eC3xjg4wUOFQuUvJTAFc2NYvkuikdwn4xjczMDNYU9WXsxik191Tj?=
 =?us-ascii?Q?U1uW70Rf/a+73U/CvcqidES5GMw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b12825-6eee-4503-56df-08d9a906435f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 13:37:41.6364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VXn7MXMpfurAponvRH1ze2O505YbygOZRwBu65+tNwBNyLAUaFQDm1dhznx03LErZHdGTybdoWbY/9S/C+GozL4T31/nviHPvYMqV9TjEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160069
X-Proofpoint-ORIG-GUID: R6bZ3FP5NzyMozLP5BnPH3fja7wkpryQ
X-Proofpoint-GUID: R6bZ3FP5NzyMozLP5BnPH3fja7wkpryQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 02:30:59PM +0100, Ansuel Smith wrote:
> > On Mon, Nov 15, 2021 at 07:08:30PM +0100, Ansuel Smith wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> > > > head:   debe436e77c72fcee804fb867f275e6d31aa999c
> > > > commit: 5654ec78dd7e64b1e04777b24007344329e6a63b net: dsa: qca8k: rework rgmii delay logic and scan for cpu port 6
> > > > config: i386-randconfig-m021-20211025 (attached as .config)
> > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > >
> > >
> > > This should already be fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8
> > > Can you confirm this?
> > >
> >
> > No, it doesn't fix the problem.  The check is either useless and should
> > be removed or there is an out of bounds bug.  Checking for an out of
> > bounds *after* you've already written to the memory is *never* useful.
> >
> > regards,
> > dan carpenter
> >
> 
> Again sorry if I insist and I'm 99% missing something.
> There was an out of bounds bug.
> It was fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8 by
> starting the counter to -1.
> The extra check is useless, yes.

Then just delete it.  We don't want code which is illogical even if it
has no effect on run time.

regards,
dan carpenter

