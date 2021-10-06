Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDC1424629
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhJFSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:38:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:38302 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633545369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72qAc0jjma6aLdqCsYkHVsoq3ohYUcSEsklKYx2pIxQ=;
        b=Jy5KFw6lwhxB656GZtdTqFR38uiixVdQLcr2VJkaJqgTUHLXTSPwi0BzyfI5qIiMfKbPsp
        yqLpEbEjF8YH20m+YIkQs6bXsDxuq5fUsL1wDHJSOGAcDNJrH2a8qGV1lq4m0l5+Y5NhYu
        Kv7LLnDo/0OEYBtE3JLGS+R3yUUYtxI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-65kzZkj3Nq-dG-3RxlmMgw-2; Wed, 06 Oct 2021 20:36:08 +0200
X-MC-Unique: 65kzZkj3Nq-dG-3RxlmMgw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMJeodY7PeQeu3UgEo3jc5R67uZTg4ZNXnbdNh91vC3KcHqYKoSGOybQJ92SqOjcth/pGkpnL+cWdr8itlIrOMZt428WmGQnysIPnaoWmNibOZvMrZYv9f0Eed9tDNYw+Iqb0oA8Tn8y3tYfHLZAAJ8BpKJcz3v5ZjbVmOjh+72wlcWMfKqkBBxV8IPC+WrPLNpzkjj2YJ93iFBNmnM6HS2Ss72Y/ZTo62EEhRCxmzUa5L03fPCl8ice+aNN0DCywCbSloohTvSyFhkH4PwjckN6DwSJ6ZzG0VbYUYVUHhHbHQ/4hncn0xpnD94BcEfJcL3JiwHrqjGBPYeqUVjIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ6jPwy/YDKRUt8jDivZ121P0GkthVjheDjB0vqsCj4=;
 b=cUaN+Yfu2X4pWmn47E2jvaQXWfAYjKsU9RDM+yWgkRf0xWTokLk1bwJJwjL89q3WCIecYHzRbGh7mPbrbncSMxlvPhLNvcTeDcVR/0kplSRbFx7oK3w4YOAD44i9KfsuEvuUpY/i80fEJBJbH3dccpigSOmpU8G87IRZPnTbAD2ErX/yzj1Dt3jfMTnmgDp5+Muu0w285Xib21ZPvTMFK17V8g0FYDOiw/zBr4oY7kcu3qnUTpz6Xp9p3mwH0Jcgv0AX30vYbf2+OlvOOsWVKB2OULooMvP2wDz3LZtAgTTsjeGAqKNVV96aBl4cTCyROU7L5yB1Tdcd5A//vSMypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB7PR04MB3977.eurprd04.prod.outlook.com (2603:10a6:5:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 18:36:05 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::61c5:2592:9e7f:a390%5]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 18:36:05 +0000
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as
 removable
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
CC:     Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com
References: <20210929224823.556943-1-rajatja@google.com>
 <20210929224823.556943-2-rajatja@google.com> <YVVLxi/on9x6nfCZ@kroah.com>
 <CACK8Z6EamamgYExt629gyNrYKpvnu2Gh0eGOOvOa5LH-jnOmaQ@mail.gmail.com>
 <20211005145655.GJ621017@rowland.harvard.edu>
 <CAE_wzQ-XG3YBtKTmbn1LSGETCUg5AYjTmcnwOnc1h57OaL9+Cw@mail.gmail.com>
 <20211005195929.GA634685@rowland.harvard.edu>
 <c219168c-2727-0b44-7a05-7c0e31770de4@suse.com>
 <20211006161058.GB659483@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <978eb183-e45e-0465-d3f0-3ec363f01211@suse.com>
