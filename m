Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432DF41137B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhITL0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:26:46 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:58769
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230138AbhITL0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngNGUl6U0/24fHgxc7n3otBHEXVIR3XwfaPjSxd2GScBJdzaSndgPUkV8SeTmnodl3yQr9AFg8BKQJo+lVJCx0DNeYfpj773fh8nsSVeTVa87BiOw0TMhssUcZiyyS3xdDFcmidL+fxh3BHwGy0zN8+6px/nH14/JtA+QAUKc1C0sxIng38dfGvL4fntIFOe7H96A1vzd99UUDJJif4+AaDQPMdrYCYpXk+r2Whhae68YnU5/0etm7V1f3l0UXEPsR1y1toa//k2hxHHqrMy8u7ots7rhJjDRnKcsbv1Aqq51J3T74Z4TzgF108Isny4SRVV91OGgJW2FyWBmAzv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ArUz3DL9lgldBr9yeiwnx9Q9iCJAhqHu2CI8DJkx228=;
 b=T4f+627tKQ1Da5G8BxOf/R8oCnmc6F5j3GogAL30QAa3k8t+OB7pRIP4y5djt1mpvmDZ7shmgvvFpaU/VZu9nEX4ztki/Ig5VxAr1KfcvbJn7eJhubuW/kUOINJDKdVGL8YXiYQQyLm8Y5MMR0TLmbmDtFbDB6d1eRaV14Wr3HTQEo6R3HIJdo4annwlN4SkVaCnEzKV9AdcjGBjh6gDCATV895+/oYQ0ononoOomTEH+1Mok2HikIwAWpcFf+m8Dcr4CgxhdV/XtWgv5J9QGvn3DJvqXu+OsD/31xigN1u6uf3eq5DN+KkUrbVzjDpQvTGJNapuezQR3y7NAH3l6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArUz3DL9lgldBr9yeiwnx9Q9iCJAhqHu2CI8DJkx228=;
 b=qb867YDnnCzHyRwRS1Ai8famRDFHNWp76fIGAyAmDvVuxYXdZlCVFCvr88bSi0EtRvFYG3xaI661kE7D0Iy+bsNSSZfkrLj8CDnm4vIvh1A8v8/eWic8m67iiqiGoV5NFL8o7XTJKJypcxYQZFO2gRDew3a6Ag+cWg5pM7yl+F4=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AS8P190MB1637.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 11:25:17 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 11:25:16 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
 <vrcxh2pmt3bl4h.fsf@plvision.eu>
 <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
