Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05AE411551
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbhITNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:12:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53654 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237614AbhITNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:12:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KBOOU0000640;
        Mon, 20 Sep 2021 13:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=d1076bRUThm2F7y80nxy5PxzvPy69mHuYJ6XEB7hbYM=;
 b=c7dBWPQZDOLNiP5nsBmzP3oGKuzeG4aMyTTYgpfSw31DYWrWIg/o4GiQnzwhFnhpHW4d
 ZNJZzuhRKfCxTXSUjPmm9wx/WKTY3lkMbrDORZm3OJ3bn8WOgrK13qM7ajdA4ftk+5vl
 CjpPoYZ/7n7b1qIc/8PGHhIPPLBtw776dTdIoZ7JWqWRxpxqV5z1Piw4NXermq7gafl3
 DR6pV0SfEqx9D/C9/RcWH5LWSNC1IB+TwDJFcrCiWBQuYp8p9kyB7kzXGNFLDHF3Y/jK
 aQlCU+/m9hQvcWYIz8yJHp94xxzo7+0lnX3zDubn/QKonAYgkIE9ZqwbbEVgZdd7rrYd 9g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=d1076bRUThm2F7y80nxy5PxzvPy69mHuYJ6XEB7hbYM=;
 b=RxFiNsOADIPi9xFhLJ5IVoGB46MZGsnlfzOTFHUj/SbjL3WSrBAknsEKMyTvecGqpRlO
 tlykVhDvkmkxeCsBxdCZ0IQQzo6bXhfo4xFvndGEpis1AX6c4hXEMbNB1kYHjrwu2MJH
 Z/200XxIHtgUXGzG4/6zfg85FhoKK/ak/ejRvCnXInHDpDGh7Z7kVg7dDyUT/lGOCY29
 MCDEjNe1sSp8sQbfs7Krl/7gcVXVyUbykotXLDRxv2XxFB2wkTOIgkhld1Jy661AI3xw
 otUDpttGE2+pxl57768WrFt8/Gq9tJQ/4mSZPVPVoQ2d+zE3sYH0tUNa+V2qZco+3ETi zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b6426ap67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 13:10:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KD6jua090430;
        Mon, 20 Sep 2021 13:10:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by aserp3020.oracle.com with ESMTP id 3b57x40p25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 13:10:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKZY9WSOoUXPvhqoM0TmmMLGAy57+DzupM+jfmGiY71nLk2fOwos8rY0zyoYZSL2D2u2hOFzXPwXvnITOpzAsO5Q90fzlyBpXg+RFXg1i6FkxGDUmvF4tdohpYyqrnq83kHzsq83gOrAJSSuZm1U4E2a5M4h6YV4JgbS3DJHtVI8ZiERgM+AxWh9b68aId8T18KRrPb4mnVNNRkBdBBRRKdn4vz9FV1muwyl0VJGqXdr2dlq0lxDYoEskGSW4aIBj+l2fGECKVMTwBOzOSmZvY6xuAgLrAMgD/hYcdtKc7iDnx91lMDq/7XS02eF3W1vjN60i+sYi/zI2zN5sucqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=d1076bRUThm2F7y80nxy5PxzvPy69mHuYJ6XEB7hbYM=;
 b=EsE0QvJwzvlRF+4bJrBOulGFP8VdXYgzEGjXhCWC/gBi5ZE9YHs1t10zHwUBSviBKAFqyNUZgTHnD3a2knjL9Znm56iprQyzLLQHSSsaDmRLdCtxPTBbBwfbd6vVdrzE3ajox5ixvZ0luKSRjsGprsbxpykiO7+ZlqWj173oKRuvDIfm+EEb3QnuBnzgHdNOzPpgp5N1TuW6XubYv5KL0SXvZdTjqgl0+eGpv+Df7L/7I+D6Xnp5h0iN8+cpt2+sYK2I8PWlZCczMHm+Q/9+BswpWFCse7bPFd1nyNBE1H9P5Swe0uncMFhVP0wVqf5GGORwIKDvKUzWN66HmR6i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1076bRUThm2F7y80nxy5PxzvPy69mHuYJ6XEB7hbYM=;
 b=jBfgpZ6aU7DC5voY4oUTbGzVZmZy0H4DNR2Q6LPJkrIuqgivHXvrMOMm8IMHoOh+M+ZEEMN1cRHByuvKhuzjGjHDPniF6pySHUkFsVLjye9itXU1P+Jx2yj4Aga0QUs741nqSMkJXxpvTHR8By+EujRv2sf9srO+gp9ZAmQmBk8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 13:10:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 13:10:54 +0000
