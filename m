Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9371B33F542
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhCQQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhCQQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615997740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=Cqx48kfLUHj7JsLNjDFoEv/SE/yTZBA+itUoSvZCmR3cuycCtBqj8XKlfpjIOcdkz4dBDm
        KMc9fHSQVnKpLO1/OU8/TJZFMg5kE/cBzDuvH9l3rRMpMF9toIkoyqhxHZUGcEyHYdWeRt
        xOzpKpFBOXCQJgUjSii2Ojux9O6otKU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-bYeg9E4aPrWRSNc8LxCIbQ-1; Wed, 17 Mar 2021 11:02:15 -0400
X-MC-Unique: bYeg9E4aPrWRSNc8LxCIbQ-1
Received: by mail-ed1-f71.google.com with SMTP id w16so19531667edc.22
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 08:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=a3GW0w2KAiqrY4w2Ko5gtGmY9w4eLJjHv3kLEKGGfobd7S4gPVL/MfKNOi7xI8ciFs
         H1FSvnSONzsdBDX1OQD1014MA2spwaE3g9qEOEgc7xDYU5f56BKzTZ12M9g25C+GK3Qb
         AikXAdrf1Tdy8/VE4rt5ROWm7M0NI0pfmM1PrDaLA3LoDvvGDjYjuNJp+K/Fj9tHsiGx
         RMEXOwPqITwyNHjQXQs28fZ8SZSFp0BZvUguRw6pNyKBM5jUAfJQScfDZ/EVSATaB1tK
         O1nO9AyRaeRZwpu1ekhZLLqSnr3FP5+xHb1fTlNroo9HHspT6lIqLe0D4ijh7mg9iASu
         k4lw==
X-Gm-Message-State: AOAM532Ntw66GoWk7RSpHMKSy9TDQsZeLExgCiyhI+OOcnu3VsRRUJr/
        rHOv0RRn78rI8TcpeAkkO1W+fcAGJ1Pm2T+/dOO7mkWddv8wuu2NtGC+QiTX9UCP1hbXXlW5wV4
        ImA15r/FbMN3//JiG+wSGnzsj
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34755177ejx.386.1615993333375;
        Wed, 17 Mar 2021 08:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQOWxYb9DN6Byzwidr3K3+h7DNGVqQ1iESvq0wrLG4Q+s+bR01GCCD8HQlPCDgUoZNePvlQA==
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34754705ejx.386.1615993328232;
        Wed, 17 Mar 2021 08:02:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lu26sm11531097ejb.33.2021.03.17.08.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:02:07 -0700 (PDT)
Subject: Re: AHCI SATA Runtime PM
To:     Alexander Monakov <amonakov@ispras.ru>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org
References: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f74cdf09-c08f-5cff-e046-2729aeb703be@redhat.com>
Date:   Wed, 17 Mar 2021 16:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/21 4:34 PM, Alexander Monakov wrote:
> Hello, Hans, Linux PM folks,
> 
> I'm looking for clarification regarding this patch discussion:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/20180420101834.15783-2-0v3rdr0n3@gmail.com/
> 
> Hans said,
> 
>> Ah, so the AHCI code has runtime pm enabled by default (so there
>> is another pm_runtime_allow() somewhere, but then disables it for
>> unused ports to make hotpluging something into those ports work.
> 
> I have a laptop where two unused AHCI SATA controllers are present (but
> obviously nothing can be hotplugged into them). Apparently due to the above,
> they do not enter runtime autosuspend.
> 
> The problem is, these "ATA port" nodes don't seem to participate in udev
> hierarchy, so it's unclear how I'm supposed to automatically re-enable
> runtime PM for them. For PCI device nodes, I have
> 
> ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"
> 
> but ata1/uevent is empty, so there's no obvious way to write the corresponding
> UDev rule.

You can enable runtime-pm from udev using the following rule:

ACTION=="add", SUBSYSTEM=="ata_port", ATTR{../../power/control}="auto"

> Prior to discovering the above patch discussion, I have filed a bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=211837
> 
> Does the above correctly reflect how AHCI PM is supposed to be?

This is a complicated question, I just checked and according to:
https://www.intel.com/content/www/us/en/io/serial-ata/serial-ata-ahci-spec-rev1-3-1.html

AHCI 1.3 compliant controllers should raise a PME signal on hotplug
changes even when in D3. So perhaps the solution is to catch this signal
and then wakeup the controller; and remove the pm_runtime_forbid(dev); call
from ata_tport_add().

I don't have much experience with dealing with the PME stuff, so you will
need to do some research there, or perhaps someone else can help?

This seems to be more of a sata/ahci question then a generic linux-pm question
though, so I have added Jebns and linux-ide to the To / Cc.

> If so, what is
> the proper way to enable runtime PM for unused ATA ports?

Regards,

Hans

