Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847D7419038
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhI0Hwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:52:39 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:39356
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233242AbhI0Hwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:52:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwdlA8uOE8SOHYEas5xYqFHTEvS+kHWuo73UNsTkWjcG+TJAKVfEka9JDKAf881dqCaVR1UpKuFqlhvjsx/bAIM7zgmuPmamnwaMFBfgKVfe7wJW3tNt8HCuSc+EtBICUQKPh5zDRkS1MtmdZ9fBhZkcU0yaN7jdtWyw9d6zrAMFrnh+Ph3WcUKMf1RVTTb2+YhNY29HgIXaeet76k5seVh5sWZLwirGgmc49QGT+9wn/Y7trNiYjpPBz02vQbaFFbRbQw1KNLzCJTGExqPPbHFKUgJg0b7XqyFz0tsO8HPFKIhPfJf7MCV+jhjNozwxFREHx2WVx5tHxm2RVD5XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nCfvmBnRcgDw19gRzbXgWAhHv6CWWHKg13DpagwTnRw=;
 b=RfmTB94uC0ZUQnfkt7s97fnG4bOsIKDs5ByK/wdEqajx7sOpsjYqQe9vHhtaTdb6XwO53htYk4FqmkjaNkXg9zrKMfWaqZzDT1ewayolVKFE/ZYF2DR7Kw+c7X3kZRHb4r8OK9JN+1nmxTESjgQqfCQTWZdzqHVotMsmGenXSiAVmwppSLZc9gpubr/FIfv1+mF2NfrrKZKW95jXVZ9OjaQYyopK1hwl8GMd98XgoNaW+xPvxdQ/djAD6HYXNaJreL9EXDcQOFp/OEmTkVroF1JmMa7MJInCl0s0MlPbhrqmDlHtwYH5Bng/mQmGPa0j2WMFI+h7gUfGYFcNxGm6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCfvmBnRcgDw19gRzbXgWAhHv6CWWHKg13DpagwTnRw=;
 b=A/obvh2JPb7o0GZ/tP+dFWTT14YD7EpOHodM3sS6zPI/5EHOt76by05nMqIdon3fLEizsOuJlkRzl5DFfxm0tVjgZ5ZnuEV6h3PkbBK2pKM52uohFEgSsEAURRaQ4uLmmPwYmmGsZj07znloLKEKVLvOjIRJYOykNVJQHMvu1Rc=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AM7P190MB0647.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 07:50:54 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 07:50:54 +0000
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
 <vrcxh2mto7bfcb.fsf@plvision.eu>
 <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
 <vrcxh2lf3rbcjc.fsf@plvision.eu>
 <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
 <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     John Thomson <john@johnthomson.fastmail.com.au>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
In-reply-to: <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
Date:   Mon, 27 Sep 2021 10:50:52 +0300
Message-ID: <vrcxh2y27ia23n.fsf@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0301CA0023.eurprd03.prod.outlook.com
 (2603:10a6:206:14::36) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
Received: from pc60716vkochan (217.20.186.93) by AM5PR0301CA0023.eurprd03.prod.outlook.com (2603:10a6:206:14::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 07:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78eae9d6-c645-408c-1205-08d9818b8872
X-MS-TrafficTypeDiagnostic: AM7P190MB0647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7P190MB06478AFC0A03495E04D62A7F95A79@AM7P190MB0647.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kzkpve93Z3ldr1z9Let/d5wY19AQ7e0Pv7wrtIhU+ox7IgykfETVEZhobWB5ESk6Ha+Y7MRBNTx5Wd20EpfYoElF1eyE91qOaXyJCPw5Q3t4XqIrqWUZzK/MyJNaP2FDE1ZAW4g5HiqSk7ssXtYUVRgrSXZyH62e4fTh8H9aMZ32ODVWWGAZA/T2rI3AwfupkQwenV9rkBFX64vt4j8/EnhZ0fgEq+WzkRpHTpxIL2XiL6beEGJI0NsmvT7EDzi8Ry8bgXNZDIS88GD/kC7J/j+ljxDCG/EbKapPe14N1oyssNUPekj0FzkQvHL1F7C8ljUU8FPZAz8qz4zJIHhBCW7nH+J2pbnyxKBKAF4KweDH9esypYKS2k4F25b0gZ1DhXos8uSalqIaJH7x0gH9T1Wtj9xV4XadIqDlTj763DPG/D4N8BoHHiEmebaUzk9XeIolAnSjMM1XgnjRnlZNsHP9vHjw6b9eaFiOXlXpO3itMDKVSAj0vS0hbfgPtmVvdyAknb4nMa5yAFDWNH3ctFLOicB9RqjoNB11jAIMQwd82miDe1fUo+UczOZQkmwC6UP7W4U8FPu+k4J68suwlbv3Z8sPVjvH2xv+m2ZjjzFL0eamDATK3BZ1oVFJpJrDVpfBMf6QiNWk7F6tvkStU2PA/tM/cP/f8UkDtdCpTtp9mD97/2zQ1p6psGkloVW5NI6LIrJE/Vx2Kz5ZzMqFlz3qkIt5/Z0t0/pzXkGsXBf4EaDH0Bu1p5AE2pyf60eKZrygMyu2qWeqOj0sj1ChCcQWDMx32cy9RmUb2zeIOyAi1Ucw+qvIPBRlvfUAbwWJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(366004)(396003)(136003)(52116002)(36756003)(6486002)(66556008)(5660300002)(2616005)(508600001)(6496006)(186003)(956004)(66946007)(66476007)(54906003)(316002)(38100700002)(8936002)(44832011)(26005)(8676002)(38350700002)(2906002)(83380400001)(86362001)(4326008)(966005)(53546011)(6916009)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y966p6YYrhx302vs+Mk+35qiGea0BFbbYWEn1WldOckHFtkC8e50MmhZg1QL?=
 =?us-ascii?Q?KfQVepFfwGDrbHGXUkhnBj/UpfbdRnd4q9nnHeOzEJ5eBdImpQelxFLlBmgE?=
 =?us-ascii?Q?iuylaHVRxBGtLU3Lee1IfmVutdW+8n/4FnNvOSDlXFKFyl9WW6XZJAPh0y/+?=
 =?us-ascii?Q?LBhEcC8Hlbmr2KR0iu5JZpkNbsAVuGA//BvYvc6BMPVbub/JC52XAL+LS9DM?=
 =?us-ascii?Q?P3CX7FFRgBqFBfuvzUUlfhai2JVsq28a13p3S2K6cSwoBgL2flLfeQ0ob2RH?=
 =?us-ascii?Q?3lDO+3tVqCvWen8gXSxr5dwWZj8NA7vvpv9ha7qMnOQKHT9kdJSSKut0d1/0?=
 =?us-ascii?Q?CYepLvSMzL1yDrAn1POx8/6h0Ym2FE/0cMRdC1UXXi4Q/EnZdADEZufj86n1?=
 =?us-ascii?Q?qhkWvSK3p9rnm4rZBJaNGaAnpzNIAS4W5Vctvxor937rz/o2nIASTj+yNO61?=
 =?us-ascii?Q?ov3n1IgAjanhlLfxStnIgtypD3h5sKoo7FixmLZUYJVjC4XWH7cibev0Wl1/?=
 =?us-ascii?Q?MbcckG2qZdCV5+b9RNvOeA1La0E6GOtJqsctnO1eJgLMTB0DdaMhuOU0U/uO?=
 =?us-ascii?Q?sDYZOvPJe4v4nmUYuk0jEDZPcPvXjTKOUdzhPSsInKKqNkebup9D0qhQ68ON?=
 =?us-ascii?Q?SCaf+56mFoJjDprgnnJVjYkNcEwIU1hNVXQdaXkbmS7wz0LTJopmYcfPn0dU?=
 =?us-ascii?Q?zu7+oKawOm3d4Wi7gP86RK0SaRq3aLfpfZQVofyEIW2T+sXAB+4xM1uNBcPg?=
 =?us-ascii?Q?YxCzJEFPJx4UBE/W0oseg8CTa3hoNe9eAxcYtljN/makkSD7eHl7+fRmkb/g?=
 =?us-ascii?Q?ml4FV+ZI36jAY8z52dAg1Ym52QfHPfIH3iztIdowy3Ab80/WQWBQqeCEGAvR?=
 =?us-ascii?Q?t8qox0jGxwv1JkosB15Mu6Plkq1SMYBkGOK2eGUQQedn3aeDYKWWvacowLE/?=
 =?us-ascii?Q?4hHHbGKcTYrEG5rdyj0tD72sdqbgoMSVds2C/UHN71d/CdbOfBFMlb9Ap8YE?=
 =?us-ascii?Q?644/GoIf9pJF5fr+V3HVW57x/w0sZkCR8os0LXyGrMFrqgBqAH27fSG6T5eG?=
 =?us-ascii?Q?3Kq0brlBF8juRaHtFahiyQoFFDmWieAZeGOpvhyfgKLbHQUct27aDQQ612Q+?=
 =?us-ascii?Q?1vBMt7fT3y/FdKVoOKf2nseXG3IIwzA42/lXymeX+fWJg+EnO1JNb8jyGGOo?=
 =?us-ascii?Q?jJNP5BtZGroLTZINs9bO64yE/tpZmV5VXnSfsFPPnc5MrKVTBLem64JElO6A?=
 =?us-ascii?Q?v7aaFKjRu+yGn0lZwl4h/5q4wKBSNKzWAxZewXTR/EHy3/VzCXFWI4oBaMxE?=
 =?us-ascii?Q?rEqu+b1N0/y3m9l1lLOlPe0H?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eae9d6-c645-408c-1205-08d9818b8872
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 07:50:54.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ezvI1Nuj1MXxqwoMHb1xbvr+b6axkpHS1Zc6tElY/rPzCoN3g5IvhKLJ9sjyyxhOAnEACW5i5ocJIKHvgiOxm5RHaG/TFIIhcZR0mC+5vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0647
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Srini,

John Thomson <john@johnthomson.fastmail.com.au> writes:

> On Mon, 20 Sep 2021, at 13:40, Srinivas Kandagatla wrote:
>> On 20/09/2021 14:29, Vadym Kochan wrote:
>>> 
>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>>> 
>>>> On 20/09/2021 13:29, Vadym Kochan wrote:
>>>>>
>>>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>>>>>
>>>>>> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>>>>>>> Or, treat cells with length "0" in a special way and allow to update
>>>>>>>>> cell info later.you can update irrespective of the length, as long as this is done
>>>>>>>> before register.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> some_dev_node {
>>>>>>>>>> 	compatible = "xxx";
>>>>>>>>>> 	nvmem-cells = <&mac_address>;
>>>>>>>>>> 	nvmem-cell-names = "mac-address";
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> == CODE ==
>>>>>>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>>>>>>> ==========
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> If you notice the mac_address node reg is 0.
>>>>>>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>>>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>>>>>>> with tlv name.
>>>>>>>>>>
>>>>>>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>>>>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>>>>>>> update existing cells parsed from OF.
>>>>>>>>>
>>>>>>>> Lets keep the core code clean for now, I would expect the provider
>>>>>>>> driver along with parser function to do update the nodes.
>>>>>>>>
>>>>>>>> --srini
>>>>>>>>
>>>>>>> core.c sequence:
>>>>>>>
>>>>>>> 1) after cells parsed from OF:
>>>>>>>
>>>>>>> 2) lookup the parser
>>>>>>>
>>>>>>> 3) parser->cells_parse(ctx, table)
>>>>>>>
>>>>>>> 3.a) update existing cells matched by name from table
>>>>>>>
>>>>>>> 4) parser->cells_clean(ctx, table)
>>>>>>> /* to free cell's_info allocated by the parser driver */
>>>>>>>
>>>>>>> as alternative way, I think it would be more generic to
>>>>>>> provide nvmem-provider.h API to update the existing cell info,
>>>>>>> however it makes sense only when cells were parsed
>>>>>>> by the cell parser, in the other situations the
>>>>>>> cell should be well defined.
>>>>>>>
>>>>>>> with this approach the parser driver will be just called
>>>>>>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>>>>>>> for each parsed cells.
>>>>>>
>>>>>> TBH, This is an over kill.
>>>>>>
>>>>>> In nvmem provider driver probe you can parse the tlv data and update the
>>>>>> dt nodes before nvmem register.
>>>>>>
>>>>>> rest of the code should just work as it is.
>>>>>>
>>>>>> --srini
>>>>>
>>>>> You mean to parse TLV in the particular nvmem provider driver (for
>>>>> example in at24 driver) ? If so, then it will not allow to parse
>>>>> this TLV format from the other kinds of nvmem.
>>>>
>>>> Why not?
>>>>
>>> 
>>> Well, I think that nvmem driver and TLV parsing should somehow be
>>> de-coupled from each other like block devices and FS does. BUT,
>>> in case this TLV data will be used only on at24 devices then
>>> may be it is OK.
>>> 
>>
>> It has to be decoupled yes, which could be at any level with simple 
>> library function to a infrastructure level..
>>
>> In this case with few or single users, doing with an additional 
>> infrastructure is a bit of over kill IMO.
>>
>>
>> --srini
>>>> Can you also tell us which other nvmem providers are you going to test
>>>> this on?
>>>>
>>> 
>>> Currently I can test only on at24 devices. From the:
>>> 
>>> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
>>> 
>>> "
>>> Each ONIE system must include non-volatile storage which contains vital
>>> product data assigned by the manufacturer. The non-volatile storage
>>> could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
>>> sector or any other non-volatile storage medium.
>>> "
>>> 
>>> I am not aware about other nvmem devices which are used for existing
>>> ONIE supported boards.
>>> 
>>>> As long as you represent this parsing function as some library function,
>>>> I do not see any issue.
>>>> If any exported symbol is available for this then any nvmem provider
>>>> could use it.
>>>>
>>>> --srini
>>>>
>
> Hi Srinivas,
>
> Can I note here that I would like to parse
> TLV data from an SPI-NOR device to NVMEM cells.
> The same general use case (getting mac-address from OEM data).
>
> Was planning to base my work on this series, as well as
> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
> (thanks for pointing that out Srinivas)
>
> Cheers,

What about at least to have just one call in core.c to make it a bit
de-coupled, like:

core.c

struct nvmem_device *nvmem_register(const struct nvmem_config *config)
{
...
         rval = nvmem_add_cells_from_table(nvmem);
         if (rval)
                 goto err_remove_cells;

+        rval = nvmem_parse_cells(nvmem, of);
+        if (rval) {
+        /* err handling */
+        }
+
         rval = nvmem_add_cells_from_of(nvmem);
         if (rval)
                 goto err_remove_cells;

         blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);

         return nvmem;

...

}

somewhere in nvmem-parser.c:

/* retreive parser name from of_node and call appropriate function to parse
   non-fixed cells and update via of_update */
int nvmem_parse_cells(struct nvmem_device *nvmem, struct device_node *of_node)
{
    ...
}

?

Regards,
Vadym Kochan
