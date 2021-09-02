Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3633FEDF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbhIBMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:47:12 -0400
Received: from mail-mw2nam08on2062.outbound.protection.outlook.com ([40.107.101.62]:62881
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344561AbhIBMrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APV2dqJE65QNpC5DZcyoNDdNg4J5P2iAZzc/hpC/KJGP0nrI+ngzyRhz/wx+Zhb+lNYTOAduq9KIo8shdlVLFc8YIr+xU5L/vhVicsYcMHDsrYceEI6e1hLGT72EJAQGxP3nc3ROtd/iNISc3GL5jk9FPf+VPfncoTf0Q0CmDU18WWjEuOz/yfHlEIrrDFj/xoi1QcnZYEnnLzEjdlRC/DzHLSnrxvy7E48AjRWcfEzlUqLbGHkX0d7wu3I8O47m9TEVwqtjw0lz5e291SDz4BA1z2IcUyUGa4nf616VvyHjXaXhkMfbEM/KENG1UPpYEZcDuYbttKZiejuAGNCQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n1LomTbld0z8yxDVRceK/hkfbB3WJLrmwFQ3Tg2tUCc=;
 b=kZeivJu7FxbOG2TIVYkmJZjPc1LQtsyErsfSdYFWZGrZeJRagjpopMgfHZU5BKfvWqhNooMTPvxUz4G0FlFniijbEtJ5AguNBjUlmlnpsmyO9Yac5XBu7XYznFKQCo2GSQSzzQtXZTMXmKSgYO7t9o71pda29E73gmrk2Gg+lhNQRCWmCaXOGuQenzAGalPuzM/4orb5sdwzr+HfrJQxuAUcZvg3V41t+ShL47dHDsVdveMrgaxdG2bQ6TPMfnNLJTqHueuSds9z3YFVaL6aH54tQMpqKg7WUA8vkdSzUfAtwyRhhU/Hr97RQ8CDhaJsY7fBvgm3T+6RobYmwICjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1LomTbld0z8yxDVRceK/hkfbB3WJLrmwFQ3Tg2tUCc=;
 b=UFORO8XW01V0DF10F59/Y9ZsaabxiNSOpBnEgX4+/R+aAjQim5s3Kl4WJ6SwJQCX5K2wnrgB0Ydx6bk/5tgG2z7xMRk3ybf9p7cCsQXPiAznnnpFFoyYS/qp7PDVMef36qMfZeEOmq33wOqPXjeMtok2nCoyRNySHHCRTIk2afc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 12:46:10 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e%7]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 12:46:10 +0000
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Kun" <Kun.Liu2@amd.com>
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org> <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
 <YSXwkKJ53d/uwnhy@kuha.fi.intel.com>
 <BL1PR12MB51443C94208DDE0AEBCB91A6F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YSef0Iyr3oDWv6Kt@kuha.fi.intel.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <a06b1b50-771c-312d-c91e-b6707c4b9401@amd.com>
