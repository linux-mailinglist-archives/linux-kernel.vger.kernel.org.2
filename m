Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5F34132A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhCSCje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:39:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhCSCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:39:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J2bpJn192888;
        Fri, 19 Mar 2021 02:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=+E1f9tivUCIefRjJU9VwjSqQbSM0U8SJTw1fZXF51WA=;
 b=eT84sFfx3GIS+vzAJV6aK86cxpO7d/ZKXlaj5jb45ohgd1CzEr6YahrwpCanqdYoMKnx
 X4BZssMmran/AXRm33w7kqzdlUbBl0v0HWKIGW3+y4SAUD9t0psxNyu/pVQaHKToYa/M
 MvjphtyDrb02UBdoNJuFg06capQ+h9cyq4lpccaSkxnCikS/CxxmhFByxjWQx3Gpzho1
 ICUE8+EuGEWYzJji2HtJDdL7crAPVlgMWUw2MSQ6dUcmF56bqfRaha2SxdLaNtkMIBsy
 dedtznKDU15wj5yYbk/65xv07AxElYPMT/Ouzvvc/2E5l/2OafJah93ym1cJ+0s66x/q Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 378nbmheyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 02:38:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J2a9Fl181038;
        Fri, 19 Mar 2021 02:38:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3797b3q8gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 02:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgIcPCjsm2fGENcK4PPXBnioU9l5BWpNdSR9+Cl3O5rFiEUaZmnr0jXYMSKl07qxN8umXLWkBwvx2ygMMIdC1QImYOl12l8Sxxzwveur7mmRTfHoq3A4d2rJX1g+mwZ69JUGOPgi8tDrXF+nKaRw6t/FQ8WZLliNIXoNbynNx+kH43gEaVk2dVgF3d/0z6RRp+hw3G6Q1L+bmJMu8In9iToS2WvLHvlTds0jvn4EfPCJojmvVaDLD8kTnpTuyOqIJbMNWLoCG7mcsYe/OIXZYK+rqmEw4bdhrCAu5J+W1VGxW7jO0h+7ojTs8Ehch6uiPuIdirTvLaHPmwVd31ZoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E1f9tivUCIefRjJU9VwjSqQbSM0U8SJTw1fZXF51WA=;
 b=TKYO0Xcs9oUnBx1gdcGCyL1f+wrI54Bm0yC0FhMtH0vZBJDB5iJUWE5qfYHzhdVK4Fq4EWgsG2oxE1dnKB1ny0NUThukuPyTo4WDtr52uojzieBnFuDK/KGQrDQ8Fj6mK4hNmGdRPXADu2MAUx12D0t9jke625YzZP2PQIuuaClAcJWBLAi/9lSLtHPkfqHahrMRSuBdsD6xdwdVMhZHPDZgJHG4QcS/32zXSrh7Hm9cxJbnOyuJqge/h3HNoGS1+TUOP14hkFucgjRb8/Fg6yqaU2SpsLvgBSORL1/QPGMRYjfD6XiaQ90aI0TFsim+DNd+oe9v8cxIMwuEXe+NmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E1f9tivUCIefRjJU9VwjSqQbSM0U8SJTw1fZXF51WA=;
 b=tzt8CUij2+UnGF2/4wUV0ujNIlv88nG1IOJ1EIblktR1dpeLuLllEtEttyjdBxSlcbQvIiZ24nSqsqt5Ou7kjNB1FQE1IfxB5yWOXsc9qgN8YmHU5E0GEG9mnYhBBbPw5iTpUbzDMouB7gukYdJt6Q4UrRPjUCVXfs+HsrQnENU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2615.namprd10.prod.outlook.com (2603:10b6:a02:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 02:38:39 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 02:38:39 +0000
Date:   Thu, 18 Mar 2021 22:34:25 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>, opendmb@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
Message-ID: <YFQNsaisCvYksA4A@Konrads-MacBook-Pro.local>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
 <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
 <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
 <3dd81519-4a73-efb8-abf0-0b766f993a8b@arm.com>
 <a7a858e9-d6e6-cd06-85fc-8826e45d460e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a858e9-d6e6-cd06-85fc-8826e45d460e@gmail.com>
X-Originating-IP: [138.3.204.61]
X-ClientProxiedBy: MRXP264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::28) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.204.61) by MRXP264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 02:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8036bd51-0ee7-4486-0094-08d8ea801a57
X-MS-TrafficTypeDiagnostic: BYAPR10MB2615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2615C2FD561450163ECC99B189689@BYAPR10MB2615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV1ryt3poyJ97r86JxIL+OPT8CShfJTZQ7kB7nvak1UbtysAKLEZkh6F1yxEPaiDK9Nz2OYgkz+D7CUQ3GQAebNzJsirQbMnB3A3PNMdcDp7Op8qbKmRAf30EA5fC54ZLd39uHvJOtiucriYXjOsLuoNMTQUvd2Lwn2YaoDhhIuDeO5eLxgTiCchhb/SZCLg9O3NeCOv0a+pvzT3g4DeMtxiDlBscKZKHhPD6ie34lcEHZh/XbHLEw8XJuGde+BHUAS2c3qyyVGeR5tN73S0p0sfwIlu7b5qj5E+J1+0nNGr1KJPyc1la/ikZ0iSi7pqh6WxlV44EVKZ7Ld8mH9BenoMOQvYejb4QER1S7FphmNKh8A1aXXRZZQYi8F3ScxkYDMY4mqUv2g1xPKFJTAIHKWJ2FLRIsG4ct4XdwH9kuc04/gQ9JuC8tb4i/vGGRcftrAobIURMO9WYqlKuvUnlZTvopuq1cdL5ljNLnTsPtdMkWEqHMdx57wPuO2iub1STgBFx70G0aL0St+TGJM4Qgxw+dfvVISnK9LETQHkXe5UetWeRNyVTd5+e6A92QLjoSFthRXUamH2+WXbTcM0w8xgGqT/593hQThuN3VrvO8MVoDQJUy6zBRDPBIA1rIrEss0cKtle1U/Ofx5+yra9giHvazhV1HSaaWFNazfI3taoUHxalU/1F+mJxHEwHRD9eRyGS/GQlY0kl815LSE0/ggmRxzX37P6/wrSWVSUH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(956004)(86362001)(966005)(8676002)(54906003)(16526019)(4744005)(66946007)(8936002)(7696005)(52116002)(6666004)(316002)(7416002)(2906002)(66556008)(38100700001)(6916009)(9686003)(478600001)(4326008)(55016002)(83380400001)(6506007)(186003)(66476007)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HVdDYbFSUWN4CL7DyoVIZy37b5bwVX/7/R+6Gk7QFcv2bwnRXguaWuRZV+Bo?=
 =?us-ascii?Q?gbjp0igS2QPWSxc0yz1O8cwgg6BaNx8eM+62R2Ww3lcLF0pMi0NfYbeivCsE?=
 =?us-ascii?Q?w/zLDvfCDMONOCBTFzPMXABS1OO1hgw2eIe9VY370PILyJUngvvvr+GQ7fJv?=
 =?us-ascii?Q?AXEYLlCVLhDJe4lhYCyQNLYj+ezKVPWGuadYrcL3qN9T1MkRRCa5qDzYJDO4?=
 =?us-ascii?Q?+cXH1qYPb756wP34EV8Sshqx1i/3TZOo+E23u3hmsOKqAPmfeBVlgnxoC3C5?=
 =?us-ascii?Q?eGFL3BLwvwFiUk70SJTj1OPQXaRWYbFFgi0t6luW3WTFpq27igXaNOhcu7FR?=
 =?us-ascii?Q?wdbF4VLhKPyFb2RS5hc+/UO0KyJX6tPTMeWw2YmNySz+TfTyyuNN6tDKsz4F?=
 =?us-ascii?Q?NCU8hYe8h7J+i6HgbpC2u6v57y109utxyEz/lhcWvN0vh1QCW/+o1KavnGLE?=
 =?us-ascii?Q?7ayyrXt8ME5mZrs/v/a3NgAoN0T/1ObDXe9/qwEA8g5rCKSj1hQhy/jach4h?=
 =?us-ascii?Q?dGhf1tEZtJcZjz3e9tY2waiIAoskdSA8mJJ3tMdut+NyYY8fFkp0oVL+KZs1?=
 =?us-ascii?Q?wWxhnN9signyGdUBi/eQ2wrLcx81d0wIjlNXmT1bv5w7Wy9ktLDK7NpewcZE?=
 =?us-ascii?Q?z8Y0QVSAuHh2qC6CnDcVZg4gja0bpZFoezEniVL5xI94uDVzVtuPopeEcMmc?=
 =?us-ascii?Q?tH7RxCJRl3026a4jsUGE1Pghw4cgZwr8bpCJbXIeDZaJXL3DZwVH8uT5xGQX?=
 =?us-ascii?Q?uj0XxpEaIujmaaQxERai8pWk5vgDziIXCZpyar+6e7L++PpXyjJkRGMf9QQf?=
 =?us-ascii?Q?8ncVTRgIfpGvi9xE/sDgCqfOpx7esTHwNdmWIUAfE6Cui/UjSU7ZamIu1z3n?=
 =?us-ascii?Q?AjGNvWJfzKG4y67aKBp9grXOZBlwg6Oq/cokzoBK1jfX4XBNbX+S1IjjCFL8?=
 =?us-ascii?Q?+G6UdI9SqM348/Oy3GBiFUDYj8h6BtPkdjUKxzL0D0TeAYKUoDQIR4FdwX+x?=
 =?us-ascii?Q?ELthaRZODbc+C8EBP0HSnOysnJqBh+83s0R4dDd8jaXClIuXXQaLQKs5fYFp?=
 =?us-ascii?Q?uYS7tikDSg5snWRRKNSYRpnE7592KiSM4MFvHwMili9ZxTMesBbQ4SZpMiSt?=
 =?us-ascii?Q?UPTIghK1adJDvQ5gi8yW3F2j+JFTNh6vMStmIGd1DXcm49MkN6zihyqQ61sQ?=
 =?us-ascii?Q?CPLE3P/+Jk6V2LyrkxWe7Q/kDEbzSuVffX9O9yJxzdIsZxo/58aIUwV66CUU?=
 =?us-ascii?Q?cY9hvxMLbI4D+etGeyfIYM8U4qEevXocz0IyYBTZojW4hjUjGDA3uUOkMsHz?=
 =?us-ascii?Q?e1UTGASv+P3yOd3wiv0I42il?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8036bd51-0ee7-4486-0094-08d8ea801a57
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 02:38:39.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1GFjxInPZfuvppfsZXY40aq+lzhmrXpYNLHT/awMFlBwioAeTb0ecPpGzoV5i8VS0ZbF9aNxyISJavYS+iwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2615
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=977 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190017
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > In fact I should have looked more closely at that myself - checking
> > debugfs on my 4GB arm64 board actually shows io_tlb_nslabs = 0, and
> > indeed we are bypassing initialisation completely and (ab)using
> > SWIOTLB_NO_FORCE to cover it up, so I guess it probably *is* safe now
> > for the noforce option to do the same for itself and save even that one
> > page.
> 
> OK, I can submit a patch that does that. 5.12-rc3 works correctly for me
> here as well and only allocates SWIOTLB when needed which in our case is
> either:
> 
> - we have DRAM at PA >= 4GB
> - we have limited peripherals (Raspberry Pi 4 derivative) that can only
> address the lower 1GB
> 
> Now let's see if we can get ARM 32-bit to match :)

Whatever patch you come up with, if it is against SWIOTLB please base it on top of
devel/for-linus-5.12 in https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/

Thx
> -- 
> Florian
