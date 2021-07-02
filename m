Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14A3B9D12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhGBHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:45:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhGBHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:45:05 -0400
Received: from [192.168.1.155] ([95.114.43.145]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfHQp-1lJ2FH04hX-00gq4d; Fri, 02 Jul 2021 09:42:32 +0200
Subject: Re: LockDown that allows read of /dev/mem ?
To:     "David F." <df7729@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <CAGRSmLvaZ7av7ne-XKfZGrij1x9i5v1aH=t0ufL=Ad1193G0vA@mail.gmail.com>
 <99e0ef5a-156f-c8e5-cfc3-7c50e5e15a98@metux.net>
 <CAGRSmLuoP79dkE5_NgF+wiuotsYc6sV=fk=qzBVcEsjq0by5CQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d4c9740c-61ef-764a-b56e-7957cd26e12a@metux.net>
Date:   Fri, 2 Jul 2021 09:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGRSmLuoP79dkE5_NgF+wiuotsYc6sV=fk=qzBVcEsjq0by5CQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8RpxmToVlsMwy0Q0JW7pubYjuqWDAw6/R+CE/Kyg3ewTkWvUpsE
 8N/ckdq1kwcxxa3E139c5EcGTEjq81m1cmxs4R1ZVuWh5SsA1FZP3y4ruknMzJ212o8p2YN
 Nj4VztlIE/sWXZFqD0uO7m6LeY1d9sUtC/CzcFrEBjDzNK0ZRH5Z34cs3t9h2XbYkFgIJw/
 57kn/Ui5xuUi/eE+T3PuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T5ioelvqV5M=:fXSZs1AoahNEiP88Lzv8ap
 3kNGMuOcFj3xHeJybeO9G55ApgFskRmCluOoFpOZq2x1apuHQ1DI1hPBHrywpAjG5HBbQMRPn
 h0LPdKxotHTCDp9VmvmTn2r/aEsfH1Mj+QfN0eSmB5x+HnVkI1esz8C3U+ezFqoSAQsppnS/O
 zd0YhqaCELyNpAOCiCFnGzkAzr1p28UON0De7xKQWg2qcH5n3T9tPNUUCJkcx4/l21AASXZG6
 ts8ZIAwCQMbH5cpzOmdH0gQ02SvK2THHM06luIfi82eZrJlwYOYC5+EqWm20FniuVhpOLOblw
 Uc7VzNW3QUKAfPpLIHJ8gNNPQi195UnBqRMK0JqAHtVIZuyZTpVCT1qg0aYSmn1o4ck6OLkGF
 1CPIWv0xEuNmrztJnJDcKLREGbuOA1p19dSfG+RMuvVNuBeQsXwvlrGaUii7WhDtWFIPygHbu
 62W5NPYXFiG/JYWpwx9iUOOIOvMFhoD/vhVoNEUssjGDyuYmQVJpz57J7l5+kPb1T6uN5qYPQ
 VPaRdwIDi30BFSthsxsxJ1sUqF7deX9RYC0DRdRrLklWgZwPMzjyjiIz2LQmfYPyXjjSZ7oJd
 lB1y+4wjbxLr9OPughs4f3ZA5L9aDhBAWOpXMhY+OFHrkENNviXNku2G0ElWaaBhNG5uxo8Ng
 UFNnpI++rNNHdUHsMGednCr3j6fJi1Oo6sn0eNaAN/z4kqPefFVC6d6saMwZjdc3VNouElkBH
 D0KRmNh/iZvu1M+WUmd7TPrhiExohi4tYXZqB02yRDYFold8SKjqxUg7M//z9DABNRsZTc0a5
 drie9Z7Y2HobdCeiPfLWD9ti/u2nRJtUZmwm3jSZSj4FoH3hhLoqROTJDxaJMhlv9eEjHj9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.21 17:29, David F. wrote:

Hi,

> Lockdown required by secure boot and shim signing (prevent acpi
> patching), root because it's main use is a utility boot disk.   If
> lockdown could be forced when secure boot active but not when not
> active, that be best, but I'm not seeing that option.  The other
> option maybe to modify open_port on mem.c to do the secure boot check.
> However searching EFI_SECURE_BOOT doesn't exist in 5.10.x as in
> efi_enabled(EFI_SECURE_BOOT) - It appears that is some other patch
> that is not applied to the base, I do see struct boot_params has a
> secure_boot field set, but can I access that from mem.c?  If not, is
> efi_get_secureboot() function available when /drivers/char/mem.c may
> be used?

I'd rather try not using /dev/mem at all.

What exactly do you really need it for, in that specific case ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
