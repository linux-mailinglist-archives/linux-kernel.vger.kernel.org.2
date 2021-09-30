Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABE41D4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349022AbhI3IGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:06:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:42658 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348946AbhI3IEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632988929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL6gml+pBgUh68FbKwGNPs5BTPVX3xm/OD/1xFRZgE0=;
        b=F+MEbGBBW0kPn0cG8RROf9vq93UrJeLNH7SIeca7gBT4kebMvS8OLhLM/SVi1Z1nvp3Zxt
        DPcQ6TrM+rlYX6ySj1tyJZzBQbVq0Kflm1NKXTjS22oonJ1ekogXvxoACsL3VgCiLiE7vZ
        +yeIOalCnT5Q4Rynz1kEDtF4pG1rUQc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-Fi7Vd0WfNLKA15rnN1DwVg-1; Thu, 30 Sep 2021 10:02:07 +0200
X-MC-Unique: Fi7Vd0WfNLKA15rnN1DwVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBucLrpS8p4tEEbzBNRyVNFASyOkmLwYZkmoLZxqc34woe1bEhUXwmEXsh1tbtU+Zy3m/XOxGpkFUtmRjVZBIaGIeT0avptgsdQBLHNsY7e8+3CWbjEVmSPhrvL9YSSh7/ezzrkPqBY8quJwOCREO36PIbeOuc8QAP6VT6GNY94kRTA17POkryOvb4rbmvG3ZDBzvBkolI78ChW/80Wqw4iaVTyXqpKs75kGGLctBCHFVQH+YA3Gs0/Hjx6HwHVvr17c9BoX00LjBwD6bRtkx6ihAyv3+QLizHs0OajlBoZtj4B/u2CB8+Ckbk12cSaqzAWRKaryopOvWnJtG0XQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GBynppqDTGD9tlbUm/RgJp4mvWILGALRvIdanlkG8eI=;
 b=ANLnIQVXQfSi2k5vRYYbuRXYvmk/rtBRWygHCXflucyc6yndlrppk/rgcIWBuhwSzwAq/gX1LsDjQlwZe3kYkPmYe+GP3bYc8usoovfQfFG1ZHSYncoXf94tEWKqTpEVl6wQL1mO9p3eJ1hGWz5q7efWtzQiGS36G1UPCtzlfeU9w2XCSGcY4rwQ/XmZIyuBIsqnfx31cYefa0mQnLsTdXkkz6JBMC0NA9TqbxXdlSBJYGLSHSoWcuAvBc/PRFhJiRlsoyEAMKbr9yLfg8SFhNCIHQbYAPaY0jevFa//14CDZ+fUTnSZ33mYTm1xvDQmrVDk8/RrQsLMMkbuENOLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB6PR0402MB2822.eurprd04.prod.outlook.com (2603:10a6:4:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.17; Thu, 30 Sep
 2021 08:02:04 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390%5]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 08:02:04 +0000
Subject: Re: [PATCH 1/2] usb: hub: Mark root hubs on removable devices, as
 removable.
To:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
CC:     levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
References: <20210929224823.556943-1-rajatja@google.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <2df726b3-e5c4-0fbb-991d-e31e74348d52@suse.com>
Date:   Thu, 30 Sep 2021 10:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210929224823.556943-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AS8P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::20) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from linux.fritz.box (2001:a61:3b0d:4601:21ab:d1da:15e9:ca07) by AS8P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 08:02:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1216f5de-c8d9-457f-5869-08d983e89705
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2822:
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2822ABA28985C23A2141B5EAC7AA9@DB6PR0402MB2822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L0CJSPB+hM5wTuoMSY0tEdvftvzfGbsZw2jbX80R/XHvb1diVT/KvY2IGTqRbtRnjZq9dZ7LGt4wiAlcQK8qHaOqraTOJ5bgTxY2YVdtJ3QJo4QvhZw6cAYRA2fV8I2agcFEvjzKf8gIP1I+Rehvm1iMx9NA8fcn46B++1GLcTK2S63W874XhbzNLtmqtbECV6fRshfUe/HujOlt6GkqGpXrUSM5l/mz51eCiXnpJW8OvWz476tNw3AfI4aUDk8tZpJ1k3QuWuEDCYCD+0vwLLJ96pHzA3MXFF1xd/HVUBsPJ5Pp/G20pZH8q54vvVB/jBYs1GUEsX4ZILWhsrO/2QZGwhbYwd2niS/HxUlpbX1i4pNzMujE9sKM5zxOk971HFt04sG0XzaXpkqbQLEvC0kCOz8yd9Hwp+MUl9/sdbK8u5JXEbyzB/4YdlafG+gir4Gqp/T4F3tXhBnZ94sKiOfpPEot7TuITz2nkmk+Fgyf3EL4lyWy4MRe99uZvrOD3pZ/2T9qsM1p/53gg1v4L1dPxytCbSCOQEHGXPaPX1tOheSlWqE3uEE7+3icaD73PUHsCpFXGg0mJkT9MtiPM4RIvkO/vyWmnkE+crwA1+g+VV7Knc7CgYCsSKxI3yXdbFymkqqkrAAHUY8wr0BCibXBk1ZBRfENyLTtE1jBBquV3ntd72iMdppMAfuV7DzOsnhv3n3iiuW8DPXspp1L1/6Yjc0GC9ZfuKYCPZq3/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4744005)(7416002)(6486002)(2906002)(31696002)(8676002)(4326008)(31686004)(66946007)(66476007)(66556008)(6506007)(53546011)(36756003)(5660300002)(316002)(110136005)(6512007)(508600001)(38100700002)(2616005)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBfKJwtM6D60TUJ7NBBUoEeAWEDTELpEXX4W7uzFtJU/Y604GvKsOYA+ZbgW?=
 =?us-ascii?Q?ItPpyn1v1nACJfArdqmRQuUN85hc1M6ODxUowbgTNwM32uhXWcVASOBvIrAU?=
 =?us-ascii?Q?BD9otfeX3JBSZia3LhlUGc9VQT6bBdZ0Gs0AJtx4+SjoQmX8MaRffxxToLha?=
 =?us-ascii?Q?ZsxsHwXrwMaTEWjZexUMK6FV5tLxtzMwgDvkVpy9CF5vnoQflUBX2iMZdgR+?=
 =?us-ascii?Q?UHet48Pp38SEJnKJovVW6mdnfbYzNPMHN+VplyPCtY3B8oPhkY+TrGLJzZdW?=
 =?us-ascii?Q?A3Xb/hJ09dpEmjgxcgtem43fiNHVyHJ0BrRJrRGIWj0vR1VAytVUWZli5Ord?=
 =?us-ascii?Q?WXGlAv+XviCQ/uCJV78QFDoRKiNOJEiWQbExRhEkeANj0/Suq9QqBiRp4O3y?=
 =?us-ascii?Q?7gsfj+FCEt29ZJaVQwUUsCF+2zX0NWHLG1izktk6VL9odh5Uo3fChwmsncQy?=
 =?us-ascii?Q?dwFoVnuyCAkynEMOPUiLshL23OozjUQQWIytE8jurfRSusejIXR8hhPiD+yR?=
 =?us-ascii?Q?VH7yGtQs1Pg7AfbbcFYhKXOyXBo97vuvwYrYUSycMwf2cx7zMWMIHdIIyNXH?=
 =?us-ascii?Q?y/a0bWHr8jETKiY+j+Q6qpwNqFliZMnPawS3fd8ycvQjPQoK2osNjmS7atXC?=
 =?us-ascii?Q?kl9zAzVHzXoewy2tvjXmmUEBoQF+LR2rmzQcPQ8Z5YGEIOMURWA+W4PfYyZ6?=
 =?us-ascii?Q?P0Vr+LkJf4BdDTwAYfhdKL6RZwL2xjwB2XqcmBwjlk+Ucf9+NYKWNn/jbutj?=
 =?us-ascii?Q?2Tc5qosNzxSerogvu8pmoJrAuYUyTWHUcxuOgwBrWSrCX6H6Cy/L5CBggGP8?=
 =?us-ascii?Q?V7lsFsehRWtlR2Bjh9enPEj95K7uEK05IufZCcTi6XjV9xJqV6MX24nutlHL?=
 =?us-ascii?Q?UXkJUwLep8zjcMJySAkCE3uApGAS+RtFjFViAQl3oliVpFunpPk+7HV921Mp?=
 =?us-ascii?Q?m6FY2R1UyXvZ6pJPHEqStGLRGMv+nEOWQyPB++7CobAqqZEJPqDYnr9qHRxJ?=
 =?us-ascii?Q?oTpb5+C3D0ATSqXx5i+FU5FyltbziHDEZbbLkNmq5n8ft5CWnfmh6s75AbsY?=
 =?us-ascii?Q?s4byN91w5vXzlUMejcmZ3IbZuL8QCxUcb5MCprTsGgb3zZ0nVFcW6gDrQ0sC?=
 =?us-ascii?Q?BkXZLyP/kg5xrLKUqZGUoayySjY8MnonZODd9AXrKcyBCBKV8JEL6AJkDxi+?=
 =?us-ascii?Q?IUjm+bv0Wp2NYoX5zWTuZaQnvn8pnUBWma09NxBQr5vyPetcFFyKONUNFL5r?=
 =?us-ascii?Q?SlDSc3FlDCjpcq2XGocFc4xYjIZAoxA70AryaS3QGDpYE1bbSceKF+Jx9vnf?=
 =?us-ascii?Q?ZJscLlF5Wsr+jCkT2fIOZEQTbJSzsGEWw9JFL2bHgAspnjidlzGpy+oJvnei?=
 =?us-ascii?Q?UZYK4amkwHSTY+QQC4kOMDxDvDBo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1216f5de-c8d9-457f-5869-08d983e89705
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 08:02:04.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y39rXANqnxAPj3jQr2uANdK4fNMB8HPgSmd25Wle/fS4nQgpltRsi/+udMPH8stGgrzX8AOdNfRCkTCCB4S9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.09.21 00:48, Rajat Jain wrote:
> Currently all usb root hubs are always marked as DEVICE_REMOVABLE_UNKNOWN
> unconditionally. Let us try to help the users to identify the removable
> root hubs, by checking the device on which the root hub sits. If the base
> (parent) device on which the root hub sits, is removable (e.g. on
> thunderbolt docks), then the roothub is also marked as removable.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Hi,

frankly, why? You are needlessly throwing away information about where
in the tree
removal can happen. This looks like a worsening, not an improvement to me.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

