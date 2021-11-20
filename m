Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FFE457AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKTD1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbhKTD1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:27:07 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04621C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:24:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1F28641EE3;
        Sat, 20 Nov 2021 03:23:59 +0000 (UTC)
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20211117145829.204360-1-marcan@marcan.st>
 <20211117145829.204360-2-marcan@marcan.st>
 <f3582c00-925d-91ec-c829-0aaa8f0157c0@suse.de>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/3] drm/simpledrm: Bind to OF framebuffers in /chosen
Message-ID: <36f3cf18-6654-e1bf-1fa6-a5797751ee86@marcan.st>
Date:   Sat, 20 Nov 2021 12:23:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f3582c00-925d-91ec-c829-0aaa8f0157c0@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 18.19, Thomas Zimmermann wrote:
> Hi
> 
> Am 17.11.21 um 15:58 schrieb Hector Martin:
>> @@ -897,5 +898,21 @@ static struct platform_driver simpledrm_platform_driver = {
>>    
>>    module_platform_driver(simpledrm_platform_driver);
>>    
>> +static int __init simpledrm_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
>> +		for_each_child_of_node(of_chosen, np) {
>> +			if (of_device_is_compatible(np, "simple-framebuffer"))
>> +				of_platform_device_create(np, NULL, NULL);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +fs_initcall(simpledrm_init);
>> +
> 
> Simpledrm is just a driver, but this is platform setup code. Why is this
> code located here and not under arch/ or drivers/firmware/?
> 
> I know that other drivers do similar things, it doesn't seem to belong here.

This definitely doesn't belong in either of those, since it is not arch- 
or firmware-specific. It is implementing support for the standard 
simple-framebuffer OF binding, which specifies that it must be located 
within the /chosen node (and thus the default OF setup code won't do the 
matching for you); this applies to all OF platforms [1]

Adding Rob; do you think this should move from simplefb/simpledrm to 
common OF code? (where?)

[1] Documentation/devicetree/bindings/display/simple-framebuffer.yaml

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
