Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469B53B6E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhF2GTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231952AbhF2GTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624947430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5rtMzus3P+lVYlXRaQspruCr0CNxzJODyOUb0KYDic=;
        b=cpoeMezfnoENfhmSzCbsIGF0lv5GS95ymaJaFkDN9O3WvO8glBl+bYxkzMK+pH1VaJZcMO
        R8hv3Z4B+uhwJog2hTCgzU8rF/p1sNfJ7jltEV5OsIqlZqw9Fg1nMadyhUnAFHnG1pHZkP
        fg8pbXH0YoQn+v97qGCyQJgQcNTFdvc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-Dz02W7a4MEybPValxCD4Qw-1; Tue, 29 Jun 2021 02:17:06 -0400
X-MC-Unique: Dz02W7a4MEybPValxCD4Qw-1
Received: by mail-wr1-f70.google.com with SMTP id g4-20020a5d64e40000b029012469ad3be8so5310457wri.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 23:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5rtMzus3P+lVYlXRaQspruCr0CNxzJODyOUb0KYDic=;
        b=ZlXdywjPn4pB4uFcsjoH/a7KbDkhGD0qZ1eiNPR5t61KttgHLNYy46r9h1qKG0Eyts
         zTMXxMZcQG6usTmGOfWLklUpRUwmqoNMUr3dTNggtdZ+28AZ9EqDQXL3vzuzj0GjJUTn
         n3vRYGuWHastjKKyd9tIa/EO+Xmqd12wRVf5+8L8RLjQ82IVKw++TKmjr/nQZ1E6Qzv/
         hXQy4NGsx2O4NP25sPhNrcZc23UI8UOXBjPKq4iXBrUxuXz6KBCLr2+RVCZig+4Oosmz
         JIqS1PCipORQjJ9IDi7txks7xDk6fZxdliWRQmanq444f27iEo2NrKmbZ8DE+5wX62vh
         N8aA==
X-Gm-Message-State: AOAM533keNq4NtMgYXLkqFzIDq3GqyO9uf6dwp7c6szXwphPkbk0fly+
        5tqytcr0PA0TrjE67Sw6Zm29M6ISffhUOvKBk9dvG5tFvQ7SQVCEC40Ic5+46P3NtaIR5+z1YDS
        VkGbLGjJvAuldCII+9koBy4gg
X-Received: by 2002:a1c:9884:: with SMTP id a126mr9898381wme.59.1624947425626;
        Mon, 28 Jun 2021 23:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwENZ0HLqQb4ZwkvvzpA0iQ3ffLbLA5shQGhTj0xUToPMfioID+ETv8jiuPJgiveOwkf+pTyA==
X-Received: by 2002:a1c:9884:: with SMTP id a126mr9898344wme.59.1624947425375;
        Mon, 28 Jun 2021 23:17:05 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id h8sm1801392wrt.85.2021.06.28.23.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 23:17:04 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210629003829.GA3978248@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <2317a4bc-bd4d-53a7-7fa6-87728d5393cd@redhat.com>
Date:   Tue, 29 Jun 2021 08:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629003829.GA3978248@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 2:38 AM, Bjorn Helgaas wrote:
> On Thu, Jun 24, 2021 at 05:40:40PM -0500, Bjorn Helgaas wrote:

[snip]

>>>
>>> So let's just move all the IRQ init before the pci_host_probe() call, that
>>> will prevent issues like this and seems to be the correct thing to do too.
>>
>> Previously we registered rockchip_pcie_subsys_irq_handler() and
>> rockchip_pcie_client_irq_handler() before the PCIe clocks were
>> enabled.  That's a problem because they depend on those clocks being
>> enabled, and your patch fixes that.
>>
>> rockchip_pcie_legacy_int_handler() depends on rockchip->irq_domain,
>> which isn't initialized until rockchip_pcie_init_irq_domain().
>> Previously we registered rockchip_pcie_legacy_int_handler() as the
>> handler for the "legacy" IRQ before rockchip_pcie_init_irq_domain().
>>
>> I think your patch *also* fixes that problem, right?
> 
> The lack of consistency in how we use
> irq_set_chained_handler_and_data() really bugs me.
> 
> Your patch fixes the ordering issue where we installed
> rockchip_pcie_legacy_int_handler() before initializing data
> (rockchip->irq_domain) that it depends on.
> 
> But AFAICT, rockchip still has the problem that we don't *unregister*
> rockchip_pcie_legacy_int_handler() when the rockchip-pcie module is
> removed.  Doesn't this mean that if we unload the module, then receive 
> an interrupt from the device, we'll try to call a function that is no
> longer present?
> 

Good question, I don't to be honest. I'll have to dig deeper on this but
my experience is that the module removal (and device unbind) is not that
well tested on ARM device drivers in general.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

