Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD5240D803
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhIPK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:58:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51528 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236506AbhIPK6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631789843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kpxwp2rdKblmC5SfIehBy1UULgOd0P1/OQyZPZUE7sI=;
        b=hxOb4PrPnW+oT/V22a3OMFxRgKYj9++2G54oNFGm/+BqFrOiikVFiTh8uLHLXEzLY2r87Y
        4eLgi9cr9g+yxQ4i2VxSpD09ddGINyFKnSmM0bPcaVtjt6MNECmNYQuBppPQBjJb9c2CQU
        BYZgNnCn3ikEsMEh/eHC49p4vQLQ9fk=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-E1tukwA8PcS2Te9jK0t6Bg-1; Thu, 16 Sep 2021 12:57:21 +0200
X-MC-Unique: E1tukwA8PcS2Te9jK0t6Bg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkA0HQwWLFRQLq+Y4q6SgRDGAizKNUnSr74JXzoZ3z0eZNojZIu7ZUcoHCIcTMSt84cXvjW1t7TmgsRj5JE/eCp2fmMcZZNQ5zwsMYUYXY+iht4cQPfrl9+ZKtFE59eJAOdyyeoyBw8fKOvEUUVsPJRU0/GO4ouf0+QtsuIK48C8fzMig5YgnSoxWA219FdS8S6qWMHw4cJeOCNOrNvsL2Tob8uqbnkqau46uu6FqdI4OaLmw3E4QyctgVi0P/ukaNRvOzBKtlVN5jfgY5CQalZA67dfMV62N69lBAoCBPAPdTdD+LinXwSh6bFzL+uSAg5o3AA/MhJHJeaCFiKYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Kpxwp2rdKblmC5SfIehBy1UULgOd0P1/OQyZPZUE7sI=;
 b=epkW+shyz08d5mi7ZrcmayCeVTzCJsrzYdYQ3Yu0PKBacdxjoekvRzIvK+Wc0/Dguk25IdIHdFeE5gStcrVCVSRTS9WaMJ09eN+z5jRMs/kU+VBGCesSSQ4pTW2AJeM76huGLXQkaJk2MeV5DNqKK55wrAZ2rzkiPtPv0KAgXhqascB8JLeLvOLun0uPj5l3mik+aphyHOCAnNN9Jsp4hv72tqpQrfXe+54ZQEUer5voUlc8N2ZiwDWjD9lUj2XLozdrlKjhnRUBuF0dEUnC+HnyP8OfajW8UY/2n/MYUQuqyzJaS3PcHLWt6RujCS1TCIo3pxcGnXI82MqkachCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM5PR0402MB2849.eurprd04.prod.outlook.com (2603:10a6:203:96::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 10:57:20 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::e9ae:619b:1fe9:46ce]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::e9ae:619b:1fe9:46ce%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 10:57:20 +0000
