Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4391B40A9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhINIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:54:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2836 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhINIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:54:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E8jNYc018165;
        Tue, 14 Sep 2021 08:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0hppmZQeh7jia2ZCYvOqrKIxLr3Wh42DibZQTD00Ypc=;
 b=Zhl4xP/RWk1AsPL8Fdy3FGS969WvOLV85dq0xueuROjgsWo0VIZHSG1wsirZ4Es/KOT5
 qPfmXLtsoKwhIJzyzRvVp2kgS8gMQA/BYFIcZRdM+ncYN+X3H/64U+dq7FFlqsBpQozc
 KAYs5FNP9vf1EHCPKd96CnLgUUpzEPREHC3SPHU01t5XRCLF21mBPJM+KoMN0xLlluEM
 uWso3NY+qfPkobE7fN0cfyntrNToEmdKgyspDqpbkrhtFURrswFiUzUfY1uupI35uSi1
 ta88lfiKazxTA4ZwrRAkAh4cIrZaIp39XooM4j1VeiPHXjTJ8jHcjck8Ky/iUV8yKBXd SA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=0hppmZQeh7jia2ZCYvOqrKIxLr3Wh42DibZQTD00Ypc=;
 b=zI72spb7T+WTxUik+BiJXy/rQbU9cSAS/z9mBPGNI9Oit9OdkxJW5gx8bsIhqDGHWeOt
 VpYC8QmN8ybvPFunld+yQU1rUGCG+rKVI2TNPKjUDixR2T9Kf16mDx8FeQvt6HpdvDyF
 s0ygFyAeoDjjc5Psm/odA9IdkRrVI/f+QxNj5i0sTrYm+CkRpzgVyFsYvwXwz4EWOhlb
 V72umvr0k2O1lX0SsWRIQgiBYudLxZ2SOeWbWnTWgLU8aP+ohbPuTtkmhtoDB5BlGvpl
 xShlRregDquExKBkRXynN9HTDFVnPv4tM3kHQ2KjGEkcv9MxFFrblMbi2hUAEYRptF/C OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4s93xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 08:52:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E8oPdT114499;
        Tue, 14 Sep 2021 08:52:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3020.oracle.com with ESMTP id 3b0m9604fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 08:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx2CmXoVcSI+4fEzICCNp+cjv8hDVwx2SpLCiYlbrmxw2KPQNOtXDeieiOGPF/OBbkRUZ1g5+7YLqoDBuXFhc3pom7xAjGeI8yrGhnpOgH7VFGk5TFbRlYbO4AYRUJfBLhCGJV6pmTzcBymz1GZzIaoIiU0fYHvDzeG7BEH5X2cQxcJAc99Hjscy4ggBzse0O6zwXfSHF630qEOlm01LC9DUCGxLM9vpIhrFxodspE5275jRQQ/sQxJ4rJXQZE2n7l/6SDlBM9vKqRQdIg039q/hLeyjQ/HGGYfd6/PjClBWvAD9msPiKuyQrQ4CHZG8x8C/tg3yS0FAL+KvliltUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0hppmZQeh7jia2ZCYvOqrKIxLr3Wh42DibZQTD00Ypc=;
 b=Ds+RQ5auDXsJw8U/CB1pJ79CBxyIgrgOlLzSuxZqY0nSWbTLYzeDXLAhMzLH0KuXX83eXtsGdhe8fieCPYsXJZ4mfhjT3wsPl8WZktXpmThSJomRBwDfsL0Z1PoVKI0KetwDmDlo1WpbHXKuAj2kJZ3vpHhr9VH7xTvhpnCfOl1P5YaI2AeYYEDTmSfVG7Pu2Y/Z8uoeehRC6DTpLQmv/iNxLPTamlwe2bExm18aqR8zA3FkzLYVPjS72JCz1D4Yt3tFC8aL1gDV1itxPVnjrzx7jdI9A/JN3TLnzxLu7c2Mb1GlLRw3MBBiei0nZxfgY99Wu4AZraDlSka+BF35Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hppmZQeh7jia2ZCYvOqrKIxLr3Wh42DibZQTD00Ypc=;
 b=CbVZKOFZVoZ44h9kQFyOemGhJX8BgGQKfjx0JoXkdf57TkVhAp6sJOxB35zQLEJ3qyCPNXU4g5L4HtRISBsDAFfQndbEVjNuOcumDlgVFQCs1JNWtzI3yCwjX7S6Gfj9sddJpSrMPAt1FxUubeQpSaj6Xb07t19bQ4CxTPqvsko=
