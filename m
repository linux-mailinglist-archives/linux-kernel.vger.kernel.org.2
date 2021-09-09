Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06ED404501
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbhIIFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:32:52 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:27680
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350686AbhIIFcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg4Ml+1tl3weTQCdlVBxvlHtXNPVuDuotAzi84/gVERjTyEGnQRgg+KbepUM9JsE9DBvtvJN229qBDkbebEh7jVUEWX1gjKnA0WERxBolEj8sCBjRo0H8IXu/DvzYc/7sKqUg4b23HK01UsaPn1wLbfiF3L32GxeQJQBJfI7FAjOLN6ae5RiXVty1CdMQM3BaskVBpw2Y2e1lf3iSWK7JK3HmHpR4FAYN/OUPDV6sYDxpFVZeiq82omzwy1H6FRYS4PJiTC8fU5zd/YMf+pTye0L2uZqlj+tynQ83bOgAbiw7W28QL5nY1s/2fx7p+eXcIIB+Fd5KYZ8grEuui1mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uJB8Jh5AwtHI0E3goPjhHV8fQIeEFTXPlw94JkFaGHA=;
 b=bHOdt7stnxhFJ83IS5WHWq3dLrPcNG/ajctBvEF8SgJZzlFZj9vqUgckeCSyCJNz0HTKOkbZyCfK20hIuB68TDUaHHgFMCnLP48tk2sv1LEgQkuRkQqDIzb3JG2L0ickc4ZB4Nx4jHDys3QKwmOteMXtS0FGFSlrsUyeF1v/4hgIDKMuKdlHP0y9RRtNPGuOHucnGiKc+GjqkIkw8PbhZn68XQVuy7BqzTaXvBcJhnoY948krz5JQxPl1zLB/xMIkVuhS0O3eIT6lzGGk8qLqXhFvs9qoct2TLht7NS+3CeGvjVH4NfLXyU6Zxqle6ehka327F63NYYJMRD+30Ma+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJB8Jh5AwtHI0E3goPjhHV8fQIeEFTXPlw94JkFaGHA=;
 b=Xv6vTagp5StRH2JuVW+SdT2DqpH0Lq5kOeFVm5Q5CK9KAIcxQ85jKrV1gXNVMnDYxuKBGlzCryiThv4oMqQfmf9NDMjvvB2IIW7+TRm/wW7mtSOZZDjNckhTWnYZPQuXWsSL/rkOf6Qpv2BgQ/d5/KJrH9BEfpxjLT+NuaMoqOg=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.24; Thu, 9 Sep 2021 05:31:40 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 05:31:40 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6uaEbwAgAAAhDCAAAhtAIAAAPuAgAALmYCAABYx4IAA7buAgAACWJA=
Date:   Thu, 9 Sep 2021 05:31:40 +0000
Message-ID: <DM6PR12MB4250DD8FBA99A7F78B247B17FBD59@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
 <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi/UxFCYKqdT34L@kroah.com>
 <DM6PR12MB425003383BBF9FB949D48B0FFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTmZXU7myBFjx8/y@kroah.com>
