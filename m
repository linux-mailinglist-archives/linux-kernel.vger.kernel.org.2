Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5440AE80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhINND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:03:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41676 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232676AbhINND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:03:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECossS024447;
        Tue, 14 Sep 2021 13:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=U1IuVqNR1EiEUyKFM5fu5nLz2Ag7NEyvTUT7Z8rudGY=;
 b=nDBJwnI958kfKioEXsP+P0kOQBktWoUrOqCFC/5ZTVJBsrW9nW7g2419teDibjk9AMo4
 wV70E0hsXyDnw/MxYFKueIWeovs+CaBsMtm7CkXT43gauWHt3P6hYLGi4g3h1dSokJVd
 5dJLR0IcYwQHCQeEnOdTzyPHHRXI6oryeqcHfJNdu4srIBn7232SJTSdZflkbTViNnPL
 OmAenkZWo/FDJGU5ZRz5+aIxZnRjc4dPfFdGmXUn4bY/nfnkAp+7E201DZquBNPCX2oa
 46jtDap8VTEM/1iLzhr+LW+VWmFEUAhUijbLTp+8HZGw27n14NLiZBLkkEHyK00Yqdfv hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=U1IuVqNR1EiEUyKFM5fu5nLz2Ag7NEyvTUT7Z8rudGY=;
 b=lziYHedxqnBZJMYsRw6ATp5oVgbMUKhM1Gtr6u5jd+52lPL1+jMyT5ZrLAREI3tDlKYZ
 wo5RhKACF6zv7aTAvsa4sdLBThY+7DwLq6tcaK3V9c8xcu5HG7FMf82edTHL5Uclc0eB
 dkpgo1qq6MmJnWke1czeTtZc2kRoivzqH43G9uAd53RJCaImLCo5BCJj2oFZl92HKP1i
 1uRzf7Vd57KCIcOj5w6+ruQ5YJFxv70BmTGweSt+7uApbMMlfJv2XCJo2KD0jOYKV2AB
 FLIq30W6Muzc8R5/7C1Tt/iNTNxeTgK3gFNap8CFGy/zEKYXL/S0iRwR8BI/2pzHJBsP wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg9524-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 13:01:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ED0QrT066252;
        Tue, 14 Sep 2021 13:01:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3020.oracle.com with ESMTP id 3b0m969pun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 13:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmpz55i6GWxMZjamcbvYI3jLldNS+AgdZyoUrO/8d48YjhNIJV58osZzsMJFr+0jnCDwvPr3pLY0kwg9E9xKUaMPclObKZUPJJWPt3Xu+eGHQGEMeiZWnvl22vc2BD/ve7Fvja4pP15MjeyxMUJoR2CYLTtxtrcBekvpLtjRSJ6XQ7PaqzL5V+2L3GjN/WBrnFReDAKWIoEgvreKsfpMxbb30DZSY4s2YUhe/bGet8iQRFyWhk5MXnHZh0ZhbfdtACy5qKDtrQtlaXDtDqZTnqd9PP7P8p/+qvIr9WfKZgqQVNZOZ33urS0Faos4RIjIot1g7r6JjL0LIYBZRi75bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=U1IuVqNR1EiEUyKFM5fu5nLz2Ag7NEyvTUT7Z8rudGY=;
 b=GNspjOpPo4fg2kxbzMlrAXq3XWgfCWXzpIoQS5eOEUKt0Ca6H2DoBPu5A8mwukX8Wnz9Y/8KmTLYnvapGuWvWGpvZZXyTgZo32IN1XCUaTkpEn7aFNGkJZDEDzcEt4rzAYPJdckQouXY3WKdn0fHacfFpsa+bXDj0arHUOaw9VAkZ9QEuVHrHb06hcXNGe3mYwncQwXu7y8aBTGS02FM5PeYx3M+IYIeSxA6l/mvCo+HSJwzoj+/7snb8k7jw7DGQXXDRORtLUp5droCYpSCW5/z5vSy+599Y6+STqNmx9eN58wxQXBhSq5pTN82LjOHk+M5ywL89J0rOmc3IFM/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1IuVqNR1EiEUyKFM5fu5nLz2Ag7NEyvTUT7Z8rudGY=;
 b=t7UALEvaaVw4HuUv+ksnAaGyDBZPg+VsqJfxu0eBvY5tFsCXeRj3TV2t5Sbm//2tVqnzY1+hER8baK0XUxU3+TvPWiOdyCErC01A0xwQiJtZ1yFDrzj0+tgGc7qn3FesY/VmqRd0SgnLXktDucrIYDuWPQEUv7abH5fAhdWVKNM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1488.namprd10.prod.outlook.com
 (2603:10b6:300:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:01:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:01:45 +0000
Date:   Tue, 14 Sep 2021 16:01:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 17/18] staging: r8188eu: Shorten calls chain of
 rtw_read8/16/32()
