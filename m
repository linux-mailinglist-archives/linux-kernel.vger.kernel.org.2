Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8242FB71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbhJOSw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241634AbhJOSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634323818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHfGSkfyITaAcF7om32Ui+A/Q+/7gvnw6ydE61yiLsg=;
        b=F13VJRr00MHregXIG7tZ5+2Ccg4qRnuPPAdyivqtuXBYyPT1yUhUBq5yMKUnAJkSoXuByi
        /8k/x7idEgM7zk9KRvandghaunASebjlVbqoN7M8Z9nKYvHc6nRkko+VQFVAdhpPnCyZ0x
        NHWZTdVdZNn2UC+mccUqNUyyabT4ZHY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-TfHqOwEaNcebeZJaA4bXWQ-1; Fri, 15 Oct 2021 14:50:16 -0400
X-MC-Unique: TfHqOwEaNcebeZJaA4bXWQ-1
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso9062746edf.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EHfGSkfyITaAcF7om32Ui+A/Q+/7gvnw6ydE61yiLsg=;
        b=jaPAK6bEomrznK1vsgmUswgca4zw50AUXs6qMW0/LghG5TSfxBEV9QVQ9F8zQAZbXJ
         47a3nEiLd5yO+oHJ+ixYFIfvTexe04R9p5waM2sNAbhZfEpfGmkmPCVNoluCZjlxc3KO
         kv2aXu///Q1AKexm/cP7WDsACX4Q+wxu9c2qG7EWJgNQpy8LkMUTv7PwMkW1xpva2Thn
         2NgLCMm+DCD0U2zsqjVchB2yUTASnydoPrNlv8Tw0l2qtJKkZeaQZgOnQlMA3iPyES33
         TxpAJV/oEk7Z9gICWKatx6XQ+CTQeu008HoOOuqk/0My1ZFVZKT1AjGRQ7ZGkc0PLIBA
         Cm/Q==
X-Gm-Message-State: AOAM531X1zLTBTUpkaspsU0vU361vL6XKzvEpm24Qmj4pLm4rXjUfN58
        /WgnS+Sp6cpEiyXDb5JAR5oIoXA+M3Zx190nMvrGfESr9aUBt3Ddg27PViiJxq6BB+U1Q8mFVTI
        0A1NvNfjTCfYCssDTmCzTo4BN
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr20443376edb.164.1634323815637;
        Fri, 15 Oct 2021 11:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWKLjhazEuITCXuU+qImt0nHN0zG7Ko1ArJLNonRV0jHASMc9XlxAIb6Ck1PU9RNfUcFNuRA==
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr20443362edb.164.1634323815517;
        Fri, 15 Oct 2021 11:50:15 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id fx4sm4637655ejb.113.2021.10.15.11.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 11:50:14 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d0d1dc05-4cc6-2f47-88a9-700cfc356d86@redhat.com>
Date:   Fri, 15 Oct 2021 20:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWmwZJvDYjPWJdb4@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/21 6:46 PM, Mark Brown wrote:
> On Mon, Oct 11, 2021 at 01:43:40PM +0200, Hans de Goede wrote:
> 
>> To make this work when everything is build as a module patch 12/12
>> adds the following to the PMIC-MFD-driver:
> 
>> MODULE_SOFTDEP("pre: clk-tps68470 tps68470-regulator");
> 
>> This will make modprobe load the clk and regulator drivers
>> before it loads the main/MFD tps68470 driver.
> 
> I feel nervous about this being reliable with all userspaces - IIRC
> there was an alternative implementation of the modules stuff in
> userspace and someone could always be doing insmod.  OTOH without better
> in kernel dependency management and/or more standards based firmware
> interfaces I guess we're stuck with this.

Right, this is all less then ideak, but I believe that this is the
best we can do for now.

Are you happy with the platform_data for this driver as defined in
patch 4/12 ? :

https://lore.kernel.org/platform-driver-x86/20211008162121.6628-1-hdegoede@redhat.com/T/#m745cc1191f531a57ae7998f5c8817ba9a46f0fed

And are you ok with me doing an immutable-branch based on
5.15-rc1 with just the patch adding the platform_data
in there ?  The platform_data is used/shared by most patches
in this series. So the idea is to have an immutable branch
which can be shared/merged by all subsystems which have
patches in this patch series.

Regards,

Hans

