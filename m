Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A401F45DA04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352119AbhKYMav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:30:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53676 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352681AbhKYM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:28:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1APCPW56029759;
        Thu, 25 Nov 2021 06:25:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637843132;
        bh=ae2djdnrcrZIuXucMfsmSmeQEtEPEgbPjxeoQkFtEOM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XRjA+ZV0XppUYhbYVb5gwGRajRlNu4I07SbnFgsYc+zNUAjY1bhWMv50eDt1EuiPq
         Rr2l99n9DZB8VsvY5r7resWVBLEIMHjldLO1RVC758IfZEJG+GMJLxubxFA1vYA4Ff
         pkP9fY2I30emv8609zCtl0NAlCStHg8a699opi4M=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1APCPWN3073062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Nov 2021 06:25:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 25
 Nov 2021 06:25:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 25 Nov 2021 06:25:31 -0600
Received: from [172.24.145.91] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1APCPTe1006147;
        Thu, 25 Nov 2021 06:25:30 -0600
Subject: Re: [PATCH v2] ASoC: dt-bindings: davinci-mcasp: convert McASP
 bindings to yaml schema
To:     <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211125121521.31554-1-j-choudhary@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
Message-ID: <6af6a1c5-6b5e-fb35-a9c7-3314f936994f@ti.com>
Date:   Thu, 25 Nov 2021 17:55:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125121521.31554-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/11/21 5:45 pm, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs
> from txt to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains'
> '#sound-dai-cells', 'num-serializer' and 'port' which were not there
> in the txt file.
> Adds 'dmas' and 'dma-names' in the example which were not there in
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>    'dmas', 'interrupts' and 'interrupt-names' according to the
>    arm SOCs
> - adds 'port' and 'num-serializer' as node properties.
> 
>   .../bindings/sound/davinci-mcasp-audio.txt    |  86 ---------
>   .../bindings/sound/davinci-mcasp-audio.yaml   | 179 ++++++++++++++++++
>   2 files changed, 179 insertions(+), 86 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>   create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml

Rob, Mark,

Previous reply on v1 patch had irrelevant quoted text so here are the 
necessary comments:

- For the arm64 SOC errors in the dtbs_check, a patch has been already 
sent: https://lore.kernel.org/all/20211117053806.10095-1-j-choudhary@ti.com/

- For the typo error in the dts file which causes error in the 
dtbs_check: 
https://lore.kernel.org/all/20211125105326.17000-1-j-choudhary@ti.com/


Jayesh
