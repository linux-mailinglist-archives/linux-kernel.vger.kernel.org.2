Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0B382C62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhEQMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhEQMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:42:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051AC061573;
        Mon, 17 May 2021 05:41:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n2so6309721wrm.0;
        Mon, 17 May 2021 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BKNJl3CTQE28crMB0S78wwTNmE04FcrERIrJTJfVd0M=;
        b=oe11LZD8Z89/2QV1wc8UfsBaXBmHTuWNzQy6Ciq7eLKIaEJxpM+/1jU0jvJ0Klu/R0
         UnciIN6GN1C3cbNBcovv4y/mD1CREbFipgm8L6NvimEU7rXc+MKCJn4Fsq+ovcU7h7Ho
         GLYEQ6jUTljNT0qex3aDZzSHmeDuv1u/tpQUfYgA3E1ERG2EMojNXidzHLFkQ/yrFyzy
         8cVH+OgCRDmT3doMa90owDV7MydqZEFEvHCj7pF5BoeeTx/Nbl7nmM8ucag6Rf1vQ+Ja
         WRAOKQQp+uVzgT0aE4yY/JRty2IeC8v+OeHwFKlrvXL1ZKKk8i3GIpTvTvUwDT9v0NY1
         5uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BKNJl3CTQE28crMB0S78wwTNmE04FcrERIrJTJfVd0M=;
        b=DgiWLC5/mCVI+2vSXHf0F6W0JUESGn+SmkyVhGC46Wf67mZE4QWKdmWjj0sdAAmqQx
         yx/66PR8fBsg1atoQSNf7LyQPBN/QHtx7Joi89bzY1C4JujZIrvQ5iUne4KJn1bvZrdL
         C7sguEuuZKwf9Za0ORcao8QoNZ9unLZsmVtM3bap2PUYCOl5tNjKlJizO6izpILhxTNe
         kDGgBdNQbJ36l870aYxaEi6Cz+nodpOD4cphAffeN5fnKSysC1GFWC5WWo6s8Jbo5n4x
         /3XLZqySYqj9QIOCc5I//ouweNSCEwo5oF1TjlPSLUK6wQnnnA1QdN4cXChzN+A8wUt0
         AxDw==
X-Gm-Message-State: AOAM531OpGQ/ojV2lCqbcdDlG5hJBP5LUV4YRqUH585g9IR21s6RncrS
        YGF8F5BSdNqOCQ/Ec6EjeGM=
X-Google-Smtp-Source: ABdhPJy0h52zOnwMVwH1jVnDJGtacl2aMdeHtLVP8df7Ljacm8z7uCJU92TsR4afYlioEP1UVrUJig==
X-Received: by 2002:a05:6000:52:: with SMTP id k18mr16210709wrx.419.1621255261294;
        Mon, 17 May 2021 05:41:01 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a577.dip0.t-ipconnect.de. [217.229.165.119])
        by smtp.gmail.com with ESMTPSA id k9sm14723984wmk.5.2021.05.17.05.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 05:41:00 -0700 (PDT)
Subject: Re: [PATCH] [v2] platform/surface: aggregator: avoid clang
 -Wconstant-conversion warning
To:     David Laight <David.Laight@ACULAB.COM>,
        'Nathan Chancellor' <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
References: <20210514200453.1542978-1-arnd@kernel.org>
 <057b5568-c4b8-820c-3dd7-2200f61a4d58@kernel.org>
 <16280aaedc40425295d202431ac3adc0@AcuMS.aculab.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <eb2f2897-6e94-7fc3-fc9c-d48285c4209a@gmail.com>
Date:   Mon, 17 May 2021 14:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <16280aaedc40425295d202431ac3adc0@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 10:31 AM, David Laight wrote:
> From: Nathan Chancellor
>> Sent: 14 May 2021 22:23
>>>
>>> Clang complains about the assignment of SSAM_ANY_IID to
>>> ssam_device_uid->instance:
> 
> Has this been raised with clang?

I believe so, see this earlier report:

   https://lore.kernel.org/linux-mm/20210311185154.6uysryumfho73zlb@archlinux-ax161/

Regards,
Max
