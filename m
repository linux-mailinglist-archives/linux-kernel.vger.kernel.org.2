Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAC42EA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhJOHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236271AbhJOHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634284403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSCdihYmmS0IN1GmuVO1Ycrr/Th2rhDypmITMXSUWgM=;
        b=SU3BX66towafNnIq+UcQdCeJ0oKY5/o02T7rr7p3tA7SPvP1gUjG3xeTCIJY2VxSWvG3NL
        DL4B7f/WG8mqfIPcvplOxAHMlq04xygzJ7JI+hlTkDrMaQyv4tQK3LFjAi0A7L/20uWznF
        AgOM/Eyv43PpbSm0Ld0dZfkHLhMDFX4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-4KnnprpcM7SHEAga-fGv_Q-1; Fri, 15 Oct 2021 03:53:21 -0400
X-MC-Unique: 4KnnprpcM7SHEAga-fGv_Q-1
Received: by mail-ed1-f69.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso7475963edf.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSCdihYmmS0IN1GmuVO1Ycrr/Th2rhDypmITMXSUWgM=;
        b=PaUEpK7+yxWZ/HFuWgQG6o3rwp22OMBIynGrhgHZ/k2oWvbfAoJ/hALHL9w2cdCGeu
         LpWyLp3aEB1YxLndw1UIALW2d/FPUytRGtsDyl7Mmtw7C+G2fu8tLpe1cDAUCJC+18U4
         pznBWwkTK+a7JxC1ohMIGcGIZDazaUbU6GNBtad7v8ouMjGPnhEM+xOpvuZpgfDhoess
         /lSAp1itqRGdTO0vGOGHvfXtqoJyZ+ZI65Gs2DzuYOB7RYzElNp1arZNZiEfhkzF60jT
         jHTK69Xb1AsgALL0fizZCwLpaJQbi0iJbkJkg1LR4rnaG4JQc2OHnGm9T6TsirJ2ErAK
         tOhQ==
X-Gm-Message-State: AOAM530ISzaki9pjky99UKzSKsI66VyHTAu2SHwgdcSBL9rQbKKdQwyG
        hhNk++nwyn/j3U4hJjwDZ6OU3sbcWI0oQP81eSOyqiC+3d3jFm8UYSvqWyfhyhtcZIF8XQosB0F
        pO3+gH/Q1miNWkDXblooneZjyvAPdwqckiHiD2inuBvGNXyWlAASQdfY2UBhfq/qzmd2EVlyKzJ
        ed
X-Received: by 2002:a50:da4e:: with SMTP id a14mr15562008edk.154.1634284400348;
        Fri, 15 Oct 2021 00:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKwzRN7rZPYuvP0ikraKZR0NQIEUYRQJlDmLs7FqK/noKjG07rVbr2fRTQwVGXutgUYCgiRA==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr15561982edk.154.1634284400178;
        Fri, 15 Oct 2021 00:53:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a9sm4080539edr.96.2021.10.15.00.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:53:19 -0700 (PDT)
Subject: Re: [PATCH v4 0/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211014211104.GA2048701@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8761ccf4-ee6a-348e-0d9f-531adc5dd73a@redhat.com>
Date:   Fri, 15 Oct 2021 09:53:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014211104.GA2048701@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/21 11:11 PM, Bjorn Helgaas wrote:
> On Thu, Oct 14, 2021 at 05:39:07PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v4 of my patch to address the E820 reservations vs PCI host bridge
>> ranges issue which are causing touchpad and/or thunderbolt issues on many
>> different laptop models.
>>
>> I believe that this is ready for merging now.
>>
>> Bjorn, can you review/ack this please ?
>>
>> x86/tip folks it would be ideal if you can pick this up and send it out
>> as a fix to Linus for 5.15. This fixes a bug which has been plaguing a
>> lot of users (see all the bug links in the commit msg).
> 
> FWIW, I think there's a v5 coming.

Yes I posted a v5 yesterday evening (CEST).

Regards,

Hans

