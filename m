Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4D35A4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhDIRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:34:42 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:58848
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233896AbhDIRel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEdFCiLPIYEfEfUvF7+A4+GuYqrFlJwqPQ4cLxjTqzS6oP88rAsafaLefBxYyu2muTE3FlnP+axmbEQLVz0TDTfxMYRmRnBsPMi6gQHB5JcWo2lZ76iwMPRevyiIaQaL7/JoIa77w/KIkyY496PvQTI6b6CMsl2M2Esww1dY99ySeBWj9Ijh/I2x1Hr5Gy1TeqZF0dLdQwt8yxkBJBHRcsvg57Y/eb767QIezMUVXLm8A3wdnOiFb5ycFHxgPQbnKpQemnY4pezSPxpr97YeCi/9B5EBb2Mq5ot4eVKO2BAMWhNZ3fLozUpKK7jR9VRLl/fJ5ktyEb9Grk1MociVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0iWitHvtYUi2eizDejgVtPxprS1+k2x7LyZcS3E+kw=;
 b=TmGUQNIXQMnHojWgDlXUJ58PWTRFmKipIlH/H9KjhBxe82iaTsTcs/oW75/LKbCb68FbiNdWL8XwZq/gM3o0SpUja/wzADyMtNzJwlfB+KlXcpPgies0IXNSFvPQ6gF4IiAGmxmrlHsLH7wd0x5b020cbdWr5aY3s28nFpy0vU68HHgpJeZqPJRYkMIZAC33yJ3MjuEGkOBIIeU7QXe9XLlL8zrLRsoToPUrquolTyGtkpNu1xDb4gTfyguJ9giZ4LSNeNCMK7piAQuPjjy4xvPM4LcCiJqgSPzoNwKuUxshaRMtDE+NYHWWIvlCaB6cnIChxWfyOzarboEgKiP92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0iWitHvtYUi2eizDejgVtPxprS1+k2x7LyZcS3E+kw=;
 b=Tboi08qIlU1K/B3rciJWktj41yZpuKFvGbB30s9AsCWJPyzLSvFcU+PFQ5iHxay7j6aDec9YHLBZz5SNEdCD7F4vnjvzte0lMN/KVJ0FFt3OFg1q3ugRnC3Gtt00grCeAlypYq8H9uYgwN37wqoaN0i2qX1AlAo5TtvjIkjtcPNEYo4itXlguuujoAMYx3a1JjgncJPLiUYaYwUVHKdWvOK7Ggq8VWAPWonj7IlTHD6sEg4HdqZ/urKE9fvukIRjPqVjJHGCibd0akVQ5dIlgU/0cDuuqPp6Mg6pN8G7WX1JBNSGrErVYgx3blTvKpU2Yu8QH+kO46rQiNng3XeP5w==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 17:34:27 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 17:34:27 +0000
