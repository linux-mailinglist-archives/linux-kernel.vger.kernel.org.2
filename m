Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2751D403C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbhIHPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:35:02 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:15776
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235441AbhIHPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRnb+c4mtdLR9hvfy3vfMZz1hVdVYL78n+LbQuyagQ2JVK+xhOpZ1WgELZflNvtBG1evc6BouSvV9IZ3QmNQ9f9NxXtiAUlxdtb0+eSM2qeZ9lRDkUVcYWtfmSdldNDGQYJ4xuv2ZkY2Z032PR4Aurv4YFQSJ0m1Yw/NvdnIxQdyIdm+gUWNPRRfVHOtSoDwrOmN4I/KR03r6R8ZGToxngZEelJLAnnonRDBJReKfg+AvUgKnRLImACz8qFoHl5V/vHHU4YtUOepSyKZFLPsRDa9ZXqvpl/fgEp/jHBZ7ZppX/VLRqJ+WuRF3qtcTn9xl4Ghpyg9FcsxSd9jk/9I/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IGrQfjuLVclAqXyoLf8+f2Z1b6/dNHsbDHJwjOrMpaw=;
 b=iAZGgW8RSNEI8tIe5W2NsRv2qZQkJ539h5J/ikIckSwK9ehRR4VK9WtTDgxpWsz3isLGLPMYHo8SazBy66Bj74FgQtxaNH+6OSLCHeqi6cas6oYYIM6zK6cgJRliMRuQ2MokljKkveaVDXz2jGzzDCyy66y3G1i/sNDMDdejCoUEvYZBXy8JhgsQQSluuNdazuvdqAObw+aR90tEizc1dCyG8ee2AeIbxBS6WNz50Z8/SwHovtm1jw3te4PX2DsCs93for+/jyen6u9iU8Nk8B3GkVf/tW9SsW9+sH8Fmb2mDosuqz++ut/s97L0+rk41PKjkAXXmbH9OvPsEjdqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGrQfjuLVclAqXyoLf8+f2Z1b6/dNHsbDHJwjOrMpaw=;
 b=Uo7qcfE9+k8sTBar1dySGBkY1As1ZxBUzhxciAcP0nyfe7SinKaQpGCgqlZzjoTbSAezLL7G+nuqlv+tDhp81UHxZTE42dcCe+/wRTN5jQMohx03FErgMnb2sCHQYuX+3AIUQRVr+Jp1smDYrpYPS7/+Mj7stke+8P1wvGKdYqg=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15; Wed, 8 Sep 2021 15:33:51 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 15:33:51 +0000
From:   "Yu, Lang" <Lang.Yu@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Topic: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Thread-Index: AQHXpKowoLymFk5Tf0idLKRe5rRrP6uaEbwAgAAAhDCAAAhtAIAAAPuAgAALmYCAABYx4A==
Date:   Wed, 8 Sep 2021 15:33:51 +0000
Message-ID: <DM6PR12MB425003383BBF9FB949D48B0FFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi0xkTVYqUpKXSt@kroah.com>
 <DM6PR12MB4250080A69BD3E2DB0050273FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <YTi/UxFCYKqdT34L@kroah.com>