Authentication-Results: bryanbrattlof.com; dkim=none (message not signed)
 header.d=none;bryanbrattlof.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5570.namprd10.prod.outlook.com
 (2603:10b6:303:145::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 08:52:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 08:52:29 +0000
Date:   Tue, 14 Sep 2021 11:52:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: define wowlan_stub only when
 CONFIG_PM is enabled
Message-ID: <20210914085214.GA2088@kadam>
References: <20210913140937.1490133-1-hello@bryanbrattlof.com>
 <YT97lJVU8cx3wxwN@kroah.com>
 <20210913234247.ptqjjbilrtkzc4id@h510>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913234247.ptqjjbilrtkzc4id@h510>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 08:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 315ea046-23a2-423a-b6e9-08d9775cfbbf
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5570206CE687415672AE993D8EDA9@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpeZmWa7sHs3aQx9aQRNgyjuCAbFS7LMSxx3gFEE9NQasin8DyJGSUZZd5C5t873G/HX4nYuay5swxitBO2jev5M/CFytc0/yacIseXMLdAYJcPLK6llndEivMLR/YMUzVuTqyFMnAzmVR9XW6arRj1Xvj0G5NuS2V62ShAYXJ5nQDQdcX1nwQj9iLApeU9Id13iXyQBheZQe4rH0CT84uwDN2Rkn6HMGvkuLXy8qwSoHrg/Arxyxp7A+mPoV94/ALHwojkWRyM+xAfwre9Eqw3Y0iharJ6Es0DpC2/oTV9Oky7N4jHTHaOAdN75GWdvfhLjZoOCVL3nOeoUQFCoUzvhij/r+2Vu6wDG9j/e+uw53dxXGWAszGTy74jX3XkdgQE4V1TSl/fuA8UkOndjCZFUERmY8OzbIz2mQC1rbh3wVIV/PaQLX43S4nUWuiTiwpcXJDq79zqzg0bZSNHXCRB/46kGYWFXzg+6AzId0icDe20CdoP0Po4iDsKTS8kOaiV/GqH3Sc/mgJ/pnYcuvFdmKN6HVOYQkGrtoFxq96AqM+RTK8vZWX+0wVz53qWemYsz028muLBCZkxKrk7h707HvSa2PkmIVUfdOXStci9MJwm1BWuxEP1pIrbBfFRhz3mqwlWleSI5y6HMkn8adSEY/m2Wf3oNFDOy2tNvWH28yU+ZJ3yDoRMbp3TT29JMf8xUUOLdJkcLg1FPp2nFhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(186003)(9686003)(4326008)(55016002)(558084003)(2906002)(5660300002)(6496006)(1076003)(38350700002)(38100700002)(44832011)(6666004)(956004)(52116002)(8676002)(86362001)(33716001)(26005)(6916009)(316002)(8936002)(66946007)(478600001)(33656002)(66476007)(66556008)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVo8bqpnbTgndpCTAQnkzIlW+ObU34ABR+NA2jqElJegGDFWn84CIWvSc6Ba?=
 =?us-ascii?Q?GySGqIpsVwa1xgqiMLZlY5WSGbaljkTadqTiU03ZsE6hIhjd0XO1fFKYE7ie?=
 =?us-ascii?Q?oYWL3LXwZkxq9jYhewfQkTw2oxhW7y72RmfChymrA0H+081ByjU31YUBojzB?=
 =?us-ascii?Q?Vy5DoO5t1H9UFD/ule0RRvzfeqJgw/FXl0TgMlpSwcsMRDRtVGs4HpRrY92d?=
 =?us-ascii?Q?4Pjq2qZ3u3cUpX7UTnm1xgiepr+PlioDpgaiGTUSE97FjH4BWu6t4KlDjEIL?=
 =?us-ascii?Q?K84Dnnb1ZhytWI0J+NDQfPvLhw3qlIH30kDLQhvClwO/salEiu9aHqcLoH2v?=
 =?us-ascii?Q?wDNRFyYwQaCYknSecM/WsFjz0bKEthkEAtKkV+Wlyd58snw0hY3aHEA9dADl?=
 =?us-ascii?Q?zlkdtbIb0oZ1I8HqUb42WvC9Z4MBqDfNcZnDBHQtJZApRRRdWvtcAeCLcBYc?=
 =?us-ascii?Q?T9KEeGexnc+0M9JnkOp/qGhqozn0OHxcuP2akv1+4i7RZl2VWaj/gUkyD2qr?=
 =?us-ascii?Q?GF6EHKGBA8dSf9fJvYaOzXtoSvvdzq2K9u3dK7FLNCck6Qaov2vr+RPxsE7f?=
 =?us-ascii?Q?lzkfiZ3uR0EqSFQTRJFFgbxasaZbbB0m1Cm+wPe/OYErIwj9xrio9xpApFN+?=
 =?us-ascii?Q?wwREe3jLSJ/JvzSRYcjcL4OuWuZZCeVw2Bv00tTZEUB+sTsa6OYUxXQas3MI?=
 =?us-ascii?Q?TO828+W6Zwd0bEbeZpDyS8BDMUAs7yOUX+n9+xb58IutAHRgCqAkGJiBt/Fb?=
 =?us-ascii?Q?M30V3JzC97Iq3T0X8gR5P+28sqeo29k9gvYuAfVyKJ20ZgaCF++AcfnnJVWL?=
 =?us-ascii?Q?pCO7Fwi19lvhmTW5a6E2IKAY0vcNune4UVVx+RWgrkqu6Mqx6lhcr+w84vgJ?=
 =?us-ascii?Q?1YtSSG7MCdmrkbYy66SPkQPgjhupTV3XRXWAyD1f2cs1RL090Jo+VdyEpMuN?=
 =?us-ascii?Q?wB0hkz6VbEPJMhCqGSSx+3grwUEHeBDjwqJ0AnNUPO0PBQgZEU4ysbbeZH2g?=
 =?us-ascii?Q?ngFqU0SRjW3SDCxEkikCsYg1gQhzXM/2SG62N0rxGMBJoYCItpKHepHR9l+G?=
 =?us-ascii?Q?tgy471BqL/3/I3RRI6w2guaMTsUPDZDILC2TTBGwk2dB0tzoubidS5tBIFPB?=
 =?us-ascii?Q?ozxFPdCWsHi7G0Mo21gXdj5CtgVeMMycY9r0QFh3YswmEglCDqDQgMaw2lv/?=
 =?us-ascii?Q?uVZPtJuYtAnG9FiDZuQOyrUeVMQq054HyvMBWx0pMUsyCXgety6TaUYc4yb2?=
 =?us-ascii?Q?kGAt/GItSs6Evzn/iBZTvzMC3HNx2q+p+VoZ2QSeW7XLnh6KSeiCjIJl7exQ?=
 =?us-ascii?Q?d5q32dK+z7AcdL0ZW7YT4AZj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ea046-23a2-423a-b6e9-08d9775cfbbf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:52:29.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0EdRxbuFTOo6GajBa8VHFhigHf4WaybqaU8qhnVrZwzPSbL7OM8GqPLNg82jpjNsIazc/ehTORfgw7Sz0LB6iRn/ZOE5TQo6VQfS458Xns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140053
X-Proofpoint-ORIG-GUID: POKsZ03WeFoBnhorUWc3vzbTW7Z2gr5v
X-Proofpoint-GUID: POKsZ03WeFoBnhorUWc3vzbTW7Z2gr5v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:42:55PM +0000, Bryan Brattlof wrote:
> I'll be back with a v2 that rips all of this out.

Or use the __maybe_unused annotation:

static __maybe_unused const struct wiphy_wowlan_support wowlan_stub = {

regards,
dan carpenter

