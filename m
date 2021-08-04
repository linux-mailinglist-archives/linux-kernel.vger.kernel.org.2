Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1093DFC64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhHDIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:00:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236015AbhHDIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:00:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1747pKK4025444;
        Wed, 4 Aug 2021 07:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aO/8Q4L2t2VL9rlgaqekucbf5oY+T2NL4z1s0RO7zoM=;
 b=a26XN9MmlFLF9/NKmcPBXLHS9FYNXrmRzYaBb5HZKLklW8iA71PGUuwWRvQVhH+uzdjS
 egtwgaNAdjdzothkh5+v5PgmSIzK8GW/J5ukaH/RKyIXsLndO26Kt+JCfaUpztBY3Yls
 UNIfxbi81JURRR0alIVLElD2IT+sEtYGhfajCgOwgR1MjtjkO6wvaskIga39tglGyyco
 602Uf4E0wyG4qEVTj/xDyFBH2GybX2O8VCtEAiGKb5P8KkkV06bR5jGQDCpeKaTjE+Uf
 i7TNV4o/V4VAD0BW96hyrO+o0FERmmw8wfxS/tre9c2CEFo4+/noq5rQmS1GVPfAdXiI qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=aO/8Q4L2t2VL9rlgaqekucbf5oY+T2NL4z1s0RO7zoM=;
 b=HSzRPmBh02uOw0kLudDeXzXYAeNhHqAtMYZcl7HOPMMr4/BTJk/ZbxM5uYw54e6MYMgI
 CYm2RAeN0WPsMI0czyEc3hF/+o3in0/rqf44VL7vegSEoXBsp8FnBCAuK0LbFDVgB9nV
 5qXjwem6Rx0Esv7nyhaJGp8YJmig6PgTt5QK6gYYrfN55+7IhMRsUyPt/w92nFRqRBVP
 O1RFn60b5zizzGNNprGT456WFWZZjTbzB7OGYlmsUsb7ClamQGET/gzpgi+P/mi944Kf
 gN7rqX5uCYl1FTi47uWtlAOyeZR3iw/7pg1a0MMDt9IjEm8uhdDZl7ZiwLz6yGlIQzrP lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn0xjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 07:59:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1747pUWw156192;
        Wed, 4 Aug 2021 07:59:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3a4un17seu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 07:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU5F0uvOl+NdLttvfclg4Xyx7JLCcojy9nsh9rTcucMBGte03LjxW4okvHKEmlLCKRL+eGF0+2UZca8XhatjZSG5CvNwl1DFcUytA9R6mve8o1eySYYoq6aLkOzLWNgiAaegZ7HmQhXd4/BVlArGs7kCjK4L6KHhW/pEpamgSL2aonxFuJgsTciK6cjZrkoFDnkQ3+v0wzCPMegi7ancSDa3oUUXG7SdyeZPsqt5o48fSg2cK2OhiJmbkyC30KpTmR2M9hp7Ua1eJzt3bVcIwh1WZxov4Xd3WD1+aKlJCdab0lCUTDE3S/eRWRlOWmZTcB4qXHx3zJ2c4JXePwdF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO/8Q4L2t2VL9rlgaqekucbf5oY+T2NL4z1s0RO7zoM=;
 b=DQ1O3KNnUS6UBXRF4DaIHFmQ7wBwtY9kVUk6MCI++S+DA+YuFmQNlQkSkSUFC2tHnHJ0vEP31GZa+FCzFubzblMh9FctQfA7jTT50CKZOH3dRtwCH027g+53lP9gcF1FP8CyaEXiqCK4TwIL2fBYBNZCmRUo8yT0auAKk/rC/VVPAjdOegYW1Y+Iga3psHxYD+aRCpdki2N0hPoZ1qlmbn9RQNA5Hxsk124VHF2VIHmRQK5T6zRyks6zkWF2Gqk7N3k8tfOop6ybt5DRDHnAawknqn429IFUkH3fb2jiTQtAdv8cgOBQRDlNEK+KBPcbsnPrfhFq2V51o+jQIqxUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO/8Q4L2t2VL9rlgaqekucbf5oY+T2NL4z1s0RO7zoM=;
 b=FghXN0Ks+ZtJakrPIZMPRlLjlTaaXEY4qeUfBAmKvlmwRGLLNYP3PFrwBXg3A2pFRmdGvpio/YfKHsqPeN9pw8utqHuwbERSqDov0a9sljiwpFU6LyKS0+KvrbFplM2IcgGPXi4OVbDt0nLOJO1tkQTfX3/z7DNLmf7v0ck4ojw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com (10.174.166.156) by
 CO1PR10MB4449.namprd10.prod.outlook.com (20.182.139.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 4 Aug 2021 07:59:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 07:59:53 +0000
Date:   Wed, 4 Aug 2021 10:59:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in
 assignments and parameters
Message-ID: <20210804075930.GD1931@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730181452.23062-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 07:59:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d73b1f3-889f-4d71-57dd-08d9571dd758
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB444969B143E5B50323E37F7C8EF19@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+3FSw+viEXyStf8QwanmAHHaOmbqNKowKY0JSX/6Xar2hfxdhVZw+ooULrN/Z7+RCyIr1CaLijlEg/ISVYN85wuRP4EndIFkZcF31lwYfAOixNZjHLGoRu0nMJWv6jNLYkKRrPqJnwUtm2LR4xtTmhseN+SeWCzvgwLwkoVJKo+Lm06eGRZku6TrJB1hzoSzUQRXsASTmzRSFFClJFyVrQxgGt3YP/3cM6Zix4aT/esBNW3VqS1rB5VgzK3lU8BI4G+Gw4kYnQXNDs+25iWHnb9NKDH+ETjeBwBn0yjSbHGQQwgIQ5MM45SHb6YSNhn94UPTFgdP8rGl9UblXnroo2+YHKduVtJ7FP+95ylTlcHyHrAM95PL7RAnfVoCGbyp2NhLk9QZG8FBSudP7SP2R/vojce6M1DfVlvHSlIJ38+lNMN2qezfwsExe/uY+GnIa1jaMHDQIyouVYNDzvWFPOcNSeVXpzP4PIY6m8LWbiQCMZ4HHNRnMdfqGiLhd3+GGInfzz8n7xyio3bMDtvQu2OcH1DnUEjOpEDuMJAtJHZCdSzA8vpvmxqR9juuQm3caVpk7aZHuR7KkOCFjWBEbrugprJiwBoiyXuzXBprmF7cg0j6XPCyZ/KQiYlPy9yLTAN9hxYGHdx0PQUsNKKkw26sgWSnNKLlqRFj6ijpsQlORLniPfzhoDDN2j3F9ftfsrbnqwfUjPWs2u8huEd5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(6496006)(9686003)(33716001)(52116002)(6916009)(956004)(9576002)(2906002)(38100700002)(38350700002)(54906003)(44832011)(55016002)(86362001)(6666004)(4326008)(316002)(66556008)(186003)(66476007)(8676002)(5660300002)(8936002)(508600001)(26005)(66946007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQwr2zEIRycOjWcA+al2J+L0KVd448ATJvQVjuvfpvOaDcR5KdP1z/EIvP8j?=
 =?us-ascii?Q?7/urlOBJUFux5YNiPrHIPxdcnBtrbBiObZvsrl/w0SPzAD5jndesZHhSvVDp?=
 =?us-ascii?Q?WgpKEKCWBqYEcGIwpIxbDSEV4C6MNAwsUviqey41KKiouyZVOzdJ6hGuvjxe?=
 =?us-ascii?Q?i75hzJLMmQtKt3+Dm1z3rP5/E2NPA8WIu5qsjtg5CtATnlI6B2lDfSYpdDqK?=
 =?us-ascii?Q?S51wyCevegR3IbBfKl5zESPduZ7cYkMo6Oh+52NaH+FTjl8gHeBLrqNSR15m?=
 =?us-ascii?Q?jGAsXdAO/K8qiJZ5bcn9Yuy2omsfA+wV+C2GzvxmL8+SWYM7wgjGV7vA8YWF?=
 =?us-ascii?Q?7rkQxIOTF+//6BYK687JHNFhNdBzmv3xsptttHb7q21BT6grm+JV8+L0V5Qg?=
 =?us-ascii?Q?JHzxhfWxc994V7UfAaTUkW9ALC6rFppk0Hvh5lSj5XFBiIi3vH0JTBaQzRte?=
 =?us-ascii?Q?rSl48ABjADt1smPOI1B6SNHA9JauWHaxIwIVlfNj2X5crwzkCSJQQ/jDcZp+?=
 =?us-ascii?Q?TgKOzCMnwnsKjVXlKcJ8Q9tKl2QMpA2Cz3RdZiAFRxIM/jOc3XUsUJs1KvOT?=
 =?us-ascii?Q?V0DF2dcAA3N8Duuszr5M8M+io9sledUBkuM5GipnrXf3RKUdbpI+sEVWgRkG?=
 =?us-ascii?Q?0XTe8fj0MgjoxHdbRWcFQFDaKsLLN+HvYkeZL82lPbeR2MTwk6iVKN42LNoU?=
 =?us-ascii?Q?+niDbU90fyRfRKnhsFgh2/+8HPD84nzw2XfsZZoNsxyJgWNhprcORwwn4Wyj?=
 =?us-ascii?Q?I6YRkrM4YEGvogwtvTGHstCvp+F25iNVXBAVQhy5ysuJMasgXMz/e+bYv+oX?=
 =?us-ascii?Q?8BiR/ZibL7/UK/DbMkyZLlLJ9ywKW6v4skxfrh4Xd12P5s65H5KSRDsOoD3U?=
 =?us-ascii?Q?VWz2MTSZQQ/8AuzlUiorAwlGrWDigWyt4i4+E0Mu2Hpm0RLS/TagfSQwpGTg?=
 =?us-ascii?Q?p1ylj3SPdp2Klx3HeXuj83AFIAxPdy2ovMRokNS0KyuZ6USGKJz93SDHTygi?=
 =?us-ascii?Q?mrWD4yN7DeChjnsXVW34Fmc+ekPd7kndBW8AhpokepMtnMpo33de9MiauOoy?=
 =?us-ascii?Q?lYisgnbyAEGrQdh4e+UyrG4/fHpLrb7j49MPFW9Wy+6eeuc7L+yYZOAAKDcC?=
 =?us-ascii?Q?MS0kgwu3cb8g6T8yCspAjJiyD8O3jkTXnqyQuHRRN3B4JJM/PsA7bJi6AVaX?=
 =?us-ascii?Q?qD5ccuJ8gljLs09n0KTBvv0SbTumzzmQvX1KhSvCcVifyMO/FB54pp3kv4gC?=
 =?us-ascii?Q?MGzbmADiG/ryFYsgfgDEiiZg1zUiZtMLuhiV24XVzGvHQFVbzPQVZfgwXJ3V?=
 =?us-ascii?Q?jWDUKQx7tmWAgUk/7q5WsQx1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d73b1f3-889f-4d71-57dd-08d9571dd758
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 07:59:53.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/A5YgcY8ipld347EdVunEFIhCF/doLiMIi5HoxCpXUyz542tXEgakNGt78d/daZnxuMtxX2ThxFGD7TIj8N2CaYSVkIc39bXKpi2Yko7zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040039
X-Proofpoint-GUID: Es03kxRDJtehmmmqhaYm192yXrtp6mUk
X-Proofpoint-ORIG-GUID: Es03kxRDJtehmmmqhaYm192yXrtp6mUk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 08:14:52PM +0200, Fabio M. De Francesco wrote:
>  static inline void __nat25_generate_ipx_network_addr_with_socket(unsigned char *networkAddr,
> -				unsigned int *ipxNetAddr, unsigned short *ipxSocketAddr)
> +				__be32 *ipxNetAddr, __be16 *ipxSocketAddr)
>  {
> +	union {
> +		unsigned int f0;
> +		unsigned char f1[4];
> +	} addr;
> +
>  	memset(networkAddr, 0, MAX_NETWORK_ADDR_LEN);
>  
>  	networkAddr[0] = NAT25_IPX;
> -	memcpy(networkAddr+1, (unsigned char *)ipxNetAddr, 4);
> -	memcpy(networkAddr+5, (unsigned char *)ipxSocketAddr, 2);
> +	addr.f0 = be32_to_cpu(*ipxNetAddr);
> +	memcpy(networkAddr+1, addr.f1, 4);
> +	addr.f0 ^= addr.f0;
> +	addr.f0 = be16_to_cpu(*ipxSocketAddr);
> +	memcpy(networkAddr+5, addr.f1, 2);

Here is another bug which was obscured/caused by the union.

	addr.f0 = be16_to_cpu(*ipxSocketAddr);

The addr.f0 variable is an int.  On big endian systems only the last two
bytes are set:

	memcpy(networkAddr+5, addr.f1, 2);

So this is the equivalent of:

	memset(networkAddr+5, 0, 2);

regards,
dan carpenter
