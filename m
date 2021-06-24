Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21A03B2DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhFXLWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhFXLWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:22:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:20:31 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id hq39so8926901ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9yqHOvEXFM5M+Xh9I7gVovXRkNcEd0z6OPYCZF+Zvx4=;
        b=SODSE+qrhT+5SDdE6Sg3O+6saTYoIJXJ22chH7cmAo4NJWjtuGVrWzBVojhOkSb7Mp
         BZG/KAwV6WegPEFmbvuH0gbj9vQk2Qaba7p0uCqMngNihMceMkancFe2Dvxtg2MYggCq
         O6ID05w0/pq5SPj01u/fz7h+r5VkFoz0vZo1NptS2v1cYDLuDnt/FRnv4riy7pz9iIxs
         +nvs8I4eGlXiUNeUVBB+LZkNR2fK8vUVU1MKaw3KcyDafNcq+IIUCmbibXVD0gOJ3PEe
         KHN5SKbW9Ge7vLhQZUDxqXNsLOjSSqZiqe1i10rPj+n3isvvENxIVkf3KY+wVvwJrEPC
         zXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9yqHOvEXFM5M+Xh9I7gVovXRkNcEd0z6OPYCZF+Zvx4=;
        b=dUP5P6ctb5Lt8UpdoV0YZlx3g+cUz+A1xv7uibnS7a2PApWWCxx/900Oa4z4Gvwt8d
         YToPyLB+cz212zVc1UCKEAQ9SKrPQcEKSKgRzZUo1eqaCSTjeHff6ycrs1GY3C3w3Lr9
         fT+19ELtHK31Spd4zXNlhZjMkXfb5F8D9k5MjO24grX52fYNWElIWW3j/Na5efFfkCfh
         7iWkBf2rjiYH2CubrfasPHf6T529pB7TQ+1IBCBxeHjM5rx6A49Oew2sg+iiDxM3/rsf
         KvU6n33fC8sCwVeSBOBjTSBEuDmEh85tSvzWO7JaZu77fAg3mcrlBqlKng8BAUJOqZlE
         3xIQ==
X-Gm-Message-State: AOAM532e3R9M2mwofQZClLqwS/E5HV6mYpTH1uLuyp/Xe2G7Z4+EE07P
        VUq11VxePin7urJN/SWa/jsb0A==
X-Google-Smtp-Source: ABdhPJz79mtywF82KyD7BNgyK4ywqk9jjP8J0SBKHBzgNCAa3dfxIkNGsnl1Aqjli7K++4A1Fk8yhA==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr4858497ejb.223.1624533629949;
        Thu, 24 Jun 2021 04:20:29 -0700 (PDT)
Received: from [172.25.20.242] (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id hx27sm1043820ejc.75.2021.06.24.04.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 04:20:29 -0700 (PDT)
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
 <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne> <YNMrpzZgH4KECykk@kroah.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Message-ID: <7f076743-3dd6-d397-d3cc-8c31e080695c@immu.ne>
Date:   Thu, 24 Jun 2021 13:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNMrpzZgH4KECykk@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.06.21 14:40, gregkh@linuxfoundation.org wrote:
>> On Wed, Jun 23, 2021 at 02:17:54PM +0200, Hans-Gert Dahmen wrote:
>> Hi,
>> Yes. The window is part of the DMI interface and the south bridge or PCH
>> converts the bus cycles to SPI reads. It is because this region contains the
>> reset vector address of your CPU and the very first instruction it executes
>> after a reset when the internal setup is done will actually be loaded from
>> the serial SPI bus. It is AFAIK part of AMD's original 64-bit specification.
> The point is that you will never be able to do this for all devices.
> You should ONLY be allowed to have this module bind to the hardware that
> you KNOW it will work with.
> 
> So please work off of a DMI table, or some such hardware description,
> instead of just blindly enabling it for all systems.

I was referring to the DMI/QPI/PCI interface that connects the 
ICH/PCH/south bridge to the CPU. I have gone through all datasheets of 
intel ICH and PCH and they state that the address range from 0xff000000 
through 0xffffffff is a fixed mapping that cannot be changed (no BAR) 
except for the original ICH (dating back to 1999) where the window is 
only 8MB. The original ICH is for 32-bit systems only so all 64-bit 
Intel systems that exist have this feature. I have talked to somebody 
who works with future Intel hardware and the person indicated that it is 
not likely to change.

This is why I made the module depend on X86_64. I still have to do the 
same complete research for AMD systems which is a little harder to do, 
so I am proposing to check if the root complex has Intel's vendor ID and 
only load the module on 64-bit Intel systems until I can confirm the 
same behavior for all 64-bit AMD systems. Then I could check if the root 
complex is Intel or AMD. Would that suffice as "some such hardware 
description"?

Here are my public sources:

ICH0 Datasheet Chapter 6.3 and Table 6-5
https://www.tautec-electronics.de/Datenblaetter/Schaltkreise/FW82801AA.pdf

ICH2 Datasheet Chapter 6.4 and Table 6-4
https://www.intel.com/content/dam/doc/datasheet/82801ba-i-o-controller-hub-2-82801bam-i-o-controller-hub-2-mobile-datasheet.pdf

ICH3 Datasheet Chapter 6.4 and Table 6-5
https://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf

ICH4 Datasheet Chapter 6.4 and Table 6-5
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82801db-io-controller-hub-4-datasheet.pdf

ICH5 Datasheet Chapter 6.4 and Table 133
https://www.intel.com/content/dam/doc/datasheet/82801eb-82801er-io-controller-hub-datasheet.pdf

ICH6 Datasheet Chapter 6.4 and Table 6-4
https://www.intel.com/content/dam/doc/datasheet/io-controller-hub-6-datasheet.pdf

ICH7 Datasheet Chapter 6.4 and Table 6-4
https://www.intel.com/content/dam/doc/datasheet/i-o-controller-hub-7-datasheet.pdf

ICH8 Datasheet Chapter 6.4 and Table 102
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/io-controller-hub-8-datasheet.pdf

ICH9 Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/doc/datasheet/io-controller-hub-9-datasheet.pdf

ICH10 Datasheet Chapter 9.4 and Table 9-4
https://theswissbay.ch/pdf/Datasheets/Intel/io-controller-hub-10-family-datasheet.pdf

PCH Intel 5 Series Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/5-chipset-3400-chipset-datasheet.pdf

PCH Intel 6 Series Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/6-chipset-c200-chipset-datasheet.pdf

PCH Intel 7 Series Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/7-series-chipset-pch-datasheet.pdf

PCH Intel 8 Series Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/8-series-chipset-pch-datasheet.pdf

PCH Intel 9 Series Datasheet Chapter 9.4 and Table 9-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/9-series-chipset-pch-datasheet.pdf

PCH Intel 100 Series Datasheet Vol 1 Chapter 4.3 and Table 4-4
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/100-series-chipset-datasheet-vol-1.pdf

PCH Intel 200 Series Datasheet Vol 1 Chapter 4.3 and Table 4-4
https://www.mouser.com/datasheet/2/612/200-series-chipset-pch-datasheet-vol-1-1391746.pdf

PCH Intel 300 Series Datasheet Vol 1 Chapter 4.3 and Table 4-4
https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/300-series-chipset-on-package-pch-datasheet-vol-1.pdf

PCH Intel 400 Series Datasheet Vol 1 Chapter 4.2 and Table 8
https://images-eu.ssl-images-amazon.com/images/I/B1TDsSyARKS.pdf

Hans-Gert Dahmen
