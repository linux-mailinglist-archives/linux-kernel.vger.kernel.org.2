Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD2309836
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 21:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhA3U3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 15:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231903AbhA3U3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 15:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612038468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCzTXndvO6PUCmY4kSZIvx2ZZ5a0W/Jzz1ojxQurW9o=;
        b=Q7Li6XMNALV/M2caQ3VVhbUdvZuOs32gM4UZLGz4YcTYbq+wd5nZj1v14zxCEsrZOhgSbT
        eYagB19YO49gPMdbwS0oTSzxWZfDpuoKZydEsq5PtZ91+PnIAitvHr101DEBRuiubPDq/f
        kQrgM52A5Vb7/1uxC7rOB1cRJmE0IRY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-49cRX9A-MuOGkYL3qr2FNA-1; Sat, 30 Jan 2021 15:27:46 -0500
X-MC-Unique: 49cRX9A-MuOGkYL3qr2FNA-1
Received: by mail-ej1-f71.google.com with SMTP id le12so5853597ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 12:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JCzTXndvO6PUCmY4kSZIvx2ZZ5a0W/Jzz1ojxQurW9o=;
        b=BRy4qGK6GhYOh2clH0wCBGF4z8RWAWVB7LAs0rVPJimHbK0LjqBb1D0Uu0ei5XN232
         SQIrKA2NpJ9f2BTvnwZQaM7bTYBEGNGAtaiGwg/ZtuEmKDmYDzWsaYVr6A0F55fVLnfC
         +l3PApQ7ckZ52KSKNC7/2N/hLwgXfQYg0DZE/aZnheucsMl4xtNlT23wgGSqY1jjO0X3
         K7Bsg3HWq3pgRGLdbQ/2QaUXLhTWh26wxBYzXr0ci0HomK/k6hVAf4yOD47hWWh8hygS
         TaoJqdux6lJmf6+V0+/z/I6VFhT/uEo8WWs0/H5p14cBfqYeZfZggO26j9hn0RQ+/ZTl
         2jiA==
X-Gm-Message-State: AOAM532G5R1q8E8tR2GTMlZpgSbtcwR8pl/BdnimEIDz3sVqqCnm3Yjp
        t0WB3kjQe4LsX0OyRVHJeWo1oOu0nZ4b+5tdTA/G/LcMmqfBFArooY0s4HsMj5T9TfrJMFaJH1w
        cLej4t7LnwOFb75/QlXteGolAZcdN3AxvGDx7ohUgHBzFKszPL1dD1SSmAzdEOduKMwWjxdlduW
        yK
X-Received: by 2002:a17:906:7c4b:: with SMTP id g11mr10446952ejp.475.1612038465377;
        Sat, 30 Jan 2021 12:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaO95mOA2n0ZugO4ADrDuX4NF9Msehjm+Ssg5gvE+5YTUmMoNIdPDh0Rv+ywbXdR6FmC1zjw==
X-Received: by 2002:a17:906:7c4b:: with SMTP id g11mr10446944ejp.475.1612038465211;
        Sat, 30 Jan 2021 12:27:45 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id u18sm5651498ejc.76.2021.01.30.12.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 12:27:44 -0800 (PST)
Subject: Re: [PATCH] HID: logitech-dj: add support for keyboard events in
 eQUAD step 4 Gaming
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210130191027.1225465-1-lains@archlinux.org>
 <265604c19e2e875ca17e4cf713000492b9ffd8d8.camel@riseup.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a3aa6fb-3f22-d6f5-1748-42430f6e7ccc@redhat.com>
Date:   Sat, 30 Jan 2021 21:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <265604c19e2e875ca17e4cf713000492b9ffd8d8.camel@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/21 8:14 PM, Filipe Laíns wrote:
> Hans,
> 
> You added support for non unifying receivers in
> 74808f9115cee2bb53e7161432959f3e87b631e4, could you please test and make sure
> this cause any breakage with your devices?
> 
> AFAIK, they could only break if they have a 0x01 report which is different from
> kbd_descriptor.

I don't have any receivers hitting the "case 7" which you are modifying,
so I don't expect to see any effects of this change on my hw.

Regards,

Hans

