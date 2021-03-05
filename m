Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C668232F6C9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCEXrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:47:21 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:56292 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCEXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:47:13 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 137CEB049B3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:47:12 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1614988031; x=1615852032; bh=ZkXoD99BmHsbR1hrl64a63EOD1CUA4i6MBW
        iJn8lTPo=; b=SnT8nMBrh7O0wFyq4kYGlK+Djiv3TbcaYkcom1gqk0Rr3mqJUxt
        4ITdmhYq+efKbjV9CWGwizP/FPwOlYu5L45oRUJHtllfXkKveWGzeqxSSMVLGuyG
        PZTJkjc01RfJJFtt0Vkd7IptkazCCzyN9t8A9NA4U6shS0qsc4Nb1BR4=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, LOTS_OF_MONEY=0.001,
        NICE_REPLY_A=-0.001] autolearn=unavailable autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fM0_6VyU5aq9 for <linux-kernel@vger.kernel.org>;
        Sat,  6 Mar 2021 00:47:11 +0100 (CET)
Received: from [192.168.50.85] (146-241-168-111.dyn.eolo.it [146.241.168.111])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D0FEBB04710;
        Sat,  6 Mar 2021 00:47:09 +0100 (CET)
Subject: Re: [PATCH 4/9] dt-bindings: display/panel: add Jenson JT60245-01
To:     Rob Herring <robh@kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-5-giulio.benetti@benettiengineering.com>
 <20210305225444.GA792026@robh.at.kernel.org>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <bf765112-4f69-1054-d70f-c5fd831d7995@micronovasrl.com>
Date:   Sat, 6 Mar 2021 00:47:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305225444.GA792026@robh.at.kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Il 05/03/2021 23:54, Rob Herring ha scritto:
> On Thu, Feb 18, 2021 at 11:54:52PM +0100, Giulio Benetti wrote:
>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> Add DT binding for "jenson,jt60245-01".
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>   .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> index 08afd6501094..fd0d2a573350 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
>> @@ -169,6 +169,8 @@ properties:
>>         - jenson,jt60248-01
>>           # Jenson Display JT60249-01 5" (800x480) TFT LCD panel
>>         - jenson,jt60249-01
>> +        # Jenson Display JT60245-01 7" (800x480) TFT LCD panel
>> +      - jenson,jt60245-01
> 
> It was going so well. Alpha-numeric order please.

I've sent v2 patchset, but I didn't add your "Acked-by:" since
alphabetical order was wrong.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

>>           # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
>>         - kingdisplay,kd116n21-30nv-a010
>>           # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
>> -- 
>> 2.25.1
>>

