Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C942FC25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbhJOTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235059AbhJOTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634326092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHgVsI500xUtFvvJhND0q9V1AUlhJG7wr9pcaJspSiE=;
        b=huHEqXediGnG9fYFAPjwMs+ib7hZTClXil/dTDQItu4wD5UpzeKXXAkCU/t8KsmHNLrvDx
        aFC+PKp/YY2Q57qUZJEJDAPzqx4rrWL8+cmEHn9OjlqZWSSeVR388sRXH1kM9sUzajKAOi
        O3wGxjyK706IdjXYEXVJRQnB+MXiPrw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-60FswXuTP_6lYADkPF2sWA-1; Fri, 15 Oct 2021 15:28:10 -0400
X-MC-Unique: 60FswXuTP_6lYADkPF2sWA-1
Received: by mail-ed1-f71.google.com with SMTP id x5-20020a50f185000000b003db0f796903so9142387edl.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DHgVsI500xUtFvvJhND0q9V1AUlhJG7wr9pcaJspSiE=;
        b=CGa4W9DsihSwSeQjTyGnCYN3j7QYvwGEWnoVvTDzD9SqyGTq5V7P04M/Alkgsmr/vJ
         2ALDIQFmt/7fdQHz+dbid0PJAekAjSTy4iPDVHGWeaUojPNsS+c1IpeScZdUYxBfEmlD
         ARkWxB15jDE7R3AFUacCUI+jR88yKimd/LjPVh78WpKTQbT6i+kZIgQGvYEXrqIVc4Jj
         gDv0eoVzgZHzr/FMcjS3+X40KaepY3//6uwwqn+yup9OSYwAoUVfoEs525pXww/X6jRO
         Y4GT2Zzlx9TIOCwX2rHidLseTrd5c+lPFPHw1voN6TTkVvMvc++HZpVwMBgaOoa+sO3m
         8rOQ==
X-Gm-Message-State: AOAM532gm0/X+7NGFg3s6/gMl9yUgWx5Mz9Be9qGgkp77u+Ts/rne1Mj
        AItte5oNmXYSLfxvEOJdq0Jk8QIeDck3Uhb8NVve6mFEiDofJW8XT3TWiLMvC/O4A0xm5UHJ9Zn
        LV8n1hO9msWHVZecbE69wLoY8
X-Received: by 2002:a17:906:270e:: with SMTP id z14mr9053741ejc.414.1634326089360;
        Fri, 15 Oct 2021 12:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy99ctIGjGxXAO5TNTGMcJ4devw27O3hL7cIKeEZl4TN6Opbo3iCGN5jicyxAP/sXDRjcROAw==
X-Received: by 2002:a17:906:270e:: with SMTP id z14mr9053711ejc.414.1634326089206;
        Fri, 15 Oct 2021 12:28:09 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id x22sm5218355edv.14.2021.10.15.12.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 12:27:54 -0700 (PDT)
Subject: Re: [PATCH 05/12] regulator: Introduce tps68470-regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-6-hdegoede@redhat.com> <YWQU/SYTT5Vk24XH@sirena.org.uk>
 <f6f2d7e8-fdb8-ed64-0cdd-65aded9fc42c@redhat.com>
 <YWmwZJvDYjPWJdb4@sirena.org.uk>
 <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
 <YWnPaI/ZECdfYre9@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <843f939a-7e43-bc12-e9fc-582e01129b63@redhat.com>
Date:   Fri, 15 Oct 2021 21:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWnPaI/ZECdfYre9@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/21 8:58 PM, Mark Brown wrote:
> On Fri, Oct 15, 2021 at 08:50:13PM +0200, Hans de Goede wrote:
> 
>> Are you happy with the platform_data for this driver as defined in
>> patch 4/12 ? :
> 
> Some of the other review comments lead me to believe that you'd be
> sending out a new version at some point?

That is correct.

> 
>> https://lore.kernel.org/platform-driver-x86/20211008162121.6628-1-hdegoede@redhat.com/T/#m745cc1191f531a57ae7998f5c8817ba9a46f0fed
> 
> I am very confused about why it's in the driver without a DMI quirk
> and/or clear comments about why and saying that this is a terrible
> example to copy.

The DMI quirks live in the ACPI glue code under drivers/platform/x86,
that code instantiates the MFD cell and sets the platform-data
as part of the cell.

> I'd also expect to get compile test coverage for the driver.

Ack, Stephen made the same remark for the clk driver. I'll fix
this for the next version.

Regards,

Hans


