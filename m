Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A8B39790F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhFAR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:29:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22397 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhFAR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622568488; x=1654104488;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kIaTdUnp5hUZXTDzkap0c8oQpCucHiEMnXe5pa644DA=;
  b=nGvAKXC6n1q+HaF4m29rg7sLnyLDsySncV83Oag7Dd7P0LVONHk7Yov8
   NLFao8NfIS7uCiDG55LMuvCOFIXfY45lY+0w5d5jKOOzHDq7uzcXAvqDs
   CqgQLsWk7I+xTVJ/1D1q1YLCLgkAsxjsSFPbJ5oL/XNx8AEOgUVGoGNBj
   e2LHST3boP7cmS2Om8qfhYflNeOP3ckPhmbmYI8FERlWzB8wqcCn3pu7k
   PDtQ3DrwMPD1hs3rYdoE4mFk2Qw5Rlt2ulaQjcVdfebp4Eowgsi4JoSBa
   Gn+TRfsoN/XWl1lWq0mipLG6Y8FgtA90jtLOWVyE8Ms8c1+N++OftFYo7
   w==;
IronPort-SDR: 0ELqhGh/JigugnqgWaKB1aCjW7d9NPeNKj8ohiVKUJaRstzD6ZOkUlhE3x34aWRSrEyW1PIxQc
 8NI6RkO/ze/dsQ+qnKIbs4TEVa5LNa5oSYos8x2UUQc9mjaC/bU+sq0kC6PIk3wrfKR9on1XdG
 tcz2BxGTMK+Dj3+go52AS08mL72vs9sxzPh34TrmlhycNx9WzuN5eExxqQd7iwdMKx+nwS5EuY
 nw3XsCPM8F7A1KFTlWnSn6ki4Maw6cYrQTG/cId/bk4gYW/NWZx5eY1GryeCWRFT3PbvBqg78d
 eNE=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; 
   d="scan'208";a="169583302"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 01:28:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgVsVG+NRAZOlWv+4x9zNE9cJl/f+a4bacmZGRrp+YeSAluqa/x1Nl/ta6yOZ2H37QLezBeJapEgRFV8G/2UfYZnKSKJbFKdmXgw2elgbCeE1XEQbDRIrS6bIcDIslpT9YgBrkWHoDFyH+L5P4IYrm6yuuCzyz9NF1Ka0qRLGoccYfwESIiQn4C+7QtlW6Evh0OH2LuI7jnAIMEhAfBrYv50gupnjmj7CTUVEH83oeOs9uMSYSlTDJH6lJjuDqoZjnNpDBq6MgSFLElVZnId97ClLe+4X7Ee6Y+1tExXompTZV+F7WiWuRfQAgG7i5uLxJMM+L0VP4PEbw6e3lvkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFA6rmdpIQblCuvx4EN4nQXeAeXCK8n+b5/36JnAFA=;
 b=KP9LUrxAhkngMXwz1EtluLYwKj3yQPQWa1X9o4h4InToinuCzGBZJmeCVijY4sKUSpWy2Rru6nYDWPjepSiG2piSC7iQB1Z6CuTod+5/ETdEuJSYb7DN9Mhx77tZxFNgKGNc5+Vt1HJys3nwOpYEZDe4xhVzNdpmI9uXTwFXWpDX/h83kOW5w5J80SHvyE4w1JxZqIZyhVHheauMP2X64mqJfecCCfoTWsVf9Ob2H4km1P5syOmwUqSwnL1oouIi7lylINWBN5bZ8eS2kTWXHTKxaWMWgptt77F4qZglVjlXXcOjvxPm6q5PgSJhN28V9XnFWOiYmSIUgdMftemEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyFA6rmdpIQblCuvx4EN4nQXeAeXCK8n+b5/36JnAFA=;
 b=pK+sSPDvhMeUnp3jK9V9lFXrN8ytT60ehatsteZlMJvrKXEgjIjPGX9T+jQNe1JXoYqjBOyHEUTbRq/FBJ+n1LGVpXW7HJxkVgR0tho4fEFOqpQuQ95DyZkPM8qakjfm1arQ4tDVIqgCDHBgQHdqtoP2ucoJqLeZd2v7V1spCfE=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4970.namprd04.prod.outlook.com (2603:10b6:5:15::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Tue, 1 Jun 2021 17:28:06 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:28:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
Thread-Topic: [PATCH] nvme: verify MNAN value if ANA is enabled
Thread-Index: AQHXVgnP5NluG1yM0Uu+5fs6wa2apA==
Date:   Tue, 1 Jun 2021 17:28:05 +0000
Message-ID: <DM6PR04MB4972F39AB64A70710D8CD9CB863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210531103651.109426-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38bce62-7646-4c0c-8185-08d925229e0d
x-ms-traffictypediagnostic: DM6PR04MB4970:
x-microsoft-antispam-prvs: <DM6PR04MB4970B778CBFA7165CEF58DFB863E9@DM6PR04MB4970.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwmvIFOXch/DRpFknujRVqirC4ANbW1+Z8OjfhHW10jnOab/sGY6BM3NdbBkDkNlYD+NYJ+RnJ3EPklStvbY99qguUXLHjb3TComqbwQRCA9S+pCcTBPAWQMO7urcPtF96uLc7aiJjXD2aLy9yaJe9Sprl8ofZnKcXwBZMDw4l6GcZjxfWjB1K5DWuhbsAqlQP+mJ6CxQwQvIibrmxdo/TUyGYEWVb4aV5a/QIdyhhZcmtEAQCpdy93lqky3g4VWE1AUbYSPLdyIlEWX+35SC7T4olfHTz4IZ2QD6BadgVK7q9Cc6MEdY/zg3YYrajba4KpGu4JW0ZErjoim7n6ca18PnxPUVN+ViwDoez/U3Ao4Z0ZiA/Geh685gDNuDGHAn0+SAcNorXgYEPcT0NWoius/0WTdOA157zhN2kSr7dMGAId/v4897Z2pDSndyGsn4YQPe+jCYnKG7aj2yAh6sNbLNWD8Mt9NMDBtxnL6rNIF83E6rIp6kPqPsp2HGJFA+JGjjWIY/0W1BlFEaOAuNslPzcWFDfzKRwaMhiXxVTYiF6OrO5y1voQOedBL0jf6gKQbwhFQPOtqW+jfyfViRdFhWx6cWLDNJewzIRXu7AY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(26005)(66476007)(38100700002)(64756008)(52536014)(91956017)(9686003)(83380400001)(86362001)(8676002)(66446008)(122000001)(53546011)(110136005)(5660300002)(76116006)(66946007)(4744005)(71200400001)(2906002)(478600001)(4326008)(6506007)(55016002)(316002)(7696005)(8936002)(66556008)(54906003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Swxhjq9Q5HRDy0hNl+4k8K3qVcyjxiz3dXXJplZWw0gwpaZjqN6BFJVpP1tn?=
 =?us-ascii?Q?TMjriRpv369kzpMvsUW18fxAwAH0dZB9lkh83RnR3ryI9z693542MXMTroNs?=
 =?us-ascii?Q?cbbuvCwIZP0g4n9oGGBM0ylY1GYUXJhlmj2+sTPZ4k1Qsku3XrEqLerZbOir?=
 =?us-ascii?Q?WSE8VBql2Gmluja/SU81OhiPqUoAoJw8bkf5WSdsiKseqHfTShLSr6bHn9MB?=
 =?us-ascii?Q?7HaY4Pw2Gqd8ZiFs1NHOtGTEC9xtUJG5IQw7KjOAGBfhH8cmdusAmsveL8j/?=
 =?us-ascii?Q?YuxUMNkHjvUAJUVVJGHhe/M9lhDJEwjkvRnhWz5kWuy0i+KBKGOD6AiRAu/C?=
 =?us-ascii?Q?5nStq492dpRcKKjjStHYZpL4SuaAMPr8psY3L4K/2nU7gBD1m5wRctoWvM7i?=
 =?us-ascii?Q?2hji2ym3y6Y5MFJFToYG9C+AJzAM9stzoxr/1rTgv1B00ePoJv2kHQ8hEBL5?=
 =?us-ascii?Q?Z3S2Q+MN1OzDJbc++XS5IVg+QDTv9ndUc7TYX/87jOPgLxQ84zvotGTdwcvW?=
 =?us-ascii?Q?SjS9sQX7bJ4a1lGIe3yb55afVsydCYB85mXNnwjHzKUP0gmGEssuoqf/Z8ml?=
 =?us-ascii?Q?/79u5boy/w/OGMIB0nBQszCoKrQNSM24qBmCD1XbDOpkvFLf8gOiatl57ts/?=
 =?us-ascii?Q?fpCS5P69vFYqfWfizWcG6ijatgS2t1NV2qQiHWl/Z0vqp0o4rzl/NtFSZKzY?=
 =?us-ascii?Q?nfTdalWI/hq0QEesAhVDSGNgNvV7CeVxn4r2xCLSHiJY685IR5+qXe/M0wWZ?=
 =?us-ascii?Q?2kylwn36KZi59GEonOGxryplwKW06XLnK/qKqV8jmLJxzaQ3e71ZO5KrOMpp?=
 =?us-ascii?Q?PKq0oWWDZqO77v4aXTc7IRJlQvZa29LOesjY62qeyaeuo4LezzrNSL515c2k?=
 =?us-ascii?Q?VayUlxURPkVCDqli+hnEeVnhmTb2rFA+Q6UUvjLb5WPv562yuN70h0ZJOt01?=
 =?us-ascii?Q?hPQZ+jCzG7XUqWXUYCAiHMIJN1/w+Sq0c0I1GMnD64nxhu7LnjjpqmlA0gyA?=
 =?us-ascii?Q?QdTQvObe6ixXOlbPATLR7bL8DSErH3zKNRHoHgr412gRoTZg9qgjOaHj113D?=
 =?us-ascii?Q?0s9N94iNTHDompSJ0JzL/P8N5p/cnL5Mw1/s9riuxUUWCvn74fvBpuC1X1yi?=
 =?us-ascii?Q?nN4LdmTcOTsVOtWp6QbkvMZi0e3U9z2m35t0I73KUuuEQ7VZ6PPrwzblhlbq?=
 =?us-ascii?Q?1Svy7dgRohUmVTzORohBvQFajIyq3IghaLD7AzegfcXPkYREcIBSXz45yWw7?=
 =?us-ascii?Q?6jZTqP7py4Oi6w8RtpivTIxi3PXZsdPoYA4mXhJbsyCfJc913c82e9Vt3KJa?=
 =?us-ascii?Q?2XPxIsk/yk9ox7MXn/wdMXQY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bce62-7646-4c0c-8185-08d925229e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:28:05.9747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv0gaIaVdeirty3mrqlOXq1i7BrrxziAloC6hu4PB5MLE7M/EQQUIi4VAahjpJCpa/oAzAP4hFZOF+mzvfH93poBMCIfbCHmNOHXQs5DZy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4970
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 03:43, Daniel Wagner wrote:=0A=
> The controller is required to have a non-zero MNAN value if it supports=
=0A=
> ANA:=0A=
>=0A=
>    If the controller supports Asymmetric Namespace Access Reporting, then=
=0A=
>    this field shall be set to a non-zero value that is less than or equal=
=0A=
>    to the NN value.=0A=
>=0A=
> Signed-off-by: Daniel Wagner <dwagner@suse.de>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
