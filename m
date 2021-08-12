Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69853E9E58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhHLGS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:18:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45718 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhHLGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:18:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C6BPor031579;
        Thu, 12 Aug 2021 06:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=piFDPYX3Rb54OhnpalPfMTL7NE688FnKk+5oCus6Wow=;
 b=GVcfMqe+wcqel8g96FDe/3IH03Uf3EwLqqY803w42ZVYYe0BSYjZ6t467HVpUfxHAy+N
 2uQWDoEYHdWQtMFnUjz4/kdGeyG2bak/4pp5nzU8v9PcD3+CLqQUkTwytpqZhgPPKN6A
 W9Zw0rAPzlLOUc7KOQaDP6B4m1ztjMI5dsOfiHmLii5y0vyUQiy/jUQxebc/4+agN7jt
 3CH/mf66uQXnvcgHoNY+ghiMllbSLePMrxfJHygxJHAnGh81t05brZioeZBUp0hWfnly
 ZAxWjW7WieaiEN0n87wdzwFTh2a9bIn+CwA4J6asPLBC16UhLssv03BmJW7K5YqVPQxh oQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=piFDPYX3Rb54OhnpalPfMTL7NE688FnKk+5oCus6Wow=;
 b=KKkz4EC30kHt39lUhroMensL+pWmY3fYsj+74TnC6xEEI+chXUJsfrtNE4huLXW+kEWc
 kDE6traTXB6xHYVLxs4FS0AWzPq8T1OmZgEFVijd/58Mgf97RV+vFsB4WAgYPUZc95DK
 4JuVAV+cFbS6iE6eRvdh2YIJ/kI4Z0OpBOhKI3xGyZVyo+FwLV+iUINalDg9bmenI2rq
 5m5q1UPdGkKRpiNHE+7qLbajd1SwN5hLuC28vJSgZyCaMbv8a2QRZ2uWsmPD506gVkHC
 n/KqeWZE4rsrQOs4+Z+4mH5BYj140h4xUPsSdzxTEaMESw0+LVA7LGvgo76HKavjyUQr uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwkgbuep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 06:18:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C6GKXI002702;
        Thu, 12 Aug 2021 06:18:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 3aa3xwqm3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 06:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSw/WLdQ8GcLccrMzhqpmWpQbtf8qMbmwA9eGS4uEeLbdxPpJM3wXVIxatFaB6o9NBNVac8tF1TnlgwwnwJhR6UeZegUAkfTwXL1KXZvHX1oR8J1QPvNiEjhle1iOdAzO7VHb0fDOsTjtMnHPZy+IF9QCL7eXbQOf1SoNGVhcoPlA6jd7gDX4PbkdOcDIQ9UBaVVTXpMqdHMIvr/f59IFXDobTiXvHv1+L8BRrH7xpdQUsyHTt51zcjY6HpxCsEVDFhRZxGcJjM/rPlDkeg8swJS912tzT2W2DgOtVNDV3SxaM2U2iGRfk4/fCbYb2QCXXQCUzq5fi2qCOH5mBBStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piFDPYX3Rb54OhnpalPfMTL7NE688FnKk+5oCus6Wow=;
 b=XQdsBK4QxJrKywqKb7nwJ1ZKwlwWKaTrQrmVvDpqNbYkuYZDmbiTR8ElVZhpLUAumv0HEXNFvkyZ4v7Yr7nbIJhBV3buJqCQHO9m8uHxViTQ0uMTezpD325UT/aSa6pFv7sxJtr+PoIvn3c+QoAGiFAfO9I3iycDddhPE/RI+hJvW2nyWlWmVFa48aB0Mq2nZaHag2T3QCF0LlCggXqazgIyp2arVYhU0kDz6onl3IoVMyjd62RE+6+yg7KXE33YXvgz71J4tUzGS8IPurpXkgGeoVMiZjHcFL4HQa8Of+tL7JaISCarmMYi0UsI6K8Nvd03rN6oxQm4FSarxmMVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piFDPYX3Rb54OhnpalPfMTL7NE688FnKk+5oCus6Wow=;
 b=r2YerIfK2fOOso9jCYcO64GAXQz/NtyJ6xgTppRS2HtB0mNI76IJaMWvpkE1PlrV8FjHJ1xEV3VjypN6zj2JOLn5UU0goBDIYf2IK/pqMHeeriFQYKvuD2QsrIF7cUNw7ay+wyMs1nsMxRHyVnad976Y9KkU7hzZ1KUavXM/F0I=
