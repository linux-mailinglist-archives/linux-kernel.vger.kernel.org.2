Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1868C42DDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhJNPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231915AbhJNPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634224505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiT5rDJKYBUUykrwFXpiEs/xoKF/YdQLNIch3J6+wz8=;
        b=MwvKTRTbTmgh5HxIkNk+YkI7GtEqVFb8lzlKVAJw+njvf03fHpjEB83E4hMiiz9SwZoAU8
        djXiY/roxITFUuqak30GzHg0gBuTFpbLqaMO3Hjq280GLgtQBpt02CSpM62cfAKezosu8n
        F752Z+3L47Njko7Z9EfDkxSN3SQP9ck=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-p8Ns_88JOGaBhQRyipmqqw-1; Thu, 14 Oct 2021 11:15:04 -0400
X-MC-Unique: p8Ns_88JOGaBhQRyipmqqw-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso5405406edj.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiT5rDJKYBUUykrwFXpiEs/xoKF/YdQLNIch3J6+wz8=;
        b=AI0LYgudSnHgLy59fESCI3EVwoIAtlffl0JRAgX+/V6bLsTWaCDZh+oclgUvYsavMK
         /ZLbk/fPyU4FX3ZlfKYCJ2viRW70MEO2Z3lv0Vz6ayn+PKxWtuXKxWlXmwHf4f4TU94J
         xwzhStWvAe6wZamxUmHtdi18P8BZyjHsv+avjr2OIEr6EBU8pIuSIZ7Yukm+u4DdzcjK
         W5iEIgLmNAeLk1wT4GfXblSlDPc6dlVGF6m9K3hWM4fn3gBjCpWCr2UQF+ixfZ0zzzDp
         MlaHnfl6WFy/z68Gm28sJtlJ6AnQLxJTr1NM8Sh3cbSIJ5Nu9Xn82XSs5uav+dRBjsom
         Qh7A==
X-Gm-Message-State: AOAM530WvVXu3EfOw1EjCr37xCono/ZIFqonAc1TnnqFArL/WRPuWq/e
        2jZ1gyrFeJl5SEZxXl9WoNakrh2UNRaEnCdoyfHKGMk7z35q2S40qCLMNRM4SLSwqe+5c//ebQG
        cUwxwD+D5qoHg62Ce19YaR+5y
X-Received: by 2002:a05:6402:2748:: with SMTP id z8mr9603727edd.25.1634224503462;
        Thu, 14 Oct 2021 08:15:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypsBtx0K0OiLkQTrKhkIbAXO5KzgFiscNLWrrEbZFb3hhq8Gefzfok7Xd44WnydMsyfqxfJg==
X-Received: by 2002:a05:6402:2748:: with SMTP id z8mr9603697edd.25.1634224503314;
        Thu, 14 Oct 2021 08:15:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ga6sm1924886ejc.87.2021.10.14.08.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:15:02 -0700 (PDT)
Subject: Re: [PATCH v3] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     Christoph Hellwig <hch@infradead.org>
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
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211014110357.17957-1-hdegoede@redhat.com>
 <YWgzaa9Z4elzoRwL@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <40549939-e4c2-7b20-6bb6-0b5a46731b1c@redhat.com>
Date:   Thu, 14 Oct 2021 17:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWgzaa9Z4elzoRwL@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/21 3:40 PM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
>> +	 * Some BIOS-es contain a bug where they add addresses which map to system
>> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method,
> 
> Please avoid the overly long lines in your comments.

?

These lines are easily within the new 100 char line-length-limit ?

And checkpatch also does not complain about this.

Regards,

Hans