In-Reply-To: <YTi/UxFCYKqdT34L@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-08T15:33:39Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bd1ef044-a52a-4b29-86ad-c91d9ab395a0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acd84b2a-71c8-47ea-a317-08d972de0f51
x-ms-traffictypediagnostic: DM5PR1201MB0105:
x-microsoft-antispam-prvs: <DM5PR1201MB01051BA73AAFCAA168A94F31FBD49@DM5PR1201MB0105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSP0mbCkerG1u4YPbDcFbmwZC6ZawdrtQpqY79FcsoxxyZ46quUdxmifE+U7Jl10x6r9vne83RS/631AFL2Ur3tjZ5mritKVl6KBzUSu+B//JFB0gl9ynR2ltuokPWcFcxH6rOb1isphXk5NaMyeCoIP0JCEc/Dv7D0rm7WEq6HHyVCXyAEXvLV98lTfeUz3IhANEKLQKCLyQ+ZX1bzHL3/fWeGKPP/g2OzR8MaLcs5n8tIeuXf6ubPcas8qMyRSv3Y6kj4cPX2dhrDqJ/NZOVyxZiu3rx6TtQJGBOuVdTo2zJMXWPuPbY6AVgaupQ1bEzIm2n2iB9p1lji/i3JJlbSG5cwgI3wdG2EvgPEiBXgIv6hZofFA+lYNv/ey8Te2GbQbF6NKLhH9cN9cLKyB7K/loagPS3PF17QD0t9SrIfcoVzRX2QoCjAL58lC30X9VRgE0MbuhKjCX+t/rOO1WZQqFiYwpE37T0m0Fc18VcX9AnF91iw6D5AXWdX43wg1G6h8W/Nhc8oNmdtdz7f3i84b6azRjl0pJ0Lr75qmsmI1XMNve6V7VSOrmnih4S9komui0IJu57ZgT0FC83HcZKbAk/u9SuegrEgNw3E/Lt6U+i8T2nOBS+1MUT7YM9mdY3GSb5+nInoMsvoYtWhp1rmgO8gm/9RArEuXLaIlQTIUmS8parolAYfoY+NJFwLeBTd8wRL/KAIlHIlQVovZBZDvi7QBxYWOqMSHbhg/YoU288aQ2UPNTm0bt3j2ww+3du2NSurSzRG8zoYHMxHr+1zWPH/vRdcXUW4cjXDsHtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4250.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(66446008)(76116006)(64756008)(2906002)(66476007)(66556008)(6506007)(86362001)(6916009)(45080400002)(52536014)(478600001)(8936002)(66946007)(7696005)(8676002)(71200400001)(5660300002)(122000001)(55016002)(9686003)(33656002)(38100700002)(38070700005)(186003)(4326008)(316002)(54906003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rjb5o4JHcLU/VtvaRYo774oAlwqHIH2ikvhXEt3MNlFJa0aU1y2VAg5PlHsm?=
 =?us-ascii?Q?2j4SJZefFU7U+j1VDfpJqiI9+rwaSR7ohFVcpqw2pP9beq0vFI/P+qyUNeyS?=
 =?us-ascii?Q?CeyzhxXMMBz0EEHprukmmetP1ugVLbnq3zN+kbmX4PaSigOB3Dpx3mKjo2j2?=
 =?us-ascii?Q?r2do7YV3LaU5UrEGixU65xI7gKZNni+WOcWk9hmmMkiS5WY+I5d11FK2RL4G?=
 =?us-ascii?Q?wueURkb8Fnnys55nkrDQV5Of6Z43WQDEl9XMX52slXdz8atI5UqMpHcVlYce?=
 =?us-ascii?Q?4yArUMD1kw1rHHFNxO3xk7WBLm8HmbEylIKBhvpqjBb0acFCEPiyV4z22XTr?=
 =?us-ascii?Q?slI+SRbJgAoL71eQvwlDVmNGQpr6vn0TcI6szZwZXsucbAj4T1ub4s7F5NHl?=
 =?us-ascii?Q?X+NXN3o31Q0I6siy64YW2/nbN4KDfVDPLAcotK+IzvXzlBjh95jNn5mZd2fT?=
 =?us-ascii?Q?5kOTs4KTIuN/QAL0yb01Qc324IqIr3IMsRzX7Wy42/wIPyE0OxSHFpBKR2J9?=
 =?us-ascii?Q?XDOsi/H7I55t4gkLMM51KIpK6wyVOLuslYakKkdSTzsJFlcXOlnVrbkZXiyf?=
 =?us-ascii?Q?8B/p0DixkdAHyUuAn5Ru5gcD2ipQowwRs9XblbEpe5pGYKL1Dq0HC+yRG0jP?=
 =?us-ascii?Q?rcN88YBTe7XIPkcTyQYUj2rDJqO9YHxTeFZp9Xxf/GvMIH52obJIVPRZH9F7?=
 =?us-ascii?Q?SjGTiIAeyZkq9iC0REmo6laxg6c7q1R0wx5YdLZI4/oevW/OXK7Wgadkuacb?=
 =?us-ascii?Q?SL/v6FnSrSJk2yoDsBB3wRR2QuUOiP+Ep9vRRB5jVtjx5iCpYGSybUkL//vN?=
 =?us-ascii?Q?9E58B8GLX8Y0sRvY9O9Jj3ewKRNDTFvqgPwAO9BfRws8HpPhGWQEvJPUiKB6?=
 =?us-ascii?Q?ifLPzizH/IW0jfds65dWIHFJiKRxvLFHLyxxcM8p13F4WfT7fvuqDcn3vsd3?=
 =?us-ascii?Q?ldGMFWbqWbYy1fQeMQmOKGalN0H1mV/KAWGh1Vz6MSohicLKa/zWZaN/QtJn?=
 =?us-ascii?Q?hJZ8vUiEcaaRScfFarMso2zkL4qlWHYgxLXNFrRczJ8vcQsvowle8We5Yuwc?=
 =?us-ascii?Q?sMoTF0fBqnCwxMzodJz5JTT+bfCw0YsEzMTpuSsVPb/ps+VDjsHNjl+Azyt7?=
 =?us-ascii?Q?65mPW9mXiqA/SlBcpfxdNUP3DXYmtIoTPzJDdh4dI8WnJjDtuEFHra/lfHlu?=
 =?us-ascii?Q?vruYCNhASqig4vMXfwP4gfDqiB2+L3yoONMrGJPBP32H+Es2/AQm3cTdi/Sy?=
 =?us-ascii?Q?TIhjwVNPbJj7ASOVsxkSe/y//XohFKqNKrylditNvUHathzcA8u6HRkGX0Y+?=
 =?us-ascii?Q?gjo9sEiTJtsS0L1HGTEjYhQp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd84b2a-71c8-47ea-a317-08d972de0f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 15:33:51.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOnXleiaz3ZAIylMyAzJfnFGnARCpVo5+af824C6mSrnOCRVGYNlUbUiirjxrU+jgILrJFi818JN5hh376mIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]



