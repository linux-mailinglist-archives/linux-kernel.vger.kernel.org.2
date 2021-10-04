Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056B742094D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhJDK26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:28:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23786 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbhJDK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:28:56 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194AAjlR019301;
        Mon, 4 Oct 2021 10:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mNJKjMYb0Jo+1+gUzUMWqPvS0qQ7n2rz/eGr4sxycQU=;
 b=Y18CHbNNojWOFjwqVyaGWJrgYGpG155QOVL/VQMhVAqB0ghZ/fO0lmn2lhs2daZouKjX
 qLnJWLYBIlQyqVSmV/KNA2a/nLj1wR4Rdfc+rABnorBo1XV1d2/qCXhakReXCsECa9Jz
 zPcgno7oIOkH2Ov7g43+X+/KfhJ/nN8QzsxS7umfU+UrYXINisvTtyv8UcjJ28lulgEy
 jRRbrYrYc1k41VoIjLjRrPEdI5LXHPLNGneWK6g0Z9lEUWdig0NcKMlyFcNop95AsKix
 Qi8gX6knpNgLgBIw2XtG+gop9n1bdVYgW9la34csBSJ0PRLh2tVPftvQwc+VrCV8lp4l rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bf9m03buv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:26:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194AGapu084935;
        Mon, 4 Oct 2021 10:26:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3030.oracle.com with ESMTP id 3bf0s4p7ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euUqvlXRjKLMHeOp5ADoNN/3s4stD7Glht7+1L9XKE8jJxiNwIu1wcIGpgKifD+Gej4pZM9yyL7glG6lPMgYOVmgfWxeG4IJIq4k7Wpv8fI/HWX2pEa2UH3JXlHuNr+lEl3IzHXeO1Q6nLCmHL7NTguY/gWyrWen/3NfFuagbYwTKYdHccHUNO0XITYcIoUyYldmvRYabGcPkFbQMHJ87TWf86X4hnkdLF+tvBwfPCd4Pe/WG+98y25RtnxAPfkeSDgVswhABET5EDiyYShmWrf+rXUWPr/c+BxcKxQvJA9FrvkqcxMRr0hb5+aoHJjPNpJnWFXXnC2RaPJHbRRFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNJKjMYb0Jo+1+gUzUMWqPvS0qQ7n2rz/eGr4sxycQU=;
 b=SqvU4MIv1gW9XHs1owc+aJmmt5GtJMG3Xc2NjNFaqkeSi1gn1xhZqyMvln6lfwYwVAMsAiqyPsh5Cb/4zsnrADiK1nsXbRGJ9leqXyzBcHR7gK85kqpM4R626q34cJFIiPT9wVAT/n+F6CkGotERRbEQxxEQyiowMz1cgaFvx6w9ZwnFf0RhlGvB3JfvCxcdkxV4lkrScXU7ZXGk5JpS+PX3BTU2KLDQ1giN0wXus/qeZRggl/EHiCD+eqatv4voHLKkdo3S1LVo6EVuhO2ohDVUJZ7iIYvRs85+tOz7oNnCdI84VqnIlXycjYwrtxvnWK5nZjo0dVKOzygAN4ZxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNJKjMYb0Jo+1+gUzUMWqPvS0qQ7n2rz/eGr4sxycQU=;
 b=QgFOCYQDJRnO8icizp5HmFpy/5qLRihuhYlDkU4f7Q6ZYW78PYk39s32/n9m7C2YZ30YJEwIoVQQuXDVb98b0zDcAlk0tmSdrexfHCoCzcgv9LMKB/gNRdvsvShT4yg8un3vZBUA/p81hlQrYHhuXugSGS7vOBdGlRf9j2bRhxA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 10:26:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:26:51 +0000
