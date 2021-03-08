Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6356330F23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCHN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:29:02 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B1C06174A;
        Mon,  8 Mar 2021 05:29:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id c19so7738290ljn.12;
        Mon, 08 Mar 2021 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bH8SgOAbKuUs4jdIWtf1T+ZPNzyaRHJ+Vj2NV4QS1yE=;
        b=SIZd0IssvVu6rbJjVXw5WIFXllzIe5pTt4e3qzSIb+igzodeKSvYtlC5u7t5Lx/Zlu
         itvaOx1Jqh62hPA8IhRGP7YjL56pmJP/fPMIC83rjzzrBgI7kq3FoVXe828ZlvnGgVAa
         haVoVGySaDBc/UWdSqDH7u775B9Z5zG/wKg+Nuz1mAol7UtILOf7ya5Ej32I4ZzW7vT1
         IkPjxr2H8Nwgj2Y34DkPvCjLsk+VjqQd1P3kZykPVnRHLmxUjZUmCyfPLVFIo20A9QjV
         /ExFyTijZ3e7qqPa8+lab7Zgghb62lYzjkZxP7jPIOq+OM8QrsNd5XFh/EBbHyvefFkO
         UfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bH8SgOAbKuUs4jdIWtf1T+ZPNzyaRHJ+Vj2NV4QS1yE=;
        b=VbeX9E6cfwHZX5j3saoK/Sa061js8y8FnprKTyDi1BVl7WV6/741PyQYbpTtdMeM0D
         qciP8bC9JO5GMR78Pu5GbSfEe/22gDNLUp2OkR8UZyu+Cc8GzSodASld4q3cDiDOIRXF
         M+/200zaIrEjuSGXm+KavklhHLkQJR/JP4perIzZ8CCalSIe27It9W4ezJwE8NMAJgP3
         bAuIHhYYq78UCEUUgmD9TBTnEV2879GAvTrkAvBX0lJ24f2jEeXhwNu3hIs76qNdmJpX
         PlG6xS8xSHMX2U/FMmZEXWTArUm15UUllXcsmeyQMNTgUvaP938poIfEvi9PLqEEZpY1
         WJQg==
X-Gm-Message-State: AOAM533kQCrFw/LrQuj9gYBEif9iRJCo1EEW392vYTByhZMMgV63Ys1m
        5XJbQbqtRQek+2CyXRkV0Mk=
X-Google-Smtp-Source: ABdhPJyXIxkH6O2Bd6Dpg4hkRhrQU6UkSZPfe9uFeLBtYL+S4vLkHA1PThDqujc4cOUgKeKWxe+v/Q==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr11473619ljo.491.1615210140467;
        Mon, 08 Mar 2021 05:29:00 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id t7sm1394599lfd.180.2021.03.08.05.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 05:28:59 -0800 (PST)
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
 <ee596471-db9b-43e4-c085-9bd938101587@gmail.com>
 <YEUHsoC4V+H6PCHL@Ansuel-xps.localdomain>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <9ca010ed-930a-2387-2be1-18e3b558d83d@gmail.com>
Date:   Mon, 8 Mar 2021 14:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YEUHsoC4V+H6PCHL@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2021 18:04, Ansuel Smith wrote:
> On Mon, Mar 08, 2021 at 10:48:32AM +0100, Rafał Miłecki wrote:
>> On 16.02.2021 22:26, Ansuel Smith wrote:
>>> Document nvmem-partitions compatible used to treat mtd partitions as a
>>> nvmem provider.
>>
>> I'm just wondering if "nvmem-partitions" is accurate enough. Partitions
>> bit sounds a bit ambiguous in the mtd context.
>>
>> What do you think about "mtd-nvmem-cells" or just "nvmem-cells"?
> 
> I read somewhere that mtd is not so standard so "nvmem-cells" should be the
> right compatible.
> To sum up, with v2 I should change the compatible name and just push the
> 2 and 3 patch. (waiting your fix to be accepted) Correct?

Yes, I believe so