Date:   Wed, 6 Oct 2021 20:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20211006161058.GB659483@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0009.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::21) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
Received: from localhost.localdomain (2001:a61:3b0d:4601:21ab:d1da:15e9:ca07) by AS9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:20b:462::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Wed, 6 Oct 2021 18:36:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3886a0be-b0f4-4ab6-f567-08d988f8279d
X-MS-TrafficTypeDiagnostic: DB7PR04MB3977:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB39776F52E35910D69421C00AC7B09@DB7PR04MB3977.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HnDjhA6VImNcEBVqF1nLQba+xdpoBWgSmR7efdRlrvTKRj0yAHPOOORWqaAgqRfGT+uXfrXtWCBdqx9P4kSHAiWiIlgH0/e0cjAbu7hv4s9A3td33dJ7ZlkNRjlyxEkdqcR6l4GejDLM/ZUv3QYYDtsZYs+UCJueaPgv7MA8Xy1q/zdqNizHfJDwuXAAzV8N0kebvFOhMb5lgcobrGSF9P5kWUsRSr0r5EgJkcR1N6SobKw5ZckjOi9PCDRNsu4Behb6NxD5YV7GaTmZoKSnY1+9Z4XALtujgEaEI2qXDcioM9jxn73lD2w0QaVg3dVy9n7zRvb7ZP1AHf61odDc4avUVsGRtq61K2gxEdn4w17lfQ6o0vk6d74srpmgTMKQ3m5Zm68MoDjYW5bMOoO5tZzxiB9s/hUOtavXFaKHfi5yFa1aqw4+mIGVFR5PGUPU/BTWbJzo0qgkizCfIy8Ry34GhO+wC38Dot+OZhQ4Gd0XcMdGSV46Iz8zo/dhA5lnQ8jPaT6FX1zArAzRKwMFDdD99wVien2FAx2iZHIbxAnwDyebalX4SRVgVIl4pvKftOzzPqCRhvjQ5xW2MlEG0iBHgNvenG8uPcgXWDFsuXs3dPP4EnQ6vtByQHoMJZJWnt3gAygA7+wKPf2Vyfebucn2x2ukhxQbWSJqgXtkbz1XpBtZanInNBKcPGaf0izo/DYGs8CzsFM+W8ZNpnPgumW9+Jw44oODTm1dJcwvtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(508600001)(66556008)(186003)(2906002)(7416002)(6486002)(2616005)(8676002)(31696002)(66946007)(66476007)(8936002)(4326008)(4744005)(54906003)(110136005)(316002)(5660300002)(6512007)(6506007)(53546011)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?chGCd5ydHrP7+2dotX+nJfpsCAEYg0PwPERbyVIZa2I73r4me3Q101kgyU+d?=
 =?us-ascii?Q?AiF9u3X6XsN27VkjM3u1rzfWVIhIx908cs/6BRwH/GE8FCONxVKle9U3t+9X?=
 =?us-ascii?Q?AlY5nRi7WeXbJaoxYyoaBj+EGIuF6EfnauKg5MoAfINw9jtGbrUKYoewzNJZ?=
 =?us-ascii?Q?30+U0TzyZkjaI5DPYTioj7SJFgUEBYFO2KQvyJq1jJWg78ksInPlsjVbU/0h?=
 =?us-ascii?Q?FHfBxADmnWhHBGzV7Qc7NdssxlkToiLk0hyWk4c0TJcWtLCxzYo71Vx8AhaF?=
 =?us-ascii?Q?Wd84ASfZGGo1/Wlpk/F6Y4d4183KLrRZxZQLZQGu0sr5x3TOfkKXF3uWN2GZ?=
 =?us-ascii?Q?7nYH8QhgGJXUd7IJz9tEouXGHzfL69H97HQMdhqWFDZtTHR9BcrpzZy0Y+vQ?=
 =?us-ascii?Q?01tUKrydcA/T003x836ld7rC52z+LFFU7dw1dd2RjlxYbLO50nrEzgSonrbN?=
 =?us-ascii?Q?dN4TDjceK2fwr/7fkn0G9UONljPbc9EPBtiP8+GV8UkqjXeA0CsyJh4T+WCh?=
 =?us-ascii?Q?sqmLUmKCcATdRbZLUaZtoCyFQIleeFDpp/3qC6q8kXb6T6wpNShCB2x5Pld9?=
 =?us-ascii?Q?Vp2iTQ+MdqRnCJSEHMvveJ/CVpKBhciSBffVwWHSJby9IsYf1C7hgfIOyqyI?=
 =?us-ascii?Q?XpEYdAb9w+scz9lCP/Yk8xCk4QEtthFKVtxLv/pn68YDXedJnJ4neIjfoUZz?=
 =?us-ascii?Q?wOziumaxRO9XkEeKoZUbhr0faRWooK5RrAZnLYlcX66jeJC2e7eGDSyKLJWr?=
 =?us-ascii?Q?WDTswkTCwYVnz+I6IHLnTVv8a6S3jneYjHJgNjDe2J50kri4spbJc6qFcRYJ?=
 =?us-ascii?Q?dNBbWsP6K3Aqb4XjxG5ddlaUX/wnwe8bFGsTbmTuRVe/YTqb0Zm0wEQ51SbF?=
 =?us-ascii?Q?E2WBlEZ2CzhCNu40y6dqMsFTUvmiiAFweINOuoGfCFmVNoJd+Iap74MAJajU?=
 =?us-ascii?Q?b+d4W0QUPdwIRILpymA7VZgUz6NhFcU9g6MCogWhWOCU2U2qw45Egll1AzDD?=
 =?us-ascii?Q?y5AHUodyn05vIhFetNG0IgoUSEYUpWabXfxs8LZu57WNLmhBOSSXmq/50SOo?=
 =?us-ascii?Q?8FDdLCk+Z6qfwYSPgtuHVDNrdeO5hj+YMrVYPZEyILWcUEIkELyZo48RsVtH?=
 =?us-ascii?Q?qRNlipBYkhN6SNv6sgN2n5GKRdjWG1g/AfVhBgmZA9gRhUaFlaH+OE+yUWhv?=
 =?us-ascii?Q?frfsNSyRz4MP/4hVmcm+Gi2y87L9H0LWUzzuvO2d9AHGEn6+69J4SUCe626u?=
 =?us-ascii?Q?qa9eORCcoMmVZ3eOY+h0EJQBZk8q+RRCN3iUVu0mQ4LGiW4/GndkJUFU5N7D?=
 =?us-ascii?Q?4qEsyS/S5xP2EEa9RixdxWrid/aO9CPqGzOkZBrCaq9I2FNUgZUeW2xWb0Vu?=
 =?us-ascii?Q?d5906windXfxdIKPdqOQVYZRatxs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3886a0be-b0f4-4ab6-f567-08d988f8279d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:36:05.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt2C/B1+DFFzjmckLU1kpK6+K2/FWgJAwRf0cGStReOGXd7VyKkXCrfVdDs7fKw/xzHrZ4oUZkqFt/I+w6jrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3977
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.10.21 18:10, Alan Stern wrote:
> On Wed, Oct 06, 2021 at 11:37:58AM +0200, Oliver Neukum wrote:
>>
>> In theory yes. If your HC is removable by that logic every device is.
>> That renders the information content of 'removable' to zero. Everything
>> is removable.
> So we should add a new attribute.  Call it "unpluggable", perhaps.  It=20
> will say whether the device's immediate upstream link is=20
> hot-unpluggable.  Then the device is removable if its parent is=20
> removable or if it is unpluggable.

Hi,

yes that would solve the issue. We are basically trying two press two
attributes
into one and that does not work.

=C2=A0=C2=A0=C2=A0 Regards
'=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver


