Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34A412E53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhIUFw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:52:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47841 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhIUFwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:52:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E11C5C0071;
        Tue, 21 Sep 2021 01:50:57 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Tue, 21 Sep 2021 01:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=l2a30VSKC5LGozrAonmhRzd4StHF
        Us08tyB9C9xJV4c=; b=r2Tft5SxlSZ+nvTMpBXYdzCaj/7oNWMcCQz9oKLQPiNE
        J5mmzlJfHFoOtkZU8kTDbTw+pO0vq8gOVHZUj0ZVDvwiaNPXlyk2QpETMJ5XKQAV
        olcQZuvAce5s0j0zUdnSN+JB5TrfqcSq4RN92jUt1YOpfcQdmAf/PWrdhcw9OIsO
        ZDVuMroAZ9uNqw1lV6g1aksQcFKLwRxrxVaGksmT3i3c0yRWtNbQmB3LYWE4hkFj
        ezQYosb20qHqTNv0f/XLo8Nrbzv1E2lH0cd6DkVzKu3i90rWIcNgZ3Sc73xLrlas
        TT/s2tt4g1mLhu0xfF21rGEYoPIptP86Kyq0Gm8v5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=l2a30V
        SKC5LGozrAonmhRzd4StHFUs08tyB9C9xJV4c=; b=NP9eB8RhnSglE91aniL1CG
        WQCokYmK77cbU1DQQAwr+3EvSgmNjDkKMaVd9Ir7d0ge/Qnqe0u6UDM0FiHmvr3g
        Pxw3qX8ItEVE5kLZwI7dXgoqSaCdeJHcLyNeXkqxgKi3F4F58ia3m6Qez6RY5MBn
        sqLc7JaUS3GqAOTbhytFKDP5kVuIoPmWKczWPIz8IwDWXzIwRLPjMNW2b3cvBXz2
        +rxeuHOQ7JbW1RHGrtQ69989gZcvPDCsmrAUZe3/cj7oBiuyp+tQ0xaaqhdA5L3B
        fCFUYQDfOiGDTqPJZgNE12hdF2Diocm+ZFJXmAE+KFnMBnJVJg1SAWhTo8ch1J6w
        ==
X-ME-Sender: <xms:wHJJYXskBMUaWt2H6mRhZBta_p5nGbt7yrwVHa1jJBGsGCcuv1jwOA>
    <xme:wHJJYYcm5C6XTOVLCevLEhuxC8BtlJ2Lmk0IU-cEJNmrbufb4POyWmEK2Qs_xVorj
    awJXdcjcpjT8SieBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeifedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    ufgtsehttdertderredtnecuhfhrohhmpedflfhohhhnucfvhhhomhhsohhnfdcuoehjoh
    hhnhesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruheqnecuggft
    rfgrthhtvghrnhepueelvddugeefjeekueeitefhgefhkeetheduhffgvdfgudefvefgie
    evkeeljeelnecuffhomhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhhnh
    esjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:wXJJYawJln-D8Z2DvoQl23jVuCkLCLm5nWHgWJjtMKHSm3g-LGp19w>
    <xmx:wXJJYWMSBncvqMwOG5Txy7Kyoqw2Mo2IgG9bHyCOpi0OZU9BefwXxw>
    <xmx:wXJJYX-KoitkT65P9U7fqlI86sb7lGjf5x6Z6LwqlMYVMw4VKzV8xQ>
    <xmx:wXJJYaab5UROruYFoluGuTDNvJ_FTw_QwiINTwYqLgaQb1Y9L0QHRA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDA6F1EE0068; Tue, 21 Sep 2021 01:50:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
In-Reply-To: <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
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
Date:   Tue, 21 Sep 2021 05:50:36 +0000
From:   "John Thomson" <john@johnthomson.fastmail.com.au>
To:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Vadym Kochan" <vadym.kochan@plvision.eu>
Cc:     "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Robert Marko" <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021, at 13:40, Srinivas Kandagatla wrote:
> On 20/09/2021 14:29, Vadym Kochan wrote:
>> 
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>> 
>>> On 20/09/2021 13:29, Vadym Kochan wrote:
>>>>
>>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>>>>
>>>>> On 20/09/2021 12:25, Vadym Kochan wrote:
>>>>>>>> Or, treat cells with length "0" in a special way and allow to update
>>>>>>>> cell info later.you can update irrespective of the length, as long as this is done
>>>>>>> before register.
>>>>>>>
>>>>>>>
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> some_dev_node {
>>>>>>>>> 	compatible = "xxx";
>>>>>>>>> 	nvmem-cells = <&mac_address>;
>>>>>>>>> 	nvmem-cell-names = "mac-address";
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> == CODE ==
>>>>>>>>> ret = of_get_mac_address(dev->of_node, base_mac);
>>>>>>>>> ==========
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> If you notice the mac_address node reg is 0.
>>>>>>>>> This node "reg" property should be updated ( using of_update_property())
>>>>>>>>> by nvmem-provider driver while tlv parsing and by matching the node name
>>>>>>>>> with tlv name.
>>>>>>>>>
>>>>>>>> I assume parser driver can just invoke add_cell_table (with may be
>>>>>>>> by adding 'bool update' field to the cell_info struct) and core.c will just
>>>>>>>> update existing cells parsed from OF.
>>>>>>>>
>>>>>>> Lets keep the core code clean for now, I would expect the provider
>>>>>>> driver along with parser function to do update the nodes.
>>>>>>>
>>>>>>> --srini
>>>>>>>
>>>>>> core.c sequence:
>>>>>>
>>>>>> 1) after cells parsed from OF:
>>>>>>
>>>>>> 2) lookup the parser
>>>>>>
>>>>>> 3) parser->cells_parse(ctx, table)
>>>>>>
>>>>>> 3.a) update existing cells matched by name from table
>>>>>>
>>>>>> 4) parser->cells_clean(ctx, table)
>>>>>> /* to free cell's_info allocated by the parser driver */
>>>>>>
>>>>>> as alternative way, I think it would be more generic to
>>>>>> provide nvmem-provider.h API to update the existing cell info,
>>>>>> however it makes sense only when cells were parsed
>>>>>> by the cell parser, in the other situations the
>>>>>> cell should be well defined.
>>>>>>
>>>>>> with this approach the parser driver will be just called
>>>>>> via parser->cells_parse(ctx) and will call nvmem_cell_info_update()
>>>>>> for each parsed cells.
>>>>>
>>>>> TBH, This is an over kill.
>>>>>
>>>>> In nvmem provider driver probe you can parse the tlv data and update the
>>>>> dt nodes before nvmem register.
>>>>>
>>>>> rest of the code should just work as it is.
>>>>>
>>>>> --srini
>>>>
>>>> You mean to parse TLV in the particular nvmem provider driver (for
>>>> example in at24 driver) ? If so, then it will not allow to parse
>>>> this TLV format from the other kinds of nvmem.
>>>
>>> Why not?
>>>
>> 
>> Well, I think that nvmem driver and TLV parsing should somehow be
>> de-coupled from each other like block devices and FS does. BUT,
>> in case this TLV data will be used only on at24 devices then
>> may be it is OK.
>> 
>
> It has to be decoupled yes, which could be at any level with simple 
> library function to a infrastructure level..
>
> In this case with few or single users, doing with an additional 
> infrastructure is a bit of over kill IMO.
>
>
> --srini
>>> Can you also tell us which other nvmem providers are you going to test
>>> this on?
>>>
>> 
>> Currently I can test only on at24 devices. From the:
>> 
>> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
>> 
>> "
>> Each ONIE system must include non-volatile storage which contains vital
>> product data assigned by the manufacturer. The non-volatile storage
>> could take the form of an EEPROM, a NOR-flash sector, a NAND-flash
>> sector or any other non-volatile storage medium.
>> "
>> 
>> I am not aware about other nvmem devices which are used for existing
>> ONIE supported boards.
>> 
>>> As long as you represent this parsing function as some library function,
>>> I do not see any issue.
>>> If any exported symbol is available for this then any nvmem provider
>>> could use it.
>>>
>>> --srini
>>>

Hi Srinivas,

Can I note here that I would like to parse
TLV data from an SPI-NOR device to NVMEM cells.
The same general use case (getting mac-address from OEM data).

Was planning to base my work on this series, as well as
https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
(thanks for pointing that out Srinivas)

Cheers,
-- 
  John Thomson
