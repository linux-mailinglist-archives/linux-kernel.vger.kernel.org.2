Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15045D9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350294AbhKYM0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350359AbhKYMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:24:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C1C061758;
        Thu, 25 Nov 2021 04:21:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so15930348lfv.4;
        Thu, 25 Nov 2021 04:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vKwW+VHe5OcMxed3R036glSM7CFNnysyFNmayki8jus=;
        b=HmNbEV8gOFpo7zvwzGdiodhLx5aO0alsx+N0u4jE+PzgpviXCE34KVp+onkz+8jkrU
         uO/5CPgXPir/GlBDsg47DNy1Ma6Vu2CxJZ5W2n/48nAcV8Fps9BzXhbzMblsQtEUNuKS
         STL5otz6feV42aLr917H9BxgogTI7KN4zcqracOUhD6sFRp8+2AucwIe5ewEv9QXBThv
         uYYPeemklzZTZqq1tNPWhKTpCYaGwBXsLvWUDD/a7W44DBFYfZN+LherWsQp9ko9eUuX
         6IWaoxA1kwD6CQqGMF/5HUfljIUd5sh84yN7BWfp2K3p3diYl66SyKQtQfHGSnnEzWC9
         1JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vKwW+VHe5OcMxed3R036glSM7CFNnysyFNmayki8jus=;
        b=irNrkpH+j9WtxvBTbAG/WpKdWUJrmyGoRN1XOnVItmEsHUo3pEaeZ/7WdS7ARTJC8z
         Z9vW6+IvtJRAS/JXND/eUz9jsGlIfQS4R4nl/5Teq5NNy3upliWUA48CXIN7UPgKAs5f
         3bUzXny5RV4IVYP5Qnrw5bb07b4JruN6UBmp9l3Uja3b5J4RjjaVsTvizsVwehcyDqd0
         Mhl2k84fpFQFW10np60yapTiXX/DrosHtBj5+CJDauLJlkS9A1E+TbXaDt36rkN0UH69
         ylPpHGJ8muWc4vz88w30nyFgSJI793dIU6Oe9ywRALyJg5dz14d0Y3ThEXCX+wQThMvh
         FJSg==
X-Gm-Message-State: AOAM53269YQP/UxU386ZywFWcLhQQzT37gIcmBKRjer3VQlKndHf51tQ
        SukSnr3G8KIKAboBUQA3thQ=
X-Google-Smtp-Source: ABdhPJyjtb3X/8swejQdKOhc7frtnSzRSVwz0xBmcpEyK7dmM5Smu4K+sNVZW3KlH80bKOSjwvpNeg==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr23073068lff.303.1637842898089;
        Thu, 25 Nov 2021 04:21:38 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id x17sm222042lji.96.2021.11.25.04.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 04:21:37 -0800 (PST)
Subject: Re: [PATCH V3 6/6] dt-bindings: xen: Clarify "reg" purpose
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Julien Grall <julien@xen.org>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
 <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2111241708170.1412361@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <38cf1231-4a52-ea4a-cfc2-a73c09631031@gmail.com>
Date:   Thu, 25 Nov 2021 14:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2111241708170.1412361@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.11.21 03:09, Stefano Stabellini wrote:

Hi Stefano

> On Wed, 24 Nov 2021, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> Xen on Arm has gained new support recently to calculate and report
>> extended regions (unused address space) safe to use for external
>> mappings. These regions are reported via "reg" property under
>> "hypervisor" node in the guest device-tree. As region 0 is reserved
>> for grant table space (always present), the indexes for extended
>> regions are 1...N.
>>
>> No device-tree bindings update is needed (except clarifying the text)
>> as guest infers the presence of extended regions from the number
>> of regions in "reg" property.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>> ---
>> According to the recent update to Xen's guest.txt:
>> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master
>>
>> Changes V2 -> V3:
>>     - new patch
>> ---
>>   Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
>> index db5c56d..156fe10b 100644
>> --- a/Documentation/devicetree/bindings/arm/xen.txt
>> +++ b/Documentation/devicetree/bindings/arm/xen.txt
>> @@ -7,10 +7,14 @@ the following properties:
>>   	compatible = "xen,xen-<version>", "xen,xen";
>>     where <version> is the version of the Xen ABI of the platform.
>>   
>> -- reg: specifies the base physical address and size of a region in
>> -  memory where the grant table should be mapped to, using an
>> -  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
>> -  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
>> +- reg: specifies the base physical address and size of the regions in memory
>> +  where the special resources should be mapped to, using an HYPERVISOR_memory_op
>> +  hypercall.
>> +  Region 0 is reserved for mapping grant table, it must be always present.
>> +  The memory region is large enough to map the whole grant table (it is larger
>> +  or equal to gnttab_max_grant_frames()).
>> +  Regions 1...N are extended regions (unused address space) for mapping foreign
>> +  GFNs and grants, they might be absent if there is nothing to expose.
>>     This property is unnecessary when booting Dom0 using ACPI.
> I would remove the last sentence about ACPI as the initialization is not
> done via the xen,xen device tree node in that case anyway.

Agree, will do. I assume, the similar sentence for the "interrupts" 
property down the text wants removing as well.


>
> With that change:
>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks!


-- 
Regards,

Oleksandr Tyshchenko

