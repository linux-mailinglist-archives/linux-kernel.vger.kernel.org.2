Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF36369AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbhDWTUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:20:39 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:7296
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhDWTUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvQ3efIVIsQZqI9VDSg60PSJlnidC1jTAcXkNy+5SZcrIpcyAAOkWuMWht0WZBW0WDIMG4i01SKHOAfrPMFzhhPUeWqSLsY5fIhL/T9ks194L9l993TACldS5YXNPOcYa47qDFZJ3pI2Tmt4ro7AsNVbcTsBCin8ew+nJBOa5tMSfX9tlUK1mLFOhQpVRwMpohreQrEqGCKyzqkqIgd6Km017KHbDhNXMWK/ZtX6Lw0lUuxdMldtr4sMz2skKcuS/HrDoMi8P09Efe6u2GuuJ/sbN8pNRjOVR++XN6X3D7IqitioC0tadqPrelwgIIYy/XzomvfXXvpY8a+xTvTgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QcPiZK/CNTE545/Gq+4Gsgw1zFlnezplBe4o6HMyrw=;
 b=L98uDsIRzGETJFQA1KSUf6UAlvRnBAt/W7oYDEX8guu6tkbTnk6H86pGs9qmXy4z9a2fsZvHw3rKnTS0YML7aCSFdtd9tHYbf1vtdsZeAX5bRX1+XV5v3xwyOqKqS40DHCIXrwEP+palC43PonXLA6CHofXvJLK+wYB5uaWXV/7CoGc4xI2TdzKSBe5vyO1HVMQA8oig9j9Bi3mkAyq7XCzU1ZjxT85yqAK089hUvEyV9kzEDh8b1yqhJXGPrPY+dBXFRlh7r64eNR5hj4ylnMKD5w5TwY1FxWjX1RZc+9JDiib83DomsXosqq0gywZgx2AhahY7YWfHnrkbFqklzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QcPiZK/CNTE545/Gq+4Gsgw1zFlnezplBe4o6HMyrw=;
 b=PD29wIM30vcXhSDP4q0JXJKSYwCwRWcVJeSaz3516FO2gsiFoxcLhKDwvz3gMfdo2z6JEHz47RSAeNGtMmA8J79NdxMqnLMRROb8TwS3q86t1jC/mPOjWBZSc699MXC+83E5B3ZqyAaq81U/iZgZGTUBK18Tvuc4fYYAI0ae8LVe6JgYCso/v1Aq5rKMOeGQfe07BHWX4m/HmGQ9Afqg2R1jPJaDvq+AV/S+jd6dXf8IZ1StY9hhCokZgtsgxMWZO68MUHNO2Q9GF8+mYEymVEnXZ3wkRoG/OWC+PaXr5ADF2ouzeY5IDr9roXkJ499Klxc6fSp3JNgoWtw7Fe/SDg==
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0202.namprd12.prod.outlook.com (2603:10b6:4:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 23 Apr
 2021 19:19:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 19:19:59 +0000
Date:   Fri, 23 Apr 2021 16:19:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Doug Ledford <dledford@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20210423191957.GJ1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421180155.GA2287172@nvidia.com>
 <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
 <YIHhBNp38vgpkuW+@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIHhBNp38vgpkuW+@mit.edu>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:207:3c::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:207:3c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 19:19:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1la1LJ-00BnTQ-53; Fri, 23 Apr 2021 16:19:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e42190-dfeb-48b2-9e3d-08d9068cc8fc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0202:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0202318BEAF88906563DF582C2459@DM5PR1201MB0202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km3rZJZ72SFhh9+4fqh0uKo1X8rjwndY7cZ9ImHPhqsjd+fFzbDMR6DciEKP+PAKoCTo7m0hUq1nfzS3TBltYx5BXmDtB9eiirlTw4NcieCBAnLm1JGQaJMAGdpXKRtS8bBvC09ZGAxavDMhaSFr89xE3Lm9TZqV2hCPNE2gvJ9HpwP5D1T+pzEXFxIqIQaC20P4j6UiaAOOPx/C5HjlrZRsp+RVm0IvTlnbIqcC3912cZDmmL8tEsoeKbpxR/x5sV7j6eviKn81wMbv40hhO31Uahf7d6goH1VZugz0RNghGXCG9MO0ge31Uh4/Chr+G2kc83EunOhOLXYHpM8PueTucuDShjYNxq7dZ1QWPafuqHvGUbZFHHeNvBWywtcQFxz9h08HBKskxGwcmc3iX/UGSICwe4lTkmFaU4nYZPopbXizuf299HF4ZQU8WE345OOY4PJj2jVMMea6zxcpA/L1meJyxvah5dn6G7WlK+sFFfZYmJXsQyqYjfs+h9OXXKrfIMJqbMZi5w5L0dicwd5NCTFJdYInxh+8YCZf2wAaE6dhJlLDEEwBKaXUO6Q77QJoR4VRPJBe+u1fo/xfnN0B0s/+zEUn4RNY1gOVB/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(83380400001)(7406005)(33656002)(66556008)(66476007)(7416002)(66946007)(2906002)(4326008)(9786002)(9746002)(478600001)(2616005)(426003)(8936002)(8676002)(26005)(316002)(186003)(36756003)(1076003)(86362001)(38100700002)(6916009)(5660300002)(54906003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wh1YQ3/TPzxYYE6r1mLPYRKD6nQLz2dIQ4np1RZUv0gunBi9WtQMhrGJI68P?=
 =?us-ascii?Q?JfeuNKKr/Pyvlyx6RQ0maxFuy3znIOcSRwksiPvXoEge2LxI25aeVOMg4dng?=
 =?us-ascii?Q?8HOnKabHAToGjmMVlwxSLdNzTNw/5DDO018XWvP2WYQkcuOMmUoLcgq3bGCt?=
 =?us-ascii?Q?Gz33n057CoGf0NZGQJKCr7GNy2ozGyhAvZkiajSlDbq6ggkRhGvlMg/cajh2?=
 =?us-ascii?Q?PW9UkK6X8hF1T8fVEyTe4snYSiHQGAs9dj2w690jIy5MHhyupmD77mhnS8ea?=
 =?us-ascii?Q?X5ChWU+oXdxlm0xtfbfiRwwWGGpR+8N8E6l+ptbykXNi0NqVkNkuD7UJs06Z?=
 =?us-ascii?Q?9jhj349aFVxYfGuYUJ1I3kuog0aQTGAQN/uLd/GEh8eUDtNcVyJwvGrG4VAS?=
 =?us-ascii?Q?Xm1C0DKGA9my1N3DH0AQcu4KBNFxRtThwARAyvRFs88fMSdrD9peyxyg1xPZ?=
 =?us-ascii?Q?R8BCvDG3xcf8keA7aXvyNCkTcyACeD2mvlTKBVZrbW5eefbgDrk0NoF7woD3?=
 =?us-ascii?Q?pp57yv4oKhDnfFnYJ5d5eTiR1dhFSpiWAVxLRYtHMUVRXQ90lEVPlGKBPP3+?=
 =?us-ascii?Q?jXrIDmccbEoTt4ghPaz56q6kcc3FnYdqd1YSvHGSLiUqm5ZE31dnxebPqdmv?=
 =?us-ascii?Q?87vQjImSp17LRvLK5JxxhritCRP8PeWfzAMdzWoMEDf5LUktmeeAMamR3V6M?=
 =?us-ascii?Q?zVCSdez4e/5/OpXIXGjqmLx6MsdqCBlHOBRh7u27wJL3ex11S7bjOZEehdz2?=
 =?us-ascii?Q?gtZVGyt1beXjlqjZURtlZngk1tCmhcvBWVEgY3jebfgI7f6ydj9AcR0pK+/K?=
 =?us-ascii?Q?iMivjzsqLmO43kbt4E9rlcNe8OfqyX+q/ACpSh/cFFaJtfKu2KHEng2Qw9ln?=
 =?us-ascii?Q?B6cSUbAhraco1YZya+tV+dppRKEFupYpKJN9cvasiWh1/eT+Z+GOc0Wdx6IA?=
 =?us-ascii?Q?/dx1+bmW/ePBdJCo0H8EiWQMAC5Hty0Y0mAeGw+FrAcHFrTk+y3lzYZely9U?=
 =?us-ascii?Q?0cl/tUBFdaGwIxpFPsjdyAqSVIr0TQ7USvD3B3/yoe11QhidOhhB5/2xIEul?=
 =?us-ascii?Q?x/aEx+Pm4e2VVkkbYPEsqh+cGxqyBkjgm3VpjUi7jcZ2FC/MSpL7va97rk8B?=
 =?us-ascii?Q?wVtaoTOdoeKqOqgu2YhvqiUWca+NMgJl1KnhLM8jC3vK/Jsm9dAIqQbzlQ7F?=
 =?us-ascii?Q?pN/aHPd5b4u5Y1LdO4E43CWGa5Vag84OMwkHQ2R6yHXNc+sOrn5mDv9ortJp?=
 =?us-ascii?Q?red3sCGoXzN3RAUM4SkRnUWHMJCIQYuSBVxF0q0LeDqwkHY8nQlbutMO+XNR?=
 =?us-ascii?Q?yOJxOi94AJFP1hxqwo/zxtlP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e42190-dfeb-48b2-9e3d-08d9068cc8fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 19:19:58.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjWjV7GYYIly6rV8oKzH4k8u9VPGXbn9q1r8vkPzWDJP9lQd8dRwU1YfNlel2/ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0202
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:48:04PM -0400, Theodore Ts'o wrote:

> So you could consider doing an in-depth review of the patches sent
> from umn.edu to be a step towards doing more careful review.  Let's
> see what we learn from that analysis.

My take is this is "as expected" from people operating static
analyzers and other tools. At best they are good at pointing to
potential problems, but typicaly lack the kernel specific knowledge to
be fully relied on to make a fix independently. Further, it is very
rare that people doing this work would be able to test their patches.

At least I always check this stuff no matter who sends it.

Even well reputed people like Nick and Dan make errors and need their
work checked.

I'm interested to see the measured error rate of these 190 patches -
excluding the "not-useful but not wrong" determination.

Based on some Fixes: data mining I did recently it would be hard to
get excited below about 10% errors.

Jason
