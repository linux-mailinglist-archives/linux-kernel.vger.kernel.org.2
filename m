Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7F23F9958
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbhH0NH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:07:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51378 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231271AbhH0NH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:07:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17RAGddL000904;
        Fri, 27 Aug 2021 13:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=40M9VCybbUCVZvA3GbFsY0nGrHTgSZWghzs4psez2Ho=;
 b=kOm2gQq0lhNVy67HqQ24Z/r4IYDATQbO1lCmFk+3SFoWtreHAMzUP80ctVlCTcj/LtF6
 Jus9dJ0jkWpvMbK+O+uOL5/6PdBGXd14aLxjSPP1N+c0HOhK1uA8PwaMlU++RLPm6/le
 6obWmdv0mNwKJc0ammCly0raAdEI2Mnh6/4skBUGBm2uBLxUYfGVCWwNPd5n+yfGotH3
 VDfD9+cprjZUXcZz0UGkaJN1XkIrMqPoQFVYCFsp9YAa8E9ZifRAfd0dUI0ZgPPAsopU
 x6UurjLdYLXii8YFZwiLRcdetk+cchY+KRldh4TAx8miYcrFBOKs2WDWHBanYPlXnrDL xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=40M9VCybbUCVZvA3GbFsY0nGrHTgSZWghzs4psez2Ho=;
 b=UtULMnz3ggD5nwj1sbkBGrxSPgENxhM+2zYw//SIfXz+gqflgG2jU5BkYUepzi9AjCxQ
 uzq1N7baRJcn1ZKnWAUaC0+s4jJ5MCu19LIiYzvkr/alOna9s1A4siI8hPepHHSHuTf+
 TwmiA108hCV9e4NGxmi+HKVo3o44xDQ9LRgEvTsZlZGL6l6MsXGU2MpfLQeYtTtGHBNU
 kgCTdukLG9CTD/WbJuYyMKnhR7vicJ4Vosf8UbKG/4cWuGOVKls0CClnjvt/hy8q9p2H
 fFkN+6VOgoDWY8Wvy9f5a3nbpvYy1AwmKj0Hkvd8rKsTywbTiRnGItJQxI95ArhRTNQj vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap552bgg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:06:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RD1feZ170020;
        Fri, 27 Aug 2021 13:06:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3020.oracle.com with ESMTP id 3akb923unw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjoG3ApC1AbtmxkbZoCVJnikbggMx/mrzxEZMxQBLnSGcc5pvyuHulgEmTFPiatqMMxfROqIbzozi6V0PkTT9aKcSE5WX8Z3YYNxPtLbdtDiqQ3B011/rxCAlHwOSA79F2ILMbuQY7laeqMQzbG0/XV1J5dU6PXE2kKfCLDFCLbdu8UgdEmz6p+WRr7t6OetUVzvIgtiUVu1hXvxp2wUQqmi5QdMG9qkvFlFe30mI4hv7syit/euTsBG+dhjc4b06euQZOa4YP/NMbvkv5DMYqnAmp7lA3tZmb7hJgga7HQUbKIb+7E7A3cN4xdk6wwja+bJv9Dm5h+g2bcuj1BOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40M9VCybbUCVZvA3GbFsY0nGrHTgSZWghzs4psez2Ho=;
 b=RVMKjUzo91/Mrk1LIGdbLDkrGxn5yLCnpPk6BfPJBT3AedkdEdn/JaqzuJdrqDiHQgKzL1AroA1et0NuUfho9VCLYqo+y/5wcrDPC2aZRVPY1jkL1/DLiQ8o4eYzlYIktqTuUXWMAULM8VYaWrs7MfWpodjlvB37EPnzcO6bbeE6zUelj+WKAsL+RnvfY4w4C27K0YTYz5diVYm4IHrtghQX2OEMDXHs8MyVnkuDctXpLug7ucW+vvMxn8yppD289s1y5UFXzzX+TsSdZzaNdOp0CxMWPCQi9twVIClJBvt7VbuQ+6KoVU3XPY3fx+JZRX8cpM0xDqGD+1IiBRyYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40M9VCybbUCVZvA3GbFsY0nGrHTgSZWghzs4psez2Ho=;
 b=LihKXdRdV5e00ZLzi5lX/9SrVZWrzU7V6AGVtsq9Sin6HUlQlICaeAzq67UtwbNxWAC82eL4KTAhnnwdBA3iXpl8QSMaYpeAH6YVPZTn68fkTBnuiERY4NN65RsYpbVFqCxD/E7RoTo2jRFRtqYpP8mukeCJQNhvgDtwg2AlZVM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 13:06:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 13:06:29 +0000
