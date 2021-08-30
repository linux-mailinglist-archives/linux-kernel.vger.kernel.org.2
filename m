Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2163FBCB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhH3S6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:58:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28994 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhH3S6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:58:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UGh2W4019488;
        Mon, 30 Aug 2021 18:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=TkNF3E92XldKy3AeyHSUZj50Xch9fJO5JZuwcbOyvfY=;
 b=nXxJX2g8gAXrnUKcdPc0Umrx34ZvxbJYFWxCIkSA4DXuDFNmd31KVkpBobNNE7blE4E7
 mThUGpofuMQP4FY6Jb8EOsUOjeya7VJPCJ7KsXzHhrZiHSR5Muht/x5DJcH/y9cQzfOJ
 h5za7gdKOT855hnbOxVbhjv5FJ4UImzVdxboo+4roGkYOp9i2p0JXFAcz426/Pb3NT0/
 a9oCnWAi0VPap/6BZTGYDLP4agrFEhYMjx9ELIsQO3dnUf02lUysVkwgWIomEIC7ooeD
 8AGirbxxntoC+gsL1gfLBIajKUel+kf2QLlgS1nposUZpt1/2r4PcNPMHbRff4+NpAp3 mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=TkNF3E92XldKy3AeyHSUZj50Xch9fJO5JZuwcbOyvfY=;
 b=FeAJ5h6liS5IBqSJbBax2JYx4K5p/I34Rda8r94G8tuc6DyGaju0QKrgYRZ95aXGmo6t
 0JfxHS5eLXJhjRPUbObz4856IfeqgXzwHn/GF78y4emUNNiHkptnYirjFZAxUm0Ha20a
 1ISsfDDwTXWDh2rFl8oPkmLfHG/MhIaV2l31J3AiFWh9v4cpBPribM1Zf60QAxS+SFrg
 mqJoMj7vWJ+twEyV74wA+RaTfCQAu5l6z+8+9n6v1yGPQYIsVvEyIqtpGgkqs3lMHw53
 RbCEQzbi4f8+F8HZ4mZjBIWsL+Id30sV1rVxuUssEoEq7ska6BnHz/oo4mC6zoDCpu2R uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a2e0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 18:57:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UIe2gR096571;
        Mon, 30 Aug 2021 18:57:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3aqb6ce96v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 18:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS3XoHWTsz9R2JK3BzOdxTuz1gMKbaISJ9GIxw7jlavSAoxeu08hH8TulGi0EPD4HeC6ycKDPTVd1RnT/TJeRVKWGYj6u43m588DsgPZFJpRZ1srLI+UFxm3JAatAu7sNUDyPbzFBeVJJ4vKk3pL60re4nKRZxzdVu2P/EC8231VPCw6kjAXIONR3U71IsIk1LM0Onp6kQtKXMXAKfSmQhRtCGIDktK3bHzetkWLVTeU8TPEHIRjhqKZ+kHXFv8Wsl3i+HeflFtkILDUb709CX9OfNky+NHMc+3jnCGKY24tiw6BlrD4Fbah3xBmwt4x4RVH/ecE608+hB2RISeIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkNF3E92XldKy3AeyHSUZj50Xch9fJO5JZuwcbOyvfY=;
 b=i/KXlhW3rUpWgdvFSweiKuomzMtrQsOG/GPBYLjFjQJNvhISLHPgz11KdGw2x8xncOnDAlEkoRBZF8TXI740iQMxdNHO+m9GhTwNzDv2hosnHb4pUyi5aQczoBOT35UQFTmLeiRJag+dOI0ZqYdbuVVMGbJSCBUx0fhI9QC10MFs6I3NG16afgHsyKqKASebZW7Kn4Tw6LQnw03N4jTBa9qhKiolm8vM7WCKVPmpt2aeo3Slrvl/upTYAnogndrY6E0dUUVH5Srx95DDjieBtZh+CdPrG3wymLqPcXzMQ8mGu/p7nzWyqks+OphT3y8BF5XhggkHQvYvRjfYE7/Rkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkNF3E92XldKy3AeyHSUZj50Xch9fJO5JZuwcbOyvfY=;
 b=X73xjQK/Vxcfs1KwhvJOWM6M8+RedKeEsPZ69fdCtzI6MZOH9U8lcMapQDV6noCYZYD4jT6WwNqz+DiBQzS1kXhTLtX9kJaZBICep3/UIV+ms0GahM30vJeiT4NaFOESq1MTuGp2eZbxLtP2W9GAK5ZKhMUTHknz23DiDDznTQY=
