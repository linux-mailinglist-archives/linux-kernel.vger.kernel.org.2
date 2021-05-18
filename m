Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920B9387633
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348386AbhERKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:13:41 -0400
Received: from mail-eopbgr30106.outbound.protection.outlook.com ([40.107.3.106]:60165
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241341AbhERKNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOcNe7hYnTgXAqMQ59hUjugZ+FNFua36s1D0tw3+l3U3lGODFk2nw/F8wy7s5PxWi0DqUfE30kDkyhIlf/LZ0DUl445XHxpZGdzVTqwWJXko0pr4nY8puZJDoOFjf/HvOlT9fI7oZUtJIN0COMK5up1zp0gqocNUyayQKDdLt6YKoz7QQGSqFqJjZN1LXhrHvrfo8EVTOg4xONOQ5nvNxVawgYYmgbmBcVzxJbNBUa5x8YE1SSqCeEvP8DqouWiph01U+azvmFcKwq1sIC7iSJz9yM7NVcVRLpb0rKFiRZUxFO1JgPuJalhFxoPoXV6pPF7s/g9O2fKijd0Z6Jlf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmxn7Xp1sCjcfYRpneugeGHDoBhr0r90/4tXVBN76uc=;
 b=gwfQ3QDhjpiJEIDXDhxjxa7oo6byOILQANNuuvVnwILkYmSZrjpaSElIzei8jBVCL5AIAOUWXmR4XMuPMumHPinWYPCHQN5QqlLd+SZdpB09imZXaSAgqF8SSEWR1fbc3/0gbTW8xV4P4V+8+Yt1RDIlT7kqoudAYBA/2UCmW3ju0/IJi4fCUcyx1P5kigRP0r3imSEulIfSTLAMTJ6jlcJsz4wJLA1zwleAU242vthQol8xft/UWxKEyGSPgC/JuPTRwg+K7fzRzdFqnMjQAvs0RKMT/Imq7nwVbeQEt2XzGT+pMDgcamDO1HY/2IuxIuO4p7Pdm/Qb2vFJz45bNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmxn7Xp1sCjcfYRpneugeGHDoBhr0r90/4tXVBN76uc=;
 b=k0gBruZSNynhNhc9g1oxlrbI/dFRZRMUS+uOaHkDppwYQR7tF1GbQbwSMhac/QJZFlDjVvyaGCiXMdq+21CBkj3NAO9o4ttrKqr2q5bPjQ+uvbrEeEzjd+Ga4sePKc//Mou2IRYuoobpDLfrvZvwIBdKIHTEGsa+pJkW6WxH/bM=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6294.eurprd02.prod.outlook.com (2603:10a6:10:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 10:12:16 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 10:12:16 +0000
Subject: Re: [PATCH v2 1/6] dt-bindings: mux: Convert reg-mux DT bindings to
 YAML
To:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        a-govindraju@ti.com
References: <20210517061739.5762-1-kishon@ti.com>
 <20210517061739.5762-2-kishon@ti.com> <20210517140757.senmh5vc7klagym3@cache>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <dc106faa-5d11-59a9-63d9-dde8ae35220e@axentia.se>
Date:   Tue, 18 May 2021 12:12:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210517140757.senmh5vc7klagym3@cache>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AS8PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AS8PR04CA0013.eurprd04.prod.outlook.com (2603:10a6:20b:310::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Tue, 18 May 2021 10:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be6ee263-9770-4098-205c-08d919e5698c
X-MS-TrafficTypeDiagnostic: DBAPR02MB6294:
X-Microsoft-Antispam-PRVS: <DBAPR02MB62944EDF556937E9D4400079BC2C9@DBAPR02MB6294.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60Fzz3kiQmswcHB9aP5o9gzD4u7IBdFsGM/HlS+hCFciG40qKLmOGJ5+2kCnbTXfvulgCF0O5OBw1mCA8pYYY2xuiofxfqf1pqPI7kRQVo91CB2KGkvnE0jQKkP1Uu/Z/TBI4sJaiw/ybc/ov7Q9ZZ+0sCZv0aw92tSmnK9qUHyzZFr7UlxFwEWvpvZtrB5JgHBK1/1ZtaOsbW7hFvZpbitRQXZYVUuOY1VIWzjmPOOX+0nONHQH3xIdL10EaFaA7566/GZ/DAN0SKFuTQZisR45b5NXLNd7j1MN4qjhekFsn8Z+xsrlOV899QmZgJi0sUev/zcwBzAyA9N6Qg/cW0hpLbnTpWGndKs33sTrHC8s056m7CQS/zm8tyC3jNlJXrlpFJPVF+tXO2qMwWoQIhT1Vtwcao0J3LcZpRq9l2dUT3MOXgGRaXuh+mdAkNoY2hSpQ9DSFbnSFo95ORAzvYDlEa/u+bPfhKHv73DgzX3FGmxWhD2AO3w0083n6xZXI2qcgEMX8CklIJwK/Bwz2rmyy4C52zi5ve1CeApO3AEhygLu+qLcG3tVeLExJ7rnrSD0b1t8NH7N0J4Kk2ULrF4NVCPRZaRv3L38j/wT/6IKFTyDqJRAjWC4+Dkhm/HWNxLCDr0vzwRrIUFkElJr2d7tLMzSD1pyVg1vMcsKw4TaYTxMs9XvbG7mCVpH7Q4DeI+CYa5fDTz3XZ4LNQuEAcZuBjx35CAnwwsTn8rgjdKx5x3XcHfnWdgASpHt3FFjS0XW8Phl1bXQxw5XjHgTrHcPL687+Fj9JdLn26jhgqAE8dYQc+8m/1jRuzEeY9mT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39840400004)(366004)(956004)(2616005)(36756003)(8676002)(4326008)(31686004)(36916002)(38100700002)(53546011)(316002)(6486002)(31696002)(16576012)(2906002)(54906003)(110136005)(83380400001)(5660300002)(26005)(478600001)(86362001)(8936002)(16526019)(66556008)(186003)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVCRThiOWpzUGRPZlFud2JkZ0h0SkluYmt6UFN4SkhETEwzc0VCNGlIRjJ5?=
 =?utf-8?B?aWRIY2FOcDdSZ0ZoQUFwQXRNVXl0WjdwMUZMSEhZNVMrUUNLaVRwN2xiL0pS?=
 =?utf-8?B?Y0ZzVHV1NEhWc1JwTGJhWEViZWMyOHNFMDFub1JJODFhbWpka0hhVFdzZmht?=
 =?utf-8?B?TUVTRUJoMlpKaDErYkJrbWFDVHpQWTY1eDFTbkswbWp1RDVSbldtVWFZZVZ2?=
 =?utf-8?B?VGRRQ1RhTUNwbmlVbE9hMGlmbU1EY3d2aG5mcGE3cFdoVml6R0E1UVhpbjVZ?=
 =?utf-8?B?ZHlZZndoa2E5YkEzVlhadlpXQlhJdGRkYnY0dFNIeXR5WXVHQjJidVBzZ2RO?=
 =?utf-8?B?M1JlS2M5NU8ycFVkVEF5bXBiMVdPMms5SkVXYjR5UkRwSE9DUDU4ZVNlZEFI?=
 =?utf-8?B?bWpGTVNaUVZ3K0RxRnZYbEFMblg4QlJheVdjZ09xTGx5Z21UU2JORXc0Z1Yw?=
 =?utf-8?B?RTd5TTdHcUF0RGFRSjk3WWJFRmp2dFo3V01meEdUdzRyZWFwUlZPYUdOakV2?=
 =?utf-8?B?RjVFb2djYWw4OFFaeGtwY3JwNVpzcE9yNFVlRkVZdG4zY1B3Vjg5Zkw3dE5q?=
 =?utf-8?B?NlpEdEcySG1ialFvM3Izc1Aydnl0YU8yZVd4N2VlSG9BbEYrdkV0UkJNWjcz?=
 =?utf-8?B?eEtxODI5d2pxbUkxOTU3NFdyUHhta04raW16b2tZMitvR0VlaUhDRDd0RkJJ?=
 =?utf-8?B?MTNuMzBNd2M4UWFuZFN5eDVTdDQxREZSWG9ndjRPSU80VmFMUWJrL3FyK0FR?=
 =?utf-8?B?c2RFeXJSeXp3OExhNENFTWl0cjFRWnJ2Zm0zb21hVTR2WlM5NStPeGFRNFZz?=
 =?utf-8?B?OVNJQlc3U05JbFpYTVloVnJackx2MG42anNMT2dQd0NzNjJNTTBnZCt0SGtV?=
 =?utf-8?B?VWY4VWZOM3FxcUxzU1NOWHB4TllZK2NvQkxXZC9HaHdDV1lBS0lkSTRPQVQ3?=
 =?utf-8?B?Um1KejROazhWRVZzUFhxSGg2ZWx4d3ZVVDQranhseVErMDNBeFdaUUxaMDZ2?=
 =?utf-8?B?MWRqTERMdlZsMFA5aFZLSDArWlVCYXNYUFEvQWhHMVpiSmUzQzRSckNmZTNk?=
 =?utf-8?B?dWRadEd6cDdWZ1VHTWNlNUw4d0hWSml1RndXaU4wTmxxbzQ0UllTSFJEOUsx?=
 =?utf-8?B?dkhyVmZWNFFqQ1RVcjZZQ0tUVXlIYVNjYVc4TU4zTzJLaWdJZHhobmFOY1FF?=
 =?utf-8?B?Qk1keC9YNDlWZDR1b0ptbjQ4UzdiWlc4NFNWMGZSMHR3STQ3NHN3bnBFSXFX?=
 =?utf-8?B?eDFaRzZUbGR2aWVMbjVEMTBEdlY4b3JaWS9KY0hRODZuSGlJSTdVTEI3c2FD?=
 =?utf-8?B?OUxHMEdPM3ZyU3UycEdGZ1BEVDdjRkxjZzFuTnZvckNFc2hNejZnMjY3bDY1?=
 =?utf-8?B?Nk4vQkdOOTk0Z2NTWlc5TDNaZWRWY29UTGp1QlAxNFFqUDJKeS9YcTJ1bjVy?=
 =?utf-8?B?R0Y2bERFUmVCdmUwSGVkL1NsN1ZRaWNqT28xWVJhR2JpUUNCZTVscEM2Qjli?=
 =?utf-8?B?TUJtdTk3WTNwVTVYZmZsK2FtZnBSTjNQVHRzeUErT05TT0FwdHF3NjVzUGFC?=
 =?utf-8?B?QU9YWjY1UHVLYkpLVGtEMXdEQ3hYU3Fjc244Y3FyL1h6N242YmtGUWdqbUo1?=
 =?utf-8?B?Z3lRNjgwRGh2NHNkdjZ1Zk5IMHpheGlQZWhIalg5bzhNeGxPd2Rtbkw1dmsw?=
 =?utf-8?B?YktaclJvNHg4eXp6VWJXWUc3TkUyb3gwVzFHMnhaME5lcUpuOWRLRjMzU015?=
 =?utf-8?Q?h2Djith2lkx8N+h+LeB6TtKy62uzsunlbaLhHvA?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: be6ee263-9770-4098-205c-08d919e5698c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 10:12:15.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1ruJy8rFoFKpc/9R22OGabhvckBr6loi74KGKtb6SVv0naTtuLyeL9GAXbDs6yP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-05-17 16:07, Nishanth Menon wrote:
> On 11:47-20210517, Kishon Vijay Abraham I wrote:
>> Convert reg-mux DT bindings to YAML. Move the examples provided in
>> reg-mux.txt to mux-controller.txt and remove reg-mux.txt
> 
> --to 'Rob Herring <robh+dt@kernel.org>' --to 'Peter Rosin
> <peda@axentia.se>' please.
> 
> 
> If Peter and Rob request me, then I can pick into my tree..

It would make more sense to me to convert the common mux controller node
bindings in mux-controller.txt to yaml first, and only then convert the
reg-mux bindings. I.e. duplicating some of the info common to all muxes
from mux-contoller.txt in reg-mux.yaml looks like a failure to me. I
understand that as long as not all bindings are converted to yaml in one
go, there will be some duplicate information, but in this case info that
is common to all muxes are moved into the "leaf" binding and will result
in duplication once more mux bindings are converted.

But I don't know the yaml rules, so I might easily just not get it. I have
some other questions below...

> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/mux/mux-controller.txt           | 113 ++++++++++++++-
>>  .../devicetree/bindings/mux/reg-mux.txt       | 129 ------------------
>>  .../devicetree/bindings/mux/reg-mux.yaml      |  47 +++++++
>>  3 files changed, 159 insertions(+), 130 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
>>  create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.txt b/Documentation/devicetree/bindings/mux/mux-controller.txt
>> index 4f47e4bd2fa0..6f1e83367d52 100644
>> --- a/Documentation/devicetree/bindings/mux/mux-controller.txt
>> +++ b/Documentation/devicetree/bindings/mux/mux-controller.txt
>> @@ -38,7 +38,7 @@ mux-ctrl-specifier typically encodes the chip-relative mux controller number.
>>  If the mux controller chip only provides a single mux controller, the
>>  mux-ctrl-specifier can typically be left out.
>>  
>> -Example:
>> +Example 1:
>>  
>>  	/* One consumer of a 2-way mux controller (one GPIO-line) */
>>  	mux: mux-controller {
>> @@ -64,6 +64,8 @@ because there is only one mux controller in the list. However, if the driver
>>  for the consumer node in fact asks for a named mux controller, that name is of
>>  course still required.
>>  
>> +Example 2:
>> +
>>  	/*
>>  	 * Two consumers (one for an ADC line and one for an i2c bus) of
>>  	 * parallel 4-way multiplexers controlled by the same two GPIO-lines.
>> @@ -116,6 +118,115 @@ course still required.
>>  		};
>>  	};
>>  
>> +Example 3:
>> +
>> +The parent device of mux controller is not a syscon device.
>> +
>> +&i2c0 {
>> +	fpga@66 { // fpga connected to i2c
>> +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
>> +			     "simple-mfd";
>> +		reg = <0x66>;
>> +
>> +		mux: mux-controller {
>> +			compatible = "reg-mux";
>> +			#mux-control-cells = <1>;
>> +			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
>> +					<0x54 0x07>; /* 1: reg 0x54, bits 2:0 */
>> +		};
>> +	};
>> +};
>> +
>> +mdio-mux-1 {
>> +	compatible = "mdio-mux-multiplexer";
>> +	mux-controls = <&mux 0>;
>> +	mdio-parent-bus = <&emdio1>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	mdio@0 {
>> +		reg = <0x0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +
>> +	mdio@8 {
>> +		reg = <0x8>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +
>> +	..
>> +	..
>> +};
>> +
>> +mdio-mux-2 {
>> +	compatible = "mdio-mux-multiplexer";
>> +	mux-controls = <&mux 1>;
>> +	mdio-parent-bus = <&emdio2>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	mdio@0 {
>> +		reg = <0x0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +
>> +	mdio@1 {
>> +		reg = <0x1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +	};
>> +
>> +	..
>> +	..
>> +};
>> +
>> +Example 4:
>> +
>> +The parent device of mux controller is syscon device.
>> +
>> +syscon {
>> +	compatible = "syscon";
>> +
>> +	mux: mux-controller {
>> +		compatible = "mmio-mux";
>> +		#mux-control-cells = <1>;
>> +
>> +		mux-reg-masks = <0x3 0x30>, /* 0: reg 0x3, bits 5:4 */
>> +				<0x3 0x40>, /* 1: reg 0x3, bit 6 */
>> +		idle-states = <MUX_IDLE_AS_IS>, <0>;
>> +	};
>> +};
>> +
>> +video-mux {
>> +	compatible = "video-mux";
>> +	mux-controls = <&mux 0>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	ports {
>> +		/* inputs 0..3 */
>> +		port@0 {
>> +			reg = <0>;
>> +		};
>> +		port@1 {
>> +			reg = <1>;
>> +		};
>> +		port@2 {
>> +			reg = <2>;
>> +		};
>> +		port@3 {
>> +			reg = <3>;
>> +		};
>> +
>> +		/* output */
>> +		port@4 {
>> +			reg = <4>;
>> +		};
>> +	};
>> +};
>>  
>>  Mux controller nodes
>>  --------------------
>> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.txt b/Documentation/devicetree/bindings/mux/reg-mux.txt
>> deleted file mode 100644
>> index 4afd7ba73d60..000000000000
>> --- a/Documentation/devicetree/bindings/mux/reg-mux.txt
>> +++ /dev/null
>> @@ -1,129 +0,0 @@
>> -Generic register bitfield-based multiplexer controller bindings
>> -
>> -Define register bitfields to be used to control multiplexers. The parent
>> -device tree node must be a device node to provide register r/w access.
>> -
>> -Required properties:
>> -- compatible : should be one of
>> -	"reg-mux" : if parent device of mux controller is not syscon device
>> -	"mmio-mux" : if parent device of mux controller is syscon device
>> -- #mux-control-cells : <1>
>> -- mux-reg-masks : an array of register offset and pre-shifted bitfield mask
>> -                  pairs, each describing a single mux control.
>> -* Standard mux-controller bindings as decribed in mux-controller.txt
>> -
>> -Optional properties:
>> -- idle-states : if present, the state the muxes will have when idle. The
>> -		special state MUX_IDLE_AS_IS is the default.
>> -
>> -The multiplexer state of each multiplexer is defined as the value of the
>> -bitfield described by the corresponding register offset and bitfield mask
>> -pair in the mux-reg-masks array.
>> -
>> -Example 1:
>> -The parent device of mux controller is not a syscon device.
>> -
>> -&i2c0 {
>> -	fpga@66 { // fpga connected to i2c
>> -		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
>> -			     "simple-mfd";
>> -		reg = <0x66>;
>> -
>> -		mux: mux-controller {
>> -			compatible = "reg-mux";
>> -			#mux-control-cells = <1>;
>> -			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
>> -					<0x54 0x07>; /* 1: reg 0x54, bits 2:0 */
>> -		};
>> -	};
>> -};
>> -
>> -mdio-mux-1 {
>> -	compatible = "mdio-mux-multiplexer";
>> -	mux-controls = <&mux 0>;
>> -	mdio-parent-bus = <&emdio1>;
>> -	#address-cells = <1>;
>> -	#size-cells = <0>;
>> -
>> -	mdio@0 {
>> -		reg = <0x0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> -
>> -	mdio@8 {
>> -		reg = <0x8>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> -
>> -	..
>> -	..
>> -};
>> -
>> -mdio-mux-2 {
>> -	compatible = "mdio-mux-multiplexer";
>> -	mux-controls = <&mux 1>;
>> -	mdio-parent-bus = <&emdio2>;
>> -	#address-cells = <1>;
>> -	#size-cells = <0>;
>> -
>> -	mdio@0 {
>> -		reg = <0x0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> -
>> -	mdio@1 {
>> -		reg = <0x1>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> -
>> -	..
>> -	..
>> -};
>> -
>> -Example 2:
>> -The parent device of mux controller is syscon device.
>> -
>> -syscon {
>> -	compatible = "syscon";
>> -
>> -	mux: mux-controller {
>> -		compatible = "mmio-mux";
>> -		#mux-control-cells = <1>;
>> -
>> -		mux-reg-masks = <0x3 0x30>, /* 0: reg 0x3, bits 5:4 */
>> -				<0x3 0x40>, /* 1: reg 0x3, bit 6 */
>> -		idle-states = <MUX_IDLE_AS_IS>, <0>;
>> -	};
>> -};
>> -
>> -video-mux {
>> -	compatible = "video-mux";
>> -	mux-controls = <&mux 0>;
>> -	#address-cells = <1>;
>> -	#size-cells = <0>;
>> -
>> -	ports {
>> -		/* inputs 0..3 */
>> -		port@0 {
>> -			reg = <0>;
>> -		};
>> -		port@1 {
>> -			reg = <1>;
>> -		};
>> -		port@2 {
>> -			reg = <2>;
>> -		};
>> -		port@3 {
>> -			reg = <3>;
>> -		};
>> -
>> -		/* output */
>> -		port@4 {
>> -			reg = <4>;
>> -		};
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>> new file mode 100644
>> index 000000000000..54583aafa9de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/mux/reg-mux.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Generic register bitfield-based multiplexer controller bindings
>> +
>> +maintainers:
>> +  - Peter Rosin <peda@axentia.se>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - reg-mux
>> +      - mmio-mux
>> +
>> +  "#mux-control-cells": true

true? It has to be exactly 1 for this binding. Is that enforced somewhere?

>> +
>> +  mux-reg-masks:
>> +    minItems: 2
>> +    maxItems: 32
>> +    description:
>> +      An array of register offset and pre-shifted bitfield mask pairs, each describing a
>> +      single mux control.

Is there a way to specify that it has to be an even number of items?

Cheers,
Peter

>> +
>> +  idle-states:
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +
>> +required:
>> +  - compatible
>> +  - mux-reg-masks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    serdes_ln_ctrl: mux {
>> +      compatible = "mmio-mux";
>> +      #mux-control-cells = <1>;
>> +      mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
>> +                      <0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>> +                      <0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>> +                      <0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
>> +                      <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
>> +    };
>> -- 
>> 2.17.1
>>
> 
