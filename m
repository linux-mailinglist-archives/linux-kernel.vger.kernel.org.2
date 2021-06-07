Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4639D8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhFGJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623058019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLG+N8IISSaFXHv3nYYz+LhfYko+7EiBVIOp5Vbf2Pg=;
        b=XorwbapWoPmQ3TijEqvQ4DW0tFJ9+ZVwkiTNsRT4oKzcg+LYveTQcXsMZQVk0cSoUJB4re
        sekwFA0gGTsPQdCPydpcq8DDoCeg7c61tTQVXmTKzdJO75J7Y/gJ6Xe7xXjYT5WI5IDs+T
        D1ZH7V9OecC3PPFlftFHzeZWC8brF4g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-C1-O7D_COEaBs4Kzn6QYcA-1; Mon, 07 Jun 2021 05:26:57 -0400
X-MC-Unique: C1-O7D_COEaBs4Kzn6QYcA-1
Received: by mail-ed1-f71.google.com with SMTP id q7-20020aa7cc070000b029038f59dab1c5so9041449edt.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 02:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rLG+N8IISSaFXHv3nYYz+LhfYko+7EiBVIOp5Vbf2Pg=;
        b=XT3sasysxt1Zncja2WWVqgCide4AZDtMf25lsigAZ93Xq8BQQc49b9QaDorC/61REV
         pCxiQLXZsyb18AmPvnbIDlnTknKy8PiLxJJ8Sc9eW2GB5gNURRduHrK+jmrE9bgNrJSG
         pnn2+w6clJcnP9iK34mUwh8QYdUQUqJ/HxenpwaMWh/IyE4ylVx9QH3fn4cRhegvghhS
         zPhz73eQ7PgpBKFweYV9uIAy/uQb9iW/fzai8Bgww49RM3C+dH7nRo1dYccOlIuf00C1
         kqgZoqiY3WT7N3BfCk9NtTvXniJpOD085K5JqQYTGCgs4n9E7qorkk+c0Ko4h7KEdjK4
         H1Nw==
X-Gm-Message-State: AOAM531//sqh2DmLVrUES6U3GM1QzVnFwIPllLL6M720igfjzRweMU0B
        hWTSF3QXcXEsXQ1gkhSCO/LpNMDacdiuf9PvWiUCclH7P344TfcYhdJK4fpjKvn8kMu9CIUnxue
        GZUJHa+HkwuAv9+sPySkgYXXdsft6BEBRI23G947jhfBMqnvOUvKlT6uXADL+Y2xmrviiEAwwAT
        9f
X-Received: by 2002:a05:6402:344:: with SMTP id r4mr18715832edw.226.1623058016056;
        Mon, 07 Jun 2021 02:26:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFfhavJFHdQ0RKGYOsgN7g81GMm8nIP2xjlhqS5rI+K9scmNRhByfsXa0QCbAO2iTUJkXwBg==
X-Received: by 2002:a05:6402:344:: with SMTP id r4mr18715814edw.226.1623058015891;
        Mon, 07 Jun 2021 02:26:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f12sm2001800edf.72.2021.06.07.02.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 02:26:55 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
To:     Guenter Roeck <linux@roeck-us.net>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs> <20210605005422.GB255680@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <34498620-be3b-7695-8d46-954d7673eeb8@redhat.com>
Date:   Mon, 7 Jun 2021 11:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210605005422.GB255680@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/5/21 2:54 AM, Guenter Roeck wrote:
> On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
>> Hello Guenter,
>>
>> On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
>>> The rtl8723bs driver manually re-implements list helper functions
>>> and macros in various ways. Replace with existing list helpers.
>>
>> I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
>> and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
>> system freezing while trying to connect to local AP.
>>
>> Only a power off is allowed.
>>
>> I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
>> (staging: rtl8723bs: Use list iterators and helpers)
>> introduced the bug.
>>
>> I'm trying to find out what's wrong with this patch, have you any suggestions?
> 
> Some of the iterators needed the _safe variant which I didn't take into account.
> I thought that was fixed, but maybe some locations were missed.

Since 5.13 is already at rc5 now, maybe we should revert this and try
again later ?

Regards,

Hans

