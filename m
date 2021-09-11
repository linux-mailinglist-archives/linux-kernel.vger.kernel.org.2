Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0940756F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 09:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhIKHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:32:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235213AbhIKHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:32:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18B2rhlH021355;
        Sat, 11 Sep 2021 07:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6UF9y4VkplT13q4Ocz7PVudI8TGlGL7T2FKmXSBSQzY=;
 b=0G7GT5Op+fYOpFURynStJjAcsikjwyXBBmGbd06QFp317SvuiwsoSIcwCZadfcOmpGZW
 jqs8ZyBC7m10oCFsS++UJBMl4Bhj63nPf8PlIo9veSw+apfoV/zfeINN1Bs/vh3Z5r2Q
 e9dea3anc48Jmn0vW/Eq5wg1mY9ta9FbRPZHtXqhpB6JPhBh+mUB1t7oRQMcLJnPvx9Z
 3tgJ7JBI5239k8Cnk1gYRCAJvfDPQt92gFqU4qCJv4kuzu6XNKadz2Qf/hiZsOXqg+Pd
 kZEtLofKTIhmFfsqXzeeeE3NNmT3X3Thc+SSyoOASVLyV5MYYJo++HqzC9j382un26Sh sQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6UF9y4VkplT13q4Ocz7PVudI8TGlGL7T2FKmXSBSQzY=;
 b=hfbKgUn7sCpTKl54x1c3Q03RcZanlh0ulYsbtqe78cZAN9AK428WbTLRpFex9v3N/hEs
 4LFiu7avRa8unKtb+y1PYwIX6nFU521nzcGJQbQRbwc6vd+V9IQ4UoIzDtpa3iIE9SRp
 WoVWVyKwXkTLzfW41XCc43K6llxpKB6aSq4oTPCvQd2r3yfxr1+Vq+6qSByGAzlO3ulQ
 kSVp3VnL+7XAqoDs9iZrjdzjOECuhSFNt7+t43oorv+tey7f8r3kBqH0YUR6ycGMeUAY
 pAcT29ND6Eic+PVzqWhLH6+ulT/E8GqYDnKg7XZOhDbw9sor8wpsvL0rPfPxH+o78gIC 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b0m2sr5ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Sep 2021 07:31:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18B7UKUi189296;
        Sat, 11 Sep 2021 07:31:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3b0jg9pcp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Sep 2021 07:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNdU8oa+jinSST0kRkkIOs7QtQ7bfH/dWS9oaeZgaflVgrH9jON/l0Bk6eg1/1GjfVOKRU4eS2AC0fDKWx8e1W43+0eI2Y1aDQNWnY5mFHdfRic/C/ELTBlDTIMJRDHiMgze4Epw0KrORlMjFiAEn9jzD9MLlWoZAROU3pwhfWdGw+eqtNDi1rNC4fOuimc1QPUjtzQbYouTK+KZ+3Ui5WJc5euf6c+P9Nb+MmOIM0KGZyWss0vCvXu1yn5RS0gUsfaHAbkBEvkFKPSTVlr/AYZWrD558/vzHBYieaOP/DCtJlSMmQ+E66Aw7t9efcQmqbZoDZgrDIDP7LRzM99clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6UF9y4VkplT13q4Ocz7PVudI8TGlGL7T2FKmXSBSQzY=;
 b=nlbBnZQlur6yUygfoewow+RsVtwM3lYkov8189P/l6kmFMlOPhqLUgSqD9l82UF6Wc0kKylOQgMKYUrK0n4OhbktqKASKPoVc7uODtcYx3N1+fJT691I9NEInfGO2yQZ5nRSDOkaYjE9PWEZ2j0XOBmNFDI5y0tJcMxW1dYx86RVnyUFP3JAoztUNHtoF9G7zpu3Do302Yefe7e7QYy3uBtPNVtv36QUt7FKc2naDXopFuiDCoYHjYQbAkVliu1co+yz0aITxMAOFwpEBz6ztfBwElFWuNFCDrA9wn9KDTcZ+gd8ClkydjmygggLgMcsqhZg9h0L50FDiLjgJKtWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UF9y4VkplT13q4Ocz7PVudI8TGlGL7T2FKmXSBSQzY=;
 b=it5u2lxUqAIgDQLJr1qLZmMD/YM2AOr5GXL7GfdmqtumKaYpRUDj+YLfHrfdc1G9aYL/RmhWNUfFDGDzOWvwxjzEg2PKQ94pvpfqUe6ZUxZQVabfKmt3sgT098MoJsy8YGPGOUl/T272uqgAPdt1tMk4Db7SCxG0LiMOHhHVeh8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Sat, 11 Sep
 2021 07:31:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.017; Sat, 11 Sep 2021
 07:31:13 +0000
Date:   Sat, 11 Sep 2021 10:30:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Move similar execution in to a
 function.