>-----Original Message-----
>From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Sent: Wednesday, September 8, 2021 9:49 PM
>To: Yu, Lang <Lang.Yu@amd.com>
>Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki <rafael@kernel.org>;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on sysfs=
_emit
>and sysfs_emit_at
>
>On Wed, Sep 08, 2021 at 01:21:16PM +0000, Yu, Lang wrote:
>> [AMD Official Use Only]
>>
>>
>>
>> >-----Original Message-----
>> >From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >Sent: Wednesday, September 8, 2021 9:04 PM
>> >To: Yu, Lang <Lang.Yu@amd.com>
>> >Cc: Joe Perches <joe@perches.com>; Rafael J . Wysocki
>> ><rafael@kernel.org>; linux-kernel@vger.kernel.org
>> >Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
>> >sysfs_emit and sysfs_emit_at
>> >
>> >A:
>> >https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fen.w
>> >ikipe%2F&amp;data=3D04%7C01%7CLang.Yu%40amd.com%7C43d1354fdeda45
>713a340
>> >8d972cf6fcd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63766
>7057520
>> >373013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
>uMzIiLC
>> >JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DtfUI5HXg6YbMRtFXs7
>X0o7Z
>> >rRgKdwJfk%2FwIykAEkNCY%3D&amp;reserved=3D0
>> >dia.org%2Fwiki%2FTop_post&amp;data=3D04%7C01%7CLang.Yu%40amd.com%
>7C
>> >fed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d994e1
>83d
>> >%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d8eyJWIj
>oi
>> >MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
>0&
>> >amp;sdata=3DLHujj041jxZjvoYxVYUKtNr7us%2FX4pl%2FdOkFSOP1W8U%3D&am
>p;r
>> >eserved=3D0
>> >Q: Were do I find info about this thing called top-posting?
>> >A: Because it messes up the order in which people normally read text.
>> >Q: Why is top-posting such a bad thing?
>> >A: Top-posting.
>> >Q: What is the most annoying thing in e-mail?
>> >
>> >A: No.
>> >Q: Should I include quotations after my reply?
>> >
>> >https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdari
>> >ngfire
>> >ball.net%2F2007%2F07%2Fon_top&amp;data=3D04%7C01%7CLang.Yu%40amd.
>co
>> >m%7Cfed047de547541548fcc08d972c92627%7C3dd8961fe4884e608e11a82d
>99
>> >4e183d%7C0%7C0%7C637667030534349355%7CUnknown%7CTWFpbGZsb3d
>8ey
>> >JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
>7C
>> >1000&amp;sdata=3DAOLGBdj01XiEjhmsBSGTNuqejgU%2B6jg416Paz5XdM1A%3D
>&a
>> >mp;reserved=3D0
>> >
>> >
>> >On Wed, Sep 08, 2021 at 12:52:43PM +0000, Yu, Lang wrote:
>> >> [AMD Official Use Only]
>> >>
>> >> Thanks for your reply.
>> >> Just curious if we don't put such a limitation, what are the conseque=
nces?
>> >> If we remove the limitation, sys_emit/sys_emit_at api will be more fl=
exible.
>> >> Since the comments of  sysfs_emit/ sys_emit_at api are " sysfs_emit
>> >> - scnprintf equivalent, aware of PAGE_SIZE buffer. ", Why not make
>> >> them more equivalent with scnprintf?
>> >
>> >Because this is not a general replacement for scnprintf(), it is only
>> >to be used with sysfs files.
>> >
>> >Where else are you wanting to use these functions that this patch
>> >woulud be required that does not haver to deal with sysfs?
>> >
>> >thanks,
>> >
>> >greg k-h
>>
>> But some guys think it is a general replacement for scnprintf(),
>
>Who thinks that?  Where?  The name should give them a clue that this is no=
t true.
>
>> and  recommend that use sysfs_emit() instead of scnprintf(),
>
>Please no.
>
>> and send many patches that replace  scnprintf() with sysfs_emit(), and
>> finally cause some invalid sysfs_emit_at: buf:00000000f19bdfde warnings.
>
>Where were those patches sent?  I will be glad to review those.
>
>> I think we better not put " scnprintf equivalent, aware of PAGE_SIZE buf=
fer "
>words in comments.
>> It is obviously not. Some  guys are misled by that. Thanks!
>
>Please feel free to add better documentation for the functions if you feel=
 people
>are getting confused, do not change the existing behavior of the code as i=
t rightly
>caught it being misused.

You can find many patches named "convert sysfs scnprintf/snprintf to syfs_e=
mit/sysfs_emit_at".
or "use sysfs_emit/sysfs_emit_at in show functions". They may think it's be=
tter to use syfs_emit/sysfs_emit_at
given its overrun avoidance. But there are still some corner cases(e.g., a =
non page boundary aligned buf address : ).
Thanks for your explanations and have a nice day!

Regards,
Lang

>
>thanks,
>
>greg k-h