Authentication-Results: philpotter.co.uk; dkim=none (message not signed)
 header.d=none;philpotter.co.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5553.namprd10.prod.outlook.com
 (2603:10b6:303:140::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 06:18:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 06:18:16 +0000
Date:   Thu, 12 Aug 2021 09:17:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] staging: r8188eu: (trivial) remove a duplicate debug
 print
Message-ID: <20210812061759.GW22532@kadam>
References: <20210811201450.31366-1-martin@kaiser.cx>
 <20210811201450.31366-3-martin@kaiser.cx>
 <CAA=Fs0n0U62cZADeEGXD7HUYzCXpZuHXGZZruztNoTeShFw5aA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0n0U62cZADeEGXD7HUYzCXpZuHXGZZruztNoTeShFw5aA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0041.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 12 Aug 2021 06:18:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d4a9d2-4169-4b57-0275-08d95d58f8f5
X-MS-TrafficTypeDiagnostic: CO6PR10MB5553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5553EFE3F62F78579B96A96A8EF99@CO6PR10MB5553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YRcAsNvVBgPijrwseLluwZyV0bQMaEdt2lyqnJrKQfEhgqaKzha4X7yn/vWmfRHlqjN5Uxu8y/nQmQwgYuwiDsz/pqB8A1/hQErHCBP7xVfgau9i3Hz+Jo8R/TiiIsJ+qaxs0InhDmcPyhljHpwUqTKdVjht/3fZWuJQQt+o8h2kJmVtitGBfTwwE/leWjb4EofHR9fYufItkPZz83H/x97wJL1O53053s28P8DlbXmwhsFjgd0gdeFIQrfSjQQgF6ZLNPB7KTGqVj39Purw4TScfR7GPJDmDBpEbh+d9bqiNvtbpSR+D/eXfLDXsxx4LrAaR1YcZHW0JXLQZYGKUeK1x1q3S2mVNNejxwQtsZP1kxlzgye6BX6Lh/6Kox5qWxYIuh7TX3BWxEHqXWRB7LDoizYuz1vLhDJJraWeHu2px7ycqD+Bk895tdM4xZWyyKi1G0BWQDGvhLjeovXLaMqVSlL14HXIEraRHxtb6z3ZzE9vCc8dw1dHJpG3IYzjk8Givt+023XYIcgaVA3UGlow3zUO/0Z0nFy89/a2dfXDBPvIXnh9bcPCjff91KKTEHbe73bi/Y4Kz0W8G6sIjeuRgsKoCx1F+jY7poaZxM+wwUn8/dWuVNeBz1ITaMOq6h6nmpI0BFbKNYfNPjjXcV6p049EBrQUijrP9+h51WpTagAD+CpjZAZeYU45tAEtY/sN4YPmoCphsiTJFZeeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(55016002)(83380400001)(5660300002)(66946007)(9686003)(86362001)(6916009)(66556008)(66476007)(54906003)(316002)(9576002)(38100700002)(956004)(52116002)(6496006)(44832011)(186003)(2906002)(26005)(1076003)(38350700002)(478600001)(33656002)(33716001)(4326008)(6666004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8vYeng79KAKC0kaVT0xas+nBscG3psm4Kk/oABV7hRIQfhl+W5G3/hR6uUW?=
 =?us-ascii?Q?7ZuArWKISTwzkXje1Dt3MDZ9t+j5uOTiwIV9SSBGhQckVn0RKDqFD7Pl3WFb?=
 =?us-ascii?Q?qdXkbkhZOTXrueixBhFVytX4ny7zUPIODYpEeKCj8ShaE4It5I0o6HNINyo8?=
 =?us-ascii?Q?XvFMV2JYs/E3FlOH0pvWK/Rzbd+ljXmKBfZOzTYLPu2v9HIeFHCDWEPJjwY2?=
 =?us-ascii?Q?AGKZ2BAwAcNqXAVypcwEWhcFSxlsEPQjFFTRNkh/5kkykaxVXFejoZRYUwDZ?=
 =?us-ascii?Q?a8YaVUys8LYq36d6Vy8g5HODsjCoJYrTa7w6Q3IOzPAiVLKVXKI7Rg94JBpx?=
 =?us-ascii?Q?vBcXbWnqa67tjYIhVG9amJJt6KtS/0vOwVCkGuO1qfFG1gBXYRrUYxh6rATc?=
 =?us-ascii?Q?O3ZENvYS49245VO4EWL+ycH68qiNeYk60kx8mGfhy7roR/h//X+SXY7S9lt1?=
 =?us-ascii?Q?iC1w7Ww8g88xCSnAw1ApUffj31/J3V4xZdYtasGjl2v1AZFtK5wcb67FngY5?=
 =?us-ascii?Q?wzLxC82QaOsJSmXt/rvrGTzhyjjFwuspwT/WbopMk8Hh9nobrRGq58pvJYZs?=
 =?us-ascii?Q?U6We7LwJRkThgdotl1E6XfhJEkaO4EghoZ1sAL5a/7mLlwoer5YuSBUfKjcg?=
 =?us-ascii?Q?o4H3FFenjCEwF58VxktL97iPwSnCXRne5b0dnHwO7MaN/cXfy467zdDUZ/v/?=
 =?us-ascii?Q?ag22hlzMSQdTfRJFX/siu5w+CrTKuWpoNnNdggz/RBraR8Q4gkqyDdmaAYlD?=
 =?us-ascii?Q?f2BO2MuQftvNoHJoNs/M0SCi9gy73vJZS/nCcBW4VhPnCsUfpRQHxCL3mscu?=
 =?us-ascii?Q?pbLYXbUm+YqkrmvdN9WYPNsduYf+jY2mfJvLofG2eYH2Fgb/dhiLXG3JVOgK?=
 =?us-ascii?Q?YfrJHcSSAU0UB0c3udh/9D5PzYPIN0g2fD5/Nb0ZZLxxNKlxP9FkqZkSw+cp?=
 =?us-ascii?Q?GHLwlHkefKG+7ODoZonHw72tQuVXA/xLjxmZpj0i3y7JyiYQJIOqQM8I31WQ?=
 =?us-ascii?Q?+3se6Sv+ECkAtxgLmGh2HitL8iDczdOJSxP6tgLrE4giIcktdGpoTe3LSeCo?=
 =?us-ascii?Q?/cS9mALtSFzYWzCL1BkCh6yZBR70yNovBwuGCuq9/14iSspKRMFGLozqg1yN?=
 =?us-ascii?Q?fvYAAjVWwGbbiO2uIc6UJAbnVsyfSliW7z59X52ETtdZuGD4LHjugRPAAlF3?=
 =?us-ascii?Q?ehfeYezkFwL2FGVzvtCda3R2x9JAVUGVIJKwOZhQIvgPCD7Hgx3onUqwB7Ld?=
 =?us-ascii?Q?XuIOeB4VJoYz2KGHBa2xhVZI+zvpsPNYZDIwXpSoSbxbCaE7D2yoTlorzD8l?=
 =?us-ascii?Q?nYFTQUTkmU1Nr8P9Z4WutkQ9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d4a9d2-4169-4b57-0275-08d95d58f8f5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:18:16.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SOBvCovcln0WaOSPnjofXMQ19T9f7YQOf7SRMO1wnWa2sjnySdWw8FxOmzHGxk+AFH9e0FmDwAXN0QyjxdOLw/jvXDtJv8b1UlwIoEGQwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120040
X-Proofpoint-GUID: LMWTLmhgLxNmpNO_3t9R4w2JH3lz6Usq
X-Proofpoint-ORIG-GUID: LMWTLmhgLxNmpNO_3t9R4w2JH3lz6Usq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:53:16AM +0100, Phillip Potter wrote:
> On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
> >
> > Keep the one that shows the wakeup capability.
> >

Please think of the subject and the commit message as two different
things.  Often it's people reviewing on email will only read one or the
other.  In other words just restate the subject:

  These two debug messages have the same information.  Delete the less
  informative one and keep the other.


> Dear Martin,
> 
> Just my personal opinion, but I'd be inclined to strip out all DBG_88E
> calls totally. If there are necessary functions being called such as
> device_may_wakeup() we can always just keep this part and remove the
> macro call (not checked this function out myself yet). Thanks.
> 

Yeah.  I agree.  The DBG_88E() doesn't call device_may_wakeup() unless
the module is loaded with a high enough value "rtw_debug" module option
so hopefully device_may_wakeup() does not have side effects.  (It does
not).

Thanks for reviewing these patches.  I do think it's nice to have
positive reviews instead of just me complaining and pointing out the
negative things.  We are trying to get code merged, not trying to put up
roadblocks so maybe encouraging more Acked-by reviews is a good thing...

regards,
dan carpenter

