Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F115308C99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhA2SdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232365AbhA2SdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611945098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbFNDCFum3phLLIm0P0qDFEkeZizOn+HqZt2msw3YK4=;
        b=RGHeOtR75+C880VVHTub2fVTwkBpB+mv0bCAm8LlEX+fhEd6sjEaHwuOc1GQMbGjCldnNJ
        k17HjtlU+Cv/XKIJlltLrMFPkaTcf/wf2FbgEa2QaC5zEiw1MuAU5QXFBhYsa8d1r7MM+5
        H9bhyt2IwdP4KkN+JsOSuwcxoHd0ELQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-j1857Qz6M2WdA3NQkntaFA-1; Fri, 29 Jan 2021 13:31:36 -0500
X-MC-Unique: j1857Qz6M2WdA3NQkntaFA-1
Received: by mail-ej1-f69.google.com with SMTP id k3so4331325ejr.16
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbFNDCFum3phLLIm0P0qDFEkeZizOn+HqZt2msw3YK4=;
        b=b1LtmjqXO14K8ngyt6p2a68/T0Psnjb5cIZJpaVZ9ZCYu1T4/VKwU3rmmIB+cCeNHl
         dPL1/Umq8PrknINFPBUM9ZYSRkvQlifVRFin2jL6VL/gcoOUwo0AzJHr7UljbwKheRJS
         VC2tw3nGRX6NkNOcDqUWOvlVEP8V1DMlXlyTtbsnUpwft8bkNi/2X2KrPpWpV89pGGhj
         bwXrOkWPOh+DUIydfaUkuoB6d7w5jwVtv0fZNyHzdqhR6O37uZYuj6c0LSrK7LbkcXfe
         2/DUIPeXeTmrqX9/BPZ7C+6M07zcy8WCo7JN+dP8Dnu4oFVZ9pEiun5495BligQQcqbI
         lVtw==
X-Gm-Message-State: AOAM531/2G0bLCKGB2HbHUXqTyp9Iub7Q6HlqNJ0fEMsR3mvPx8UAeCs
        +OWhYeGGeod8DUfgqcYXK7z28e6Gb05T2zF2ICb1KgZf/KXsMDOlSUWQdCpVgTNm7uwnla1Wna5
        1DR6oA3Q479LtPartepnG23LVIxNNmP+LRmSZ+k+0hvH9y4QsmZaBtbJledVKIigAvgT/8iSO3G
        0c
X-Received: by 2002:a05:6402:ca9:: with SMTP id cn9mr6835966edb.208.1611945095316;
        Fri, 29 Jan 2021 10:31:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcJefhGX4VFA4DBrZ8siCLslP7vAoH+P1bHPPvvfbv1BGiMHB2E5CUC88GH8fJXIFc9pOdeg==
X-Received: by 2002:a05:6402:ca9:: with SMTP id cn9mr6835929edb.208.1611945094988;
        Fri, 29 Jan 2021 10:31:34 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id z20sm4970370edx.15.2021.01.29.10.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:31:34 -0800 (PST)
Subject: Re: [5.11 regression] "tty: implement write_iter" breaks TIOCCONS
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
 <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
 <98e2806d-81af-baf7-00f4-5a43870ff514@redhat.com>
Message-ID: <8723f53e-9954-e0d2-16ce-933f53c776c3@redhat.com>
Date:   Fri, 29 Jan 2021 19:31:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <98e2806d-81af-baf7-00f4-5a43870ff514@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 1/29/21 7:23 PM, Hans de Goede wrote:
> Hi,
> 
> On 1/29/21 7:09 PM, Linus Torvalds wrote:
>> On Fri, Jan 29, 2021 at 6:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> While testing 5.11-rc5 I noticed that flicker-free boot was no longer flicker free,
>>> when plymouth loads and tells systemd to start logging detailed messages these start
>>> showing upon the fbcon instead of being redirected to the ptmx which plymouth is
>>> trying to redirect the messages too.
>>
>> I think this should already be fixed in current -git by commit 9f12e37cae44.
>>
>> Can you check?
> 
> So I just did the following
> 
> 1. Started with my local tree (5.11-rc5 + patches I'm working on, nothing tty related)
>    ( https://github.com/jwrdegoede/linux-sunxi/commits/master )
> 2. Dropped the 2 reverts which I was carrying to workaround this locally
> 3. Cherry-picked 9f12e37cae44
> 4. Build + installed a new bzImage
> 
> Unfortunately this does not resolve the problem, after this the problem is back.
> 
> I can build a kernel from a clean torvalds/linux/master but I don't expect
> any different results from that. Let me know if you still want me to do
> a clean build to make sure this is not something in my local tree.

p.s.

You are using Fedora now a days, right ?  In that case you should be
able to reproduce this yourself (depending on how custom your kernel
setup is) if you are using the standard Fedora initrd generated by
dracut and have "rhgb" on your kernel cmdline, then you can check
for this problem by doing:

sudo cat /var/log/boot.log 

For me the end of that file looks like this:

------------ Wed Jan 27 08:28:15 CET 2021 ------------
------------ Wed Jan 27 17:27:53 CET 2021 ------------
------------ Thu Jan 28 11:11:50 CET 2021 ------------
------------ Fri Jan 29 10:32:04 CET 2021 ------------
------------ Fri Jan 29 19:16:40 CET 2021 ------------
------------ Fri Jan 29 19:19:05 CET 2021 ------------

There should be lines like this in between those separators
(each separator is the start of the logs of a new boot):

[  OK  ] Started User Login Management.
[  OK  ] Started GNOME Display Manager.
etc.

Regards,

Hans