Authentication-Results: norberthealth.com; dkim=none (message not signed)
 header.d=none;norberthealth.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1822.namprd10.prod.outlook.com
 (2603:10b6:300:10b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 18:57:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 18:57:32 +0000
Date:   Mon, 30 Aug 2021 21:57:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Roger Knecht <roger@norberthealth.com>
Cc:     Jiri Kosina <jkosina@suse.cz>, Jiri Kosina <trivial@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] Trivial comment fix for the CRC ITU-T polynom
Message-ID: <20210830185714.GK12231@kadam>
References: <20210830163324.12537-1-roger@norberthealth.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830163324.12537-1-roger@norberthealth.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 18:57:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19bd8ce0-08d0-450d-6b15-08d96be80555
X-MS-TrafficTypeDiagnostic: MWHPR10MB1822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18223DAD7BFA410D8CE9FAB48ECB9@MWHPR10MB1822.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqGgYvCUW0742B9aAs5rUAzPfFID82DjG+EgUUOWKWH4OZicaTznxOgQXSnr2gXM4F3dyBdUj/dQI32Oud3JHSxqiU8IgxHqXFH61gefnpjD0m4y8wlL3XQ+cKBtVhH7OBzKWbZppxvAzMvsaAUcju0DQdgdUmOaWPexiWUdzOQBCmULXl08IoTMOZQIVrRYgM2eMovaOD+/iBYo+9B/59F1IDRNmBX7ybJCxQxrEb4ng/oW7V29WVMO8ehu2G5r745FTSlbFSJtUvUt5vL0salGjIi+DZX6xS73sn0LFsZfidhaEaFyVfrkx58ZD58QRZmZ/pDR2xeCBcsM6zaQdQLAg2AU0aDM7Qmc3wkxMPX7iXr/E5jXu/eb8DWpAnaYAojEfHJMI4cAK9HayNWiMx7qyhODd4fHyqDTguRuxCSwaaBJTOJtstoyWcAM6N96c/TecH865MT6vBZdlp0/kN21mcZn5ht+jkP+adj0BnrPkId86F0A61HQ2uQy2ZPX/0WXzdIeP0mdVjrxuvf9Fqm8cG8N0S33SdAQfbqWS8UTzGsx1h9slGEqXydkGk8dJEHBkzx5RRiKs8lTpG66MCTyN+szBOeVYBf3ZGjgBf2RmNiS0DSlcVBiK3Ut7Jz8cdtSq2nGF1Z55yTDaw05w1ysXIiLOE84bMiBAi3Vuy+FK3GVEPxq92Ho2WeFkIxsWuzFrIvNDPvbWm1BaQKUQnz9ZRsoAqnz2ALLWcYjvIBzfUALGqBrsQWnX/K34ynwteo0rWIu5v6oSVGl/3sGsdLjGRzHs6genP2EbE5byb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(33656002)(5660300002)(33716001)(6496006)(966005)(6916009)(9686003)(44832011)(2906002)(186003)(86362001)(1076003)(54906003)(26005)(8676002)(4326008)(6666004)(38350700002)(38100700002)(55016002)(66556008)(66476007)(478600001)(8936002)(52116002)(66946007)(9576002)(956004)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdS+o2A/lVIqD0MYw6GuGva0P31hq6Z5OOybQ/Uq9gn6xnuuCvX00A5aW5Go?=
 =?us-ascii?Q?a4uCWIBqBdhYV68oi7dw2HSQGR93BGPZkbXKiv4YATnVdrzV1FnNq7NVOaPt?=
 =?us-ascii?Q?C9j/jS2A0NI+RQ22bdWboDMKbvoWWa9+1UoiYoQNZQLoDXXHhu3tuNiqry+i?=
 =?us-ascii?Q?veKILhddhV2239G08adrxJjn0pU55/ee0fIe27VQJgHhI49bwEwYOJhtiP0a?=
 =?us-ascii?Q?3R4bBDJ3izav/ipG2nv1ViNYwUXP1D96kV3PNdN9dPNhhpIkt36tuTY4s6mx?=
 =?us-ascii?Q?EXcvLj2rJTsZkePIZRV/22anyQEl0Y4RqQ1nV17in9DN6MYwUGxSzXUYAovI?=
 =?us-ascii?Q?KGHa/dbpi0wOneXLR//wFZdcrrZKf7EU56GxR4y5WhicZM4XKBaE+yq03xdt?=
 =?us-ascii?Q?Kyd+Hz1+Lid72hPgC3c0rqDDwdZ1XJxq1DOa1ZgUb/O1jJImx8OL0yZX+UVy?=
 =?us-ascii?Q?CxG1XsMLwMnTn5xKF2IWi0qWBXYZpncE1RlD6N5vRcYXI+yfsLW3HeGCaRak?=
 =?us-ascii?Q?FFhVolNmasWJ94CK8d7vjbCG58x6ebkt2vo/2rq+p+CeaRZeG6nj71McbClP?=
 =?us-ascii?Q?c8j9EAF0v0mV+9EFgwZFOR4pdH4VNnWIqMOeLfLhrQLrIrSkndXtYUZ+h01v?=
 =?us-ascii?Q?UzW/nU39BpIPdFNV1UlhVme1rpb4wyjofwKU5WBW7vAchbmo2LdoJ/vKQexH?=
 =?us-ascii?Q?sa6ilV/TRfKkKjsnxNKZp7GpOeTvehuJDd9t2Kgru2nqJoe3xNFtW7jRZOxN?=
 =?us-ascii?Q?0YKQO5XSMkMsC3ny5tmLdtC6O06awek6m1qsgRS3TZE9F8okmbBixL3Xm1/P?=
 =?us-ascii?Q?8301reOTusqDKiPNExzZkiGKspgdSQWFiIRpMG5X98SiwuEPL4cY3tWdXOTU?=
 =?us-ascii?Q?ZJG7wRwCq1HdYvgDLmcC7s16SrB9scwL+2SUbSZqa+54VHttNuwHglUizAWF?=
 =?us-ascii?Q?43wq/7hC09D0GPRimQwCNICly35o+aCnHKdPAksx9Loeu3eZRHoR/gc1kjbt?=
 =?us-ascii?Q?fyCcDlsFfcWhVKh/M8tTE6hMi2uWgyoVxKsBF7xVzXOsEl8Z/mYRb1HMqVOE?=
 =?us-ascii?Q?HT+OFyTNXgflaasQ0Ph3SmqPNkFGOvmlS2W02Dauwik3iGANFV8zhjE3bo2n?=
 =?us-ascii?Q?cTjTtodaMsfadku2S/pTZ+N4zzlsQOcP2VU1xtvr0qGJejCy0JQfjm38c9yF?=
 =?us-ascii?Q?IFej8zxI/PNXlnIlM/PcC/om+CYTbmACVbi9mMLSmiCHZXbUS4IYdumYWw13?=
 =?us-ascii?Q?/phOmvoJsGMQ9wJnhqwkNBRm9CBEmIY2G2ZTIdFmJibJme2PokgL+bVGzCfy?=
 =?us-ascii?Q?/M8uxYzGGM+A/vIpe9HJC9yP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bd8ce0-08d0-450d-6b15-08d96be80555
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 18:57:32.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3mJAd7ENuIMawB/g5gJREv4pptfzm6+7Q7D2aSIxBqhjw5qU52jz4QfBbanIuqB/0mlBw6B6/rhOJ7ljb/8F7gXI4jKFHYT1nrMrmi6DEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1822
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300122
X-Proofpoint-GUID: C1QQQgMOmM40AJ5srZC-sg060aW-Z2VG
X-Proofpoint-ORIG-GUID: C1QQQgMOmM40AJ5srZC-sg060aW-Z2VG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 06:33:24PM +0200, Roger Knecht wrote:
> This patch fixes a small typo in the CRC ITU-T polynom documentation.
> 
> The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
> correct polynom is x^16 + x^12 + x^5 + 1.
> 
> Quote from page 2 in the ITU-T V.41 specification:
>   "2 Encoding and checking process
> 
>   The service bits and information bits, taken in conjunction, correspond
>   to the coefficients of a message polynomial having terms from x^(n-1) 
>   (n = total number of bits in a block or sequence) down to x^16. This 
>   polynomial is divided, modulo 2, by the generating polynomial 
>   x^16 + x^12 + x^5 + 1. [...]"
> 
> Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en)
> 
> The hex polynom 0x1021 and CRC code implementation are correct.
> 
> Changes for the resend:
>   - Extended patch description
>   - Added additional CCs
> 
> Thanks,
> Roger

Hi Roger,

Can you put the Changes and the "Thanks" part of the email after ...

> 
> Signed-off-by: Roger Knecht <roger@norberthealth.com>
> ---
  ^^^

... this cut off line so that they are not included in the final git
log.  These patches are applied with `cat raw_email.txt | git am -s` if
you want to test how it works yourself.

regards,
dan carpenter