Date:   Fri, 9 Apr 2021 14:34:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HSI: core: fix resource leaks in hsi_add_client_from_dt()
Message-ID: <20210409173425.GB7405@nvidia.com>
References: <YHA1ofdGOEiBGxzL@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHA1ofdGOEiBGxzL@mwanda>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:160::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 17:34:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUv1V-003Ps7-Gt; Fri, 09 Apr 2021 14:34:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cec0287-1f12-4db3-1d9b-08d8fb7db965
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:
X-Microsoft-Antispam-PRVS: <BY5PR12MB48028C1FCD0C0151DB51B1FCC2739@BY5PR12MB4802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ad8BPp8rB7XRYzj7hSE6WpvRI0O+wluPdRi7mgzG5/Vq/1+/zKPxRBO8D0SYKDdyasOJjNQMKFYG1e+g6O6gTfoakrdt9g8Tn5cn25/AoJx5foV6d/vXhnZcTCgIt+VWHZz6j/zq2a8vGZZk6HXZ5sLe3gcY4dE6r75i6G99zikWQwLudHG7972Bd8r3tZE6CP6iezxdXvTIErhbgTSY3oWySCj8Wsih9LPWbKsiV9cx1xKqCgxu1rAx8GHr3ImQ8/PBIvI43WiDLhUTMDHKrKJh+cqnjFJeRH0e8OX7cAeCkhsvYpJZOp26OtW/1/vvrs+YFbLZhPvwnnVeuBSGdRAaHV+5akpXU4o2GWTeadXstusYhBLp9mWlB/FXUpa9HEoGocJm5IhsX84fgTLltNdsAuyRKdq0ZGfOzvg6Uq306MrqBp2eHd/4qJnK1VzBQMVIYBqqgwEpyxdOcVsXGsmS3C0/zkWpa6zoQp5oFTjBAMshe6JCIrHev1W5JINeXID5ll4lshb7IQV6pTWqOecY2r4CNPDVdYOsuZRLwGWVUOWRCUO/s9txVhVRjsogIAY1XqeEa2lHE9X9U1R9VMpR1YFB3h7rBGOQ6PFzrQW/5BO8aMbzqaAearSLU8QsIfWivTxiWAwsATq+q4yug9ZJxowLdnaIxR9E6Mmxtns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(66476007)(66556008)(316002)(478600001)(33656002)(26005)(36756003)(8936002)(2616005)(186003)(66946007)(38100700001)(86362001)(8676002)(5660300002)(1076003)(54906003)(9746002)(9786002)(4744005)(426003)(2906002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WtWBqYzGT0odxyYdEsNMI+F138lSV4OPykY+gRTkcEoBxrWe/+jNakt8lRd9?=
 =?us-ascii?Q?xLINkO/2UyBW5s+ULsMjBPWed3L8ppKGEaihAO1HubJSOlS0TSMyb404LXf/?=
 =?us-ascii?Q?HPrjeDevYmrjfV1KfaCWZ6HPOQ6f1NLqtPeALnC5CeNL4BtnjNTLi4V0Esfi?=
 =?us-ascii?Q?EPhljbr+WcOfVeKnJfBT41gsUJWPMBm3lqVQNApZOaJU62o0tTyYCLDb5lon?=
 =?us-ascii?Q?IAtHNWcGVwgSqTHFDXi5mwKwupkp4Lej5I8pgixyDcRX7OeKSLYZRmfEiCH7?=
 =?us-ascii?Q?1D/2OYT/ahOHlk2PAPv2HmdtRHPwVYp6yB8YOCiAIbCsBYF70p5yRU3Fbm2p?=
 =?us-ascii?Q?lvqt92ltfj7yTqPMc4NCO8ABZ2ivccwSjSARQ7Ehh3qu4UrNreR73J73Rlop?=
 =?us-ascii?Q?aL0v70b7tWe24+99askr/q16YDyINQqq/AdWEFHCsl5hmOy9Loku+67VuLYB?=
 =?us-ascii?Q?wr43s+4RAhCoI2GWMMCQmsY6AEuV3lzUbxKikAoIR7MoE4tyc3+5EePtUWWN?=
 =?us-ascii?Q?AhZnmWIki/cn8wjTgV7zs2MgvfNAulyMcLEW2v6jl1NHKMPZGLPpTZD6i7kD?=
 =?us-ascii?Q?dIlTwuFYGxaMVuf5bnSjnoX4z9zCI6Im1+EKN3HmkswfQPfBBoRG3SnPdzcY?=
 =?us-ascii?Q?YoTb4Uw5cFz5o2DxFRgtqwx7NIEUKbjbb3YzTsWtfELQutx9LoBd5/4sNoTi?=
 =?us-ascii?Q?Fk0ZwAU8VoQ7zFOs2RXcVQA9KB1Y1FJLFRi6b11x8nRb0nC6aXQIBnOUREQC?=
 =?us-ascii?Q?OOnViy10ff/u2aTyAnbssorypK6A8ce1y6YK+jyvH4mnfwPdXxr++mA7/5mb?=
 =?us-ascii?Q?0IsmG8Xwn+6CjtEYRvHmkBAb3GoilyzU+0yPRmlQiy8g+14a+claC7lxD/z0?=
 =?us-ascii?Q?T5ngDJuroXu/0M6+uK+wQXFjBlRLj8DrTCyweRQe5NAFheqtjRHZZEtGIcuY?=
 =?us-ascii?Q?tPY5ZMKgAcT/qKPsTqVJmhOncXdKhMypyf32sN4ZyIHY7tNmqosUJ3NvSKvu?=
 =?us-ascii?Q?lbgisDmI9OIqXA7fjriPAI551XFMz1v1g7ugVcFuvrnjfpa2q3oXW6xHmlrR?=
 =?us-ascii?Q?XlfS89dTx4i1ahDECh9KznJGq2PuotDEqivR5TnoQfzjLtfqRfoafzGGlQtv?=
 =?us-ascii?Q?AjQynOid1w/YCdcTyDsubmvtmSamlLnET5RlIEN3Szk+OHKDW/kXelLE+HJA?=
 =?us-ascii?Q?tjMSbeTE3+b+ZULq/Rt2QDKuxqcEhsJGviGIsfM4HWDa4pEF2jaek8CltnEo?=
 =?us-ascii?Q?/Kje1cN0vT8bTySFQtXghZ0dxPZUsUvthRoVN4aAwtJIW/PH66kFCVdj0u37?=
 =?us-ascii?Q?PDnoCC92k8p7hOLoDmY5rKYGdfX9Y9u88p+kfVN11kb+2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec0287-1f12-4db3-1d9b-08d8fb7db965
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:34:27.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5SfYRp0IiYQtZlhUlP4+CxYbY7rgZ68WBKxsw7yU6++6D6WJrzL98zy3kZCHmOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:08:17PM +0300, Dan Carpenter wrote:
> If some of the allocations fail between the dev_set_name() and the
> device_register() then the name will not be freed.  Fix this by
> moving dev_set_name() directly in front of the call to device_register().
> 
> Fixes: a2aa24734d9d ("HSI: Add common DT binding for HSI client devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Jason, this is the most common type of error I see with device_register().
> Is there a downside to calling dev_set_name() later?  Presumably it's
> printed out somewhere, but I feel like just moving the dev_set_name() is
> almost always the best and simplest fix.

It is hard to tell without detailed analysis.. ie a dev_err()/etc call
will use the name. It is why I don't like this design pattern of
avoiding device_initialize() and using device_registrR()

This movement looks OK though

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