Date:   Mon, 4 Oct 2021 13:26:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211004102632.GT2048@kadam>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
 <YVKdVCaVwmPG7DVx@kroah.com>
 <20210930214929.GB45822@tom-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930214929.GB45822@tom-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 10:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c68d04-09b6-47d1-2af8-08d987217abd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398A2D367E7995AB27E964D8EAE9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thm0QxcA/sPyqTSxbf9hQl0VUJukKw3KBuJ6LblpcrH8YZGFx8tRaLJJ/SpwPc8CoWC9T2LPpZ2fN20WI/keELZLCUmX4t8PkSRoNpko2bkyN3tQUpI4bn5AGcYooY674nLV6nuJB2thM3awVLINSDAiCoe1GElYkiARiuMg+ckLNiadm4Nu2Uui5omI1WuIUq8p9l5SdMTBOpqEmPw+1IRQPDJXvtyWKUWwFLNs+Io5pq/wKSu/XmeAngJRH6MsH5rK6w20ePIi4GARUoG6KS0EtirBMKABdrrUuoq4gRJsjHlCMuaEs12GB1AmTyLtH3WFC7KSPnkrjr0Po4bN+vTCw2l1PUU2JpvoOlOqPZ2HcixtdmVVutjp2DAGc/W7YMfzZsvnAJh6JBkYKEkWwiP7ZcsRfbF7Kn597KgvHDImn1xq9sPw4HyLtnCE0tkX+xxq9AaY/4l1iTaVS8dr33z/tS9n3fUd9MaZWRmL1tclwgzbmOGq+qHGJNKnwUVrNldlQuUa0nA3zTQeb821xo2xQz0u0sJWpF2CszGX5Xp2A0kUw0ZYRURY37eEemZMUGu7EtDsDiyeEV2fzgA6AwumC1uUqTaoxOTaWIwluq0Z2lUWcp2VOnr3PNwHkNjDDuTX8TS1pf2rhJaS7Ul3QtphKIKfmElJf3H2eM47VJlWd53hZSsQDcewFZn4ZHHNFp9XAiLEw7O9uR+f2+5BVix4wJjCOcvmvSbzRRaJrJ+hh9/4b6nuqVbEZlm4AaE4kMAzJ76sw30uDokJBMatEg4N6ZIWCGrLJjdouCu6BStXksfAAftaZRsYf3GrFhOpj419mzRMvdrC7up+t2ie7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(316002)(33716001)(4326008)(2906002)(86362001)(44832011)(7416002)(6916009)(508600001)(55016002)(26005)(8936002)(966005)(956004)(66476007)(66556008)(52116002)(66946007)(9686003)(6666004)(33656002)(5660300002)(1076003)(6496006)(8676002)(38350700002)(186003)(38100700002)(9576002)(145543001)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Eg6+N5A1lhoW8iiaNwR9GTUnWebcGGSH5s0zDfgDdILz7gwLjkPdxE2b1+T?=
 =?us-ascii?Q?LliiH/GgnpRoxyJy7GHOimnk4aMws0KP92jjDww98YygScgAyOV5V8L9L6Ig?=
 =?us-ascii?Q?sOgZgxC70SlUEItO8gZWfEZvh9tILdaOhJ/q2Bqa+p/dOtKx1qwoErrkYX0t?=
 =?us-ascii?Q?Oo99ArsqInLg393Wrht2m9Ptm5ml50E9q+TZd6g6suD6DULviFB8hRYbkvk0?=
 =?us-ascii?Q?EvS2EkRaeTtys137iqRFdLZX5QX2woc/XPqbrpddYT930iD19IPOljDeUGk3?=
 =?us-ascii?Q?NwbeM+92UWUVx+JIWA2Sccfbe1kbIhseBjvOsiwKiBPYPqFCgooene7lsMi3?=
 =?us-ascii?Q?UuxdHHVshJEeYUJcg6WMUqYXS7qbgrUd95R6oeTTVx5Zytn70awrR5XxAXdq?=
 =?us-ascii?Q?GTCbJFwzaE0dDCa9jHCyT8aZY5io8f+eTDjamZ1efXPcgQSbQc7vF3IA07BT?=
 =?us-ascii?Q?T0IgrV/8/12BQCd0afLPQOq8Hfjic8acrmOKuDw3vsywiqiH7IoVqnSfzgy2?=
 =?us-ascii?Q?cTePFbHQm9xVHBmRUN5DC/ycCtqIol+OUyCGQhZsMgL9A8id5bPLjHuOBd52?=
 =?us-ascii?Q?0YiGFVY0IoXgzGD9/aP59zqqdm5raTUFtGcxKLs/Lb1tKanSEBdDzX4lRi/z?=
 =?us-ascii?Q?RrfBkP7NJ9hYVEq6ynhMt0EbT1gvySaQY9ts1R9trlxoUSa3f79DBG2/ZY9L?=
 =?us-ascii?Q?HK8QTCDc98JTjh68SXFh0APHqqrNIIHv03RQp7bHM4ybjniQdUclHTX2q7/R?=
 =?us-ascii?Q?86fTr05lh5aIaf0J/a+PHkA0b5THfo/hOzSS7rQ/l69d8IF0WGVGUgC0Iju1?=
 =?us-ascii?Q?9V7gkWfz/To+vI/UTdQVVTUGJng6VMpwVDbvWOy/mPbtjMY5utsL2TUBGgl4?=
 =?us-ascii?Q?VHZ7/kqBT70MJrdNkAE4CkkYzQ2wOJQPDayw5s2d5nRkVNjJwQRJJPbEQXO4?=
 =?us-ascii?Q?yC3THXLg8EyHlKjRyR22/8Ekyy4BDHhtcd0bOvKadIsZt9oNyo3rKzgGncIJ?=
 =?us-ascii?Q?elonlpKN1C55Qaxz7A/JzpJDXN6vYAVypeyMmL2EcDAWS6GUcgVT0nGNSE+H?=
 =?us-ascii?Q?iIDXkFW0y7pdYsSsBX3+LbjlK9Nq3pF3ZfWQJJHOHhzOxr2aQVc/hIsLed9J?=
 =?us-ascii?Q?SPXbA+ZF+xmVCCLn8wluX3Qj0uzqjL23OI3TpV4Mddz9L1CPXnF2ShtLFlwM?=
 =?us-ascii?Q?joDa57HcQKQTa+4Dmu65hyxG9gJsjqKw6eDQBkVCRWPZeG6YDVnnXEetnAjF?=
 =?us-ascii?Q?VAFbO3jjaSv4mb+FJdEZkbAk9Ga3d0OhUIbhRG+t7wStjscB41K1vLkyM8t5?=
 =?us-ascii?Q?XyZ/wID+699dTYr6g/QIGfDD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c68d04-09b6-47d1-2af8-08d987217abd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:26:51.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ObSork7CVxlYbFZgRPoJ5M+AxQyjL28UzU0GQX7jSPmAvzi+yFMeBzmD3u6g8rgb//4wlog/HkEmGTkQYSdpHpbhFi8f29yPXB7ZglcyY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=913 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040071