Date:   Fri, 27 Aug 2021 16:06:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, cyruscyliu@gmail.com, yajin@vm-kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210827130609.GB12231@kadam>
References: <YSfjtZsISLH6cktF@kroah.com>
 <20210827125059.26694-1-yixiaonn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827125059.26694-1-yixiaonn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Fri, 27 Aug 2021 13:06:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456e84ef-afbc-4c3c-21b7-08d9695b7b9c
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2096DBCDEF04E089AC84611C8EC89@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0j8FFHfUacLXc3h/yzuqnBMVkJCXI1KhqZAGd5+w70dGQmZvzCq7KYWxeCOUjUKZNAvcmRMc46nT9gTf4kUen5+4QoCBnflkYRBq9WCf0jg6ZQYedh4qJEfAEwYwfZi5JVBbnZkue+2wisNAE2k5Ebi3Eecj58yvcUaenegrM9DUAwNKrtPQpZKXgVFVklNuE+kTn95nV8JQXuqWFSVVwPw33/JSGMKlVM2PgFenyusyXIFjvzCBNvaOp+0LP2m+2I8npj+W61SS/veB/gEkmCwNDNXMVzzeE7NCdN6CeZNXojnTbpoBR1/9ZzV0IwahwP06Yq2VY3Bg/f91gvlWhKKvcBs+6je2iMiZ4kdwuz7cfj0c7FU7ixnUKTvXqM+yA1JCg9iIq1tU6RtZgrnbaw700ynDdM1HjJs/l5wT8jzpL5jOaESK9rYw9TxUx7ofNXVXbkpUou8YsO8iOHOwRSrqJQGfq9+DtXmiFsoDzbyxF/WN7DeZPs7M+NOZ51u0/Q5dTZiAtHAaYADNcSkNV4UNmGxXxoLSGcDHyS4IdkVjNUmgZB1JpYtfRUvUJuTdtwsXdzGziKHKzeK9pHZVr+rDZUWCnfLqNdBmhrJ1phgiFd86KYI3ZGRlidFdMqATbmUD0Jfvulh0Tf7uqL8Rv+yr7U+PMWysXRFqPlQLRZbww3A1oIrLt6dx5SHadoBBVvDVMfrRScgsS/34XGdamw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(316002)(7416002)(1076003)(8936002)(44832011)(33656002)(86362001)(66946007)(66556008)(66476007)(478600001)(38350700002)(6666004)(38100700002)(2906002)(186003)(6496006)(4326008)(52116002)(8676002)(956004)(33716001)(26005)(5660300002)(6916009)(9686003)(55016002)(9576002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tYvbJb3PPmgJq6YfcyUwryzX0OmfwyfX3FHdYMoJM9Qm6vnZ/yOvgt7jknQ?=
 =?us-ascii?Q?6LQavCz6xntI6h0VhFZlFbTrkBIY3uboNK7oP6DxT7L1k8rIJa6xK9E9Nfuf?=
 =?us-ascii?Q?YFP4gjc3n0mUIt3T317PvXh4OAX35xx4yIcDkNTQeaeC3fbWtq8zLObx9cZP?=
 =?us-ascii?Q?6Uzy3BQjUmZOIVUBrjw9FMA9VK8CDonMiqmyfe0Ltd57QitHYwfUkHsVSoBu?=
 =?us-ascii?Q?4EUvBTDj3cLvuYBYKkI+YS6t6C9aBP5atcsV7+YQ9OPzLuhwYyuxtnZmk6FH?=
 =?us-ascii?Q?B9zO9E68OVi4j2N+q4aNGkvRfJYr3ov4sSUo4jdHBvE/2B9f5W/8fRyi8ZJC?=
 =?us-ascii?Q?ke454QgFSc1T1dgZfzOHHnDW0ag29BcMEyA+7Q32QRTxKZqotAqiXiWOL5IP?=
 =?us-ascii?Q?KGSeYrI6qLhnDM+PGqQY49qnOld1Xqc5X9Hgq/70/6fytKuHWzjcev3lbQPM?=
 =?us-ascii?Q?NGRNE7dkBUP7xA5XjXVgZ8YuXggQ2khjdV7YbLgpx1s+40qiL+emTcOzNLdW?=
 =?us-ascii?Q?RyxfOBotpyrry4ky+9vzmXuBFIMWnQJPmagAvJ26lQVhZOL9Rsm/YmZcC/Hn?=
 =?us-ascii?Q?3nD4QMIUYNQnVXk9QF27W00eiRfAAfyddGggOt1LoPlOc+YBYgpzk4JZJHt9?=
 =?us-ascii?Q?F5ANrX8x8U5G5NUJmjYVcR+YD7veOtO6QG9uIYgjpWeA5aAQKZJDBI5L7FD9?=
 =?us-ascii?Q?dxYTSzA0j313X4wuu30YqEHUvtHHwiGCogu3ULteG4bR+vGL8w9eJw5qWnLw?=
 =?us-ascii?Q?BV/1YcsHp3H4c5f07zktppK+ECuQDUzN1fPfo/w3PY80+rOggPxaVfPPqb5k?=
 =?us-ascii?Q?oYMVefrAXhH1ZxWop9wPGtAMsM/W4eWC9ikWr2Bq/MaqLytcpAdWJTfPt3XK?=
 =?us-ascii?Q?537aFoLjdbBxsBAB1m7kEW/WWcgz6W1tv5hqW7YObjOedqvQujoMK/CsE9ED?=
 =?us-ascii?Q?3XJsohf3VfXEGfAUTOgpH7sYvwtnGaUlXczpNqR1rjxwbSUo8781r6V88jzx?=
 =?us-ascii?Q?Rl1s0YohuOyI00JOuiefMvAophZMKmmRI+PNJVNXWprjxpp/+lrSV1CY4ZpF?=
 =?us-ascii?Q?FCrPxYgtXbMu6RSiDxwsXGRLmKg6CIBcei+1pYZEopHU02bi5fbtkyvLyAj1?=
 =?us-ascii?Q?qGaCCfRG6ph4FtOZSLKz/TzE3ct/3LqL44fxkVpCeDl6R0wfAgVplV49p7XD?=
 =?us-ascii?Q?3MUaJa+FJASlDGdOV/B3vcj4DxkFYY8fNn9JgBdsCMTQdwkySIZ5aFLOyEKS?=
 =?us-ascii?Q?LwFP829XdgklsxppRg8/NGRy/7ImZz9h0SykhhsgBweHkD9mYjGTvtIAdgiw?=
 =?us-ascii?Q?P+U2pA6VIfmd1IOMpOv9qy4e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456e84ef-afbc-4c3c-21b7-08d9695b7b9c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 13:06:28.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr4KgxX0WYpPJyoT99Fyo31GX9WJJ66Wz8swX/u4AbzLhqluGXKOhkE8LcwcEfEBEbnCUfm5RkwierPqPA388sTOS88OsOSYOHcVV6EMUBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=921 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270085
X-Proofpoint-GUID: lNolTqENz2a_me7PJ_pxLXaxcGfPph4H
X-Proofpoint-ORIG-GUID: lNolTqENz2a_me7PJ_pxLXaxcGfPph4H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 08:50:59PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan()
> 
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> ---

This still doesn't apply at all.  I do not think you are writing the
patch against linux-next.

regards,
dan carpenter

