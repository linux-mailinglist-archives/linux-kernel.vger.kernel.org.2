Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2637C3BC28A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhGES0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhGES0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:26:08 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A67CC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 11:23:30 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t3so21647247oic.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ENYjv6yx17UpEQB61r1LoW0SWsAcW3u+lqBhbOZKAU4=;
        b=SFXW9Ej8xVyBKXo4K4ofpy6opT6X+8NzgxzZHUvvDW1F2YM2qes24BLj6xcWPNjNpX
         xt0G4P2P2u7b2tBqEjkM25gPXxyGUL4JIl8PlgnCcKWFiPZ5r1s+rdZnCvhKYtX1xR2W
         wybsem//bYQiow/PCFz2OkayHSNZIC2yY66KoUFwZYx3bd2yjN7vs2As8XZQ2k0CffIA
         4zoCMQynlQJz5Zt9zw+ZMQ0F1xSHrUNiD0CVuUj1SNew9UsN0aizfzCYYnL8Y8u0GqZD
         jN7OzVjBpsiXU4n5o7DVpaYUR//81Gu+G33ksKRxUwogn9+lBkW/SXAEAkkUUC/XWzYM
         awFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ENYjv6yx17UpEQB61r1LoW0SWsAcW3u+lqBhbOZKAU4=;
        b=LD/PCuluqDAvsHvoSFU22dnoo1DSytJj2lPAwf+4gnccfkqmYICGgHJY21KtjwLs5W
         gu4ColWlCWVczJPDnzjRsdX0wWy8qMMPwJyuceFKn9cmVniXLp1Ud+sWPjbZMngoAcVX
         VdjtqtsnY5j6fW/VkWgg4JHDZqwCtjFba9aHzJTSwon+fe+rETnanPf2C29UvXU3x3zN
         34TxL4VF/ObaLAUYJl6eQFrNR7QgQeZox/FM2ZL/tbqMNjGlNaBYcqUWDqMM3V/2YmE7
         XyEIDoWLcWKmYakObsRO5wLYwIML2XkB8+885AObc+yq5haoQ+n6RMD7bMWs3LRqCLHn
         JNMQ==
X-Gm-Message-State: AOAM531YLaz1EU+0iA8DLKzKD2QwZA9MHJatMo+bASDK4m/YZEUkfz+l
        GZlnh1h72ekiUfySW/D/3M+jUWUmVSg=
X-Google-Smtp-Source: ABdhPJzHXIsJBEhFF/J6bs/enQBhS6GwVVcsZSXuJUl2Zg6fvntCrzW0Jo1NvDx2p8cSU8utBfNTHw==
X-Received: by 2002:aca:eb42:: with SMTP id j63mr5096813oih.92.1625509409541;
        Mon, 05 Jul 2021 11:23:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 13sm2895761oiy.32.2021.07.05.11.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 11:23:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap
 with RCU
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
 <20210705172352.GA56304@roeck-us.net> <87h7h88wsd.wl-maz@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <79ec0069-553b-cac1-5ec7-d68c757619a5@roeck-us.net>
Date:   Mon, 5 Jul 2021 11:23:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7h88wsd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 7/5/21 11:01 AM, Marc Zyngier wrote:
> Hi Guenter,
> 
> On Mon, 05 Jul 2021 18:23:52 +0100,
> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Fri, Jun 11, 2021 at 01:54:36PM -0000, irqchip-bot for Marc Zyngier wrote:
>>> The following commit has been merged into the irq/irqchip-next branch of irqchip:
>>>
>>> Commit-ID:     d4a45c68dc81f9117ceaff9f058d5fae674181b9
>>> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d4a45c68dc81f9117ceaff9f058d5fae674181b9
>>> Author:        Marc Zyngier <maz@kernel.org>
>>> AuthorDate:    Mon, 05 Apr 2021 12:57:27 +01:00
>>> Committer:     Marc Zyngier <maz@kernel.org>
>>> CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00
>>>
>>> irqdomain: Protect the linear revmap with RCU
>>>
>>> It is pretty odd that the radix tree uses RCU while the linear
>>> portion doesn't, leading to potential surprises for the users,
>>> depending on how the irqdomain has been created.
>>>
>>> Fix this by moving the update of the linear revmap under
>>> the mutex, and the lookup under the RCU read-side lock.
>>>
>>> The mutex name is updated to reflect that it doesn't only
>>> cover the radix-tree anymore.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>
>> This patch results in various RCU warnings when booting mipsel images
>> in qemu. I can not revert the patch due to subsequent changes, so I
>> don't know if a simple revert fixes the problem. Log messages and
>> bisect log see below.
> 
> Thanks for the heads up. Do you have a config file I can use to
> reproduce this? The QEMU invocation runes would certainly help too.
> 
> It strikes me that in drivers/irqchip/irq-mips-cpu.c,
> plat_irq_dispatch() now uses the irqdomain resolution before
> irq_enter() took place. That's certainly a latent bug. I'll fix that
> regardless, but I'd like to make sure this is what you are seeing too.
> 

See http://server.roeck-us.net/qemu/mipsel/

config		Complete configuration file
defconfig	Shortened configuration file
rootfs.cpio	root file system (initrd)
run.sh		qemu run script (tested with qemu 4.2.1 and 6.0.0)
vmlinux		Kernel image experiencing the problem (v5.13-9883-gaf9efb8b661)

Hope this helps,
Guenter