Message-ID: <9b5edc77-cf03-1006-2963-1ac4e24418f7@suse.com>
Date:   Thu, 16 Sep 2021 12:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH v2 4/4] sensehat: Add device tree overlay (do not
 merge)
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
 <20210820180801.561119-5-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20210820180801.561119-5-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:208:122::48) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.177] (206.204.146.29) by AM0PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:208:122::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 10:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fa8251-9b8a-4992-38d5-08d97900c12c
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2849:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB284983B802E7DBE58728047EBADC9@AM5PR0402MB2849.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtNfpjw9o/J3Yhj/6OBDt1SdGogqhB86+fsBDkF0sozqpHlwbgCSh/CtZlvLHzurMkJSoRpKHpJJ9ytZYDG0Hhf6oPfi/TWpcDnB+Jfskhz4r0zjsmRLzxOBRBLUEPLQmgI5OCy8+FGm5Oj+9q6zOQFJMhUwkIggmWs/pET8iwTnLxyTiAMYrNsqzFaS1EXrineXz9RJxH2pDjrHFcXXuUvWwne2s2K3/AFOuUZSZuIlad1x4WVf4BLdDc7ODAUunCHA+kez1oKuvs2nSS6nAtjdkwVtieHF/tYAGJZrFrpG2bH8XVlrNMWsFhM1WYL0tqXMwfnakggDVQqI1GhUgvKl5Bw1lg+nzZMKARNAXpfHLT5RG9seIR5P0Zl/q/S72I5J+kw2X/buFtqD+Q3a3eCyDgyRZSu0gIiNFEZNUPX7BbFXM9n+EHxwFiTdojPhTmxQWADOQlErfaDV0t2hJkbWf3yLFgjqfVaOaKIhob2z9Jgjch2r9SUOUKdiXRzk/lzkIl2AF4+/4hNHvt0qm380BGgQ36SKeB9SZ/o2mJsuOL7Yo84mTxkvbIgOHMdIWsZkvK1Shrpm8ksGlZzBd3owpP6naT4qcD6OHrcOZh5ObKWhYcZ4dxo+dUL6GpITzKAYIxOR9Cl8bKlxVIIKi5Z6+ZVUtZ0QDGjatjI3vG4WK6XlR3dN55LDuocMv2wptBh/MHFMjmoJPm+pfzmI+JFbgeiKQqZDIy3c981iENg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(66556008)(38100700002)(54906003)(16576012)(316002)(36756003)(31696002)(86362001)(478600001)(6486002)(8936002)(8676002)(26005)(53546011)(5660300002)(186003)(2906002)(4326008)(7416002)(66946007)(2616005)(66476007)(31686004)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRYblZLeDErQ3NYVHgxd1llTXlucjNicnppTEl3ZVVZeWk1VVdPQW5reSsy?=
 =?utf-8?B?Q3hENWZjcytlb1g5WnRJb3hndzljZG1PUFB1V2FqY1VIMVJ5SUcyZWhlWTk3?=
 =?utf-8?B?MnJrWFIvSWFxTkVQRW9LSHZIaVI2bTNZWUZCenk5L0RVZ3ljejI4OGpXZEIr?=
 =?utf-8?B?K1F6YWowekNkeUxtakhZMGJMeEF4QmNnWXFOanJBUStsdGtGbzI1UDRLQWlK?=
 =?utf-8?B?aXpYamFZYU5SUmxQSjdHK1E3K1RPbVRCelN3MU9tbVYxWWU2TkVudjE1WDM4?=
 =?utf-8?B?b09yTVl6S056YTRkcTkyUGRsbHphNk1OQllxZEkySCtQSU1JcEpzSXhjUmxC?=
 =?utf-8?B?cTc4TnIwVHhuSTZKbnZpT2dwdTZILzNlRFl4VElJemsvTzEwa3VGL29HNEpV?=
 =?utf-8?B?R1JFMDdjNjl5SWV5aitVU3NZaG5HdWJFb0paakpvT2p0M0tYMFg1MkNhN0g5?=
 =?utf-8?B?R29BK3ljU2s3L1NpWjhkMFlzZ25vVCtwRm9ORzhkak84ZEtDVHlCQXhZRWpK?=
 =?utf-8?B?T3hwSWdwR0NlY2U3dWdOWTZ6SllDVjNNdVFaVXI3YWhDNGpLcm05S0llemNo?=
 =?utf-8?B?QnQrVExlYmZQenpjRXNCYTNKTG55MmlvbWRNS0s1MkdNQ2NzdkloSlEvb2Rx?=
 =?utf-8?B?VEtGaVdBZmZCYkZhcWRFR0wvWlNDVnU0SFNXY3hyRnVrdjQ3MEN4ZE4ySmU1?=
 =?utf-8?B?YjlDOE9rdEwyUndkUndyWEY0VTQ2ekVSSW5WUUdxckp1alNrTlYwTXdZenA0?=
 =?utf-8?B?Z3pDMzRBTG9BVzArbXkwdGRzSWFBMzIrSy9OUUtnS0JQNVd1SFhtSHhBeXVO?=
 =?utf-8?B?YUNZNGR1c25HWGdETE52eWtYRHVMeWhpNEF4QXl6MFgrNVlIekVSb05pOGRM?=
 =?utf-8?B?RGR4cFRla1JKU0gyRUNLYUVkcHJGZWlSSnczZVcrMEUvaGk2MjBFc0o5OGlj?=
 =?utf-8?B?Yk14MlVSNWFnV01WM2hncjM1VjE0ZFVNMDUwV3ZHMW1Gbm1PKzZLc2RTU1ZP?=
 =?utf-8?B?YjRyeU9aelFnR2ZpcDNPZzM3UUtrWWoza2VrWjZCSVNoajhSTVJWQVhFTm8z?=
 =?utf-8?B?K25FeDZNRWVRRVdid1FIZmpkRmorUXBncElmUThXSC90L0QrbndzKzFFOWZP?=
 =?utf-8?B?N2tGNHJYQ3UzbXN1dkJnMlArNTB5ZnlkdXR6bEJOVnFKdWsyK2FNajJiYlNs?=
 =?utf-8?B?WEtQbXpYWG1PMzNCNHpMODZEWkowMWdNOVdPTmdjejlrcVVsY01ubXJGNG5p?=
 =?utf-8?B?UlJNeWN1SStUSHVXMTdZeXRFRmg0WTFKeStPazNpVml6cVdZQ1VhWmJKKzY3?=
 =?utf-8?B?V2FyR2o0Q05nbzA3aS8zZzM0M0R3S3NVNjlWblpJTDdoZjFCdFFCS2xwNy9M?=
 =?utf-8?B?Z2JlcWx0c0lscDhTVzE0V2REcmJYbFRlbXluSCtUQ2dQdUlzRVJENWNnd2No?=
 =?utf-8?B?cUo2TzRZK0lkQU5wbUdNWGxmVWlheXpsa0NYYmQ1a2pNL2dtUDdSYlJLNTd0?=
 =?utf-8?B?bEcvd2JiTlRvMHZobTRSa29ESHBOY0dXMHVOdWxtTHA5SEZXYWdiZVVvQmR6?=
 =?utf-8?B?VTMyb0l3NlNPdTBTU0FMajVOalN3SUlyancxV2tPR25tdnNkSC9aSXlPQThk?=
 =?utf-8?B?ZXBBWngwVnNFNTh3MkpYWElWRVViRFdFSTF6Y0E3bFprWE0xMG5xUEpHTDBj?=
 =?utf-8?B?bGNxc1NTZWRqdkhoYy9oK1E1dEQ5TGZwZGNkVi9VRUdzelJtTWFZTldhT1hP?=
 =?utf-8?Q?LOPn2fFRkx4UxvhnM94o/jqEBu2ukiNEuvuCwFZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fa8251-9b8a-4992-38d5-08d97900c12c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 10:57:19.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuZ+u+HxPECxKUZVyfu+UuGtuMf8GCPlME7733x0wuwlGUYY1KO0fxU2PtdkQ4cdHj8dC4WCOrGBYc1KS5TIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2021 20:08, Charles Mirabile wrote:
