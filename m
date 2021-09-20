Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A841146C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhITMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:30:41 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:23463
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234895AbhITMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3lqiqQigrMm/+Zm8BOwTUr8q8n1M4r102HrpS/M68zicJ6wXJt14z9oIk33Ui6xWP6AcpU81BXcTI116wXtxGQJmYobg1E+MMajc0sV2wlnOsdooAXsujbZt8N8O8YdhwD619Zi6m85docJZ3md3nQh6RKG9KTuL/59GURGcrWiILXHDLLmcEKKAiHHHNEibs3ZFNZ5bOwxLsv6mae+5SCveKgCrNRBdJolR+jVc8ZrgFmHkErc5y9B/VbMFsZDxfGD3TCxn6iMgBsRpERtTm+DCUu+PMB+6et8S90OEzmuMrRXCtdC9pcXkEzKSQvqVibU1ATSE0t8Eu4ex0e1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=36dH61E6ICFl+seI1GgeKnkjm96ik1U3WRwRC04lYjk=;
 b=NZZw50cnPpPmXyUFfTf2IGgeJQfstaM9EjP2nUtrwH3LmfUkUiC6CVUGdA+uttmbh2dYKKP1x7uH8AfP+F+vMi+QYa56w+6UV3ro7FIdQa2SEbogq6DG/Jg2HeR8c0T8KADXd92OawID7IbdYXN6qIB407haTFxvG5qnu8qY4lVEpz5UhxPuxyyWD3uU0BT0hFhYq5ZMB+idvPx9W8t+kG8tww9VrdstWLjjoqtrlGLr89MElg788nh/upjhuJmUmYNsH+fkJsqTnewyRA9AJqigdc3HcWkEGR6IZJzhs1fACzZx8DFYweWvXC76wiF4DRN3zWUNBlUk901Hc2CG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36dH61E6ICFl+seI1GgeKnkjm96ik1U3WRwRC04lYjk=;
 b=yiILTJlxbF+Q9ESuPVMd3r5cDfH2yVFPZabiVE5Os5uc657bUZDIp8jxVr5VLYFUg8eBIHdCyjP9d+3LcPt7eMYiH1G2mVypJZUkp5MH9nEEFtDnQAKO/E0tjCdIpuLjN/0HcNwYXIdOLZP6hC82Gw0mZPwjcj7yRNffehoiws0=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AM7P190MB0597.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 12:29:09 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:29:09 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
 <vrcxh2pmt3bl4h.fsf@plvision.eu>
 <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
 <vrcxh2o88nbias.fsf@plvision.eu>
 <1da03714-8f23-1004-e89a-891e4599e04a@linaro.org>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <1da03714-8f23-1004-e89a-891e4599e04a@linaro.org>
Date:   Mon, 20 Sep 2021 15:29:08 +0300
Message-ID: <vrcxh2mto7bfcb.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::16) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM6P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 12:29:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 609c4d74-606e-4912-7c46-08d97c323eb1
X-MS-TrafficTypeDiagnostic: AM7P190MB0597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7P190MB05976D9A74278555DCE0ACF595A09@AM7P190MB0597.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RUuhe5kbKcpObqQqsLS6MkytkeGhbdof8wy5WPGzhjUgHRPYacT65ls9B9foFUKd2/lTPtV+djPFvFbqhIy4NgOjJHv59NGQmeOyIfKwJv5b4BMYmOR7cFUH7qoFY9qmv+/uw/94jFlvvO6zUjGyKjYhgn9qA1HJC11UqWiF6ZQt5voGDK6zLeDMMMUP9hCnu6Kbavrq1SMgzpBs1u32pcQn2pwIDdyUFuZxzywELha2UIbd7RidtAh07XrmX3G95k55J5IwsdKrIjCBrELepxBUjxsunOJeg2evZzhJCjv4QQVL+IEaPhZtR6+8fJEfJ/Ri4PMJXgqSk17VAQoVjN998Cw9yisitl+JI9HXsrlsfJMN/OK8+yzF6meAjmogxQHZvVFJzGehI9cCWdWypWbKsrmqwkq76DtYjit1u/h0QvMb3/h+vx4VhNglh2z/esgwOc3iVrrn7MLMG8lUzcmZwb+y3qbGo9SH0G2mpNagxouHTf2TprkWKyIJWMJY1xFg2P4sJdUVbQFtd/UPj8YDsK4vT42C0ImEoW8250i+O2LaX8aWMW6puzZ5lFYVHGLCI9aWjwK7IhPb7v8QlKq2SlwCCOOvFtqJ3v6ld/rm2aS3Yl7TIpG/ut1HtQ4oOLNb2MqDrs1X2kyAjDX4jDXoPtHtNi1zbKP9uojxBXhE+fI/7xkdmEX9L5d2OhCwDSJ4KM/QAl4gQlCxDhdy6AgEKu95JiPmhPzrmXi9Dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39830400003)(376002)(366004)(346002)(316002)(86362001)(66556008)(66476007)(8936002)(83380400001)(6496006)(4326008)(52116002)(53546011)(66946007)(6916009)(38350700002)(6486002)(508600001)(54906003)(38100700002)(26005)(8676002)(36756003)(956004)(44832011)(2906002)(5660300002)(186003)(2616005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqpQgGdHBMkqYi1fRpxnZ/ovJPhMVSAqfR5qx5TnMncq/mC9LDUirW9SS5hk?=
 =?us-ascii?Q?H66E2AcLRXp+eCJP7saU63xE6pDB1MgzU9m/dOwtb/sexAByrjmaTbC0+3Qf?=
 =?us-ascii?Q?tgIGefRWBHdWVLi5uNExUbazNC6mySSMfZIijYeTT+4BoeuYzlLTOnAATpIb?=
 =?us-ascii?Q?M4hukmOiVd3RuixFTTZSmITm0jtVqmh98wUc0TRzomlA6brBp5guHHCQeWGH?=
 =?us-ascii?Q?fsXGE2kx95nZdU2b0+nNxf7yKJ5qqY7wC8i07otrGNUVREdVITWif3bo14mj?=
 =?us-ascii?Q?hSA1lslQTZrd6PTDnYKxNWaOngul1J3mvcWzYsWba5ECMcJnwcm0FHM4wssX?=
 =?us-ascii?Q?xKwTARqYBwy8E2ql0wAAQpESYAPfpQW8NoxxIcHzJbU5zm+pht12mBiIARny?=
 =?us-ascii?Q?C7A1Qj8L//Ur+IdKH0d1J/X/vZTt3Xq3XTDbATFw/53IuAz0V0GDoO9FhqAs?=
 =?us-ascii?Q?o00shLZ9bXldJbAYuK5RABsNjxXTjt4ygHghFLSZWovqaYEf4h8dwU5/Asn6?=
 =?us-ascii?Q?UULtQhpuBJ6Xisjhk80hzw24TOoo1WuEUJ65swNoOhpLfVdAEnaPzOGdPGg1?=
 =?us-ascii?Q?2QtrOs1CU/1wUvGZCwSe6bXpO2o16+q0KrXOxnVstt9sB0v+PS9ZkdjjPfJj?=
 =?us-ascii?Q?h+yHSLHZqLXlfzPHYEw/HTrbxn3RfFDVzUzeHusQGsmTyfT6S1IErkpgCysh?=
 =?us-ascii?Q?Lufe41nn+pZaO/s+v12goEGtw84adaolnGf8bro5v5Qd/kNDzQ2T2/79p0qf?=
 =?us-ascii?Q?wdEarBkg8d5nFyxcNEu8hsThIlaL7pPV7MpnwkhQ0wX3KPhwv1CZxZJZeUw2?=
 =?us-ascii?Q?0JienZhc7RcTtr0DYp8FRfutTHdtYgNgEcPxZaRRXWhcjFFEn/2ljRMvJi1A?=
 =?us-ascii?Q?4vhdkowqEKRwp3WXm9m7t4RDsCDwUP0i5zBm/yM7n4e7sRmXRiT1jKQtPP44?=
 =?us-ascii?Q?I5MybyasRAFnx5LQi7jG6Rbt+LrRc73yOGRvd9B+mgzUe3zZS3z75cZK3h8V?=
 =?us-ascii?Q?YHGj8ZL7oo6K3buo5tNe2dk9CYwIGejuKltrfaMicv7rqKBcCi1XS8+esVNN?=
 =?us-ascii?Q?lK+W0kkUHDjgNGel6/zvXJVw9tNqGv/Kdi4G5m6nbg1xFPwLC9JGJ/SSU/vV?=
 =?us-ascii?Q?+sDhYksJd+wg7XRJtIRUYMIzyugGDgA7653LoB+KkWb7malJzUswZNvu3D87?=
 =?us-ascii?Q?i/fzHd0buzIbyp3mubDDPXRycbvoaBYiiyDMJMcI/0G8fp/Teu7J5eRtzFBh?=
 =?us-ascii?Q?TQSVC0i/dyGTb1zIbBlyMrWMamMzVY95IP872qINaoqdnZ7/BVOAMyV1hokf?=
 =?us-ascii?Q?LPsIkJFr+Xvk1QKpIXt4jnUg?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c4d74-606e-4912-7c46-08d97c323eb1
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 12:29:09.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH6u4GiJQNBa71U4sG9Icqnh5uVRSHE59keg80+9xK5AVLo47IPiNIPSsiRGBmA71kR24u8FPLUESyQ8u8CjW9giSTrk9AQdGNj9aHaJzH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0597
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>> Or, treat cells with length "0" in a special way and allow to update
>>>> cell info later.you can update irrespective of the length, as long as this is done
>>> before register.
>>>
>>>
>>>>> };
>>>>>
>>>>> some_dev_node {
>>>>> 	compatible = "xxx";
>>>>> 	nvmem-cells = <&mac_address>;
>>>>> 	nvmem-cell-names = "mac-address";
>>>>> };
>>>>>
>>>>> == CODE ==
>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>> ==========
>>>>>
>>>>>
>>>>> If you notice the mac_address node reg is 0.
>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>> with tlv name.
>>>>>
>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>> update existing cells parsed from OF.
>>>>
>>> Lets keep the core code clean for now, I would expect the provider
>>> driver along with parser function to do update the nodes.
>>>
>>> --srini
>>>
>> core.c sequence:
>> 
>> 1) after cells parsed from OF:
>> 
>> 2) lookup the parser
>> 
>> 3) parser->cells_parse(ctx, table)
>> 
>> 3.a) update existing cells matched by name from table
>> 
>> 4) parser->cells_clean(ctx, table)
>> /* to free cell's_info allocated by the parser driver */
>> 
>> as alternative way, I think it would be more generic to
>> provide nvmem-provider.h API to update the existing cell info,
>> however it makes sense only when cells were parsed
>> by the cell parser, in the other situations the
>> cell should be well defined.
>> 
>> with this approach the parser driver will be just called
>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>> for each parsed cells.
>
> TBH, This is an over kill.
>
> In nvmem provider driver probe you can parse the tlv data and update the 
> dt nodes before nvmem register.
>
> rest of the code should just work as it is.
>
> --srini

You mean to parse TLV in the particular nvmem provider driver (for
example in at24 driver) ? If so, then it will not allow to parse
this TLV format from the other kinds of nvmem.

>
>
>> 