Message-ID: <20210914130112.GD2116@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
 <20210913181002.16651-18-fmdefrancesco@gmail.com>
 <20210914093258.GC2088@kadam>
 <5747368.884CoaO9ss@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5747368.884CoaO9ss@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 13:01:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d9dd92-980a-4fa3-f15d-08d9777fcde6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB148834E0CE1B092C038BCF558EDA9@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Exvf6yqeUXhtdOv2G3yllxuHc+QzxTYsQcPFtVHubeOCML/AscZwhqguMbAqpFH7traRZgLJmGe8gPbf327nLQa0KlwxEpwFjaSsr1wGJCGtJBWEGCpG2FmcbhuLhriqIsBeeR66pOaowBeLFFalsGuhrXPIZnOHnCX/fyZavZmpms3IXmDQkrFspXfgRsOiNlOLO2slOISYW3lzlCfPHTaURn1We2j6lhvxL7hOtun3UXpDO49qjh190dqe8b6SkRL95kz4iEj5NGCeKw/ibiISOw5Ey78DhBRzyZDNMNWcP0ESHzYn9jYf1nQT3tsxfLVidJ5c0BfkWnVhVISlRtUMw4Ju5+5iJjiJ5FaVkvizx8qkO02SxhHWxH6Kc5ZCpW0pkqneBT5+JV8aQjoysuuyaLOcPRe+LivH1wtw6XAZDwywFuxh+aWUUuSdAlL283W6r+H0vCR4w0R9xvkUaimsffLbhvgFHdkcNmCKslZ6hsT1vw3YGkcjE1tUUWKNMLYa8eAdT6suEX8jrUqlV0EnOwrb0B9WQifXFdGDZ8+0LHUskhyonUKgu7OdtLm3mwiA4/iEjaK2cyQ6MF2VpleDuwgZ4Gkqk0g02jpQvFnBXVDGymkqLpo/atlO//m8hM0RxaqWaTlZNc40NctBJVrK9DolhFxxmKJ3Ajb4WsWiuCPJPOMnqJbnL6ZYCyz30BuXohnkVulp9Qo226DgGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39860400002)(26005)(83380400001)(8936002)(956004)(5660300002)(9686003)(53546011)(66556008)(8676002)(66946007)(2906002)(4326008)(38100700002)(38350700002)(55016002)(86362001)(316002)(6496006)(6916009)(52116002)(9576002)(1076003)(186003)(66476007)(478600001)(6666004)(54906003)(33716001)(44832011)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2h0Ywet+Q9oiBW7rilQHx3odgZrxSTHpXAWE2FzO83Mie2eAp56uzqJSPqP1?=
 =?us-ascii?Q?EFnt0yBudmoyimsqLUCu5iXaBab6fwYL3b2j2En5H1M5gYmNk9EwEqhMSy1y?=
 =?us-ascii?Q?NXQAVLMu+vL5dBg2lMwldh/vDz2tsA6GT3tp/pP6uQks36YBi7qsG/yLDWGN?=
 =?us-ascii?Q?KVF1YqDjDV77yl4mht02sQWyGRYyi9MlKWYIY822G/FYxpFLPeTxdbeaRjyU?=
 =?us-ascii?Q?57krhkMqm8KJeKt2BcmPX0JJByD0MD0UBVUbq7E63+BWdjhk+fS0Q1XC8mzS?=
 =?us-ascii?Q?F2Lylyk3m+8qaIOdC2wdBNDpkPho6+zDZ9BujWE8Ox45ZNbqDi26lL6Yf0e2?=
 =?us-ascii?Q?MsyCt8JKv1QWGNACIBrJL2yQSYWLbH5sWSFK+RD0SRAsl9p6G7wZt1RNHlXx?=
 =?us-ascii?Q?1RP54hxvq/AzNqwhpzgIAOfiBOXiFvRyLJBxWd3NGk3AhYp6l4H6QhKH5dPj?=
 =?us-ascii?Q?WLjvM5/aM05uOCHxWKbRZH9MEF0fgs6zhxeDsOHtFvrmwWs+hdR/Ki02Ap7s?=
 =?us-ascii?Q?FxCmhJfqeAX9+825H63IHk/9z3Z+TxrJSDU8eViKitv5aVaordSZmb6hCgXZ?=
 =?us-ascii?Q?ivInTty5Q4aahEvbJWjMsSr/h5gcHQmbVq55aveg7xfOsDIsd2oO1RXqv5Ad?=
 =?us-ascii?Q?KNEsF73pjZZvG1w2Jb6QlwW7oeC1eAQPDZwtDdvIcuTSjrH9jBN8V91Jccf9?=
 =?us-ascii?Q?CTT2kY9nrd7kr546WY36HlSmO/LuL23H3Jpcs+FNy1zZYUaqKGvgNgtBcZqV?=
 =?us-ascii?Q?lJs7Lu2QZLtLV9JD8at7r42M/8/IllCA7Y55Fk4YwrqJxVFZWe+BQ2OsXJvr?=
 =?us-ascii?Q?LG2NERea34Fjq2NfOZ4sWfxzansWq20zRbyF4lXWQyTx5PRIE/jvMqJVExNb?=
 =?us-ascii?Q?ovdh2OGvReTYbbDUJq5ozq5xgM1S7wyuirRGcdZc4sHUO8hpxWXgD/AMD2Xr?=
 =?us-ascii?Q?GGeH+QH1aUZq6RJIJ2BoltAb2UBNyUuy6/vG/V0CbUo0ml5u2zdIPmSgVsOf?=
 =?us-ascii?Q?5+EvvzAURZ8gczuZzbRP9Ojl8X4Cbfho9zbxH6ggnliILXb/lvQWM4xgRZbo?=
 =?us-ascii?Q?bDsBDuiUplX6Rl4DsVJrxv3PablCtKDqdye6j+O8xre4ZWnDvc0iW/APAHqT?=
 =?us-ascii?Q?6EJ8B5iaXd4yW68Tfmy0Tq3eth6BaKxPNe3KJjTiZuBBz2V7gLODnfz2O0jM?=
 =?us-ascii?Q?O+g9U5ovQzOnXIntsEh0Ysty4FZODarGv3Uisq6FXfKgZeJsSZJaZ6LIdsC5?=
 =?us-ascii?Q?eY2OLZkobnwQRURmxmnX62BWjIvoSABrkXHN+3KYFwfNM1JTeZ0O/E23qEyx?=
 =?us-ascii?Q?8rfFubx5JcspsoaZ14/TFj/8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d9dd92-980a-4fa3-f15d-08d9777fcde6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:01:45.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EW3+Ht92gpjJUvOfWUDBxPZeTQkG2cX7T9cSJxYu5LB3iL97xswsVh9qBxgNxz1MJqumrK1AAohMDwFJ8bbNT9UeQeXjgfl50Rl/djxh/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140081