Date:   Thu, 2 Sep 2021 18:15:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSef0Iyr3oDWv6Kt@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
Received: from [10.252.254.83] (165.204.158.249) by PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 12:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5f6f63-d60e-4bc0-b2eb-08d96e0fa3d4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5242878841A38883A0E56013A0CE9@BN9PR12MB5242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmzVLCCWRGI+yLLaXbZRPwRmi4/SJpxIiJzFO+Aa70QGhIFF4GeFRHqP/30oyiJJ6VIcDqmgsdsOAB+ybh757ZpBtDiZ3lmhSFalugyOiou5/8f8JIMSVeegawFZqwRc9zUrQKYhQNrR1gT1kmWeUB1ZL3WKpwkzFi4K7LTZequOb9mYi00xMW3uMBoBe1mD7j2bEg8U84OxyXcgy4UACcKPg7RwESlPg4gll2lssEgr2FXcLQwOlNqlGIGdojxy8muoL7tthYiAEnTYN3GmL+BuyM2cTZISmcyEog26McDt6vd6c2xctBZZdVTvEH1G1y0HO6PXAXsoKZoLFmRQXFZTQ+kugxPkvyDNC2G4eANxY88rUDQkZNQVb7ZUWpJWe1htUdceNrEhkD8K8jdnr0v17kd3PL8HpMQda8yAKBvrAvWWwqRj9AlleLOPupLp8i1MAJ9MQGyTYwUWOOdwdKe/qdrtQjkYTpErox9ewJRbQ/SKaM2R6vl9pcR4dnWFoEUTzsyIgmALf/9Qh7vFhrSmei+dF+7D+v8EgNPI0qLD0REumZUhxGeek2aVdp5sWX0Ep62xYW65rpVMbxL0fj0UK9l4yDei2D3QnxmmbmYREGpv49CsY0/rhK7REJ8uLgUcIgMpmBlP4VGTWzntvaWjcyv/DcKR0PxF5uuckO6Cb7ZwnVJR4NcQGS3w4aA/rEz+gqTaHoXDb/6uO+3NhLf7YKnN06lo1xv4jMMMdfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2616005)(16576012)(53546011)(31686004)(316002)(6636002)(956004)(86362001)(110136005)(8936002)(186003)(31696002)(36756003)(38100700002)(8676002)(6666004)(2906002)(83380400001)(6486002)(5660300002)(66946007)(66556008)(66476007)(4326008)(26005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NURjJvY0w2R2xIeTE5a1dWdzJrMWNOSXJoTFVVS2xoZ2FGaGRLV3phRG82?=
 =?utf-8?B?WmRNaWxvMDl5ajArR0F4RHoxNU8xenJoLzhZQkZTVVhGTkhpMVMxZmJzaGFm?=
 =?utf-8?B?b05xYXNpYjA3b3BJRGhaMjdPNHdSODBpdjFRclVYNXNIR2ZNeXZ2eWUwVTg3?=
 =?utf-8?B?UFRpUEtQTHgyM3VqdXowZXV5MG4vRmhkM05ZMVh0cGFMaDF6VGZKU2ViRkQ1?=
 =?utf-8?B?UWdCTjFiL0xBdlk2d0xmakpRaDZDNFR1dEtvekF6T2duUDd0NUdPQXRUTFA0?=
 =?utf-8?B?c3lJcXVNY3lLek9BNmsweWp4NUo5bGI0em8wUGxQcW9aWlpJMmp5cnB1ZG9l?=
 =?utf-8?B?VDNKK1QxaSt2cGFXRzB2RTBtZm5PS3IwSk0wTmsvUEI2cDgreFpNTGRhUExy?=
 =?utf-8?B?Z0haZFp1QTV5YXE5WXFyaE56bU9xcDZzdHVjUWdrb1pjeHAxSzhKYmcwUzY1?=
 =?utf-8?B?Skt4RlcwcFJzRWV2TWZ2Y005aEdoUVlMdlVETHlNOUpoeVpDTHhJNjRnNEl1?=
 =?utf-8?B?eU8rVS9aeGhIRitMWEczMmZYbDZFWXMzaktOakxNaW43aDdILzBjcGxGRFlH?=
 =?utf-8?B?OUR2TDRTQlAremUvR1c4TDRIWUNtTllYUVdhNlRlaEZCY040UytWT096djFZ?=
 =?utf-8?B?ZE1FbWtNUW9SZ2lUMWdLRTRvMVdJZGYvTldONGkzRDJkTEZTWTlBbUZyL1Zl?=
 =?utf-8?B?TXgyWHM0V1F4ZE1KbGdjWmFOV05Ca3JNb1Q5Q3dTUXBKU2RhWldyWmk2T1ZD?=
 =?utf-8?B?SXNzUk01WGRocG9aTFlqdkhUcFBsQVhoTXNFejVmZ3JZSXZzTEp4TTVLdmtR?=
 =?utf-8?B?SkVxOEhZZnB2SUlidVYwWWEwM2R2WVBJMW91NGVCcHZxaWtUOHh3NDZnMkta?=
 =?utf-8?B?S3dHU0FJNjhQa1J3c3F5NmRPQitoTHJwSU0zck5RWHVlaE1KSUFHUUlwZUVp?=
 =?utf-8?B?NS85MHZMb3JXOGVVa1M5Wkp2NGhuSEdKczZmVUNwOGxzYVNzd2NJa3duVGVG?=
 =?utf-8?B?WXM4NWpOMW9DZEtEc2FZR2JpYzJ6U0VMT2l4d0tEakYrOGdwcmRSR2NjWU9M?=
 =?utf-8?B?Tlg2ZFNrZndRNVZjQzd2aVBLZWx5L2FjRmJTUVpWVWwySmhSMXBKL1gwblpX?=
 =?utf-8?B?M0tNRVV0OS9MWG14Wk5pamZrSWZoYkpnc0tlODYzZGJtYzYwK3kza1JTK08y?=
 =?utf-8?B?cFQvSzRZNHIwcERkaFN1MmdSWG1ETGRuZWYwTlRrbklxbFRBcFlDYUdmRTFy?=
 =?utf-8?B?amw4REZNdUpSM3RVUCt4TVU3L0hkbitPV0k5TkY2TVE3bWMwMVpsdEhaRk13?=
 =?utf-8?B?U1AzUVQyamxrdmR5R2llUkZyUmN5Yk02SzdOMGs2N0tkMFZUc3E1Q1g1WU1n?=
 =?utf-8?B?c3QzQU56K3ZDaEZtWXJxK0dnQURRUkJ4dzh2SjgxUTV3d1JXaXcwbTVXa2Ru?=
 =?utf-8?B?dmE2dUJPVTRaVWdaUTBMRUdYaW1tWTduNEJycElnQ1JKTzNkNEpzZlVYSGxV?=
 =?utf-8?B?NzdOTWlRcmJwUmpjZ3hNU24vazRTZlZrQnpPNkVJcU53M3lFUklsbllWZHIy?=
 =?utf-8?B?UVdWU201N2FBWU0xd0FmZkxhQzhkUmdnY3ovZDFLYi9lRTJvaWV4RENyb1Ax?=
 =?utf-8?B?SHQ2aEFCZmRFRytWNnVuUUYyanlDaHBjNnhhbG9Ga2VZNVMyT2F4MnlFZm1j?=
 =?utf-8?B?Tm4xbHFYc21tbXhsSlNudXVHejlSTEFNVlppYktpMlF5YVF6VlBtWDYzeVJT?=
 =?utf-8?Q?ZuWGCkEwvyWN83gkdHmnbn7HIRkWoWS+rAt+XLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f6f63-d60e-4bc0-b2eb-08d96e0fa3d4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 12:46:10.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lEgqpAK5Ln9vuEbY+stKISzs4fidT8lcs96iSzBa9EnF89JWCmnXpVL3T3CajSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,
On 8/26/2021 7:36 PM, Heikki Krogerus wrote:
> Hi Alexander,
> 
> On Wed, Aug 25, 2021 at 01:50:48PM +0000, Deucher, Alexander wrote:
>> I'm not a USB expert, but I think the idea was to pop up a message asking the
>> user what role they wanted when they plugged in USB cable?  Then based on
>> their input, the role could be changed.
> 
> What exactly is the ACPI/EC interrupt in this case?
> 
> Note, that simply selecting one role will only work if the partner
> device happens to be in the opposite role at the same time (actually,
> even that may not be enough). So for example by selecting host role
> will only work if the partner happens to be in device role. If the
> parter is also in host role, nothing happens, or both ends just fail
> to enumerate each other.
> 
> So you always have to negotiate the role with the partner one way or
> the other. Now we need to understand how that negotiation is handled
> (or is expected to be handled) on this platform.
> 
> Which type of connector are we talking about here? Is it USB Type-C,
> or is it something else?
> 
> thanks,
> 
Sorry for the delayed response due to few designed changes. Now we have 
more clarity for the customer platform with respect to usage of DWC3 
controller driver. So it is type C controller which will be using ACPI 
based UCSI driver. As UCSI driver has already role switch support we may 
not need this patch. However we need your input to understand this,

con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);

