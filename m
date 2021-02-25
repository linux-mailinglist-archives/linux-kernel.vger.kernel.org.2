Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B3324F56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhBYLmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:42:02 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:13025
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232616AbhBYLlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:41:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj3dX0sVRykV4gA4IU9A24ibsflH4msZ9TaIhT4jPXuKAlfDifboUe4fkGb3NzE51i4OgFhQ4B4oemtBCT/wBCWMNFiEjP897csLH7sU6WpgrMKp0ZhY97qH8CSE4r4gZ9hCCf8bq35UvgPYSGnhU4GfLPu0p294/68mXf5Tm0IG/kQnqSlGCqIefTBhRhDa2OyQK6EqecdhpG2iDGMOYbb/o2MF60H0jEKEPAEu04CdPex7s/dQ2nBlC6KRIzseGluEaUG6KR1t2b/G0O+mXoFTYZI6DhNgtiQK77CABHw0i8yue2cHk9bm5hFNmldg725Br3t7gVgkblxKAo27rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXxOHL+6GAMlMb8QkT1kI52kSMnTURSZFUjb1X5M6uQ=;
 b=DtaFH75RjKpTQYwU+W9dOZiIOgOLQAmzKkbGB93jQM795GrBijdz7H7hBPPMgS4eTKs35DSvu4x685xuFkgRWav3qLtvu2Ewc0VDqun3cLsTasmsAgoLP5tg0BO3eJg7F3B/SOw0oJvp7kPVLgQ2zGMS7gCNgljJVoLLKWzMfU62VBgOFXfahQBxEn3VnwIyPdU5w55QXEzWCr6QmPaV94Gb9FnciM2DYGlWb2W7GouoFaSrJheHXMhN8hkBVPzMl23PhI9m1SGST6B3GBUsDzC616170VaLFrmOvAm2GrAOHe0In+D9QYi2BgMKa85xc6QRdAh15sYDoVxPAEryXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXxOHL+6GAMlMb8QkT1kI52kSMnTURSZFUjb1X5M6uQ=;
 b=iSe5gmIqqDapjtMC/QLrEZ6A0ytz53Sz3xetZZbrpr21VLdJU8M0Y6sXDekt2JAQSqCPxAWjDPnkQdx0gSxEMgyLiKweKY0XjxjxvMe5+fnoZ/QcXg2+8116hpF6p93bSQkLxJIJ2T7TsFMxE9pgGmW45Vdf5fYM54oLzDrq0B0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM5PR12MB1563.namprd12.prod.outlook.com (2603:10b6:4:a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31; Thu, 25 Feb 2021 11:40:57 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::ed2e:3ea7:b315:1f52]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::ed2e:3ea7:b315:1f52%5]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 11:40:57 +0000
Date:   Thu, 25 Feb 2021 12:40:40 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Extend commit message
 layout description
Message-ID: <YDeMuAqgxEVNovwO@rric.localdomain>
References: <20201217183756.GE23634@zn.tnic>
 <20210215141949.GB21734@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215141949.GB21734@zn.tnic>