Date:   Mon, 20 Sep 2021 16:10:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable
 in rtw_read16()
Message-ID: <20210920131036.GR2088@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-16-fmdefrancesco@gmail.com>
 <20210920115647.GR2116@kadam>
 <48009934.f5uHuSIIb1@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48009934.f5uHuSIIb1@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 13:10:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae4d9c5-2248-40b5-0cfe-08d97c3813d4
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55553069351CE71067EB09648EA09@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RjgBLPJMrJVALc9YLgEhou99Gd8s3GxWBnwSGyfBfwmlr8hICLc+EbgZpn829PRfajlutbGqTzsoRZ+UYl/vFnPNzufi1nhYi4okrSO2p9g1mxZBSGkbHo9FanqGd7JXMPZfZ8fHwCspk8sKpOdfZ5GclxqQSNvMjXGmrwaZ8EkmPMECIoEia9KtQLor5Als3uj4YpXy6qYiXe2BNoVzzJcKs/CoZXgyozqK2cY63Ov66HjJgFoBPswwx6EK9IWUCG8aavxLt9sQf53f/ZcmFypSfKCgcJlpDxihfFJh2Df+PRC8LpQZGsWH8oNpF7RCRsezlg44B517FWzs//ISXF5642cVhx7edpUEMUhdNPhdCuPjGuq0sChnAkV+BhRh9IWtnQQWpiiMH0imLi7Uayu7OH+KH/6Qj2/s3qkFofCt+5JT/CrsWO8F10p8FvohWmcvp7TrfhL6k5SXju2rHpZf2/eo0jq+1x741TMkoXqJ3/cBlhLnaicgQCYgB144MOAWxtvjdYZXEx7FHbTbe7gPJOm/G5x5ugvSHTy4LvnyzMzfwvRIZcGB3WbS+UvFyhZ8DuS48/OPnj6K1dbmaJOIE7UwJwto3Os1+C4L3kzG/HCZC2zdDBDctCD5GfWYKIuX15ytemRhgRc8NtRuOf1G6nkWAwcOLsmiCNry/SyzzTMLTU+BmZiaQJKxer8uBvotZDztA2WTWtvjXDQqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(54906003)(53546011)(33716001)(316002)(38350700002)(6666004)(44832011)(55016002)(5660300002)(9686003)(33656002)(26005)(8676002)(86362001)(6496006)(52116002)(8936002)(66476007)(66946007)(956004)(9576002)(6916009)(4326008)(38100700002)(186003)(66556008)(508600001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wT5HJQmZqLrQABMLPLrmWQ7pl5gpZMD0JR7L9NoTaLEN88HSMDqUdwfaJITd?=
 =?us-ascii?Q?x9OvUBu1RPmxY0Hc3fBYwSpS4c4KldjdIdD9dwtjVKfQC7eN4mnYMMQaRSMu?=
 =?us-ascii?Q?smJ6cyB2GoFIs7vix5s9xxWuuS4W6W6iJAd8jsuNltAOzuQsck60/jbsFgDp?=
 =?us-ascii?Q?hhxiTIpyD6EMyF7lcS8/FawGneepMr9ST9JL2iUTADPpOqQZCGjvfPvchgAi?=
 =?us-ascii?Q?8AoOG7Jq3DJtweJlx1C5BQDVny6iCTzO8OYdJWUKpB56xhqMkMpoIECmYFdT?=
 =?us-ascii?Q?O72OCE4uxkfZb14T18wUKRdIFOueVzz6ZEY+17nh9hqLuRCRLnKLaEaBozQu?=
 =?us-ascii?Q?P1Mpo1fqi5uqxebqrt8CnhrbN1TWYrFVCTfct5jvDRd0vxq4ibA3TjvDiNhI?=
 =?us-ascii?Q?Rw7O897ZR9s/Yrqlm+q4x0/AF4XikSbmQtCxWAhpcadMvTguAOVoSIrE2q2e?=
 =?us-ascii?Q?fCa4klxuyOSRHzojzxT3VV650ZFV4dF6Y1jj7Jt7q9v+BoyZdCmO/ztm2Pn6?=
 =?us-ascii?Q?piwh0GNK9UBfMSqQsA/SXJ5rQ6D6Au4TaNOy+bAnY75s5EK6w2ZMuvQYwbYu?=
 =?us-ascii?Q?KYQPz1I+Kdu+gVlOmDdqC1bYOWZPEFkLnDnFeL5b8xrVI6pmKZuoMQat3J6J?=
 =?us-ascii?Q?JKwioo4D1hDmJl9ocjrmaWi52c6Wb5TJUXEKuOAKiwtiEnZN/WY//HbnqY0D?=
 =?us-ascii?Q?LO+fh0LYMt7s/NkxtY9QnVVtCBTS78I0EWqeOC5R+6aKSQWDsGvlPpc77z2i?=
 =?us-ascii?Q?Z2RGlC9bMibUsRa6FYKR8CUmScElEmA8m2CinjxnE6Gg/aqYoMfZ3fMUkZyx?=
 =?us-ascii?Q?+hWqeg1mh+Jtk6LIvLwNsTNnrukzL5FTH6sqWv90nqFou3pCvjK3a6luH6h6?=
 =?us-ascii?Q?DbcKw1Ih2jG7PBzlmG1L/NA0edqo3CKT0/YI1xg8z5KlUDWaJhUIvBFbdh/U?=
 =?us-ascii?Q?1IdV03QpczZKFlWTodNTW5qVhqAI8cV1USvGIVa58dlRsb6SS3Tvk/qryAva?=
 =?us-ascii?Q?2ymQwf8epzDl61N0suZp7eZSZaYc3wA4Vz/rBcQtXsDIsfDwpRRZ4ZXzTJG0?=
 =?us-ascii?Q?hxqP0r37YyRMo6yfVg+choG421MDkA7Ylct+bBM/CaEgWpeFtqcwqVhknnt6?=
 =?us-ascii?Q?UP8EU0QnPfwPVKr1vZUdHdOy17PxUQCzaLUWCqzuslqn4WRm5+4tpxTTizz5?=
 =?us-ascii?Q?MR13KFRWlyrZjgxV1258sz5usTSmZ1BdRjTQT0eLTq4yKKsZpRQ65D+NCF10?=
 =?us-ascii?Q?OhotTYb56eZ14gL5WUCYcylFnJVlKdzzSL4u8zxNywDMfvLDoBQ6Nm3zTu0K?=
 =?us-ascii?Q?+6l6Xng+xK/WuQaQB8e7GD2s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae4d9c5-2248-40b5-0cfe-08d97c3813d4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 13:10:54.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW78avaBbYvo5l2+44tjM1+e6A0vj2r850Mo1QUZsISAojIXWMy1is1QWuA54u56tQBsVdQNW9GZAvNXc35QOui8N2FYAgnqMhM4lAGhO5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200084
