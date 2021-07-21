Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73DF3D0CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhGUJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238785AbhGUJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626862517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RyyvPAEl0RGdNpzC1zqJ6kwCJCutA9fkHO+0d42bF1M=;
        b=cz/a1rNu7BtmI+m+PNmg39zSqZD8l+Q9dWKcaT5Fly4Ncy/BdMRFyEFWzwO04nymVOFti1
        79FfYR202w8FDRUdDAwlBDRfKgJd3xejtVH7c4tzXfvFa8b38wA1ant0oBzOWFeWN2OxEu
        ZA9wEjOagfHC35aK4Bon+Oq1P1WpokI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-R_k2_MdiNUqRViSfB8joqw-1; Wed, 21 Jul 2021 06:15:15 -0400
X-MC-Unique: R_k2_MdiNUqRViSfB8joqw-1
Received: by mail-wm1-f70.google.com with SMTP id r13-20020a7bc08d0000b029023a3f081487so404615wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RyyvPAEl0RGdNpzC1zqJ6kwCJCutA9fkHO+0d42bF1M=;
        b=HGD7Ovs31mqnUbwtvx/+cqUbtysF7eLdVSrpcWezklTwb4lO2MRoWh87ah67dfwRkU
         niGVtIo1ku8v7s4zdEnUC5iTLMoHBR1Yy+Fc96Se9F7FyZVWrybrpO3F1XDT8PnMJQyD
         pmrTUE2IEkywD6G5MeI6LGweyRhzmm4RkBXIeYl9s617F44c3uFg8JJSuR6hOfS42lfp
         HHHtTQSrbN/h3hsh93TRtLay1rTNCrRyK/4sJj61+l233CzonOu2Zs4rM3atMS8EE8Xc
         oURMFCpMAUV+nPEAXEIeqiw1affhfjXqNAaE9UPL3oFf1fjeY/GLl593yJW+rZiEiEg1
         akFw==
X-Gm-Message-State: AOAM533neGw4n3kbWMJsQkklpXzMheFYkqRpZ3cCnL8yALDz8OOxh/+G
        ndSOTX60TT/G/8kuURUVc4TS2vHIcyuV7q5anI01mJL0xGLQDP43+3ovkllEH0nZXcOYlmwmXoF
        Ds8CK5fshBFzoovGJGgh78WsI
X-Received: by 2002:adf:e40d:: with SMTP id g13mr41478944wrm.12.1626862514804;
        Wed, 21 Jul 2021 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIFThd2tj7VfPp04ezzlehuYz0UUfR8kKnkyo/eLPDFM6dUDBcvPZYMmqeK3YnHEpOoz/6Nw==
X-Received: by 2002:adf:e40d:: with SMTP id g13mr41478916wrm.12.1626862514626;
        Wed, 21 Jul 2021 03:15:14 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id a8sm26534248wrt.61.2021.07.21.03.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 03:15:13 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
 <YPbWrV/cIODdgu6A@phenom.ffwll.local>
 <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
 <44a75f18-e3a6-f764-b0ec-ce3ac05805a9@redhat.com>
 <1e85fae7-ef95-b2f7-3463-e90958e54684@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <0ad257ce-44d9-beea-8afb-c879146c523b@redhat.com>
Date:   Wed, 21 Jul 2021 12:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1e85fae7-ef95-b2f7-3463-e90958e54684@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 12:07 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.07.21 um 07:09 schrieb Javier Martinez Canillas:
> ...
>>>
>>> Can I simply put the patches in to drm-misc-next? There was some talk
>>> about a topic branch?
>>>
>>
>> ... which AFAIU means that there's no need for a topic branch, since the
>> patches will be present in linux-next. And the EFI folks can use that to
>> check if there are any integration issues or regressions caused by these.
> 
> Merged into drm-misc-next.
> 

Thanks a lot Thomas for all your help!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

