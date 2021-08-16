Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC53ED0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhHPJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:06:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18660 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235154AbhHPJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:06:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17G92YFl021266;
        Mon, 16 Aug 2021 09:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2Fl9AdfRgXtjR4KsYG2oQe0wtJDSIs1G/f9mlpHW09w=;
 b=YKFihy94pJ0DytnRd93nqLWxv2XvnkqsVDm/duiUbXc5WlojW1SzMekyFViyuR3O5Zkj
 E0l2OWixoAKQYUNOPN7V/rbuTM6MkoQTLkMY+cxyPhnU3w3YV3XaDHxkiL9Y39pgzKrc
 BnsweatbLKyWGca9e75I8S4C0AarYbLVfl1tYrlJ/CU5QSOKrQGXfuRNHJQbQJJmHKkm
 BrvDPoU9WcqouVnj+/tSqohBNeWXlsqkgZfk4GqeIJHIx4py+A+Gxn7gsM8fRXyZ0aUb
 Qk7oWs1mFqFnBuSqsUQG7Taxfz0KCHDfTMIVgc7etH0g6nmfQplmB0Tc9Yq0X/6/BlX/ Gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=2Fl9AdfRgXtjR4KsYG2oQe0wtJDSIs1G/f9mlpHW09w=;
 b=d5+bwtc8EtCYl0NppzsYZ+wjEqDpqnwG4BbQryLW+7kbjnb9pQieHZERVylASVo3AUsD
 CM9oau51RLf1mfCNqYQuQ8cEOYImzGlndNyNszEg/oPubHaSQK+2ZHAiTxnM+gCxMqO5
 e/iSaYKfSTgq4Cl2kmuiUOYm2F/pD0u1TXxBQQG6v587WLl+8Xvhu8k9+VI9azJogebb
 ThG473AHN/ybLajRrGQ0K4kHDk8R6FdDBRXVDHW1oTCwVC7yFnu+tk3yAmySnjwpt38r
 q4qK0gTNzZqbkO7YhRjxg/ShI6fMijMfS73slsop4f0qVk9rIKcdxKmiAxvEqexEcI5P cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af83016s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 09:05:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17G90qp7064430;
        Mon, 16 Aug 2021 09:05:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3030.oracle.com with ESMTP id 3ae2xwu7t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 09:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LatQNHDy8B2Kn3LXgRPAwTh6K+3rFULELQ4yYlcdW+X1lT3SOTVq8nWPZ599dv/J3w5bgQ6qW54kvjyFDGQLwtwtmtcqiaoI+1DAQo4/pJ91vdGGwfmCzBudd5cWeK1QyJptoe8dPN4HZHqNDBkZvuAyqeqQhQ0NMT/WprWjXqRoocQYszS5Q6/40IZB+xAjmydOwQd08wy/e/xZ2t5hnt4cwgQx//ybKs490kSAus5ENgFOHT4VeXEq5m6oA1NjWsXpdqEflOGcwu5EIapwmfcBuXH0w1oXLb+3XBJFEZ87jvPfHFdYBXbH5BYrWdgl41gP9brf2Qk9lhzgWJyXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fl9AdfRgXtjR4KsYG2oQe0wtJDSIs1G/f9mlpHW09w=;
 b=UF7J+nnM+jNBVgE54KLk/4YJoLfqgpXIPipFTs8JmxDOGjIw3HBsocCtgtN8wrRXCbqt8POU+YEMNBzulTKdQxQSvrhWy999Z+2MY4EMIL+phfr5xkYeXh6tbOM20ralUETr6wHmbXFpBeglBp9zQ3Gb85Q82r+O2hxgUZsas7btBbX+rVSyBjqBR4Zl7DCHaXoxm/yByekFjz2skkk+mlkLrze4mRWikYaZYSdQ+PVFPRfpo4GjQtGlC5ov3tCS9qqXbnNIyKgOPxbOX4h1rmxB+pZxYjTikULUjpHk4CejZLLrJTbGOD5ilafD2vCTa1+oQjF9joGWhO1Xo3ShoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fl9AdfRgXtjR4KsYG2oQe0wtJDSIs1G/f9mlpHW09w=;
 b=IINGZJPjXMAx3blx0x/0HbCNhrc2vlPSJ8bQ3S6TDKve2/WIMioyBytKEAwULi1mBX022tWPcGoBbRxT3uG3SFzpVjwOTstR6vBGkzkAXcs7TboRSSsWX1dsHfwhm44eakmjIBZdXbPMPshjp+wYU3FQc7DGoY+3AXMtyRV5yf0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1616.namprd10.prod.outlook.com
 (2603:10b6:301:9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 09:05:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 09:05:17 +0000
Date:   Mon, 16 Aug 2021 12:05:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Remove unnecessary ret variable in
 rtw_drv_init()
Message-ID: <20210816090500.GG1931@kadam>
References: <20210813201418.4018631-1-nathan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813201418.4018631-1-nathan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Mon, 16 Aug 2021 09:05:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deb36ec8-f175-458e-ecfb-08d96094f76c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1616A47DBDBC088CEEC9BF988EFD9@MWHPR10MB1616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sux69Fe/VZLDa4AGQS6+SzUvxTjGSJJewRrnNewAB1X7Bx74n4XH1urxUVxgJL5oDFmpThlsgPPN5JF1r1i+4QNUIMwr1IMYXYH4fOdT3Fx2WtXnZuL2qMNtuicAEIj6Q5fKlGuqdJ3wAGWJfDSvmHGKB6eJ3eC2YEpuhQSnyABXhYI1jvwEhL6df8hgC5q6nOPaaRZTyWwRKJySop0PWZm0yKVv+4hOCxtb7AJsq7shsvdFtvR47V1IXCqG82qOeZeof5AIhRV6UfN8fGrOw1l7wRyZeXP4v5Js2j15xXJ+j2MBtKhZP5/4JwQxUfGB5R1zVhZWwxruHwpWPyAH8aVQgMuCp35wpYIyP335Dd6Fp8oyNWZHTd+4a3wibxXurJfU6wMlHf+b0TCmg2tRYGB+xMplFBMv0YfC4ahHinRVq3u4AfHDZTKa0mH8hvule8vusHL/ZzLbeSVWj1E4KiMll3WKvZ0+YqV/r4lhb04+fBnw/Gxyj8PxNX7Wrqow+avnmPJDAk3W95oORAecX5wvTCu71xO93TLercCw2HPjWeaYF1yHTTd4ZgcGypTpqN5BY5CMuG88DOlPTava7+AxV/PMOxGZNg5MT4h6AS/0R3e/x6U61BdQwZ8XJvL79WklUylOu//wHildoibfULOJsvT6/0nf4mW/2yhfeYIU+eIB1ervLO8Fd1CekHVCAo2c9nDglBHIC4vALrmN8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(2906002)(956004)(478600001)(44832011)(8676002)(33716001)(9576002)(26005)(316002)(38350700002)(38100700002)(4326008)(186003)(66556008)(6916009)(54906003)(8936002)(55016002)(66946007)(6666004)(9686003)(66476007)(86362001)(1076003)(33656002)(6496006)(5660300002)(52116002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ArTzYY2QHNy6aUqBdHMzelZTFzypz2enjWeevAvkhn2uFDe76CyKyPAhbciD?=
 =?us-ascii?Q?DgT2T80HJqkDXcuZtuv//QcIipN4mJCociciOw1if/jN6cEKSpwKNv0PS2Dy?=
 =?us-ascii?Q?RIhV2yezl7VRSdjOjS3IwW6Vst//7sow7vuDmwcQcIGMmsAQ+UknaZIVSPWI?=
 =?us-ascii?Q?j7mNKBFtnVifDgtgRH/RBzPieTTLs1wsChVM/Drbw3U/O/neoqCr1J1uMqMA?=
 =?us-ascii?Q?KBnDCKyTchZ6TQD0JwHN2DoTalMMYjH8cOxAjFBhtEePLAFCqlLSB7A0WcFa?=
 =?us-ascii?Q?THR+Z3jhxbZmCNTeqI9WwaWLKvM6JnzVU7Qqbd64rvgxCnWvByh7xiqGubkI?=
 =?us-ascii?Q?ZYKcPhzdo0M8sfx78NCwyPrxMsrWRDkoicKpbjsAgvrKHUNnbnrYfz3WSrOR?=
 =?us-ascii?Q?ft5vm20JD9OTXwpHjya2peZREbiywZAbLliaR+ACq33dgd4X0Ans53V51adx?=
 =?us-ascii?Q?dsIP/v5BK9MvGzzjrwOK6Uvm6v5SI7jIqt7EiwfAIkT4lY+NL/npY9pHH1k1?=
 =?us-ascii?Q?GYFC5VTYNF8rrFRrrtoClNBemJbciazkSIR6Dpm5e2SkRJqalqUmQoi5L4H/?=
 =?us-ascii?Q?HF8I1m3tzhIGri+GF1X4N/5tPs1+5826JRv/4brUrGhyVnplo1NBHYbpKtWI?=
 =?us-ascii?Q?eYCGVM3PHotL5VXyZMdTCzelcbWujLcL9Kjj6bhXJZ9v/ZSUHPwtqvmcqWvd?=
 =?us-ascii?Q?1Ab9s6136IqSmWiifz9FmKeQ7Ch0R72tjaJRUw5Xj2gYaQAoL5BnWWKRJ3la?=
 =?us-ascii?Q?cQen2qjOOUfJtyjUxHhA4IlyznWlqa7g/zXkZkmyDmtJ++NzfaVXItxVB+m8?=
 =?us-ascii?Q?EOFvvqrXg14lmNkkf46ng4RNJD41L2AeP1y76rGXQIPPr33dNer3zYnGWMRG?=
 =?us-ascii?Q?yQ01S3/aO1XmqBxhXOrcrIDUexrbAB5C/wXXb8cvh3KdN7CmVH1yLCs6MCh5?=
 =?us-ascii?Q?XC8hggPwIK/eb19lxag2b5fNhKXRhNW8gny9ouSydb4YaQ3CBOiT0y1yDSuq?=
 =?us-ascii?Q?rk9I/YHA/NNV+jPVnTExZgVHlvARQLlgN9hhuZkZuSu3wWcxJTJI9IZ44yFU?=
 =?us-ascii?Q?HazkRVgPT9aECkXoKh8PsD0rG6ncz+Sxcxf6jl4P9xiuoRf1suRxbz8/iRTb?=
 =?us-ascii?Q?0WLhNtW79HT3hXSsXS9f2ZvzBeK1iT1B3EqrP65PEpP/Ucrm6UW1P05/Y7Ip?=
 =?us-ascii?Q?6J37VQBa26Ij0SJwJFcyznfWAbLg8I9elMqrFvFAvpGyoC+4O9KfsqTtYE51?=
 =?us-ascii?Q?Wyotdiz5yHWMJKCsQKx9Nbr89wE+5910oH7vlGjL8ccayLPum7n78cBzVyTJ?=
 =?us-ascii?Q?hUYysfjRlwVJMaP0mM7i0+7E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb36ec8-f175-458e-ecfb-08d96094f76c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 09:05:17.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLK78F2ZzPj9O1FbUHTTeYICmdXjM9jqVrvxKg2F0Q5UegwkFNptFj6Ka31alBuLmm0LrlqiafXINt+xQXLIGk6yKGei/5trxanhZOCB2l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1616
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10077 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160056
X-Proofpoint-ORIG-GUID: 1VJGN3M0E8vXIv-ZC0PknNkdcSd4JuEj
X-Proofpoint-GUID: 1VJGN3M0E8vXIv-ZC0PknNkdcSd4JuEj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be honest, I prefered the original.

	foo = alloc();
	if (!foo) {
		ret = -EWHATEVER;
		goto free_last_thing;
	}

I like this style of error handling because all the information is
there.  You don't need to scroll down.

I don't really care about this specific patch at all.  It's a small
thing.  But we had someone come through who was sort of obsessed with
removing these sorts of variables.  Just because you can remove a
variable doesn't necessarily make the code more readable.

If you're doing the work and maintaining the driver you get to choose
your own style to some extent.  But I don't want to encourage people to
start sending these sort of patches more generally.

regards,
dan carpenter