Message-ID: <20210911073056.GE7203@kadam>
References: <YTsXXxtQn7QN6nIm@user>
 <20210910090045.GD7203@kadam>
 <a31836c3-6999-339b-32f8-5f7d7f7e5b27@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31836c3-6999-339b-32f8-5f7d7f7e5b27@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 07:31:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a466249f-dd48-4ce4-2ef7-08d974f621d0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1950983FFFC4C81A9E0C00778ED79@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CORI/ZN8pmhBfqR3fwNiH0yEixW3NKAdjuRZxe3c10Zv+uioCbv0x80cYDG8fruqnajKBnCyiOJN1PNERRqw8S6y7rTOWyYOpjYUe9n3NyEoGMlYgqQEExgebDm7mb4AWhRksWGkd2I123JZAcVfF3myyaBVBIxCYa9z7J+ctcbgMA4g2xjo+C3pes0dbBNwCDB7eQeP3VSq6j2yWnzvh35o+DX75mS5RQf7zGYJYdDgddQeB+TcrKOoAqymljZ8VTYcV3Nc3JSlH2WqiEhFHBW1t4GA5p4ZeH6fexGimNah0qXZRCzQKOYmxn6pQkRaCV9E9bZSZ7jvAXD335E54GFZFIsh0nooKY1BW0SNjE8n2QfoaCjS2TcAPpks1uUWufwBYstoJCg37gtsAF8HjtkJ2B8XH9GlRQW2NH0jEQ0kcZbqQCzVif9Pu8l21LOF7oSRxWeKrwDORS6ULeG+mJFLEt/VssjZy8nhKE7BnLk8e8qejuBLfE1iu8K5cyDOpJ8BCa3x2Kj3clIT6w4vN9Tw4WIvZ5uPQCbU72AdJCTjNSIWQ9bvEYNMkqhT4O2kuMyonwI4W/fjoRB300MDDIGbpQy1CTGhk5qvS1U4xf0uQoYTOA7rKsKzwvUqeDIohG3xG2R0uutlQX+jA2mSGVCpGOLLnSkdxQx3qVh/nPEGnyviwv3e1QigjYSa1uSog6FqrgOwK/dyzZttMwKQXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39860400002)(396003)(26005)(66476007)(66556008)(8676002)(86362001)(33656002)(8936002)(316002)(83380400001)(478600001)(66946007)(6496006)(9576002)(38100700002)(55016002)(186003)(38350700002)(44832011)(53546011)(6916009)(1076003)(33716001)(956004)(2906002)(5660300002)(4326008)(9686003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tnox9dLUTKwgGRHuCnauqE8JVY+SL6nDUCwCTiQRcNErLg66nAfAIjsuyCo7?=
 =?us-ascii?Q?qk5JMR1y0uUGQwWZPdhzhuIfu7rHVLVrths7jtvSlCH58wA5K0Sdq2yin/Uy?=
 =?us-ascii?Q?BC7y54FJsNrTuzQ2iDo/NAKM7Y7+kL8QZSadWoPi9FEnYBEgsTEwu+XLMbv4?=
 =?us-ascii?Q?LHO4DibyxciS/jDFFsbqmMcWONwbEVxoQSrfx+A4nwUDBU7F+y24M69Tp8zr?=
 =?us-ascii?Q?3aeRD5gLWxu6YcLgUQc6cf+Qhk15Xl663njWxXprkf2hN+wGwiHffVyEg5hm?=
 =?us-ascii?Q?Xna154tyJaur1Lo7MzJRS6nkSnECRoOaTCg6VH5JxVE1vJBL9qaYkT+D4XuS?=
 =?us-ascii?Q?ecvq10nFzd7q5yS8VMzZq4sqNeh7sZguYuUmw7ThbmiscBn2P1Eo5Lu0ixGn?=
 =?us-ascii?Q?d/henfDmZvyEO7a9Z5zF42fhJnS8qyZlQeZFxeDpkK6SuGKC7RuibTzEnzyh?=
 =?us-ascii?Q?MO+D/sPLxmeahn+31qVSpvIwCH70z11U4ZC004zUyRXReuAVN+fMUL8vY7/K?=
 =?us-ascii?Q?vvi3LNHVM1pq3bB1fe9hG/PiwbcarFWweXdesLsHfByQyI6gijU7bt9wUP7L?=
 =?us-ascii?Q?XIoUEJ054nqg5GotDJs+mnJW0JxRW9KqfUyvcx/kUVRugZWYoolREJC9eBWE?=
 =?us-ascii?Q?3TyR0dli1lrgwatUSmrmgPW9DbAZPNaMXhwhpRG20sQXJ3MS60iks2r3kk6H?=
 =?us-ascii?Q?Ovt22UwJieB6+12H5z1Zhht/pLvs9BBltfsN/+scDX4Tqe5FZ9ZMRXgfaUjt?=
 =?us-ascii?Q?yqE0IWdyaQROyst5D8lxwLD2xKsM7AKdobpcAhDPfSYIIVptkOuey7t2v+gh?=
 =?us-ascii?Q?+dT5cLJFBSxI0kKK6CBwI97GEHyZtcI9i/VHotpLFEltGyxCY4GzIYBffQeN?=
 =?us-ascii?Q?4lFx94CyTG5PpNPpNJ00m7JIIHjElEtxChxh7cY2jh6K1J2wv1G62s+0m9/Q?=
 =?us-ascii?Q?nhy/s74h22cmoYV2nevRTkhCIaF8BXDp7aTBr0om53luFvG/9c0j287vWewQ?=
 =?us-ascii?Q?OkN1xzopMpXnwDDJx5WRDA7OEQ343umfkDfxO5CKJwoniHSintqDT9kCFr9c?=
 =?us-ascii?Q?TuH1Fk69ycfzmi9O09ioxpfM9EEmDb2y/vDNHpdPEMmn+/XXKbveusHfyk/b?=
 =?us-ascii?Q?BDbD9P/+3rK9tSE7i11sNxzjNsHj5ZLjSWsb8qdS5z3bOzPVM0FihXn98//v?=
 =?us-ascii?Q?1M/uHht4FM/NVCyvtsaQH/HAwyAvpdVnz7BKPqgwVdF4Cj2dxwSfF7dy7mPL?=
 =?us-ascii?Q?MwFkFspOc5fF/vlu9v41TKTlv103uEdCRMyQ2ceLZEqKhew1yC5VyM8YR9A1?=
 =?us-ascii?Q?0yaF7x5yqjYluhnk1ciLWoaw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a466249f-dd48-4ce4-2ef7-08d974f621d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 07:31:13.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JapAAA6VuBWV9XQrDXgJUJ9cHnZnMioWjhQyBO7PDaAckSYQyUkPExHxWMlrstgMCQf8ToiypzPp2HlcU6i+chmPdVKUDqLGcR50tyqRDr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10103 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109110045
X-Proofpoint-GUID: 0Tw6gExSZjcKNETO54kOaAkPVNbLbEqv
X-Proofpoint-ORIG-GUID: 0Tw6gExSZjcKNETO54kOaAkPVNbLbEqv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 10:19:03PM +0530, Saurav Girepunje wrote:
> 
> 
> On 10/09/21 2:30 pm, Dan Carpenter wrote:
> > 
> > On Fri, Sep 10, 2021 at 01:59:19PM +0530, Saurav Girepunje wrote:
> > > In rtl8712_cmd.c function read_macreg_hdl,write_macreg_hdl,write_bbreg_hdl
> > > and write_rfreg_hdl all are having same execution.
> > 
> > I get what you're trying to do, because this code is bad and duplicative
> > but this is not the right fix.
> > 
> > Let's take read_macreg_hdl() as an example.
> > 
> > Look at how it's called:
> > 
> >     215          switch (pcmd->cmdcode) {
> >     216          case GEN_CMD_CODE(_Read_MACREG):
> >     217                  read_macreg_hdl(padapter, (u8 *)pcmd);
> >     218                  pcmd_r = pcmd;
> >     219                  break;
> > 
> > Then look at how it's implemented:
> > 
> >     120  static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
> >     121  {
> >     122          void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj      *pcmd);
> >     123          struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
> >     124
> >     125          /*  invoke cmd->callback function */
> >     126          pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
> > 
> > So pcmd->cmdcode is GEN_CMD_CODE(_Read_MACREG).  We look that up in the
> > cmd_callback[] array and it is:
> > 
> >          {GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
> > 
> >     127          if (!pcmd_callback)
> >     128                  r8712_free_cmd_obj(pcmd);
> > 
> > So now we no that "pcmd_callback" is NULL meaning it will free "pcmd".
> > And if you remember in the caller it does "pcmd_r = pcmd;" but "pcmd"
> > is freed so that's going to lead to a use after free in r8712_cmd_thread().
> > It's garbage and the patch doesn't really help.
> 
> One more thought here after the
> 
>     127          if (!pcmd_callback)
>     128                  r8712_free_cmd_obj(pcmd);
> 
> r8712_free_cmd_obj(pcmd); we could do  pcmd = NULL; so in the caller when it
> will do "pcmd_r = pcmd;" it is actually making NULL to pcmd_r. On
> r8712_cmd_thread there is check for pcmd is NULL or not before execution on
> pcmd.
> 
> pcmd = cmd_hdl_filter(padapter, pcmd);
> 	if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */
> 
> Please let me know you thought on this dan.

You have to look at how it's allocated and is this even called?  I
haven't looked so I don't know the answers.

regards,
dan carpenter