For this to work, how should be ACPI entry to be defined. Do you have 
sample code, we had discussion on similar point in past but still need 
some clarity if we have sample ACPI ASL Code. I remember something on 
this line from previous discussion with following sample code.

/*
  * I2C1 is the I2C host, and PDC1 is the USB PD Controller (I2C slave 
device).
  */
Scope (\_SB.PCI0.I2C1.PDC1)
{
         /* Each connector should have its own ACPI device entry (node). */
         Device (CON0)
         {
                 Name (_ADR, 0)

                 Name (_DSD, Package () {
                     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                     Package() {
                         Package () {"usb-role-switch", \_SB.PCI0.DWC3},
                     }
                 })
         }
}

So here is the another question , if we can not achieve this in BIOS , 
Can we register the software node with quirk in DWC3 controller 
something like this

static const struct software_node amd_dwc3_node[] = {
	{ "amd-dwc3-usb-sw", NULL, amd_dwc3_props },
	{},
};

if (dwc->use_sw_node_quirk) {
		ret = software_node_register_nodes(amd_dwc3_node);
		if (ret)
			return ret;
		dwc3_role_switch.fwnode = software_node_fwnode(&amd_dwc3_node[0]);
	} else {
		dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
	}
	

And in UCSI driver again with quirk,

swnode = software_node_find_by_name(NULL, "amd-dwc3-usb-sw");

fwnode = software_node_fwnode(swnode);

con->usb_role_sw = usb_role_switch_find_by_fwnode(fwnode);


Please provide your input that will help us .

Regards
Nehal