X-Proofpoint-GUID: smk2AUECnUfHx_ZYyQ8hnAtT6OUQ5KqL
X-Proofpoint-ORIG-GUID: smk2AUECnUfHx_ZYyQ8hnAtT6OUQ5KqL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:55:45PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, September 14, 2021 11:32:58 AM CEST Dan Carpenter wrote:
> > On Mon, Sep 13, 2021 at 08:10:01PM +0200, Fabio M. De Francesco wrote:
> > > +	if (status == (-ESHUTDOWN || -ENODEV || -ENOENT)) {
> > 
> > 	if (status == -ESHUTDOWN ||
> > 	    status == -ENODEV ||
> > 	    status == -ENOENT) {
> 
> This is a stupid mistake and Pavel soon noticed it. Yesterday I sent a 
> message to ask reviewers for disregarding v4 and wait for v5 with the fix of 
> this test. :(

There wasn't enough information in the email to know what issue you had
seen.  I had already started reviewing it when I saw the email.

> 
> However, I noticed that usb_control_msg_recv() might return in "status" some 
> recoverable errors (like -ENOMEM and others); so I guess that the code must 
> retry in a while loop (exactly as it did with usb_control_msg() in 
> usbctrl_vendorreq()). 

I would not add a while loop unless testing shows it is required.

regards,
dan carpenter