X-Proofpoint-ORIG-GUID: LIdw6L79gxyT5eLTUQwfT8Dts2nD5MJk
X-Proofpoint-GUID: LIdw6L79gxyT5eLTUQwfT8Dts2nD5MJk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:49:29PM +0200, Tommaso Merciai wrote:
> On Tue, Sep 28, 2021 at 06:43:00AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> > > On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > > > Replace camel case variable bShortSlotTime with snake case
> > > > > variable b_short_slot_time.
> > > > 
> > > > That is a very odd variable name.  Why did you pick that one?
> > > > 
> > > > What deos it mean?
> > > > 
> > > > You do understand where the original naming format came from here, and
> > > > what it was trying to represent, right?  If not, please go read up on
> > > > it:
> > > > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > > > 
> > > > That style is not used in Linux, and so, when converting from it, do not
> > > > attempt to keep the same style present here, that is kind of pointless,
> > > > don't you agree?
> > > 
> > >   You are definitely right. What do you think about "short_slot_time"?
> > 
> > "time" implies that this will hold a value of time, right?
> > 
> > What exactly does this variable do?  That might help in naming it
> > better.
> 
>   Is a boolean variable, if true short slot time mode is enabled, false 
>   not right?
>   A good solution could be: "short_slot_mode"? What do you think about?

No.  That's a confusing name.  What is a short slot mode anyway?

regards,
dan carpenter

