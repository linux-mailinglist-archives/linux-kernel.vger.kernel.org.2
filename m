Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106542DE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJNP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhJNP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dD5eJKWl6u8Q3eVDhZmh0TWejBpBRiryD3uLwCemlOQ=;
        b=RX4XnMXvHEL1nDJMIZ2kMOAvPQDNmZOk531S0CiqNr63rDqritp6/RvdS93M1f3LhFtUn5
        /QGB0TsDgz86W2bE7gj7furEnpSQXyL7qfQuXFBXZH0dq6rEIk3+MHDu8qs7PTPMY7yijE
        zPNwPw+d67Gyp6/qRhGV6Yr3imLC1yk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-oGNeU87aPlWY9gua614bzg-1; Thu, 14 Oct 2021 11:24:15 -0400
X-MC-Unique: oGNeU87aPlWY9gua614bzg-1
Received: by mail-ed1-f72.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so5506901edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dD5eJKWl6u8Q3eVDhZmh0TWejBpBRiryD3uLwCemlOQ=;
        b=bzPLfI4V49lmmyi16RexNrylHvt2+E0rIHnkPLnkI6+FcMQ2wUmSUER/Ed0wYb8cUa
         xeY+406mEqcLYKWTQPxH5DkEqi5vAP080grNOh/KjwaXUk6PczhvjPiurJB64MEZLgxi
         8FUzoKGFaE9EHRqvisNT6IMxsDbUeL9OdGyBkbF3IOHQwFWRL7kUaVw0EsknmZlcWmoE
         +bkghey6pBk0zOYTKTVDU4GRj9EEN9mXOq4gb168KqykIIiL9QmOmOleWh7WcIcYO+xH
         U6ALclRDf+EODPiFoMUxsxd5Xs0pjtsfJIY0fcKMYg3u38c2ghPJpf8/6kEIKhRR0JMb
         aKyg==
X-Gm-Message-State: AOAM533TE2rboiHnvO2A0IcZSdzWrVa+CuLKTKcOkObrMDT0SHCsdOHD
        V9O9McSbEgbyFt7xnf/d4tk4MrhPWukclt2513Vv9XN4zy5K/8mBT2HJyshvyzaYM3YXlaPzSRl
        XSPZIKVwCQkqkYUFfJklpDvMm
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr9266728edd.129.1634225054515;
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz90txXkiw/a/Ag6xrnNLNCQ9RzFwBreiI35q+8iDdAryAu9rkiWD6hDaMbYYbCdJm+Lo51dw==
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr9266713edd.129.1634225054375;
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y22sm2870813edc.76.2021.10.14.08.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:24:14 -0700 (PDT)
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
 <40549939-e4c2-7b20-6bb6-0b5a46731b1c@redhat.com>
 <YWhJ2kmGzNMVY+cP@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <77705ec1-eaf9-efc1-79db-c2c1c03abe65@redhat.com>
Date:   Thu, 14 Oct 2021 17:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWhJ2kmGzNMVY+cP@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/21 5:16 PM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 05:15:02PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 10/14/21 3:40 PM, Christoph Hellwig wrote:
>>> On Thu, Oct 14, 2021 at 01:03:57PM +0200, Hans de Goede wrote:
>>>> +	 * Some BIOS-es contain a bug where they add addresses which map to system
>>>> +	 * RAM in the PCI bridge memory window returned by the ACPI _CRS method,
>>>
>>> Please avoid the overly long lines in your comments.
>>
>> ?
>>
>> These lines are easily within the new 100 char line-length-limit ?
> 
> That is an exceptional limit if exceeding 80 improves readability for
> individual lines.

Ok, I'll send out a v4 adjusting the comment-block to fit in 80 columns.

Regards,

Hans

