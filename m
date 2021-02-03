Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3753830D531
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhBCI2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbhBCI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612340809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ny65LY+TRxvsTsvW7S+eXZHndHGabCwYYH6ldS6g6HY=;
        b=eDudMeyCVcmEjM4ckMS69SgaCI3vHb8lZZiiEqHGtXmyYNR0lnTVY5TVKDXEHi5R+yvzwt
        ONY/KLWTOZ0Ih6jmfd1kNfDJADi8leMWReL4lGMcUKPvxeRt9QDaR8CO83leDRL7Y8WORS
        tlkk7nhJUvvFrzvKkO7BHvvI62Hdpus=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-aeMLl1seMMSyj3emqBuwIw-1; Wed, 03 Feb 2021 03:26:48 -0500
X-MC-Unique: aeMLl1seMMSyj3emqBuwIw-1
Received: by mail-wr1-f71.google.com with SMTP id l10so14032063wry.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ny65LY+TRxvsTsvW7S+eXZHndHGabCwYYH6ldS6g6HY=;
        b=c1aYpVr/jBooo7+dIF8fldyflI9rbflYqXWnGIf47zJWZzZz6ynHX+rlXe53M6ftyV
         d+J+lJyPgpe84OowUE/Mt0sHKN6ZCJLhebMpGead+hDGjrrPIZZaGhgBHu5Vdlgxbrvu
         JltwwkPYsqDxnbUcLzAns/WanYYlwKasQNNPjc4n8nKPfoTgZlymKms0R/iU1QLcy5rm
         egzLirugrn1GhR5zwOSQ1JcatJuKgLkh0RsloEL8URCXrMTBrvGq051GKglMGBHdhojJ
         e80+9o+7W99QZ7J51qx1U3EL2b6KD+m+umC3L5qDyv1hkqII2g21lBUtn2Vz0wOETAaO
         n4lA==
X-Gm-Message-State: AOAM5312jVGXPFb19Zi1igSSL//CVDo2mTNWM4HeW1ud7whSbCTzo35t
        m7bu3t4xVx45WyWeg12mwjwEIweZxhm6ozNR8kdjQyfzhDGvgLwbzxMokiRHgQWfXI1l2libduI
        TcAAue24GfySiZuB5yNj+LHrX
X-Received: by 2002:a1c:6145:: with SMTP id v66mr1704818wmb.188.1612340806959;
        Wed, 03 Feb 2021 00:26:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXDjrVWxmNntc5xJPT+eSmrOkD9+6ETwunqBSSfUEjXcvq61kj8NhKYLN3UN3NRwqH7dmImA==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr1704796wmb.188.1612340806764;
        Wed, 03 Feb 2021 00:26:46 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id q7sm1231601wro.55.2021.02.03.00.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:26:46 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] arm64: Move instruction encoder/decoder under
 lib/
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org
References: <20210120171745.1657762-1-jthierry@redhat.com>
 <20210120171745.1657762-2-jthierry@redhat.com>
 <20210202101755.GB59049@C02TD0UTHF1T.local>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <9c01f293-2c98-43e6-a497-89610fe5970e@redhat.com>
Date:   Wed, 3 Feb 2021 09:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210202101755.GB59049@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2/2/21 11:17 AM, Mark Rutland wrote:
> Hi Julien,
> 
> On Wed, Jan 20, 2021 at 06:17:41PM +0100, Julien Thierry wrote:
>> Aarch64 instruction set encoding and decoding logic can prove useful
>> for some features/tools both part of the kernel and outside the kernel.
>>
>> Isolate the function dealing only with encoding/decoding instructions,
>> with minimal dependency on kernel utilities in order to be able to reuse
>> that code.
>>
>> Code was only moved, no code should have been added, removed nor
>> modifier.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> 
> This looks sound, but the diff is a little hard to check.
> 

Yes, I was expecting this change to be hard to digest.

> Would it be possible to split this into two patches, where:
> 
> 1) Refactoring definitions into insn.h and insn.c, leaving those files
>     in their current locations.
> 

I'm not quite sure I understand the suggestions. After this patch insn.h 
and insn.c still contain some definitions that can't really be used 
outside of kernel code which is why I split them into insn.* and 
aarch64-insn.* (the latter containing what could be used by tools).

Or do you suggest that I still create the aarch64-insn.* files next to 
the insn.* files?


> 2) Moving insn.h and insn.c out to arch/arm64/lib/, updating includes
> > With that, the second patch might be easier for git to identify as a
> rename (if using `git format-patch -M -C`), and it'd be easier to see
> that there are no unintended changes.
> 

But it is more a split than a rename (at least in this patch). But I'm 
happy to do this in another way.

Thanks,

-- 
Julien Thierry

