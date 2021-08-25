Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE3F737C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbhHYKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:41:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12996 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237638AbhHYKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:41:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17PAXmHp001041;
        Wed, 25 Aug 2021 10:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+Po/Sjr0v/AxxvBWnmrVryrCcSi3UG33UvteUjUeMhU=;
 b=MFbXbdmI3/4QGwgLtaRwpgx/Ccd7aLOi7sksoLgsOZOrxTIiG1DusQDgSgHmi7BXZ5h0
 Vwmzgo+4Hl5vhQe1xWNj10/6IfiyrfdplE0Ty3ykIN+T6QeUzWOGIupFvEmNuyD+DkCv
 VlV/SomLw5xh1kQ19+HRL8iwqeeylnbf6Ogg3KaOcv8IIAtFccthRI/VGwkd/Bn7fKDc
 rP39a0ynqgFgIDB7eX0XdNnxhBKE2njDMauf4ODkTuuNnvU+3CdbCgfeaQXSn/puk8cb
 zJN0+HbkThhE0ys8H1LviCPNvwFGSkOUkXJah55n2HZPUmqOaEkeH8xF+h4+lrrpMTNy 8Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=+Po/Sjr0v/AxxvBWnmrVryrCcSi3UG33UvteUjUeMhU=;
 b=jeHTVHV9WHpYdT+wm1N8X2bqO9lXrhR4BhJx/aKuct2imp6h2A2J1HUHE2WSFBqE1fK/
 ZvtMZ1DFp7xPyX1o9ksZC9rSdcZXXPoHWlH6jZdPjzJxA2lIqzQLp862v/WrMeeIIcOI
 akZz3axWbr04GtRc15OvDFjtq3ZphOg09NsJLeFRjTIbXtdqDE7wIu6hFCeDnBid/mR7
 gLnqHthFzszKo1PWHVUYkmNNkO4LwKQg0640p2FAS0qYNgOXNXTDuDPmmDxuyVxb1Z11
 E/AZJJNF2l4k4GovlM/Ebq7wZ2D8EnH9sT8MTWAHGQiVTExckBtDBhhj2tKJwL5eE//+ vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvuakc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:40:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17PAZO85065071;
        Wed, 25 Aug 2021 10:40:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3ajqhgcu09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 10:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv+hXzyZ+u+vO7yXjZjclsIg1WgGXmhgQg05HSbFewrI/9FL18HfO2tFrzWKKFm1jCfh1aRblv2cU9Lbk7oDSmdsBptlcSgOOlVIUurZ/75iA4F2NGRtvfLh3ZQTKJ1aTRH0E0dosAx8vaRI6NVqkhw4G61m5leSiTA0QsUmIq8LiBu+6+KhLEbT77b8bJ7HT21zMgesCL1Udme41m6N2yeEwo6VW4JSPYZotdCVVDp8hLMysLPMPe3ffeNnUkncAyWSid4w8Y4vlNis3V4k1fGIcgt5DIwyenvEsB88yOhQmS+PLizr3oNx9mZr9rHk39YxTVcQXUWKl+LBAOA/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Po/Sjr0v/AxxvBWnmrVryrCcSi3UG33UvteUjUeMhU=;
 b=GZFIvUeeCYyFg2mhbbATcnpsM+fH+Y2VE5xPVCbS7UNS0T/tactIeZ3z6Q2K6K3UBYZOy622q9VcSGgF09QXbYEMsuTlYM7SJo9vS+zDE/slVf4ZKKoNW3i+JurmQdPn5qrmf5NYx9xE9Bl2xaUUwxQPRnrGfaFH0O70A7owfIIXPRrrhP031xORKBYd7PUtz9VyDxFDUAZTkpyUW23U96nKQwy5qfjr2404/zUDAofTb3dpms0i8KEdB6ABp4fN2t/rM4Y31qM6kASrd80sXuG9Fswh/IAIf5aErKvQlh9S+Ji8EsYlyLrmQDAcHXSDKFm7bSdYB7FU4Wo58bAYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Po/Sjr0v/AxxvBWnmrVryrCcSi3UG33UvteUjUeMhU=;
 b=qJtdGJ7tuzMA06ySZtXOLW6YkrgPQNFIXyMQq6I0wig8kv0PSeShpuqJIyO7w/L+flp/oqr2EqHe0VUoufPLdD9q9v76RWJQI1QoDMpmJP8FhCMsx9gHLsSBw72MQJ+cPMuRlj3cA+dDjMvpb+XXH7ygWjA3vrH7r0W3KbVZJXE=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1661.namprd10.prod.outlook.com
 (2603:10b6:301:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 10:40:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 10:40:13 +0000
Date:   Wed, 25 Aug 2021 13:39:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210825103956.GT1931@kadam>
References: <cover.1629562355.git.aakashhemadri123@gmail.com>
 <50439a81aca7ce8c3c97ec1c7247f4cd03f645a5.1629562355.git.aakashhemadri123@gmail.com>
 <20210823084426.yo2mhgbyehkwwz3h@xps.yggdrasil>
 <25d336b5-8008-9b3b-7efe-a82afaea0e98@lwfinger.net>
 <ba4668725f944d12843529f0b0d4a8a2@AcuMS.aculab.com>
 <20210825091921.GR1931@kadam>
 <c5cfa7262fca44abb08f1ec5881fac4c@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5cfa7262fca44abb08f1ec5881fac4c@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 10:40:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650fc806-c73c-441f-cac0-08d967b4b816
X-MS-TrafficTypeDiagnostic: MWHPR10MB1661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1661FFED02D33E99FA367D9D8EC69@MWHPR10MB1661.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOIhlCiOfnrZzyotKlBlf9iKsPoEFjRlBDg7YRIehDgm7IYnKUj5Fp77iZ8oRCItNK+u+63O13IlKVfqUY87few8m0cruHMreZkaT2rq/2uJFG215NhpGtotFrtcO8DYXsyMoSCMFkQ8c3xfWWF27xeRYSatLXqXgCSPwN3n58PYsIFweo3RX+gUBJYaqZAdUlbNYTyW+Uw/1ZEKa4uZAu75oaJO3OY/bpp8NXAjk+b9gYP1QMJwyKh+px8ZR7NOKo5UoNu7G9RFP5JNa/qSp7ZW/HUILE3Fh6WDuBJkcY1fhMxvxIQVWek8T1cldIfrY8gBfo9sVENUK3Ncr3GZo4RqPQpjwzyEu8G6OUEvVGvLx6CJMhLDAbRX7xanTTQZ33Cc8RnKTk/fi1WU72FxYVoT8JPPL0m+ZTL/+ketLreoWllmMfRNJA0UYmDT6SbSkmz7XE0gON+6sLIJ/hV33zSOeJaudj7gSFhPwMGbCnLUloWP9ObrWhrYIfRdiVkzrGl2mUZhiTTSbA7Uwxa5L2LV4u1h0lTx8i5AuVt7BZPC1+8XB8hKy5jAA3NN3+EjChAlITUQnc6bMnk3ER4kKGU8iwpSQhYPdX44C25iU/1MjBGIkfr+ekP6G5D933t9ecoQqELOi1nUOmYoRP3UJxclDz3b1o31GRURvGqYAkZGauhlfWVcjz0RdlkyQeSNQ+pQ/Evq2ZX2cGCyJE3B4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(33716001)(1076003)(316002)(4326008)(6916009)(956004)(38350700002)(44832011)(38100700002)(86362001)(83380400001)(478600001)(9576002)(54906003)(186003)(6496006)(52116002)(26005)(8936002)(9686003)(33656002)(55016002)(53546011)(5660300002)(8676002)(2906002)(66946007)(6666004)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8BMsnyCweH/2U+Np/IkdLBU9NKORqJ7W68LM9oAor891nxoZdqCU8xdYo85a?=
 =?us-ascii?Q?jMctoEHPdngGLGIjWSyYquWPoXETPCONPat7OWEV++W1/l7sX5rHoj+Nhtwj?=
 =?us-ascii?Q?zH98DzpJqGnKBR8stVIRJIPmnp3OzVUzRDv1j7k05VN7mm3Iqz5ph3jQi+bi?=
 =?us-ascii?Q?5QLDb+P4hdKQRsxZs0qswmGX9Aj5Eg+zltk6YHrzmpTaxKzbTpGMneAvac9O?=
 =?us-ascii?Q?6sXyYqZTZsRsrt6jCaclb1sDnqk3uflavBHM4330AXgMPPT6qJJT8DqMI8Km?=
 =?us-ascii?Q?kpp4qYY+hxavaZ95Mwjyyta29aHowQVsMYtdq/xBafaOpBvhvarJKBeGTF6U?=
 =?us-ascii?Q?kJ3AHmBbs46jJA0zMK2cDoffP/QUhs7IT5Vpyp1BbXif9274aEs/7NSbsWnD?=
 =?us-ascii?Q?694QsXcEciRx3FkCWp8pCCx6xLraB9uO+rQrQXq7JHqShiglsxDE33kICLTj?=
 =?us-ascii?Q?VLNwLLPaUjCSUTsHkNzymeee0L5y8JMNNGw5b70IzCx7E6CSOR3Xfj9Y2kK2?=
 =?us-ascii?Q?URp0Mmr3XeBJ13hGf/GIlRF7Wf5yeuyAMu7ApfeG1aSoCIUGTHuM/Pdd2bbQ?=
 =?us-ascii?Q?/NoLlZLu8M65mFDAUMyGtzZCYNiKYBGJlCMeLU1BgNvl2rmNvmqlxkYyO8//?=
 =?us-ascii?Q?UGAAg8Rv4wDQQk4l+qepAlZvuPHUHMR310OPvm+btd+nDzhOv8jL16w9bN2/?=
 =?us-ascii?Q?Yn4D73hiv/dv8zGaeLvkR5AWJtT4vaSCwtC9+8CJmIft2etyku/w32GUDqWJ?=
 =?us-ascii?Q?s4eNscgPLIBk1j/h8tszTV4j+wquyBYlNGb7ZFJF4zmj+9VfhZvmeqOMsRr8?=
 =?us-ascii?Q?aZids7zgM9y+Ygw875vK8O93Maop5JvJcIIilkkH0qlJMdARGy1B7y7O9p8B?=
 =?us-ascii?Q?9qRXPy3sOqls7P7QQC+uaceKRhrSFn+uPCntzdoP4hC7WEpZ+XFreR5BM0oq?=
 =?us-ascii?Q?g8wWLUq9MQWhRlrPMSYl5dNMOS2YqZxaiF9HgrDrxyJKn0RuGJcDG9kjlhk6?=
 =?us-ascii?Q?oPycs81/rZexFVTUapRxzk7u2oCeB3w5xbNfRB9TDCh8yx4Uj4+PPeJ00VC5?=
 =?us-ascii?Q?9hYA7+IKTbENPw7K6g0VFfp/6cqGbHsSh7XZ9MUlfxkNT/XuhIlPwacTVoI+?=
 =?us-ascii?Q?5TIbOqA85y7p6O/E26RC1NDdt627qWU9X3eBC1FiEGuiPinDYcZ04DgmZWrw?=
 =?us-ascii?Q?mZz8xwaul6h+hT0Ay+mxXyTQkCXdDT6VwmNpoxyxN2L5QVggQtlFOEze7fz+?=
 =?us-ascii?Q?t+PzEujJ+9NUQ+NkaH8qyzrDG+Rj/F0GQXysCzRb0fNpyYpnQeq9ev6Qgvxk?=
 =?us-ascii?Q?/EpmnnZp8G0mu85MYlaWJ60o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650fc806-c73c-441f-cac0-08d967b4b816
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 10:40:13.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jd5Goy1sL54fRNnJcyd+gwZ1xLmpEMF0QKhEkRCoMi8L6XuI+QtzZIfpx/kHKJ+Ij6VhyBfqNyAZz9h9QaX/iHBnxEmhGlCa65MCTZJs+8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1661
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250062
X-Proofpoint-ORIG-GUID: leJbAdQPJH9g6Su2ATom-D-OgyMoAp7q
X-Proofpoint-GUID: leJbAdQPJH9g6Su2ATom-D-OgyMoAp7q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:21:23AM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 25 August 2021 10:19
> > 
> > On Wed, Aug 25, 2021 at 09:13:44AM +0000, David Laight wrote:
> > > From: Larry Finger
> > > > Sent: 23 August 2021 15:24
> > > >
> > > > On 8/23/21 3:44 AM, Aakash Hemadri wrote:
> > > > > On 21/08/21 09:48PM, Aakash Hemadri wrote:
> > > > >> Fix sparse warning:
> > > > >>> rtw_br_ext.c:836:54: warning: cast to restricted __be32
> > > > >>
> > > > >> dhpch->cookie is be32, change it's type.
> > > ...
> > > > >> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > > >> index f6d1f6029ec3..f65d94bfa286 100644
> > > > >> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > > >> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > ...
> > > > >> @@ -671,7 +671,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
> > > > >>   				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
> > > > >>   					struct dhcpMessage *dhcph =
> > > > >>   						(struct dhcpMessage *)((size_t)udph + sizeof(struct
> > udphdr));
> > >
> > > This assignment looks dubious at best - WTF is (size_t) for?
> > > I don't seem to have a source tree with this driver in it (probably only in 'next'?).
> > > I suspect it should be:
> > > 	struct dhcp_message *dhcph = (void *)(udph + 1);
> > 
> > Those are equivalent.  Either way works.
> 
> size_t isn't guaranteed to be large enough to hold a pointer.

It is on every system that Linux is ever going to build on.

regards,
dan carpenter

