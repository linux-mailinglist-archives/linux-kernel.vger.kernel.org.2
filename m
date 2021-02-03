Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5915A30E11C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhBCRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhBCRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612373461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2f47O+xthY5btHVP656wCtRgwd+ND0mPdvSru9EXT8I=;
        b=HeIJ5u3PeeG/WqH09gFowmWstYDOKr6XWVPOhQ3GGKjWjvJtogJT44EdVOW7mVzUkpjj8F
        ySZH3w0YAsivPuC6v1Fv8x25ydrALc2riXtXQyIU7zUlpe90ZnABth9JvNTkhcMqPfLdSF
        UFjfw1L8gX4lh/Y0HVyYtP09nC59Vd0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-qMtMQNe0MwOHRtGpEQIfVw-1; Wed, 03 Feb 2021 12:30:59 -0500
X-MC-Unique: qMtMQNe0MwOHRtGpEQIfVw-1
Received: by mail-wm1-f72.google.com with SMTP id b62so99196wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2f47O+xthY5btHVP656wCtRgwd+ND0mPdvSru9EXT8I=;
        b=m4l8JQlD+j6OL5UHYbeGYp3dJhw07dl13HLI5G42OS4cNbeg5Ch+HttVf2dPhva1KT
         MZ0bKsb2kkXi14SDz2aALFOO3XNMB5rgEcB66lmBDKc+xlFwvByCcbzW8hXa1CZSHYtV
         WTmY0NhiSd5344pePSuzQ4jnZrNaxv9jzyE860NV5vrKnQ0LfrZpQOGSOVqAQZAbiPhm
         65UjD6AGIFk+sNMcFwcJNodIkLjUZzdbUZxEAXTO2i0Z9CJ+WWfJpwETF5Z881hgDcX6
         B3hjBcoP1YKAWrXNlPgBALEzfHmsjaY+aNazCi+EGBt7OygMU1jz3apTTMZuheUzIubY
         1F/A==
X-Gm-Message-State: AOAM531H/YBcD98Wn8m6NpgvpvPIIf+Ex4yeCb8TrkagPplv5EatAl5/
        OmZ8hEit02xqi9P4u+Tw41XBvmTvNdBw/EAU5oGIkcKGxp4kZ/D48CjhVawtn2tCGGIpgJ6ckrj
        kE8wyY/pOi3c11tJjQfm+nzt8
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr4594928wru.178.1612373458589;
        Wed, 03 Feb 2021 09:30:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhw9U9nnZ8kINGuWmHahAnAIa4/7Q5FJWf34LwunkpylIlpm0/I/LgNC/qZwHvuydMLz4RYg==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr4594904wru.178.1612373458321;
        Wed, 03 Feb 2021 09:30:58 -0800 (PST)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r17sm4577139wro.46.2021.02.03.09.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 09:30:57 -0800 (PST)
Subject: Re: [RFC PATCH 1/5] arm64: Move instruction encoder/decoder under
 lib/
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org
References: <20210120171745.1657762-1-jthierry@redhat.com>
 <20210120171745.1657762-2-jthierry@redhat.com>
 <20210202101755.GB59049@C02TD0UTHF1T.local>
 <9c01f293-2c98-43e6-a497-89610fe5970e@redhat.com>
 <20210203111240.GB55896@C02TD0UTHF1T.local>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <75b53229-f518-09f1-2449-ecac2352663c@redhat.com>
Date:   Wed, 3 Feb 2021 18:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210203111240.GB55896@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/21 12:12 PM, Mark Rutland wrote:
> On Wed, Feb 03, 2021 at 09:26:45AM +0100, Julien Thierry wrote:
>> On 2/2/21 11:17 AM, Mark Rutland wrote:
>>> On Wed, Jan 20, 2021 at 06:17:41PM +0100, Julien Thierry wrote:
>>>> Aarch64 instruction set encoding and decoding logic can prove useful
>>>> for some features/tools both part of the kernel and outside the kernel.
>>>>
>>>> Isolate the function dealing only with encoding/decoding instructions,
>>>> with minimal dependency on kernel utilities in order to be able to reuse
>>>> that code.
>>>>
>>>> Code was only moved, no code should have been added, removed nor
>>>> modifier.
>>>>
>>>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>>>
>>> This looks sound, but the diff is a little hard to check.
>>
>> Yes, I was expecting this change to be hard to digest.
>>
>>> Would it be possible to split this into two patches, where:
>>>
>>> 1) Refactoring definitions into insn.h and insn.c, leaving those files
>>>      in their current locations.
>>
>> I'm not quite sure I understand the suggestions. After this patch insn.h and
>> insn.c still contain some definitions that can't really be used outside of
>> kernel code which is why I split them into insn.* and aarch64-insn.* (the
>> latter containing what could be used by tools).
> 
> Sorry; I hadn't appreciated what was getting left behind. With the
> series applied I see that's some kernel patching logic, and AArch32 insn
> bits.
> 
> How about we invert the move, and split those bits out of insn.c first,
> then move the rest in one go, i.e.
> 
> 1) Factor the patching bits out into new patching.{c,h} files.
> 
> 2) Move insn.c to arch/arm64/lib/
> 
> 3) Split insn.* into aarch64-insn.* and aarch32-insn.*
> 
> ... if that makes any sense?
> 
> We might not even need to split the aarch32 bits out given they all have
> an aarch32_* prefix.
> 

Yes, that approach sounds good. I'll if the aarchxx-insn is necessary 
but as you say, all in the same file shouldn't cause trouble.

Thanks,

-- 
Julien Thierry