Date:   Mon, 20 Sep 2021 14:25:15 +0300
Message-ID: <vrcxh2o88nbias.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0313.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::29) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AS9PR06CA0313.eurprd06.prod.outlook.com (2603:10a6:20b:45b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 11:25:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13a3e23-05aa-49e6-c476-08d97c295264
X-MS-TrafficTypeDiagnostic: AS8P190MB1637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8P190MB1637BD77BD4624D6CE6A257895A09@AS8P190MB1637.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6XijmaObQ2pJmT9Qa6myeIuNYXKGlrDEmTMDFTsE7qjDBvcIUD9b412MG5K9RVeFqufjLI4iCJYU42l1rjq/5fxnflN7U+Urako/rwBBKo5+ZIUgJoMggqNyGQ1h0Rev495ihYBp0AaVdt5n8Mb4bkKldQQltJTsHdPX6/xfsPB9gz1ikQPMPq9LEEw1rQ+0wVvFNHzk99bddhYO+IKL+33oVVPhzDIdyFSdfkdw7JyiKS6M0aqXb4+qT4E5HXBpcc669E7ggZrKFZXPqp3CIf74MDr7UBgB9xuuKoHjKrMBm4GacUvgyHF5POP2mmIssD8i0ye4BvXWgxMcNcH7WAA/Jl1vzOVRC6wZM/y6w+AjRITO+8V8fk0lgXgVO6iwwzW7Opc4+71lqCjMPJ6FmE/Aly2OSIK+sm/K32H9a0u2WgZccgAVQWOZfvEQmP3VULqSwl/Pyn016g2TYMNbu2fSKYPv94aNjsKSEf9QAZEjNZfbXuwl5FCZdLROejasTRKE6LofVIUaNU2tpRaSEPecpqmHtZB6iQHGj/YTcamZss+H86mJ7yWsYgS+4YH4MJsjK6aCHofG7jC2sp9uSdyAWuEShgFV5OL3KFpdemFw4Xvxe3Jtsxnw2sVPT52Kn0TR6cBYiU5+Dz3QsOq+N+J56R2lmes8UXe2py+EaHGTqAeOMzGp77qBDSoNQK5YuVNha5Y7/BUlclGe+4ZTA6h818svBQD+k3R5cTv2rM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(376002)(346002)(136003)(66946007)(2616005)(8936002)(54906003)(6496006)(86362001)(6486002)(956004)(36756003)(8676002)(6916009)(66556008)(26005)(53546011)(186003)(508600001)(4326008)(5660300002)(38100700002)(2906002)(52116002)(38350700002)(44832011)(83380400001)(66476007)(316002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGedq7ZXUsoYlvQoV681OONyuNFnCEGMxxIbbJcVrGT4P1Qo6OQn7T7kn7vg?=
 =?us-ascii?Q?pisWvwUKaJRoMM5f2QT/B9GI1f6IY90FP9q/NTvnQjufdZr0AAtmA6olgT7+?=
 =?us-ascii?Q?H57ilddGysVOBGaXMzfTzKvmQGFhlv4M9Q2M7Fy0EOtm4HrqEgqjA3ADw3k+?=
 =?us-ascii?Q?6VgKqrAMH0jTMsQMFAPKyKu0VcezXbZFQgTU7vgjjlKwe2hz4uaTOwf2esSC?=
 =?us-ascii?Q?eoN+8kZKGtBSMMBAOxCKwYp7bE5MC8jLwueGvyExAOrqaN1yqSVMGBamvkL0?=
 =?us-ascii?Q?V6sDnSlRu3gi+FhR2grOQVwVI+g89hPwUh9utsMEAh+omGzvc1gZuL6RK07n?=
 =?us-ascii?Q?P655A6di/SCL3F2VEhIIp1O+3hs2q6em7Ghc+apWb5zxNPIWdyPjiGV6CUnP?=
 =?us-ascii?Q?vnXiBEBeDPEfW6itdb7CnFGze3QE0ZGa81jZr/ngdFTCHxL64VY0LCery9S/?=
 =?us-ascii?Q?jt6kcYq+jE3obW5lJ8ljfHeF99uzmNIEV9d4notZ0uJQsoO9/iphSt3srkcl?=
 =?us-ascii?Q?rKS9eft9WghFJA2BTuHdLqG7OO2Nr+nX9+q2KLAQ3SJHVbifVj0d/nlv4SXX?=
 =?us-ascii?Q?G6P3ZjfVHjlBc/GVLUj8OcS8UjtoMK2RBg4gn+qUTwKS2d+L/bagRBOLoIPm?=
 =?us-ascii?Q?SE+CiJ9O3OZy5h3ICC4zvRwvew7wRJ28GaF3xRIyxJujSL8T20QezHMaMwM/?=
 =?us-ascii?Q?uKLdBl8fTeqPbD74s3fUQOi7BwmW3qXhilM0novZdWCwkEnPI7zf55qpvxFC?=
 =?us-ascii?Q?yatkjX35pDbb8wKP/riYFVkTQR1Uj3x5OfeWfvFe3cBlTq0YjAqy8WCOUcy9?=
 =?us-ascii?Q?b6NO11lirPonelRmPNlzxxPcvWe8jtFVfIP89+uNXBCfklQWLkDmU6YDpptD?=
 =?us-ascii?Q?liTt/7ouOlNQroMg4RWUFJwb6DW/RoUbr45v0AgjEH63ERudJBHKdVmWYdgV?=
 =?us-ascii?Q?jAuElxVTjR3L9Dubk+0u6w5UMWuG/kwEtYiHyyVrLNRK//ar9vQw0alnfQAe?=
 =?us-ascii?Q?TMrGyqDDfEZDp5Bjd96QYITsItqyaF0U34ZS+gWzvSKYY0gtPnfVYXZniNtX?=
 =?us-ascii?Q?EGtFWf+MHxGQBiieMSCb3+3G6caVudv6twSR7GEcIQdMzHxM8zZ2IHLQ+SC+?=
 =?us-ascii?Q?DtRRKTFxLBMsvNtpXryf8e+EoJsHsFT4IdnnfDT20pm/eB74D0HUpTNLrboT?=
 =?us-ascii?Q?F4eD7T/N01PDguMs5Fbt/lsT0Qi5/m9uRwro5Xt3EWXrONYWmGKde0Wmrq7f?=
 =?us-ascii?Q?2edRz2zWDRbTEerbQN/7FbjwlrvEGXVDD2f1t6J5eMkFRkqpw5Nq7SqmJvB3?=
 =?us-ascii?Q?H+76aWU/MC/GV9pMXo8Q1u6w?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a3e23-05aa-49e6-c476-08d97c295264
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 11:25:16.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41PvCXb1PjAB0JvnSpnyigIMz9LCx5NDOKBcsG748mrj0eI3ZCZsCneZfRPj/24NpkzqSiinaDbt10dH9IWPZ97kfO3ZpxLNXLqnSPZH4vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1637
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just to clarify regarding the interfaces:

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 20/09/2021 11:24, Vadym Kochan wrote:
>>>>
>>>> Probably this might be fixed by lookup nvmem device too ?
>>> Honestly, this approach is a total hack to get it working.
>>>
>>> This is what Am thinking which should look like:
>>>
>>> ## DT ##
>>> eeprom_at24: at24@56 {
>>> 	compatible = "atmel,24c32";
>>> 	/* Some way to identify that this is a TLV data */
>>> 	nvmem-cell-parser-name = "onie-tlv-cells";
>>> 	reg = <0x56>;
>>>
>>> 	mac_address: mac-address {
>>> 		/* THIS REG is updated once TLV is parsed */
>>> 		reg = <0 0x6>
>>> 	};
>> I assume these cell nodes should be marked with some property that they
>> should be evaluated later, so the cell will be not read
>> in case it was not parsed because it may
>> exist in nvmem device optionally.
> No, we should hit that use case to start with.
>
> nvmem cells are parsed in the core during register path.
> Parser should parse the cells before this to keep it simple.
>
>> 
>> Or, treat cells with length "0" in a special way and allow to update
>> cell info later.you can update irrespective of the length, as long as this is done 
> before register.
>
>
>> 
>>> };
>>>
>>> some_dev_node {
>>> 	compatible = "xxx";
>>> 	nvmem-cells = <&mac_address>;
>>> 	nvmem-cell-names = "mac-address";
>>> };
>>>
>>> == CODE ==
>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>> ==========
>>>
>>>
>>> If you notice the mac_address node reg is 0.
>>> This node "reg" property should be updated ( using of_update_property())
>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>> with tlv name.
>>>
>> I assume parser driver can just invoke add_cell_table (with may be
>> by adding 'bool update' field to the cell_info struct) and core.c will just
>> update existing cells parsed from OF.
>> 
>
> Lets keep the core code clean for now, I would expect the provider 
> driver along with parser function to do update the nodes.
>
> --srini
>

core.c sequence:

1) after cells parsed from OF:

2) lookup the parser

3) parser->cells_parse(ctx, table)

3.a) update existing cells matched by name from table

4) parser->cells_clean(ctx, table)
/* to free cell's_info allocated by the parser driver */

as alternative way, I think it would be more generic to
provide nvmem-provider.h API to update the existing cell info,
however it makes sense only when cells were parsed
by the cell parser, in the other situations the
cell should be well defined.

with this approach the parser driver will be just called
via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
for each parsed cells.

>>> That way rest of the code will work as usual.
>>>
>>> If this work for you then we can ask Rob if he foresee any issues in
>>> this approach. I already see similar usage in reserved-memory case.