> This patch is an RFC. The overlay included here is suitable for the
> Sense HAT but we are not sure where overlays like this should go, or if we
> should even include it, because the Raspberry Pi kernel tree already
> includes that device tree blob that this was based on and most
> distributions for the Raspberry Pi include those blobs.
> 
> The overlay is just in the root of the source tree since we did not know
> where to put it so this patch should not be merged in this state.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   sensehat.dtbs | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 sensehat.dtbs
> 
> diff --git a/sensehat.dtbs b/sensehat.dtbs
> new file mode 100644
> index 000000000000..3f1c12c8f75f
> --- /dev/null
> +++ b/sensehat.dtbs
> @@ -0,0 +1,51 @@
> +/dts-v1/;
> +
> +/ {
> +	compatible = "brcm,bcm2835";
> +
> +	fragment@0 {
> +		target = <0xffffffff>;
> +
> +		__overlay__ {
> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			status = "okay";
> +
> +			sensehat@46 {
> +				compatible = "raspberrypi,sensehat";
> +				reg = <0x46>;
> +				keys-int-gpios = <0xffffffff 0x17 0x01>;
> +				status = "okay";
> +			};
> +
> +			lsm9ds1-magn@1c {
> +				compatible = "st,lsm9ds1-magn";
> +				reg = <0x1c>;
> +				status = "okay";
> +			};
> +
> +			lsm9ds1-accel6a {
> +				compatible = "st,lsm9ds1-accel";
> +				reg = <0x6a>;
> +				status = "okay";
> +			};
> +
> +			lps25h-press@5c {
> +				compatible = "st,lps25h-press";
> +				reg = <0x5c>;
> +				status = "okay";
> +			};
> +
> +			hts221-humid@5f {
> +				compatible = "st,hts221-humid\0st,hts221";

Isn't "st,hts221" good enough?

> +				reg = <0x5f>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	__fixups__ {
> +		i2c1 = "/fragment@0:target:0";
> +		gpio = "/fragment@0/__overlay__/sensehat@46:keys-int-gpios:0";
> +	};
> +};
> 

As Nicolas said, yaml bindings are a must. The overlay can be added as for 
convenience to the series but it should be made clear that it is not supposed to 
be upstreamed.

Regards,
Matthias

