Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0515308C71
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhA2S00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 13:26:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231940AbhA2SYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 13:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611944609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SpaoT08mSqZ4omGQT8Z7FYKOQiu5G/TlKgKSKfgkcx0=;
        b=ESM4iwFsX3FNZDWneDyQ9WG92+TZB7j8LUHCwEJ/uYG1q/0+kzNZS1Np2bsldjyOycZqnZ
        Thc+o1akBDoQRWfy0ojSMsrOdhvSXO5ytx/IHQXcL+HQUBRKegJ5cn4YFVx+UWxYw4Fke2
        bfXpi+8PWiMG+KJ5Xuvj6Cj5CJ5LtBg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-b-GRpKDKPjmOTofeZHEROw-1; Fri, 29 Jan 2021 13:23:26 -0500
X-MC-Unique: b-GRpKDKPjmOTofeZHEROw-1
Received: by mail-ed1-f72.google.com with SMTP id u26so4411492edv.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 10:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpaoT08mSqZ4omGQT8Z7FYKOQiu5G/TlKgKSKfgkcx0=;
        b=qLASSOMZ+yVI2/qSP0NM6OVRHBYfADT1FypKxciAqmvngdmNC0Bm9sbsdL7qlnl1O7
         RvaYNwvwTBvbDYGOhtRI0f30D+PfwCjXZIpj9Kdcbm71jRvkxCLcEk59fDXBFODElyff
         TKtnT0hWMdkcH47YIdmCd4F+UFpzDXlwtXPJ5UFYcnImIBEnLqzMX+ZlInMe7F/NVmoN
         wZQfI1ZoMPpj7vz0KUc9uYlbPMPbRuN5K05HJvJeaSHEFM/rjTGtDz+la8zsdqZEaZ1k
         TKTS6K2uQmADKINT5N0vvGvDjfyJ//umdIRA4SvRpZEmWN4QJH1vtxN1FqbJVA8OkWov
         xyKQ==
X-Gm-Message-State: AOAM532mg5dJRuYPWmKPtB2fBWY4JgNHZONj5hbhcDXSr/fTwJ/Z4TXx
        eg/s2yMgachND8TO31Ci4eKrZ3yI1mI8J0mwvxwEQldIgtg2FWp38ZveFxFUKX0g1wXxQQtTLcm
        LD4S0jBGvlHr3Qw16O6vRSpeUKxea1jL7TnA6V3F2c+L9oR8joPoUJMlnjK16RAypKyiVlwt/3T
        aO
X-Received: by 2002:aa7:de10:: with SMTP id h16mr6638773edv.385.1611944605211;
        Fri, 29 Jan 2021 10:23:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxijTObEL4EXhugm4XwHbEglHa2uVGTMfe/y/p9IJ+1ytaHTlSlC6F0iVgMcsbZOKXkNOb/2w==
X-Received: by 2002:aa7:de10:: with SMTP id h16mr6638760edv.385.1611944605087;
        Fri, 29 Jan 2021 10:23:25 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id q2sm4909796edv.93.2021.01.29.10.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:23:24 -0800 (PST)
Subject: Re: [5.11 regression] "tty: implement write_iter" breaks TIOCCONS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
 <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <98e2806d-81af-baf7-00f4-5a43870ff514@redhat.com>
Date:   Fri, 29 Jan 2021 19:23:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/21 7:09 PM, Linus Torvalds wrote:
> On Fri, Jan 29, 2021 at 6:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> While testing 5.11-rc5 I noticed that flicker-free boot was no longer flicker free,
>> when plymouth loads and tells systemd to start logging detailed messages these start
>> showing upon the fbcon instead of being redirected to the ptmx which plymouth is
>> trying to redirect the messages too.
> 
> I think this should already be fixed in current -git by commit 9f12e37cae44.
> 
> Can you check?

So I just did the following

1. Started with my local tree (5.11-rc5 + patches I'm working on, nothing tty related)
   ( https://github.com/jwrdegoede/linux-sunxi/commits/master )
2. Dropped the 2 reverts which I was carrying to workaround this locally
3. Cherry-picked 9f12e37cae44
4. Build + installed a new bzImage

Unfortunately this does not resolve the problem, after this the problem is back.

I can build a kernel from a clean torvalds/linux/master but I don't expect
any different results from that. Let me know if you still want me to do
a clean build to make sure this is not something in my local tree.

Regards,

Hans

