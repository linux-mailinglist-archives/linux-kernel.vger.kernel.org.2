Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5283B3F8649
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhHZLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:22:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1236 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234144AbhHZLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:22:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17Q7c7Sa006537;
        Thu, 26 Aug 2021 11:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jpWsWSMb/fUSRbHbaYV6v4+Z4F7VAYM/htSwnQ809HI=;
 b=YrEDiNGW7vT7U7P+poXhw+6+qWDjRXic64ykwkwjEaD7z0QTiDGjcgwS62eacJ6dDycl
 K/2+mm0UcSOB1HIPO/L9JZa/auQTwxl9n0X78+nkK/O167ldifWIP+IXwtCjmF2e738u
 Z8XBDPTw/IKa8bl9yYRGStQ2U/GDGlAYx3QgZfcxyOzLSbdn7K5xqhk06HD6yimSHJJ/
 O+BYqdHiGvJ4VX4P849J6GD1pFBO/rm2MHEqLdMrp+UKFpikCzbLmIpSkHVGenW6u4cC
 ynEQFXwaksrtvci+iJCjFYgRowGzaBrRTbqQKZ8FHySVeInipcx3HU7HLNCunUmBsFTO OA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=jpWsWSMb/fUSRbHbaYV6v4+Z4F7VAYM/htSwnQ809HI=;
 b=ice9uuc1IrY4PBch7QROHgUprt0SUR7EHcBZmBN1s8inoC5Lt0s6e7bC+DOuFVrws/6B
 ua85ehu1RjxxAw2gKOSSL1WXOJJ3cGHnjF93ElhXoawdLZeMREvrBS+wov7/URrQHjly
 McUCc96ufmXGaRXxZf/3pWZmixZDJQ8YJGzYLYGbBpUZ6POhc+MRrLRfg0BOWv6vRHuD
 VSZ3rvlnT3IwiRxKTU5+W3gt0Stg+Sl4gakopCxE8V+BOtmxOEaixNjHMmyoSWjCKYSx
 O9fVg0mIAfcAscGI8q01wySlMEzC/8zgERq/oGRzd6WuYTylkI+rT/t+zGnFxR+ZoXxU AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5gxqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 11:21:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QBFNG1132085;
        Thu, 26 Aug 2021 11:21:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3ajsa935ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 11:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrsc7ao315VFMIHwnaECAUUXlp+wzqGEPBQuBgvr1HY4NTgR+vSaNB6JnsrXkU8zVRHyQ5BYth8nZJxaETSik/Dp1VH+Dm6rI05X3gUjo9dUFe8QeNS864O0pAcqI9YeYG9E+qHOK74UaMcFUgY2XFPuYXMozKzWbyz1yOTkYvpwyD7/DxuM9z9Y5UF67BwOmMrX5fwQ5y/kPsehFYXCBZBV7vIo0XpCXeWBuNy4JAEwUvPkpTkM9IAMhsiXvMtCk4I8bmVq1t1c2lxmycQb+9ITH61cW2dpKnF5a5a5CNHyanYvH6J7sZQcP0n8/9rpx+lowWERAO5FbEBzm0k6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpWsWSMb/fUSRbHbaYV6v4+Z4F7VAYM/htSwnQ809HI=;
 b=Vp9kU2mpk+5YIwmb52BRe6rMJqBLMWzCrjiCirR+RbHXZknTCyF2HSDK19Coms3Em62SVXQl0G/aUmqUCVH8dBZELTG8H5CEzf2OZ0JDmny7GBl8qD3tIdmskIjpk8vKRgt/qyGovFAcBezvrO8fLTdJAqq18TC2adpzwlV8kk9hedW7Lu9rDwobG7Ajo2aqcvRxbmaEHVujjgKErznol6dfRb7TH1jG2rxjtnt5nDyFY+GsIcy4agKYOxcKaCe9A8t0PAspRImXWq3X3cw0v6tCAt8Pe9x2YdcDh0cLCaYiZP4B4u2It20smG2uKVcbKuK/eayJBDNoPiFJbPEOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpWsWSMb/fUSRbHbaYV6v4+Z4F7VAYM/htSwnQ809HI=;
 b=aVRj/UxCgNVQXTHunOUEweS9w+JphiwI7F+t+8xE3boJUgKpARARknqPhKNnjv+36Zh4xWaWM4lcYVrDIIuShGq3fxT2UAJE8JTgPUVyv/pyjPXzvkjHT4Mw74/vXXgNWs0QFgHPDcOZHR6SYNJMIkmfOmSuMZiAZp8VtMH2cMI=
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1550.namprd10.prod.outlook.com
 (2603:10b6:300:25::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 11:21:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 11:21:44 +0000
Date:   Thu, 26 Aug 2021 14:21:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Pavel Skripkin' <paskripkin@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
Message-ID: <20210826112127.GZ1931@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <f5c20e0f1b934e04ad11a3627d71f5db@AcuMS.aculab.com>
 <20210826112745.5e1421ed@gmail.com>
 <a251767ca181405b93b5ea55a26c3ff0@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a251767ca181405b93b5ea55a26c3ff0@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0002.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 11:21:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6946d79b-3002-437d-8607-08d96883af8c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15501A439C5B483C9474F66C8EC79@MWHPR10MB1550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3y4GQaC+ftCz/BTRExkmZWW4epwj6WzeXwc6DSWdOyHX7A4ozvqYYUxLQXb446LVC//hv7fUE99mWd3/gvztT7dK+QseMmLwnzG55Nkft+FYJoEUh3/K2EMGHeMRunmlJ5utKIO8DRxDIMU1t6rCPvf4B9B2i3hM81WnPZJQDVXYFBAnAyNbKKGWFSOVVZOAy/O9Q8P5TfaiPppqg+fe+w0hUpMddxIu1P4UZluypHaO0kf7CVZ/WS+SpebT2YMJZ7WACiPF0RIEiOgYCBTSH5E5sTJ5DuXe7lMaOgk56PXen5hv5Rry1Qt34PXP09LKxqf1BdPtbJQ6hW6P9bRh4gm9RtZSsO3QcFCqlnUO4jVFcAolk7dBxkrWhtjkHFPaQ1ieRWLAg3VKeICA+DLwtEr59KC99VlusH2c55xuDTLcE6tSTPp/q9pY/qSdsvjuzpEke1IbBTK7EfJBOwvzX665lex+5bq/grU9g/08rg2yif0u5g9M0X/eOCpQjexx1niRlutOIEJI7nmlJNiW2fa7+1xI//t6zUdQ0s4eh26BU/khRuUyZQAXOVQSPxnt28zEoJ/CIA80Rp91/dE1Z/UVFlut5KdWNZXbydj08e1el6dis7wEsMcVVTc70t89+/VRe1ByEIXWxmTcFKKQPSRj/5Q4LehPkc62eu90jAYsbfRrRIpzV9WyM3e3lQjZjbMZOvwpUmEB2QAyzkpnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(38350700002)(86362001)(83380400001)(956004)(8936002)(8676002)(38100700002)(1076003)(186003)(6666004)(33716001)(66476007)(6496006)(55016002)(52116002)(9686003)(2906002)(6916009)(54906003)(9576002)(316002)(5660300002)(4326008)(44832011)(66946007)(66556008)(26005)(478600001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qcx4c9+5xK7a/0Ms2NAuA0yl7SqdREbp5y4GOK3r0+opZViUAI8oiQdPgA2y?=
 =?us-ascii?Q?35Bl4x5Yelt4Q9cv18JQAvyPWDJLZxyCTQAVBHIEd8A6dE9RpyKgvm6XDIs1?=
 =?us-ascii?Q?FxVtCBhQ2dygnv9I/JNxjDFq/VtDBQQIxjp6ZBJghSAI3AeDKMBWMxuEbKej?=
 =?us-ascii?Q?MKcmsHe911X1mZZY7yyjJ1o4JB54fppFYyqq+RVnhUS189WSiMhjtNBHiXSR?=
 =?us-ascii?Q?lpExNyVKRO4rD7qtwHcJeffCOPzllHYjNWtpHHOJ2tueL589Kt46u7ZGiBhx?=
 =?us-ascii?Q?WOGyYG2yrev9Xbz2AxxNUb1yuiakOsNrJ4wjAQVld7hJf+2UksIaox31qxb2?=
 =?us-ascii?Q?GflCDhlrO54ILZBCtRUexwmYg1aI+IcmgiIrEePWKsviHHc/9tBI9x/KtPAv?=
 =?us-ascii?Q?pfM3BxzJdVp8rZMxARQCtmZroIxA2wiJlzWWvnA/HVkBgm7PBhUI5beQ/lRB?=
 =?us-ascii?Q?IGfRmXwnNICBTHcQw2FD5JoM1ySip9bQhKgQt39Cgyn3Y6LS9JncMzXewawn?=
 =?us-ascii?Q?21DVmdDA59NsVBBao1fvVfmBP2qQHP0nZ0uY8UlZs9vah03IJOZDAPgpISgr?=
 =?us-ascii?Q?Xgk1qMv+jxFe/4UvJ3Gas13dP+pdpuJIW2kexu/dUEr4lGAo5Wsr640p2dat?=
 =?us-ascii?Q?6Grd7liIuOlcgM1wGWjM17tpoUzaeGp1VPzSJLVtqphLw3r27X9duzveHaMP?=
 =?us-ascii?Q?fnuom1cwwR/4cAaGjpcvE2xhBIaeXISzGEAvEB+f7ciRUZ69gzcx54gBgHU2?=
 =?us-ascii?Q?t4pS5D/9eiaLkPu5icoHPhiIVG70TeJ7xfzeN5W8ovHaMgNFCCny7LteUtJh?=
 =?us-ascii?Q?HSJIh/Y38oPH1OjcqvwKx0RxtwDuJDwP04aUshoO41tLUgBEvLFWZ5kWl5Ks?=
 =?us-ascii?Q?PllTN2hv2Z5CR+xMePD7VApClA45uPE9OC0QNbwjE2KE+JQ1Rsf7uLLOfhmv?=
 =?us-ascii?Q?mhYXqXsWwghaNZ20sS4PNIsFH997e8ngxKFYhmvKwKMA9+Wt6abiYdveVd1g?=
 =?us-ascii?Q?9f3OhIRSqKQCZT4kG8o8d3KnhgIBtueeqwVgPPmHndmHKCV1idyfBSXVwEE8?=
 =?us-ascii?Q?ciDHuGF2IVhTW4qGuCpOvAFeHkYZFVVodqZ5jsBNqK3eXkw1W1IPUgY75IKc?=
 =?us-ascii?Q?zmE2NjJgIWz0k1cUsKsT5us1BGJ/8AAGlcTvlkujcMWrjP5bMWF30r8C4/8S?=
 =?us-ascii?Q?LPIZ7yiVgLJ1W6p9CfnL8e2JCcReCuW3o/woGKAR6ZJiBXSrTD4J6wjO0cPg?=
 =?us-ascii?Q?mZ4X2CFsro0AToXVwRCW80RsWcZqWZNxcM/zB3rpm3O8Cr7stIF+XfD7LxHv?=
 =?us-ascii?Q?6vt7qfBBB6PmIqGBoEX5oX6f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6946d79b-3002-437d-8607-08d96883af8c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:21:44.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQceaAY9G/CVzZzHW9u+8YY8+chriFXYnyT589/+lYMqwNR2f70IW6I+ARK2rTTEInUvnPX5vLRW+mPKhVWFu51QMzy3l2HqHUp8qqD0mh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1550
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108260069
X-Proofpoint-GUID: vTjgK3wpiJK6BUQnKiqq2nt6Wg5dcPvs
X-Proofpoint-ORIG-GUID: vTjgK3wpiJK6BUQnKiqq2nt6Wg5dcPvs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:19:40AM +0000, David Laight wrote:
> From: Pavel Skripkin
> > Sent: 26 August 2021 09:28
> > 
> > On Thu, 26 Aug 2021 08:21:34 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> > 
> > > From: Pavel Skripkin
> > > > Sent: 24 August 2021 08:27
> > > >
> > > > _rtw_read8 function can fail in case of usb transfer failure. But
> > > > previous function prototype wasn't designed to return an error to
> > > > caller. It can cause a lot uninit value bugs all across the driver
> > > > code, since rtw_read8() returns local stack variable to caller.
> > > >
> > > > Fix it by changing the prototype of this function. Now it returns an
> > > > int: 0 on success, negative error value on failure and callers
> > > > should pass the pointer to storage location for register value.
> > >
> > > ...
> > > > +		len += snprintf(page + len, count - len,
> > > > "rtw_read8(0x%x)=0x%x\n",
> > > > +				proc_get_read_addr, (u8) tmp);
> > >
> > > That is broken.
> > >
> > 
> > Don't get it, sorry. Previous code did exactly the same thing, but
> > didn't check if read() was successful.
> 
> Look up the return value of snprintf().
> 

It's hard to understand what you are saying.  I think you are confusing
libc snprintf with the kernel snprintf?  In libc the snprintf function
can return negatives but in the kernel it cannot.  This is not going
to change.  Any code which checks for negative snprintf returns in the
kernel is wrong and should be fixed.

Anyway, the code works fine.  snprintf here is going to return a number
between 18-32 range.  It's not going to overflow the PAGE_SIZE buffer.

It would be nicer to use scnprint() but that's an unrelated patch.

Also this is all dead code.  It needs to be converted to sysfs.  The
caller is ifdeffed out because it doesn't compile.

regards,
dan carpenter