In-Reply-To: <YTmZXU7myBFjx8/y@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T05:31:37Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2d0e1333-1f2b-42c6-8395-c5cda3ec7c79;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f4ad0ed-7632-4f65-ee02-08d9735319de
x-ms-traffictypediagnostic: DM6PR12MB3017:
x-microsoft-antispam-prvs: <DM6PR12MB3017DFEB9EC4CD819CD0E874FBD59@DM6PR12MB3017.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1yyUvfHmLNcFT09b2SyFilTTy/ibI6GA8xI+sX3JNszoeP5lUUEY1Hut8/rOtgN7TYgyDcqWfO/f7awOL7vAw/AlDuBU4rNzhVb2iVGFuoJd6Cf/kzR7Lm/bmKt0CYBUEVuaxiTX8FUkmXiqCMCazUwlIrUC0YdvlkxLWGRWd4bm8w+fQnlFdt2XmMHEQUTVLjWLtzm0AL0Tl5R+tpRnjAlKUkD2Ncfgo4K8REfYLM3ITBhWq/DCxAeY0aBxSU3JgHVnK16gLMWDpmN0q2UzjREZ+2NDQIhua96ESnJAMz/ryeCgrXqwKXJIuc/sNvI568Jd0WKA/Ty8lcZlWOn0IfwmQuz+w8OkLOvo/74AA0PVqQN9QDzM0oYYmW7NZ95u0rSBJgyep1S+RagXuqyPQk0+m8NAn8hgKycMa2bp3mhgJo4PLFwutrzh/zAMfjlAOCBBdoGwjQEzgblz6uv8zEK6+nuwGpRi8vXTkBYQsKzrF95gRn7pp7GQziVy/p/qO/0E3I8SfzOZo8icIWj/d/N/b1TevPEOShCOcBvf8cHzVY6FJg2zxurWZ2i7fAcSmY4DidIOanXZlljq5XINNVU/qnDgJzff9KqlNkROaxae7ngvxuCbNKTwdwl2nZIqGqB3PZOY39OTuOJrjPID1b4uOXeGHka9xwnAdn+BMdwl4anBI9WvvXQDzMVl5J5IY64sdp+LXgANNBIYd9hvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(83380400001)(316002)(8936002)(26005)(6506007)(71200400001)(2906002)(64756008)(122000001)(52536014)(66946007)(66476007)(66556008)(76116006)(86362001)(66446008)(6916009)(38070700005)(8676002)(54906003)(4326008)(7696005)(33656002)(55016002)(9686003)(5660300002)(186003)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wwxkelA8C96L92fDbBoEujgCaWVmOCnWwyz1TbA0yJZ+sYjr4NNMI2//XZq?=
 =?us-ascii?Q?RM+1nBzX9x2l+kokJ7x8ddExxCCPbt2Ix9cQ86qB5W7CWjM5lWwtfGGo84CB?=
 =?us-ascii?Q?DZPLpg75ZOgYEcU+qvdZ9zUD5oVAHBRszqT+sJM1dzvUFYT7yOv8u7G8mlK/?=
 =?us-ascii?Q?Bw33RZIEJOSAETP5K7Mwot1uHePcAREZKgi+6RXwGoPi6AUabHKXTrtbvhhC?=
 =?us-ascii?Q?bTzklKuF1THrxWCmodNxZQhgaZaNGjiqs/QNrFyFtmBWem/GSkSVa23C8j3j?=
 =?us-ascii?Q?h16mg6Twc9AjSfdTzCMIi+0eLDN4C8EvlVMQ7IB7au41tv2NuBBQIFz1hHFi?=
 =?us-ascii?Q?wdtcyJ5xrXc4gaKC+zDs17UfST4BKNiMV63TZzoKFlBpvqFg6OiSRAHBSyUj?=
 =?us-ascii?Q?yjNwKyvuZ5Mpw51gMET5mJk4FovCPyvXEEga1kYTSBPBvET7KWqNO9t6nbJd?=
 =?us-ascii?Q?wfIBlvT9Ejke2cgM28ojVY0oaVKqGaKQ1en6JYwxGuZedCyem8aNbVGoVVV3?=
 =?us-ascii?Q?soSwYv3l+WIoaMlrycHMERfY42rXlL2CulUw51toCjYV3c8iCayCkHkkDm0h?=
 =?us-ascii?Q?B4ncsGw6O9uk/z0equ5/aLFCqvT9PqgmyTS7xoM7WpRaCpsxI4xOJoSzx1Ll?=
 =?us-ascii?Q?ZIp19+sQrKawqb2wOHPBIQJi0DqGST2miAWDl1iWLXMFDNPrbUUE4onE9C3L?=
 =?us-ascii?Q?TM45f+wuB+QvihICIwTujaNm43cCLFJc6+2CW1Nuq9pATEHRFh/vYEUWYU78?=
 =?us-ascii?Q?0fmNCwpvRNGwiJIjVD6Jz3zeRg5x5i4juTMvkWN34dhMHR7TSr4qfBN1dPMg?=
 =?us-ascii?Q?dMmwiwoU+nC99Eu9yUR9YxYLT4DSCY0jKD/HBS7c52k+2uplP+9T44t8YZuv?=
 =?us-ascii?Q?lY2uYN0cPTqYTFr2Ptn1/FTmv+TmuTB+d6jauiNOKjeSDqUTjwbhdZB33dqY?=
 =?us-ascii?Q?flN/rRfGG7mRHsOjitgnXgZUa5RQ98vW2i3C83gJ6Y0LbUdDNgurQwKYPl5h?=
 =?us-ascii?Q?XDon53OgD1N5I8KKqkZ8S9LTLw61GD6QqfR5EO/VQ5AfTlL+H6ANrEtT7SsT?=
 =?us-ascii?Q?Acv+ADByggWGD9YGqGW+kflT0EIUDv+nEt4AbR+6xGGWGnqRIildHqidY472?=
 =?us-ascii?Q?xfhmYof26GvDfULT7v95r09OvkyJk9XvpjfuwfD1lv1SlKYigOWXfO/trsKr?=
 =?us-ascii?Q?MjL0paeFmD7zxS2/ZcHBSGLFgk/Bb/WYvEYEPyeF9W6S/1utZ3z1HAXI7jt8?=
 =?us-ascii?Q?Y3ogT0AXyfZyds0TubQuw35oyWY+pvgOGG33eqMt4mBfmGS8oKQKd7Scf1oM?=
 =?us-ascii?Q?gOL5ebXoSEtr09ieUoH7vGF9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4ad0ed-7632-4f65-ee02-08d9735319de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 05:31:40.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvReyjtkhCk4qWBH6wFDom2uJAMgXq2x+qR5rJdPYHUp1uihsWjwt9b8inkjgcJkKqG6yfRFhcC5rPh3NPgm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Thursday, September 9, 2021 1:19 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Wed, Sep 08, 2021 at 03:33:51PM +0000, Yu, Lang wrote:
>> >Please feel free to add better documentation for the functions if you
>> >feel people are getting confused, do not change the existing behavior
>> >of the code as it rightly caught it being misused.
>>
>> You can find many patches named "convert sysfs scnprintf/snprintf to
>syfs_emit/sysfs_emit_at".
>> or "use sysfs_emit/sysfs_emit_at in show functions". They may think
>> it's better to use syfs_emit/sysfs_emit_at given its overrun avoidance.
>
>Yes, and using that in sysfs functions is fine, there is nothing wrong wit=
h this
>usage.
>
>> But there are still some corner cases(e.g., a non page boundary aligned =
buf
>address : ).
>
>I need a specific example of where this has gone wrong.  Please provide a
>lore.kernel.org link as I fail to see the problem here.
>
>Are you sure that you are not just abusing sysfs and having more than one =
value
>per file?  Does this mean I need to go audit all of the gpu sysfs file ent=
ries?
>
Indeed, the one value per file rule was broken... Thanks. =20

Regard,
Lang

>thanks,
>
>greg k-h