X-Proofpoint-ORIG-GUID: GZwbiC8akcheKIuqULyXZlPNeWoPeOWD
X-Proofpoint-GUID: GZwbiC8akcheKIuqULyXZlPNeWoPeOWD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 03:03:44PM +0200, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 1:56:47 PM CEST Dan Carpenter wrote:
> > On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> > > Change the type of "data" from __le32 to __le16.
> > > 
> > 
> > You should note in the commit message that:
> > 
> > The last two bytes of "data" are not initialized so the le32_to_cpu(data)
> > technically reads uninitialized data.  This can likely be detected by
> > the KASan checker as reading uninitialized data.  But because the bytes
> > are discarded in the end so this will not affect runtime.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Dear Dan,
> 
> Thanks for your suggestion about this specific topic. 
> 
> We thought that, since "data" is in bitwise AND with 0xffff before being 
> passed to the callee, it was enough to have reviewers know why we're doing 
> that change of type with no further explanations. Actually it seems to be not 
> enough to motivate that change.
> 
> We will surely use the note you provided. 
> 
> However, since I'm not used to blindly follow suggestions (even if I trust 
> your words with no doubts at all) without complete understanding of what I'm 
> doing, I will need to understand what KASan is before copy-paste your note.

Google is your friend!

Either way reading uninitialized data is generally bad.  The trickier
thing is showing that your changes don't affect runtime.  For both of
these le32 to le16 changes.

regards,
dan carpenter

