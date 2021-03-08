Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C89330A75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhCHJqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCHJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:45:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53921C06174A;
        Mon,  8 Mar 2021 01:45:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d3so19949460lfg.10;
        Mon, 08 Mar 2021 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkMg8HyUAo2EgfDsqfPoEike2P+I5ZeqjTnpmKUfESg=;
        b=ed8P7aci3K9782uqe3hPoxIbeFHdhSDx80uC8ROz+WNEc5VEuLW7sN9At4il2YKqfW
         UBl8E2zBYghqkMrjjwBDj4ssNsQn0xnVSOmQGx5AHtpCN1Q+kKZO84aYlnd+yb5A6BTn
         dAnI4wEGzvvP0R74NHGvaMtPqdLHW2fLGiQGh78ssM4ACVXtSgvw8x4Pba7p4LmpplyW
         xS4yqQWSzEoSAm6J0o5nAE00KkGG57X/4zwlE9Bfb6YEqPFHwlKgEbXmC4UEwJqxA0q0
         PRzoxz5Nu+FSSVzkFRrYylvqb1QrqS64ojpHm6mgQT5JPIq/W+cG1IE1JGwEX28dsW5B
         JiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkMg8HyUAo2EgfDsqfPoEike2P+I5ZeqjTnpmKUfESg=;
        b=NuSjzm5Fl93Jc8IuZqp0zW8G9L4mJnpAozXnNF5x5KQ7PAhiH5tAEa+x2XOscyxG8z
         chmQOXnDd13KBzLEOw1KO5CCg6BC5JkH/yPzrzqN73uqw/LzJXQKQYsIlLUQq4VcZ5JU
         ALqLgLN1g3YkrQfJDsF4bG9EmJZP8AcR9HptLaCWk8gF7kVmilcjid1t5HtkYxo4soym
         qos64ODqLs9bJ3H+WTwwoanqYiJdtHD5mBFDu8DnIEzAHhv9wtA8L5nWsqmzgPcdETbj
         rHgEVK2oWWqH/qGSYSa3VgrFXLv2hFT2nuyJ3hxNuWVKgF7kYX1DdZRtUWTQQlN7YM97
         zrag==
X-Gm-Message-State: AOAM5317A0H8jVMIpGYFYxu9wilIQampUL7zYUzMpO59VYpLt0iTsosu
        iBIQxiV77Mf08WoN2dQ51J8=
X-Google-Smtp-Source: ABdhPJxlxOjZeFM6CoJXTEgzmcD+UXez6J8LL5sVrVHswDB2SOc1p3MkeVgimlJiugQiZ6XPfyF7Vg==
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr13368252lfu.3.1615196734896;
        Mon, 08 Mar 2021 01:45:34 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id h17sm1297510lfc.289.2021.03.08.01.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 01:45:34 -0800 (PST)
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of nvmem-partitions
 compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
 <1cf374f1-09d5-9fa9-9b0d-d8079f2f6fbc@gmail.com>
 <20210305222300.GA718014@robh.at.kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <9167d2be-067e-4ad3-9c8b-28bb549187aa@gmail.com>
Date:   Mon, 8 Mar 2021 10:45:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210305222300.GA718014@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.03.2021 23:23, Rob Herring wrote:
> On Wed, Mar 03, 2021 at 11:01:55AM +0100, Rafał Miłecki wrote:
>> [Rob: please advise]
>>
>> On 16.02.2021 22:26, Ansuel Smith wrote:
>>> Document nvmem-partitions compatible used to treat mtd partitions as a
>>> nvmem provider.
>>
>> Until now we were using "compatible" string in partition node only for
>> parsers (looking for subpartitions). We need to think if this change can
>> break anything from DT / Linux perspective.
>>
>> Compatible strings should be unique, so there is no risk of conflict
>> between NVMEM and parsers.
>>
>> Now: can we ever need mtd partition to:
>> 1. Contain subpartitions
>> 2. Provide NVMEM
>> at the same time?
>>
>> Let's say:
>>
>> partition@0 {
>> 	compatible = "vendor,dynamic-firmware-partitions", "nvmem-partitions";
> 
> I think you'd want the "vendor,dynamic-firmware-partitions" parser/code
> to serve up any nvmem regions. Whether you have a fallback here depends
> if an OS could make use of the regions knowing nothing about
> "vendor,dynamic-firmware-partitions".

Perfect! I didn't think that driver handling
"vendor,dynamic-firmware-partitions" may also take care of NVMEM.

Thank you.
