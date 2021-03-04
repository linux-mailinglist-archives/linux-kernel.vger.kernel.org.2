Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3D32D234
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbhCDMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239806AbhCDMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614859247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEBDEyv8TrveK2NedJJMKkQNZ4j88afljnmZycGyFkI=;
        b=hUmESZldxytmXnqTv/kKGm/82inEalVHWAXPiMrwUTJkVhDElHKebgb+IZw0G7UjRvri/8
        LsdtbaEetehow5KLIsWDNIrOerFmJn3cYDi0PIuhKqytHt3UUjfeHLTki/VvaZBvr6UhYW
        a4yEPUcAz/Gk3SYlQxge5HBYNpUYL8c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-X7uIjNeZPmqTmTRAfl6Zzw-1; Thu, 04 Mar 2021 07:00:45 -0500
X-MC-Unique: X7uIjNeZPmqTmTRAfl6Zzw-1
Received: by mail-ed1-f71.google.com with SMTP id w16so3440273edc.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 04:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pEBDEyv8TrveK2NedJJMKkQNZ4j88afljnmZycGyFkI=;
        b=nHAT8ceY6WUgxq212qZ8OkEuDFpyg9yTu6tdvl/jZiIOZOQB06HudtVgiMyKbOXQoM
         2JWj+nQmtX9lpnWEw+TCwAeOGbBAcCTjZh69N+xYLIpTvXBYNOOEOVtW0i89P60Y9jdP
         KnKHzanLcfrDwkv42+MHS0RYxlyFLXl+5VWe73mvU+jHUHtla0q0GnhfkcYASAwvU2Mk
         TrKquSswgc5J3zdfwVEUhHWjaUAaXWFdJt7UOUuSAlYF/dtOf855XpSvhxyfSJ4A9rVp
         7cRFpFOo33kcRtrTb+mOL/STLPgnoamvciQcYL+bGoWIQpZMZmThTF8v3bhJ3tV0WaYD
         o/Tg==
X-Gm-Message-State: AOAM533EhINMbLqwIZhcPizpDmOABfP4jBxLL31fCXo9OIGLIFgkXStD
        dQp+IGockouylodvLc+u1c64ScJWmLuff0cV9OoJY/zxBWOt7ZmCmXapDH3cEe/Lyxfqiox2SgP
        3poO3diMffCA4kX76hoplJgNT3CCppku9/PGgbXaJaZbkFf2RJX8eAiOgyX6U8l+CpSN6PZPYnE
        IO
X-Received: by 2002:a05:6402:4314:: with SMTP id m20mr3787444edc.5.1614859244416;
        Thu, 04 Mar 2021 04:00:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXFGOC9wRMhOoepBZ/LTYuB2zTAbaacuo71IzuGFBbI5V7V7HMKJK40z1JMoWE9Q0ymjrfUA==
X-Received: by 2002:a05:6402:4314:: with SMTP id m20mr3787302edc.5.1614859243105;
        Thu, 04 Mar 2021 04:00:43 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bw22sm23910094ejb.78.2021.03.04.04.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 04:00:42 -0800 (PST)
Subject: Re: [PATCH] x86/platform/uv: Fix indentation warning in
 Documentation/ABI/testing/sysfs-firmware-sgi_uv
To:     Borislav Petkov <bp@suse.de>
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
References: <20210219172835.253610-1-justin.ernst@hpe.com>
 <4b30e296-e4d2-c8af-a920-72a09932d3d1@redhat.com>
 <20210304115935.GC30413@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1f04ce37-203c-b5d4-d642-5e3d84505535@redhat.com>
Date:   Thu, 4 Mar 2021 13:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210304115935.GC30413@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/21 12:59 PM, Borislav Petkov wrote:
> On Thu, Mar 04, 2021 at 12:55:49PM +0100, Hans de Goede wrote:
>> Since this documentation documents the interface exposed by:
>> drivers/platform/x86/uv_sysfs.c
>>
>> I've applied this patch to the pdx86 tree now:
> 
> I've queued it already:
> 
> https://git.kernel.org/tip/2430915f8291212f2bd2155176b817c34a18a2b1

Thanks for letting me know, I'll drop it then.

Regards,

Hans

