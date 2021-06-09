Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD33A1736
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhFIO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236316AbhFIO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623248821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWskz1tpoE2n45qyKiTGnaNgZEHi4b3U+rlmrEUOMgM=;
        b=EN/KhWzN24Rpi3HTLzQio5Rg8yRyiXkGMtop0fS4lwHW82+AZq50XF7MEErP5h2ORqiVEG
        3/ds74IjMqqJFQ0xhvr/OYfGujoUokt6LO7rRnQUXAuZf0I39kQouFh8dybHBUKE+Fli9s
        j4vIh1wtN8yLLxWoZfC6H+uVVZiJb0Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-GkpUgjr_P6K26pRBhRGxLw-1; Wed, 09 Jun 2021 10:27:00 -0400
X-MC-Unique: GkpUgjr_P6K26pRBhRGxLw-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so8113182ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dWskz1tpoE2n45qyKiTGnaNgZEHi4b3U+rlmrEUOMgM=;
        b=AF3LQ86tvwtjF6UDp6+WG9w7m3FwVq/fYo741ljzh1f75KPcbhwwfJjZLvtphoeSsm
         5TpoMSEunYqNsrqO3gH6C87qDV7YkVQK+EbYvXakNCrQRNiL6ePAwOFdHeQFXpppnz8B
         e2OeXhJtkgjUj3R3RrIBvZMYGrFrx7vfsb+4Rfq26tffQUQeTrYbYz4CrQrP4/DQKF0T
         0U9Ic2m2KiJzHp2s9zg7tSv5yiLnkgr7kmi96QzDiIfwOk1KBbNzA+i8zXZMCLNSjHC9
         1RgUVyBxeG0Ccz4PimGv8sjrwpatR1NWc+4p9lFe03LGvls90tCZj+J69nqQ0Yl5XFya
         jxGQ==
X-Gm-Message-State: AOAM5333ak7p5xYsn652aftf2bdMV3dApStaGTzEtgC30CWhRx9Q4JmG
        dbJsAfoUA9+Xh8GIFDv9/r085lLsb9NwmwpwmIWCMLSrxAIGnyCOsA1yYCNsvRb6uS9/2c4O/eA
        cRv86Zhpl0ohDjgcvqWRQ6S6z
X-Received: by 2002:a17:906:bc2:: with SMTP id y2mr102546ejg.489.1623248818893;
        Wed, 09 Jun 2021 07:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Ifm3foifqY4kzazj+RDwjAzoIvaLRrU5gP8J1FL48CV04hAwHGui12uCt0VCCwkDpUd8+A==
X-Received: by 2002:a17:906:bc2:: with SMTP id y2mr102534ejg.489.1623248818778;
        Wed, 09 Jun 2021 07:26:58 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l11sm1213511edb.3.2021.06.09.07.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:26:58 -0700 (PDT)
Subject: Re: [PATCH 0/4] platform/x86: Constify static attribute_group structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e6d3ecf9-c664-4fba-aa93-773fa054783e@redhat.com>
Date:   Wed, 9 Jun 2021 16:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/21 10:38 PM, Rikard Falkeborn wrote:
> Constify a couple of static attribute_group structs which are never
> modified to allow the compiler to put them in read-only memory.
> 
> Rikard Falkeborn (4):
>   platform/x86: hdaps: Constify static attribute_group struct
>   platform/x86: intel_pmt_crashlog: Constify static attribute_group
>     struct
>   platform/x86: tc1100-wmi: Constify static attribute_group struct
>   x86/platform/uv: Constify static attribute_group struct

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

