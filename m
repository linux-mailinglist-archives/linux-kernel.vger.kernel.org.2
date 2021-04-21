Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF23367231
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhDUSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:02:34 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:50593
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240515AbhDUSCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:02:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAR/QAAfNgjAxYEHc9sEMDCA8n7XXTzJERoODnrRcJlCEdNfIKOVt+kuF+TDagdd90VppD/yu7iIk0LNbRjx/uzopE8arNJWRCIo9oBuT7bYmKek5tG3VXOIHB6WEeExjVlfHVIV0Bo8tgs0tgxI/Cu5iWQfbmFY6PxpbDVSUJ+val/WGf20s7h0TT27VSKIzqugEUZ/3dxFYhPTLS0RiSCDDRR6BAbm1baUlgwgZTVdXKumVVrzarKIpPepvROI7iFPs3tE6V31Tw9eFoZtGq5ftB3QJ7x457cAEkQzKMg+csQOWKGeP5CciMB7634jzes214mrngeKPppmrh3k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHVY6OfOUnKd7wdC9kElFgKEq2xjRROCakNL+8k6yfU=;
 b=EXLamVTF+04tnRCtHR8418JZf1U9C8ycPTcVqezzZkR1bAwxH1ApS2S5RhZxCxoS3dol0TCnri6PvVCGUUDExk6eBo4fXoUt9Hp39iL0F1UBWwJy6A4xOXcFxudB572FhBN7ehcQMcnFWG6w6F2OS1p7kmmai7b+FN7txP5sWtWYaKHa8yzweXdws0uB4eV45B7utryQdeqsitnLXrskyns4y5IYj2Y2t0Lxc0f4JjNfLu4iKzsHLLaZkfYzkd/NL5QqZBcS+XhFxZ08zoIjJzQK3SoCMmgugjfUZtAb+6Zqr+hDrprV+Gy20WNGuiJv8oysWXFNuLx1sbhKbeJ0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHVY6OfOUnKd7wdC9kElFgKEq2xjRROCakNL+8k6yfU=;
 b=grSkVG1V9vSk92tMiIhucFMHZxVNDmqk2Z3t4jIKyGFrCaNJniVW0I5uX/Xr28RFJm+q+xjgLwgEnHzLJK9IFdznLP9q3zCMowbt/7thEVg9qhp5zOGYjmkXEOuSa4rUb7qjjC6uq1JLgIKRdgeAwoL2/XTzUCn2D8epejnPliY0BFIMwQPb5IncUL10ZBOOoZZ+bogM5OSJMF42n+yswV17YXF9eaJRcBN54GObemIq64m9l8x07PjlqGLXiYTzsUnZ0RFL2WOz8WOPwXRPNOzJC38u/mU4deCuuyDVqk11EVfs/9e2BUZGeXqNn+AiOKkmzCzmLtDegBNV4S8n+w==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 18:01:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:01:57 +0000
