Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66FA3E5BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbhHJNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237223AbhHJNh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628602625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LDlPss9QRTaBr474xlXhjE3rgK4GGCgbW9ZnFPF4VA=;
        b=Wnq1QCh5gHGKKekL/hvFPHiVmg3zyicHZrN/pX8y0Fu0LP9I2thhpAL8WoX/dphEqkHKTP
        ApFPEjjcsnKzknZQAtVuMCOroq69X8sTW5K6tYJFXVA6Mlf7v2AZlZRV4AVY2lJGE17q7g
        iadaLBQcaS90DNfgxfM8ppG7BL0YVmo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-DHu_JRabNtWV-7h44uxBDw-1; Tue, 10 Aug 2021 09:37:04 -0400
X-MC-Unique: DHu_JRabNtWV-7h44uxBDw-1
Received: by mail-qv1-f70.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so15383296qvt.20
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2LDlPss9QRTaBr474xlXhjE3rgK4GGCgbW9ZnFPF4VA=;
        b=Cp+GwRczCkdLhQv0HzMv6x7TWiYXWVU4lhvKZLAmHTLPYomcCOsiAta1WT5frg4eKg
         bslQQO0C2Cg/lD18ek6VtZLupdeXHSxkxKY8izPOfrd+dyl73JNgTLnq9mHTB8xYTwcd
         Qz1GsMn/WEn1Rn7Cf6G3maR+UmwDM1kxzTvgkrHmpffKXbsyk/RmuwbjcogLys8T4xPA
         WUh4cLmuRNdIKoA+E6KsoY8sgQh92/C6nAQHQ0gya/lyzPrDAUBlqBhqLl8B02SBLGfR
         mgGl1N6H8/MeeUHk2GCSlgUjsJqYuL1KTxFJwoVX7nQK3f28hWoORvVYjYOCVPUX5QJa
         UTVQ==
X-Gm-Message-State: AOAM530AeLBZFss6s5cjhA/INNLTCdFUxHmvqkZC7/ARZgWP8UJUr+uK
        S5QuqD9nFGlQvxmENH51DnaPQ8MR1Kzn+oULRh9K6AwwpeBGU9ui4To/VQUQPkvmTO76nPB+owX
        ZKB04ysw4toPieFTja4FQsVFX
X-Received: by 2002:ac8:665a:: with SMTP id j26mr8267053qtp.173.1628602623923;
        Tue, 10 Aug 2021 06:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweRWFo+H68Fj3T4T7Iatetn7HaR/6adb+j5+Nf6P0/km/pU4GuQrXekeo83c8dya9bo80j0A==
X-Received: by 2002:ac8:665a:: with SMTP id j26mr8267031qtp.173.1628602623592;
        Tue, 10 Aug 2021 06:37:03 -0700 (PDT)
Received: from crecklin.bos.csb (c-24-60-53-55.hsd1.nh.comcast.net. [24.60.53.55])
        by smtp.gmail.com with ESMTPSA id z12sm7894678qtw.90.2021.08.10.06.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:37:03 -0700 (PDT)
Subject: Re: [PATCH] fix UBSAN splat in test_scanf
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
References: <20210809102013.525671-1-crecklin@redhat.com>
 <YRJ/tTuj7r4jppv4@smile.fi.intel.com>
From:   Christoph von Recklinghausen <crecklin@redhat.com>
Message-ID: <1f4aa937-8e5d-33db-6479-e9b2011be147@redhat.com>
Date:   Tue, 10 Aug 2021 09:37:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRJ/tTuj7r4jppv4@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/21 9:31 AM, Andy Shevchenko wrote:
> On Mon, Aug 09, 2021 at 06:20:13AM -0400, Chris von Recklinghausen wrote:
>
> Thanks for the report and fix!
>
> First of all, have you seen this:
> https://lore.kernel.org/lkml/20210727150132.28920-1-andriy.shevchenko@linux.intel.com/T/#u
> ?


No I hadn't seen it. I'll defer to this fix then.

Thanks,

Chris


>
>> On a system with CONFIG_UBSAN_SHIFT=y, the following splat was observed:
>> [  104.676826] test_scanf: loaded.
>> [  104.680862] ================================================================================
>> [  104.690304] UBSAN: shift-out-of-bounds in lib/test_scanf.c:274:51
>> [  104.697144] shift exponent 32 is too large for 32-bit type 'unsigned int'
> As you may see in the above the rule of thumb is to include only meaningful
> parts of the oops.
>

