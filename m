Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C15411399
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhITLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:34:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1962 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236871AbhITLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:34:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KBOStF000392;
        Mon, 20 Sep 2021 11:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=rT701QrWcrdCJDjIQyJlvDfLuM+mbsXc+aciyeBGIWA=;
 b=jfpL6J/6zgW3Ujn64b2QEsCciF/wnecpe4RzUx7JI/n69FWswBt6pL/0hUlpbbXC3Rho
 Vpkl3XBxt0YF3RZc6Gxg3X7N6QVTEH7bH4R1Q8E2V6XOTtcs/YrDbIfNDD0liil3RYgM
 mG3XxXPfSFir9Tbl8hmQOvVpP8oSUU1mdNIarKuWJIXhrGRGhr1LungwweKr7xm16c/n
 OMkCi21BCb+q+8f98076df/myncDNk9Tuk0kzRLOyow/jTKD2x5JDou4PNxmxBV/th/j
 jOuzmk0ymoyq/ujn3BPvZQ/5ezhI9vV2++2OmW6zghv7ojV5/Tc/CQvZ5oyxaqiEapFY 2w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=rT701QrWcrdCJDjIQyJlvDfLuM+mbsXc+aciyeBGIWA=;
 b=qUVubIR4V03L1YkSWd+dcr3A1tBEn2zvdo/4tM01nOGGUFNrPoiraSKe+Q8tBfsXqbdx
 ktp6komuwF4GS/VnFQQVC47NkjE49O0Blg1UE5odxAZWNzHtEARADq0YFbAJDsG952FV
 50uP89xnMFmNMd92oIOSJYOjeSI8FLprHE5+HeM0UVSa9oLPIu9GAKyDgaWlwbr/F/aa
 7sVINM7LBPLOpPdOndBbfGDINnUj1efKCa2KTMMWEaI9QD9L67hOTOutW1xedjRZzsdW
 zsufbYs6cpUD5TWiGxgo1zhe1QFbrxn25gjxswWZR3MsdSyloR19R5QUx2yxMymbHuC6 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66gn1ywf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 11:32:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KBVT04095836;
        Mon, 20 Sep 2021 11:32:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3b557vdjpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 11:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG3GaZQZ7urHUOb2CKkOUu48gsl5wjLyoKTt+4r5usomBSo0to8zJQKRnGn4l1zuMEeCy2GQ3Llj0kT+sj4sLQTxbbwBEfRrNlh8zHtrW26DQkwccWtSDRFqXWtRnPwZj/9izzmRcurq2+oNXDeq1xv5K72AmLnvJiWfSUI9Ym72YRX/5PM0vqXW9zzu27xIKsgNAlDQXLoBagxR/Gi9kD0+KHmhFZGz1vCAvoEmwA6f+Xz2jw1VlNAPTtt8KqLSn2NyHvKIGzYM2rTbk3AP8MJmDAoDFIiHmoosaNpW3AMoDuAYqqIHOfP7C/qPSN7Q1ZkxjkjHbyEKhypmsMjaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rT701QrWcrdCJDjIQyJlvDfLuM+mbsXc+aciyeBGIWA=;
 b=de2m86aUvv9Nfp+1KP+P8BV7un2ZIAies/HX2MYli4Lc7I2LF52DoXh6hFKBmlv4G/BRP+WiZmIJOG1dsI5qMlMJqDey7nIeOG9CR9+3qEwS4fLFYtXRwvdpWmQxEXq/l8twU1zuunc0YeDv+RQeh4WTugwMixYQOtuNPOs4/74Hd4mw35w4ov8C43LS5DI7Huyvfk0S2NeXk9AyO05SqKhcr2CPhjxT7f9FshPI4MouTj6OWdCs5LZ9R+ucTPjqMXALxYb7hXE0IlduC/c/eWcalXQ7yhaID7NqbNqC7vpwOtMEgLeutByLMi3/I/mLvbcKaCqvEcX0f60L/AJijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT701QrWcrdCJDjIQyJlvDfLuM+mbsXc+aciyeBGIWA=;
 b=qEVIHP9n6AtnfAazpll5nvfRthLMZKYS7JJezdghoBp1fYzZ2bvV2jCQ+6GLOhTNvEx1ziDRA9CJT45BgyIEoS/fZ4qer+efN2X5JqflTMfghGOshtOEkLlGfIrrDd2IZILGS0V+6lB5sggOcC6aGb/AT+UvA74vOQSvCiObN28=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2207.namprd10.prod.outlook.com
 (2603:10b6:301:36::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 11:32:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 11:32:38 +0000
Date:   Mon, 20 Sep 2021 14:32:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
Message-ID: <20210920113221.GP2088@kadam>
References: <YTub30ZRG3oLbxQW@user>
 <45c4de06-f618-4352-91ea-885edecdf8bb@gmail.com>
 <YUhkFvz4BpLv0eoN@kroah.com>
 <1651026.4NJzAxWbHA@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651026.4NJzAxWbHA@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 11:32:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdd34ab-9bda-4ef0-1179-08d97c2a593e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB220778C5849D90F1197BCCDF8EA09@MWHPR1001MB2207.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tmg4fWL4zI3S0MNEbrhP5UHG2ASPgEPDJGqouFsrmgK2aKJt11BPAbs/C65q2XDnc0W7lF5hmJ4/NEYpZX1F5YIp1L/jp8yKSUWdbnxzoNEhBa5HEgZIOWeSNUfw6FteaA1aJCDyCXzZkKuWdW2cErOVrAv5989tYj1GUNtoUix0MUNoa4ERTzTTCHllkpMGoe8hepkHO0XutuWdmCZ9myjBKI6Yb+56ikbYcrm5/iO8nq+AugQpgh/82IlhzGTwqe8KzE2hbXLMzMZAHQnmYHAWrNfzPZRkXQj3w8Hxff/2dAei4uBFBUg8naoQJOvK4Hcb2z99oBRuM+aPVcQaZx3NLYIrc3YChXZGwkQdVJZYGSMgl8/5aEA104JAsrIyfTByr8FzmAMihEcoW1SZJvNaobmdov5+Kc/N7tmRuT4ZHz+uIKdEAl0C+vahHppScp9P/QmNb108eqCaO5jBNJKWJysYh/bNjZZcUZVK3fphdKdwJIqSTBPf0GqdxcsdL7X0C1Fut9hltQ2iNmluK4SBGGFNtE+0Cjakk3ZeCBwgOqgsoAiAZShynKbyFEkYpIwq74dvPIKM4VnJE2Qrjp8lRsJLb21C8U8lEKumCGJV2Elbzvlvhpp/t5WAvEnHX/FLYH6ALhkGit9JoldlsHO0v3wLfNAtVqPrx+vRkXhB9Xg+hF0bNVXGjzz+0EOy02NQ8BrZIVCVVK8RRRS/Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(84040400005)(33656002)(53546011)(6496006)(316002)(38100700002)(38350700002)(956004)(6666004)(2906002)(33716001)(5660300002)(508600001)(52116002)(44832011)(4326008)(26005)(8676002)(9576002)(66946007)(186003)(66556008)(66476007)(55016002)(8936002)(9686003)(6916009)(86362001)(1076003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGvD2mTWluZwBddSuQW6dsrWrm7C6Dg6rfaod9kow/SPK5mmwjZTQNk/PNwq?=
 =?us-ascii?Q?4MQKyANlQmL6tl98W7R0+8yDbID29JE1dEmcg4b3QovHksTMez4mU1ZqdjsB?=
 =?us-ascii?Q?MskbHJv+oRq6uew/P0fCDvQOzsX9nKMI36PuzfV6vp06UmSOX2BevyhDcykc?=
 =?us-ascii?Q?oYCdr86PGrqc1mpH+1DnMO6PDLoh1LngixC31aE3mi/Y1AtvpqZyx9yN1kYE?=
 =?us-ascii?Q?14u2HZ0FgfqeuAfvD+8fmjrgwMCUVaAgb7sENbV0wMERSfnHoSGHw+B83pdt?=
 =?us-ascii?Q?p8+TUmwsATRzHKMFb0d2byDqy9fDDf9aO+jHpRXSl9es1D/8gtm9ZafDzJeq?=
 =?us-ascii?Q?lx6WKOS39Ur7mpb58plShiljNPkRBNj0S2aDmjEcb/zbQjKaWnPuTvR7uo92?=
 =?us-ascii?Q?Y3Q955RFOPz8ZtZYsuqrj9xr6P3bRZ8xI+xj+NCHGMSXk8CEn9I1tr8jullT?=
 =?us-ascii?Q?8oscxctPf/mJDwPKSvZKzRmTqWncT66G8uei768i5A8uPel+nI1bvF3RIwmi?=
 =?us-ascii?Q?1jkU8N+22tWTV/XmpZKUSKpI5jegpVr8lezAQk67G9vL2arvL++QdJvFhc1I?=
 =?us-ascii?Q?1YvP5jfeyi9stkVU4wJie2xe4efJjgEtxIBkWR7XaxuCqud/XyhEprhKDSYC?=
 =?us-ascii?Q?O+ZYu5XhEEZAalXg3jLts/jTz+pNNpKlOpC6J+P6zYIxBXLQVX6aaSUfeMvT?=
 =?us-ascii?Q?616pNEtKNjpvi7D8uekLm6mmrqq8iSG+Sr+KDbR14boS914pHVD/mIPbocqI?=
 =?us-ascii?Q?duCEazxAutiehAp00DAK+8ABGKQCJ6PbXxeYATK6qgiX/ixjKGtqEhcnJcuG?=
 =?us-ascii?Q?8bQqADopDmRX9miCp5r/zrkZWWo/8QE5RRyWuEqyUisDtXGnh0rOWG/WI7qa?=
 =?us-ascii?Q?Fjp6gDhFL4247pt98jz5XC31zBbrgVClQzyeQj74vrwDcBgjU48jonywMeVi?=
 =?us-ascii?Q?3wXKBHq73rp2xmG1qLB7GlPoSa5bnEsz7RNpYOy2sSi5Ahg6KqEOB/t1rF8F?=
 =?us-ascii?Q?OFdRVYtTSfJ2J9wu4PZSybXXqFG5wqX9roCRF8/TQcBkMv/sDKb269EtNC9e?=
 =?us-ascii?Q?MioF2v1KvIjEwk/JFBCLBNRP3GvHKnv20pBu69rtDv2hFHur918o+zkiw2J+?=
 =?us-ascii?Q?ht3uzEs3/Knt0vltVY0HIfxiMl/QDdw4Bjis0VSTwZEmVleuKqIfuRHlNvUQ?=
 =?us-ascii?Q?OrhPBVPiDzAH0flmdrMeZqUA6LuigPrAS2wCudQmgknsB2gUylw8sUE8FQSK?=
 =?us-ascii?Q?ScFJeJIIjcq0G4YBNw6suD0QWykJGQ+tIgBZZkcGa9l8VCKE3qnSb/BASG99?=
 =?us-ascii?Q?x/m3ZQG6GstpGvuHrNrMS4WE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdd34ab-9bda-4ef0-1179-08d97c2a593e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 11:32:38.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqirQHMymc315yLeuc72i8dUWHzETDQTOjVmSPKYU301aUw5qItGjspnkD+u8XkF2GEdkVEKxBkKks8PgNRlvvqO3E7wwAjx4MOCq8fbDTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2207
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200072
X-Proofpoint-GUID: xO-TqvTrTpjvIQezg7Rol6jwcB5AzRja
X-Proofpoint-ORIG-GUID: xO-TqvTrTpjvIQezg7Rol6jwcB5AzRja
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:13:54PM +0200, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 12:36:06 PM CEST Greg KH wrote:
> > On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
> > > 
> > > 
> > > On 13/09/21 9:48 pm, Greg KH wrote:
> > > > On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> > > > > Remove the function power_saving_wk_hdl() as it just calling
> > > > > the rtw_ps_processor().Instead of power_saving_wk_hdl() call directly
> > > > > rtw_ps_processor().
> > > > > 
> > > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > >
> > > > []
> > > > 
> > > > Also does not apply to my tree.  Please rebase against my staging-next
> > > > branch and resend.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > 
> > > Hi Greg,
> > > 
> > > I always do rebase against your staging-testing branch. Can you help me 
> to
> > > understand.When we need to rebase on staging-next. Do we always need to
> > > rebase against staging-next..!
> > 
> > Yes, you should.  When you are working on code that lots of other people
> > are working on, there will be conflicts like this, and you just need to
> > stay on top of it.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Sorry, Greg. I'm confused... :(
> 
> As far as I know, everyone here make patches for staging-testing.

Nope.  It's only you.

The staging-testing branch can be rebased so maybe you will write a
patch against something that never makes it to staging-next and everyone
will be puzzled.

That's unlikely to happen and we won't be puzzled for long because we
try not to invest too much time wondering why patches don't apply.

regards,
dan carpenter
