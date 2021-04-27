Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6236C6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhD0NIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:08:44 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:53914 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhD0NIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:08:43 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 09:08:43 EDT
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id D6AF8601EE1A;
        Tue, 27 Apr 2021 15:59:30 +0300 (EEST)
Received: from localhost.localdomain ([172.24.253.155]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 27 Apr 2021 15:59:37 +0300
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add bootcount-nvmem
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
References: <cover.1619511801.git.nandor.han@vaisala.com>
 <942aacf1c51861e5a09db6a6d322666709695df2.1619511801.git.nandor.han@vaisala.com>
 <1619528221.583004.1346444.nullmailer@robh.at.kernel.org>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <e7b2fb04-4c36-3e09-5d62-e1bfd38e134e@vaisala.com>
Date:   Tue, 27 Apr 2021 15:59:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619528221.583004.1346444.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2021 12:59:37.0710 (UTC) FILETIME=[2DD098E0:01D73B65]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 27 Apr 2021 11:26:31 +0300, Nandor Han wrote:
>> Documents the device tree bindings for `bootcount-nvmem` driver.
>>
>> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
>> ---
>>   .../bindings/nvmem/bootcount-nvmem.yaml       | 72 +++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:34.1-2 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1414: dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1470591
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Thanks for the quick feedback Rob.

I did run some checks, maybe not well enough.
I will have a look to your suggestions.

Regards,
    Nandor