X-Originating-IP: [77.11.127.1]
X-ClientProxiedBy: AM6P193CA0073.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::14) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (77.11.127.1) by AM6P193CA0073.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 11:40:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c21c56a2-ac85-4c0f-596a-08d8d9823740
X-MS-TrafficTypeDiagnostic: DM5PR12MB1563:
X-Microsoft-Antispam-PRVS: <DM5PR12MB156384E5DA40949BEB847B359C9E9@DM5PR12MB1563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnkW2yjq3MMd+iixnEOQdgjGfE12Wu3Fsrg9AGWvcUmYzUwUgY+EYucaWqYbgOhkH3uDlzHUV/gpJIZgathF5UvfJ4bLoaG/30h/ae6vY6hFUgLwct076qf7IAPZhO/k0AIRB2WMy6+nZEUEYy2pHNAKOu4X4EQcneSCLNvg+4w+jOHwBCI1GCdozwswPXDsxXGOzhi3Wx/k6WLD52V0WlatH7R+2zJVWbK4nzwklStpI63cruHczDB0HZjOcIrN3EwGajcevp9LjHzGXXy03OgfYLvL+QTmah/7eSpFpflkfWiO7fTW26HEOH+TLeKUkyjs2N8EoblnBzjzDTGZoMsJk5QPk2RwFT511YrIHHjUz3YlnxeVAO15SgqrbC+Ypp6d5PiynJ2XvIEo3lVlDIVj21kXDV+krYYRdB7WjNWPWeq22TijmEIwL0yL5BZ47cf8pB7JfDndqMhFM9TQ5LIj2PkrNGMIGO2Jl1m3s2Z5fy4YNEX4XEtvuOrb5+gP15o9X3bAnZBJS8ZCmO20JG7flEc3nyaYdkxVymXnzdsshj49leddXpbSiGSfqrrtfWONd0aWQBT4L+jza2o62yjZHMjgBhXAbXmkcIS05bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(956004)(316002)(4326008)(478600001)(15650500001)(66946007)(66476007)(54906003)(66556008)(5660300002)(4744005)(52116002)(16526019)(8676002)(26005)(9686003)(2906002)(83380400001)(55016002)(6506007)(7696005)(966005)(6666004)(6916009)(186003)(53546011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/XmphAIpAQgjPKRID2TX73tUTOGBdvZP1mHZ47gnbFfy+qcuBa+qSFybXosd?=
 =?us-ascii?Q?1XtMZwtsk428KZkm0QVKYb5rY/JuLbqn0Xg0feSy+nE4Z015L3kZVLz2LSsR?=
 =?us-ascii?Q?XbvFblfBBzAf1sDjtNL7e80Az/hn3otRaFuTdTZhZU+3yffzJIJf2TZ1bcQk?=
 =?us-ascii?Q?sH59HcktxlZN5PDyL22L036ERc1aZNwZ1M7V2KBb5UeL9nq2AxH+8zZLMRRt?=
 =?us-ascii?Q?4lEoF63x/LeDgIVPLfTpvB40OD/lYSIdU3ctIpaDTZZaKosXKOdi2ttAkH2R?=
 =?us-ascii?Q?vBchYvurOpX2K3HYNs7QOm50pOLT1SPnQSoLHnVfi9tW5PnioSiRSYB9zcCj?=
 =?us-ascii?Q?P4Fm1ZVtgQUVVlSewA1HnYJlV9BinVEnk35QGoq725LnknS4xQ2wLYvhdEFa?=
 =?us-ascii?Q?gE2rN0EmJFvjTK/V3GO1BvfXRYDsujYmTR0GEnSgTxJPTV5dAJJYgra5GHx/?=
 =?us-ascii?Q?rQzM2lK3WA5ic9C4nHr0x4RZoK5TRw4TKcisWaaH06Ye25zqkK3v2QdX9xwM?=
 =?us-ascii?Q?OTsLC/qXILGdchDkwKu3/ql4MFgjLDGMlqeKHYKJWru9JXUN+GW85vmVL4l0?=
 =?us-ascii?Q?+oex64fitiFFfC3LB4iYGg8hgAzLYZCnqe0rz4c5uDiGDOhGoqw+xpeUPIry?=
 =?us-ascii?Q?pUXH+PRdRJ2wHU3aJIIAhsxnfZRq0GI3p+l6pElTQOufgd4bnYc/MddizsrF?=
 =?us-ascii?Q?M8gBpOFKnvVNlHpZ64eKIt/py3VXDLkMjjA9weIkB+uQR8Prn0LrXv2FzPNt?=
 =?us-ascii?Q?GdjdQRZvk8BBMEVi5RzS+bcraavCxLN24eYFXRaPb4rKafmf6HIT78PUocCE?=
 =?us-ascii?Q?JyT0LV6IuuPuWsAPtHI4RDSsRLtUO9KL3mfVmu+GyCltgmGgz75Tqn/Pdyrf?=
 =?us-ascii?Q?aSdZuYqTVGllkOyhT4wgD1rqPMYpmJdC4mjJNkVQZqBFtA363iUZcJssYooF?=
 =?us-ascii?Q?PlUgcblKvWpvgDOvCYuRqcysM5CbGNbVpTgCvyf6/BD2fGJwUNIJ0tZ+N4Qp?=
 =?us-ascii?Q?cHsX2Ug4VtJkuWSk2NLGOnHNcyMrSiYe8nscuhhA/rWMQsoMkPYpX8Ydxxl/?=
 =?us-ascii?Q?jdJPcGKiI0+OJ3ELkGfn7q5P0lHeB323sTtLGZn5nGJKCFpCkHze7ZCDN1c1?=
 =?us-ascii?Q?y5KLNpd/cU47bTDdiyeMfCE7jRZvOYlx0aPytaEcS4KsH7ao41MpqkHfsCKV?=
 =?us-ascii?Q?tnMUqZN8u04TRpg/pvtH5rZ5RszlmHW/RtMAhB5vj8j33C/9t8ljAprvcIRC?=
 =?us-ascii?Q?z5g3jdnPf7OxpslYUQyGFiR5CFA3DF3+kmsgSMcWSI9IT6ORQ0CvL4qGWb1v?=
 =?us-ascii?Q?6EsbA7kSaW4sNYa8ekTOb/Te?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c56a2-ac85-4c0f-596a-08d8d9823740
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 11:40:57.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdTSmPoWnFkeBNqqzyj7nOlqNqULNpYPSfBvUJjl5gRzl4nUmXqxyhwza7z28gPg5ZBrb6za6lIWPmDpUezYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1563
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.21 15:19:49, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> Subject: [PATCH] Documentation/submitting-patches: Extend commit message layout description
> 
> Add more blurb about the level of detail that should be contained in a
> patch's commit message. Extend and make more explicit what text should
> be added under the --- line. Extend examples and split into more easily
> palatable paragraphs.
> 
> This has been partially carved out from a tip subsystem handbook
> patchset by Thomas Gleixner:
> 
>   https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de
> 
> and incorporates follow-on comments.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Robert Richter <rrichter@amd.com>
