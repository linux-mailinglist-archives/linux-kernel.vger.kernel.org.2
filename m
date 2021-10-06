Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99A423AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhJFJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:40:08 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:26678 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229874AbhJFJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1633513083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBX0fEwPjnwaXnhDRgCvxvnsv5weuGjjSkOFhCG/fXg=;
        b=PLRfBQaKn3Wqr0QFsH2yvxbmAuyHTiqQHYX6wxJ3TMo0jQ7aghxu+hXTj4TaRykD/JgeVf
        2/alN+3bi5fgr3if47exH/5IfrqZSwtWkQAVR6s4SBxzeF2mD7DQYmwrHQy7rsYLX3fnxN
        DNMIZLOtOD8+BMMgX0X5zJI/whfHmFw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-5Roshg1tOiSojBFD49AGdQ-1; Wed, 06 Oct 2021 11:38:02 +0200
X-MC-Unique: 5Roshg1tOiSojBFD49AGdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0XDfws2d3Y/R24szrAtfWmjd1pp3DWBr5HdgBGRgBvdx1gC+nQBSeV7pL9MYJxsbJCBZioQ83EgFhLoqc2fQet2Nfb57LxITbduDD5e5LjF6H1GfjE1bL7A1VyTigVzKIGJJkZBhxfc1A5dxbFQzIjr814QaEJHHXTwJMNiPWsFJUzOkm0A8s8ZeXwqV1rh/gSPqJbbwvtWxPL3DLJ/siVRGnKkKf98OCISu9IZv1Edrc46wzh4av37dtWmYqwiGXxvO3gSTt0JyRjPeHnHb4bKLthc7M9bS2c6+ZBzDNEinVycXhuxWhb2omrNDJiCqasg6ii0r3ObxY+WnJubyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUs0O2ij/rQZxtE9QHjNdQZrmQ8fw/1VNZ/aNDhtaTs=;
 b=PsYoVmDR9ob8zWYyy4PVTyByOG/+8LJJFMdrb6HFJZa5FHuxNrUsu1ArMx+3DY11DoB9fsOX2MNP4f+PJ3M5te3C6XShOm8w1OjU/90UanmRhHFTyfRHJtILXGkRNij8tDNWJAo/+IBAH2ERsmtT7lDMsUxHIdwEV9UIctQjS0jMUhlo4gpIiQVoLFWB4ceN95gy7jeeOqaZ7uFmtgM3SMr8GAevrB8YPiGA5uI/t46Mv9DucJutnIQmjxD+jQZ54C422B4NupsFq30doEfb6LWl5Tnw9oEOtIgTfqAeefbhxOlbd9iDd1NdXGxlJXWe8XeUzq5fXqiFq7huRxBG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5043.eurprd04.prod.outlook.com (2603:10a6:208:c9::20)
 by AM0PR04MB5682.eurprd04.prod.outlook.com (2603:10a6:208:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 09:38:00 +0000
Received: from AM0PR04MB5043.eurprd04.prod.outlook.com
 ([fe80::44fb:a0a:1c20:2fc7]) by AM0PR04MB5043.eurprd04.prod.outlook.com
 ([fe80::44fb:a0a:1c20:2fc7%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 09:38:00 +0000
Subject: Re: [PATCH 2/2] usb: hub: Mark devices downstream a removable hub, as
 removable
To:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@google.com>
CC:     Rajat Jain <rajatja@google.com>,
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
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <c219168c-2727-0b44-7a05-7c0e31770de4@suse.com>
Date:   Wed, 6 Oct 2021 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20211005195929.GA634685@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM6P193CA0143.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::48) To AM0PR04MB5043.eurprd04.prod.outlook.com
 (2603:10a6:208:c9::20)
MIME-Version: 1.0
Received: from localhost.localdomain (2001:a61:3b0d:4601:21ab:d1da:15e9:ca07) by AM6P193CA0143.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 09:37:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e8b85f-9652-4124-4228-08d988acfcb3
X-MS-TrafficTypeDiagnostic: AM0PR04MB5682:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5682DEF19E8DFD28AD164B85C7B09@AM0PR04MB5682.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVxasmgqsX1wJd2t4ToPBsNIdOw2Ohw0xZJW+7ltirtmc101pCxJ8UGS2nj9iimTwzC3Pe9GOyel7qk/LPEfrehlS31dkvyf+0K3rlyphNNQG6KX3ha5PCSagAh+ZeSy89DPJXJphyk4LV8fT5fF8HA7LM0zgmBXS0QtBi9MnrrtUdvlSSMztNJ4Ej0rTTGq9pO4oWiMixQ3eTCsXyjRXWgvSqnKxUtwXsvY1Wb+TDcInOB1/4vV27Jx+dOIc4NxXU9JStl0OWVdBGwcpW2fOHN4yUK5fO1SvkVukTiMWA9dqb7Q1aPTp9mQ5a9KJF2Vd6+x055KDH0VP/nTLXDPQSgJVgQAXmP79uAOXXDqmno978crLOeWsur0czWDDnEdVyWWhDwVuSSo0nMSL5/5GcIq8st8DZP0WLsSyQzVchytpLTx6fSw/OJhvIttmC8tG97HqsR8uwnktpHELVM2RbVfq3z7q+q9we/vsu42IuE3hcT+TgFw5QCYx334rd+ci5k2KeUQyDf6YPRtA9RpABWAzCzl3BEOdAYpkWR38fQLvDT4ic0Ol1/psJbI/MwQ9yUFmGPiHgQABBDLSOpaTDsgcMgN3FTCx7+2gVwyV0McfasplF7pEvdYmWzPBDIL6v2QH9qXRCRIslfCcD92n3kBECbtjXVYQKggebHHNgZlZANIYv0gaXDoxawQc/o19hENvs9UNMsaM1nuFlTZkiEPHfxUxNi4psFea3NYQAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5043.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(8936002)(6506007)(4326008)(2906002)(5660300002)(83380400001)(53546011)(36756003)(6512007)(31686004)(66476007)(66556008)(54906003)(186003)(508600001)(2616005)(6486002)(38100700002)(7416002)(66946007)(316002)(8676002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTXuIyyxml5U4YMw7/35Ubucj+GkSvBc7ekDT1ggpQTFfWPMFvUPsE+rrt+c?=
 =?us-ascii?Q?nTpn+vt2+v3yyLOLBOXiYezM9ba8VLEbvUJLD4kRUO0GITJNdZfEGDC9lu23?=
 =?us-ascii?Q?68nCqzpsjqqQHLuzNN2FMTEvx3HWlmB8J5YLeCz9n8pgg04fvEwGi2qbk6UE?=
 =?us-ascii?Q?fFhRiSmGVQhcsE3WOo+PlUa3bWcotogxtKZOUuQB+/5o2wp8Z4hYPeZWH/Vn?=
 =?us-ascii?Q?10gaS1E96oMHr9JPCdqthDPK1/QlnhE4q6BmACMTs3buWHeFPI4sHekTiHq5?=
 =?us-ascii?Q?C+4Ip3YlIlv41t7FTkIfIp54c0pRvdSfYtSEtvMTkNgpCueNwUTFFxegmO+2?=
 =?us-ascii?Q?oaSorGBqq4ANoqJttDJPZ7K0ofN9PbSrRdg/uvLRe+yt9IjZLc/zi+EPznPO?=
 =?us-ascii?Q?MMwzc4gHdEPnBbP8nmRlqYAUEptCxhtAeaoncQxs/jazhv6i55EkfwNDJJEy?=
 =?us-ascii?Q?44c7SipmOp3q6SsT7D4G93aKqcjtOXqbWbn4Prelgrx2TuqZ54k0oawjLPg2?=
 =?us-ascii?Q?M0JKOFJQR4K4Vv6sIwxgqx/rnTuKoMQN+8d3OJHsYkkwJZKQLkYNupfueaqt?=
 =?us-ascii?Q?jyoyPvGk+vpbcaWq1v2lGDEIqyk6PgBIkYBOAXNIFx+WoGOdR8u+ENQdoyGg?=
 =?us-ascii?Q?RV2swrDfDnSbvCCRct99vblFBIXKCg6BNDy6u6J5DhpsnyleJ/CRbIzRM7ji?=
 =?us-ascii?Q?tgXZZSVzaoE/GSmzBF+Ak7Jvb35RY6bwFA35t9lstTSXli5HsEQZKe4bElxF?=
 =?us-ascii?Q?fHpYJRMdXy58TcIIpDW2fWznpZxaYzGbTtPtmXwOGY8RLZDCijhwwb6ifomf?=
 =?us-ascii?Q?IDPz0/ZtuTE2WYcxw9j5C6upBsqp+0UldjvpCYWfCaM0muqUicqRpV2wAf6A?=
 =?us-ascii?Q?JTUMpnnVBlXkxxkhFncAoDOUyF9Nn5UqS7ftGe3TfualuVCAQdq0BcqcKS3d?=
 =?us-ascii?Q?F3VFsUW/LDSH3ODIxDsTTpLpcHmDEHvkEXkWh2XSNNqgrzFKACBx9NbshLQQ?=
 =?us-ascii?Q?yI83jsFgM0SlBfaqwCxoWjQYRWP4wX2bnCWtHd0c0YQN6jTJTpbqcMz/AAsM?=
 =?us-ascii?Q?+E1tTNose64nykw0S78z8vVBBUUA/f2i/9BuNE9VodBrGmhclqbdWS8UPm18?=
 =?us-ascii?Q?X952+ER2P4Bk0twIeveofmtH5G2hgHHX0FuvGw5fx6wr6IPt8IkxrQ4+NuqE?=
 =?us-ascii?Q?3u74VVoyFPlDNLFpGyBxj1YzWOCIHXvYvzZFDsVSQXnWJgQEVUQqMHgAF5LJ?=
 =?us-ascii?Q?GG/GR6xj8voJJy6CZ/fvme7E/QQr5ghNkYf3sjQ2CscY3Kcq8twbcimn12xt?=
 =?us-ascii?Q?M4X5ZYJfEC37FvVvDbSfmCyfMKWiPecNxbSP1t28NEHL6G+Kg9vJC76gWAeW?=
 =?us-ascii?Q?ATF1ocqEMnoNXpI8GgaeQAq3gt+I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e8b85f-9652-4124-4228-08d988acfcb3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 09:38:00.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgvcVgMt24oJ4Njh3FK3iOvbn2gT9rB+iGMq+ZkHsUUujiTeNedYlwJuFhGmACaoke69ttuWUAfbVxO+/ReSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.10.21 21:59, Alan Stern wrote:
> On Tue, Oct 05, 2021 at 09:51:02AM -0700, Dmitry Torokhov wrote:
>> Hi Alan,
>>
>> On Tue, Oct 5, 2021 at 7:56 AM Alan Stern <stern@rowland.harvard.edu> wr=
ote:
>>> As I understand it, the "removable" property refers specifically to
>>> the device's upstream link, not to whether _any_ of the links leading
>>> from the device to the computer could be removed.
>> No, that is not what it means. I'll cite our sysfs ABI:
>>
>> What:           /sys/devices/.../removable
>> Date:           May 2021
>> Contact:        Rajat Jain <rajatxjain@gmail.com>
>> Description:
>>                 Information about whether a given device can be removed =
from the
>>                 platform by the user. This is determined by its subsyste=
m in a
>>                 bus / platform-specific way. This attribute is only pres=
ent for
>>                 devices that can support determining such information:
>>
>>                 "removable": device can be removed from the platform by =
the user
>>                 "fixed":     device is fixed to the platform / cannot be=
 removed
>>                              by the user.
>>                 "unknown":   The information is unavailable / cannot be =
deduced.
>>
>>                 Currently this is only supported by USB (which infers th=
e
>>                 information from a combination of hub descriptor bits an=
d
>>                 platform-specific data such as ACPI) and PCI (which gets=
 this
>>                 from ACPI / device tree).
>>
>> It specifically talks about _platform_, not about properties of some
>> peripheral attached to a system. Note that the wording is very similar
>> to what we had for USB devices that originally implemented "removable"
>> attribute:
> In that case, shouldn't Rajat's patch change go into the driver core=20
> rather than the hub driver?  _Every_ device downstream from a=20
> removable link should count as removable, yes?  Not just the USB=20
> devices.
In theory yes. If your HC is removable by that logic every device is.
That renders the information content of 'removable' to zero. Everything
is removable.
> And to say that the attribute is supported only by USB and PCI is=20
> misleading, since it applies to every device downstream from a=20
> removable link.
Exactly and it is a difference. If you know that a device is removable
you must not disable hotplug detection on that port if you want full
functionality. While if you know that a device is not removable you may
straight up cut power, even if the _parent_ is still removable.

The device tree is a tree and if you want to know whether hotplugging
is possible (let's ignore hibernation), you need to walk the tree top to
bottom.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