Date:   Wed, 21 Apr 2021 15:01:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <20210421180155.GA2287172@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0286.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0286.namprd13.prod.outlook.com (2603:10b6:208:2bc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Wed, 21 Apr 2021 18:01:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZHAh-009b7a-Gh; Wed, 21 Apr 2021 15:01:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d396f89-064f-4e4f-5f55-08d904ef8da3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882087D6C4A3CA95A6911C1C2479@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LuQtN4uUabcKoqTjgfphUyKo8dLVTPKPI4tf3RG2UF2KhmURGsov6d8jFNupdS+cpa+6NRkPNQ530wKCb6Ag24dTJXlXpisVB4QlJFyGYqgAyA2tbodsdGcpKJikOkHmG0EbhVKl68vNZOzQJ5K3D9WMqPhtbc8C3JPqyIMYMPRx3TqN76Qt0V6JxMCnUjlDZRtBiLaC1CiLG949g7kgdZhsJ5jlQ8Ux4HRPBwpaLMD21J90i01YzBMNeZeYRcDsTpu+HQtBIRsxvwdEaeXK44y9RX84+XXXsPxlF+dQgMwJMqx4tbWxJ++ZY9x6Mt/izzkQCcD90dIgd+sgBERowxF9nxoAO6axgrAagh2RykiaWTR1o0P7BtTNtypzAIrOT7Y6cuLP+wlQBUVoaIzwqAaSxAA3dwyxJyYa6QVWLvjnocUZK98Nv25Ns0ZjmVk3lcnGSztMSKVhwR0MLcTug/iIUMoSbqU65j6layW8zmBJaRXZhQSHAdcgSHnQVASf0r6kbfZ+5nl+lyqOXzLqe7QElwqbH/I2ZghIrXXG5pdWK5UrG+hykNvI24c6SWrGHHAh+9xWy6SScAqZGFJoq20Pf7UVed0bAQB3CZKOb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(4326008)(66946007)(8936002)(38100700002)(33656002)(2906002)(83380400001)(66476007)(66556008)(6916009)(7416002)(9746002)(36756003)(186003)(54906003)(5660300002)(8676002)(1076003)(86362001)(2616005)(26005)(9786002)(478600001)(316002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+7dzPC1WgAKJZwAagYQAVwYJePxQ7Ucw54SvOJCc1ypL6WzTVIgnLOpIh51K?=
 =?us-ascii?Q?1Gfm8RZJ1S5JgqCdDwwB6veZ/Q0vP6Yw/CoA6ULYuR/o80fVxtxJCJ3Mv+OD?=
 =?us-ascii?Q?j4HmcZXxf3xsKj7tcT+AruBYe9yzqD30SAxrworQIyrfSf7ZVuLFpEqjAio/?=
 =?us-ascii?Q?Hfn27PcZ4/xdpVn/M1f93wwlPCrKN+uHRINC4l8WY24m803g2U22GX9LS/Mr?=
 =?us-ascii?Q?gIxnGxUPocXPIGm+ikMPvWytPzFBjyBy7R4XPl7Ex3icmN+HwHbZ5Atabg9M?=
 =?us-ascii?Q?71Ug7ZKbwwprdKzTlQBrvzkhYVDp8V/Rdb3ApIxtRcEDIRBR3Mk2RDhBbN2/?=
 =?us-ascii?Q?IaQ4eDh5wExOUc7XjVV6GufD/67Qj5AdF0n2whFEAwL5jEgG0rmZw8i6vi4l?=
 =?us-ascii?Q?Ax0UTB8KlEeo5cvphtGbHJ2A3IlN8NKfTw+H7vCv1eEOsTQmlRRuZWYveyWs?=
 =?us-ascii?Q?/QFfpuXASeUQrK+NpnghvAcHIkFaYzL81lU3WB8hltIdesVAGTZxELgWi+B8?=
 =?us-ascii?Q?p3jci5bi6xFzPzn78F8gziCXsuTnGBf7KFIKHLXJP9abakWCFBLncPmeBp+j?=
 =?us-ascii?Q?b3uXHCkvHwsPbqVOOdgPMk2t3BUbGcEiygJcZEbMUhpRSsKIJFl9PNNz9lyx?=
 =?us-ascii?Q?Y8pnNmt+C/38CUlxrw/MNR1XLRhTirmhKJiwTc8BilX2ADoCW3fKBL4zNrGx?=
 =?us-ascii?Q?AV2DVRqhXsbuITDc19mGaEeaiYkg2to/mfaWwR6RsO9tOtI27P4+uBZjjs/i?=
 =?us-ascii?Q?A5arzWT+0IuucYxuC6ukVrDUAXNu491UmRDB6FPyhN0BbPd2KkDmoaEcuz5Z?=
 =?us-ascii?Q?Oxl3nvyVG7XuKktxnrp0p9N8ifisu5iTL2FnGa36TaFnXUX7mMXyTu5pAiHb?=
 =?us-ascii?Q?Twso5XP29UrPKcJq7UsGuQI2jKYT+TBflr7qr6+/tLeZKCrVppthSuYlUE+p?=
 =?us-ascii?Q?q440H9Gvx2BiS3mBdaoH3g2x5cdD8RT0A8IyaXGqJrIadVL7xalMhkIS0lfH?=
 =?us-ascii?Q?2fNWtvtmVAGWu0zAdq7p26C8oTcECw90B79FCmgk1veQKgeBGassOSRV1YmV?=
 =?us-ascii?Q?1V/Mz5uCd4/ux6z7E0cE7rW3ts+9UE3aCH4lxMUKO8W3s9zH0JMhr8qlJbK2?=
 =?us-ascii?Q?Ir8bpBt6hal2MtCWaLkbKCoIZHPxRVr5SdZ6hLDxzCwM5o88zE3O8sA5HJvf?=
 =?us-ascii?Q?8iIgPv0EL/PpGCTIUrnP+bGuw6Gga2Et79tQsiJjcruPqcy5tQyksxWMQm0A?=
 =?us-ascii?Q?VvRAKuUNDTu0lHOH2h8VSRN4THyW+KwQXc01H/R6zRvnAx4XYRsbyHuaQ8CT?=
 =?us-ascii?Q?G/IAeYCvBSYEqVzVhEPFHenqOj9JI4pIp40h++ahBXhv/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d396f89-064f-4e4f-5f55-08d904ef8da3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:01:57.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOtoEQ3A+rqUVoc3DRJyEzM5E7C/T7PtHLJJqrVxqlqyeIN9cmDyXQilltA5AGSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:
> I have been meaning to do this for a while, but recent events have
> finally forced me to do so.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).

I noted in the paper it says:

  A. Ethical Considerations

  Ensuring the safety of the experiment. In the experiment, we aim to
  demonstrate the practicality of stealthily introducing vulnerabilities
  through hypocrite commits. Our goal is not to introduce
  vulnerabilities to harm OSS. Therefore, we safely conduct the
  experiment to make sure that the introduced UAF bugs will not be
  merged into the actual Linux code

So, this revert is based on not trusting the authors to carry out
their work in the manner they explained?

From what I've reviewed, and general sentiment of other people's
reviews I've read, I am concerned this giant revert will degrade
kernel quality more than the experimenters did - especially if they
followed their stated methodology.

Jason
