Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86853D1669
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhGURs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:48:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64910 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231680AbhGURsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:48:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LIGmeB012970;
        Wed, 21 Jul 2021 18:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8miFMb2/6QrTW11W9EpH4IzYYTzc3oq8+1jrQTw2Klw=;
 b=wToGLaMzjbZtIXT9nYo1mcw4fPKvyheTtNHS3b+w1LWE/EAeWyRqUGICL3JmNLVuxGuG
 XyCIzVnXbU/qP3hzmA4jqYqPgig95OArvM4uBkKWt4rCKMXwKRaGfRYLpUNjUGLD4lyl
 Z5jORwffzJbWRb/jY2KjN3UqLcQCGWk1qeMKdGFJB0MaspbPoOzkKWOMozRNGOYHko5D
 PzR+v8/40nnMhSKtNw4fUBIatykNhFD/6nxzB9mcViGPg20RiNtxUoYwvN+n7i2hIrTI
 8QE6S2622sr51njzCz6n8euCQ0DY1jn0ybtd4nHfpeYpYXcMwgsqNRQRNzMHi9xUhcWp oA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=8miFMb2/6QrTW11W9EpH4IzYYTzc3oq8+1jrQTw2Klw=;
 b=xe4a1bShOvUpwI3DNR81pxECBPXYs3cNbWOZA985l+HX7fwM/kC8ZaGPMqM38mDVbTVr
 bf8AwzMaasm4V52EUeLYSSIw8Yw4X6F3tjqOwF+tfHjMNCVkG81KHHFOeAh3eyqcyqsN
 M9R7J/4yq/V1GNhzD1ef/+pibnlgwAk2FpCjw+Nhe6ea6dmpsfkRM1BEwbAgEwYgYqa0
 IUwpSq6embuIsYcSoYJ+NlGPwpX1Z2+lk0OYhMxySX5WghBNX79A9Z02abAX+VgU+W12
 zxaI0PthiQnH3NffJnk7FmHN/aLgAFDKdTNgorr8MDYDne5JIOqrNHzBwMvFuHRS1nFz fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39wvr8bjhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 18:28:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16LIGYNF061398;
        Wed, 21 Jul 2021 18:28:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 39umb39xd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 18:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOMtJEPqCmasMjr5gIWR0KwyV5bpYATA5+zoqklA7fqN0R/a4iUeR/4yJdSiDjduvgl0rA/TeDzwdsQZjBas/w8pF4iUrCNb5MxKKe/bDKRbp6lh6BIPBlEGe8PTxgoIwrwVwdg1cj2mNCuTOaytjp2EBp5DAko35k2AnPKvMD67kZTGDF+x+9Vw76knAfoxsxKASGGSvkJNm5BbMqb5QIa6ietAZMxWGvOJ1oxaxY51x/BYwPGnB8L0blxbCx8d7qRKT/bMlzZRFvZdyHx2zNl9PM/cOGutEG6DN/NMSxWUrcXjeGLhbLxcfwd+1xZj1VfYriWI5Yj38AsPeO2Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miFMb2/6QrTW11W9EpH4IzYYTzc3oq8+1jrQTw2Klw=;
 b=IvDhXVtSKvMq9LUFMuBysn7mETltagu9zAGcvduCl/+65nxnuRvu0ErQDnFij+BBW8F7JtuuwGcIB9toS/K/aUq5rtjoQx2lu5sv0m/zrUq1rixSLveXRJp0+v8rPJIqI76zlUJZpVYvSxoPxXrqP2GYA9PYfPKDCCB4K/C1Lv8quLLx59FgpCXBaLqtIc77/7HuB523KHSb5CiL42BwJjhquZwSIiE6fHUTvLCwy82Dra+BGjh68wPLChLOzh8BJFxhvy9z/hzrkC9p2CuI4p6Y6p+7RkmoxOPm3VfkdPPDmymLsLzHu3uM/khVP1OvsAFh11Yqw8u6bcRdtL/kVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miFMb2/6QrTW11W9EpH4IzYYTzc3oq8+1jrQTw2Klw=;
 b=y1pYojB0c+bIGV041sjAy5WAdhUBqeh80wvZyDwcOrH56x/8aweRDODCkM+QVZlQIMWMpEkAmGFHeLVCFVex3qN8cSGtA9aILxAofk9l54Nrga9pabQ1IU3zdbIe+WFlxN3/8sycSt4pyiMbPZjoGRUCXcSxd96PLzFcZrsN/88=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4436.namprd10.prod.outlook.com
 (2603:10b6:303:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 21 Jul
 2021 18:28:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 18:28:48 +0000
Date:   Wed, 21 Jul 2021 21:28:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <20210721182836.GX1931@kadam>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
 <YPfRf8dgFd+u5hzm@equinox>
 <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DB6PR1001CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:55::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by DB6PR1001CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Wed, 21 Jul 2021 18:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b81667-e1f3-4e94-4be3-08d94c7561ea
X-MS-TrafficTypeDiagnostic: CO1PR10MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44363CA7D1E3497525037EA28EE39@CO1PR10MB4436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ydLFDPXsVFy/4J/VVUdXkvZptbEt3CK79jrL/34b4iYw4Pa8eaS2wBsa2MTzwCjJjZIo6UwnnnXYWnGSu69TAoxYE6zCjfa5ZDIykrtR7HnU3I69zwkBsXPcmhyqL2Aek8id/xaIHa/SgNxiNo4DfL6ridTcp4pv4j4Uf4Zf9Ms2+1z9urCpBQHVkv1u83QoRUZ4e3WN5zG2I2BXcp4NOiJNoUInTKJaxbBxh0q3FA0+h3TXbLeh3FY4iEtAGxFig4oSJ7uAL58vUhuO/OWdLUFul3F1p2+SWqx4MhzGFRawqesH9ycQzWXQTmEzuI60MkmSqGnna3oOlF0om8bzYaEH2tdTFpizwE+F82Ko3SfTr4R83SfPUynW+Y6bh4tG+VXxxcjZq8Njd7sX8Xb7obIduXkX30qYToLEH73RI8vYMEyBYHztSf0GtsYjoTnGnwxZK9DH6JrBDNyHFzOt2aO19qY5fR8WkQHEAGdu2kObMaskOgjV2vgKDk+ysUBdd39j8lBRJhxm3R/D3HedM9AfnzbOZ8PHxiKi0EqWcYAwU2CVmm1cdqqCyyuMfRYihtSIwE6drhxiiwrQpoQy68fCZYWIPJtqOQ2xq9gg9gwNZ52E2A/AYMocra2qx5+RXd3FQiutV210Czq9RzOUFcPyQ3M04J3Q1IbygIbxdexib2NKKDnMviddUbY5HMhZmWAKbQzcjPmBBhvqxoEzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(8936002)(6666004)(5660300002)(4326008)(9686003)(6916009)(2906002)(33656002)(1076003)(55016002)(8676002)(38350700002)(38100700002)(33716001)(956004)(66556008)(66946007)(316002)(53546011)(44832011)(86362001)(26005)(66476007)(186003)(52116002)(83380400001)(9576002)(478600001)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MICIzxDuf4Aj+l2ik/jwLZmPIJ5DFu23Z4TUvwzaXeyEa0Kwlr8bXYop4bQ1?=
 =?us-ascii?Q?83mn2iy5Y5Gn4jJNeFE78vhv1XJcpQx1A35DOU4Fy3UvT4PcquHMuAwm0SvY?=
 =?us-ascii?Q?+lq4Dv4H+xdJJfUhO0Q4poi8iVZUFu5PCFRJfk14RXwSHbaBUVbBDA048cNl?=
 =?us-ascii?Q?WkJhC8S0tDoselPVYjyB+qYp4lWbzr0cCDrWO/5OUT1UWEKxxW9Y2r+DLrYK?=
 =?us-ascii?Q?sZBa7qg2twINU8m2+x7QVffr+CLA96BVRW+3btoQHatAzJ3Vhy4jsSFxNNjT?=
 =?us-ascii?Q?b+rLo6bFJWVYeeaIW0rtPQrSRNHMlOBe396BQKAAy1LVxKdOasF/NCW+BFUc?=
 =?us-ascii?Q?+R34TcXusLbGcCYQPTQoHGnssra9qJaXCadJdxwj0WoymZXtP3iIlZlI6EMa?=
 =?us-ascii?Q?M+nrtfqYBgMhBWbYgMZtGr9C/Fbe57zJwDp9D6odu83AeEsE6g2ercf4YNKh?=
 =?us-ascii?Q?ONmXukmu+0lUcFMFRUqNaNv5ISmFdxnE18RYf1mCG5kckshaKPM+SIbY09mE?=
 =?us-ascii?Q?Np7DQ071/Lih4aRFWIb13BBZdx7y/44Bn3Jeq82HSy5qvJ11AqH92lEpWpgw?=
 =?us-ascii?Q?pT5NXtaES2kO1Dv/EGEY2j2Aka6dWyV1RB4++BlCcZy8E2WLqZMeMtRCvNxE?=
 =?us-ascii?Q?tgvkb5Aaeepip2T2ssG1iZh0fBtRTePDZZILrRVqPs1WLK8U3T5gO3LbyM/N?=
 =?us-ascii?Q?HRZcCWw/uditZosHImkgLQjmGqZJ68WmiEDiPb/BBIqVi9j7o6VUmbd+PlCC?=
 =?us-ascii?Q?lljG8TWpHwEdAR6OJQbycDHT7GBo8485m6q5K7p+aDB/2NNbB3aQZ8cyLqHV?=
 =?us-ascii?Q?ivacVfaUS3jjXrm5lXu5k/sEmEUK2QEd2wNo7TmktGhKMjaGuVsfHqSZ0BXH?=
 =?us-ascii?Q?OzhwhjjZhGrgZHVTxj1nj3973sWupBNfD9G7wexAgMvL6Iz02pCKa3Hvxpkg?=
 =?us-ascii?Q?ivEBC+2/jYDQWI5clNhgN72qYnRqgVC0R4xKVwC8hrmBjrFX00cLcJDZV77f?=
 =?us-ascii?Q?hKuCQT2lO5KXn8CgtSTpj6+6fuXPyI+ORa1U+jX8lx+faqrbFwmNEV5WrN8O?=
 =?us-ascii?Q?r26cYQj8FaeNS2E39x61Wf0SUoNiphZq7zUW4CEvQ9I6yt5DAajcqvbHAAIg?=
 =?us-ascii?Q?LN8USYt0grnxidSRs6LEeu0+YqnDT9T2C90jfW2KapM8GSa7UIt/ljITE+pS?=
 =?us-ascii?Q?IRe8xDGVLawmTdZUx2vVU7GVZ4FtwELPY3rnOfZ1w+vglGBrGjZbvHBGbioR?=
 =?us-ascii?Q?ZXvsxaDyBnF441PPPjmhn2Uc/XQaTdDi/orDUSOxP5XBsSK2eZMH2rlqYNpg?=
 =?us-ascii?Q?ufGWQvg0AgRIccDO0L2NZhbj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b81667-e1f3-4e94-4be3-08d94c7561ea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 18:28:48.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA9mJhfNX+ZfEQ5j8qj7sTKpkr2RvhmXAYragHLBLvvLB0CO0V+Hjl0kSeZrSV94qHGYBiuJDxxrGjJ7ydCRF2JOrwQ5TpS7nHkvawx4geU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210108
X-Proofpoint-GUID: m-IVPcugX95Qmsmwdh2vc5u13Z4HGRE8
X-Proofpoint-ORIG-GUID: m-IVPcugX95Qmsmwdh2vc5u13Z4HGRE8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:33:28PM -0500, Larry Finger wrote:
> On 7/21/21 2:49 AM, Phillip Potter wrote:
> > Dear Larry,
> > 
> > Whilst I (and no doubt others) are happy to look into what you've
> > suggested, I do have a few questions:
> > (1) Why is the version from github not the one in staging?
> > (2) On a related note, working on it offline is difficult in terms of
> > proving contributions, particularly for a kernel mentee such as myself.
> > 
> > Might I suggest replacing this driver with the one you suggested
> > entirely, so work on it can continue in public? I am happy to submit
> > this and continue work if you think it would be viable. Many thanks and
> > I appreciate your thoughts on this.
> 
> The reason that the newer driver is at GitHub, rather than in the kernel, is
> that I never want to devote the 6 months needed to get it into the shape of
> the old one that I did send to staging. If you take a little time to look at
> the GitHub code, you will see what I mean. I did this once before only to
> have Realtek release a new version with all the old warts again. At least we
> have the fact that this is a heritage product, and Realtek will not be
> releasing any newer drivers.

You're obviously not a Realtek employee, but what are they doing for
wireless drivers these days?

regards,
dan carpenter
