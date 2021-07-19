Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06833CD642
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbhGSNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbhGSNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:19:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:24:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y4so19032745pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A3QE1jNI0Mn5+bxGAdS1FlqgSnYTHTQYzfnIBkSNZuw=;
        b=KPhoDCCw9qtZsThRIfu6l/wx3ELByphnnhav08bU8cmIozRL+HHyykg6WxacNC8RbB
         3kNgOG9UA+TY8JfzamekW+lQrfhXLM9USnRpVJD9W/Mx7SWgqmBqfVs/xOBdKKIHuA5Y
         dd+y47EZB6OCz8ohyYfo3Y1LpygQ1T/+Cv1EJdXx5KSoLdpj65r9ZAkrLk/18pSjTlIi
         pu3ze+p8dKokZCs3GZhEvrqY8MTt76S282b6Cwaa3jNjVPv5Q60Oh6xqPxc1RDCFZMiN
         vF/TRntFP+CEMrXK9cbfCBAFTunz/h7Q7nkz2KkxcG4Hryh7zj/cBEryZQe3jfJmDR6v
         r3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A3QE1jNI0Mn5+bxGAdS1FlqgSnYTHTQYzfnIBkSNZuw=;
        b=nEEUwLP7pKmfk21gYdRybEhbqLy5d8iNOJab3wen4f25WNRNHQR4zZ6WtkB/RAic3f
         90s+1wtOJEwziyN0WvVzGrffTexMn0r36bVMk8cN3C79UAITsJh1G1GPNVjDvfiJ0wPm
         4m+w64RRDQMc20nlU0Q/bGzrteRj1kODOJMCNXUt3Gv0JsiGba70OUjXcs6KrsxrVsJW
         V5K4upS8+3eGjw/fiymEx4e40TeD/oFhVyCAThEWQIivcLgDDT/h4oGmaL7OC3iYDmRa
         ZHPrPOECfFPDvMzFQyZbmY+y2kO6bbqAcF0ZxajDzu2B82zyq4uPDPCbbiyXfwCkwtx8
         KNwQ==
X-Gm-Message-State: AOAM531Lkg4Ww8QsE2XKiFF/i3JIsUJ38KAs+CEW9hGCtZap9dnRys7f
        dwKz+2/fEehiOXVdPXCU01PHk6A3zM4=
X-Google-Smtp-Source: ABdhPJxl8p5Wcex+s32vmZcMW1o6ebyMwVqDFXF3XQIf0uhiR4rwIEi+ydZLF9uEvyRuKqqYe8ZGrg==
X-Received: by 2002:a63:2fc2:: with SMTP id v185mr5533933pgv.71.1626703217936;
        Mon, 19 Jul 2021 07:00:17 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id n22sm19768231pff.57.2021.07.19.07.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:00:17 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
 <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <e1bb4768-5517-8ef3-eaf3-bbfc103fa918@gmail.com>
Date:   Mon, 19 Jul 2021 23:00:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/2021 10:51 PM, Guenter Roeck wrote:
> Hi,
> 
> On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
>>
>> This patch will reduce cpu usage dramatically in kernel space especially
>> for application which use sys-call with large buffer size, such as
>> network applications. The main reason behind this is that every
>> unaligned memory access will raise exceptions and switch between s-mode
>> and m-mode causing large overhead.
>>
> 
> I had to revert the original patch from the mainline kernel prior to applying
> this patch. Obviously that means that there may be other changes affecting the
> outcome.
> 
> riscv64 images work, but riscv32 images still fail with this patch applied.
> The error is a bit different than before, though.
> 
> ...
> [   11.899979] Run /sbin/init as init process
> [   12.152666] random: fast init done
> moun: applet not found
> "�����V�t: applet not found
> /bi�����V�F-: applet not found
> moun: applet not found
> swaon: applet not found
> hostname-F: applet not found
> 
> After this, the image hangs.
> 
> For comparison, the mainline kernel (v5.14-rc2) fails as follows.
> 
> [   10.788105] Run /sbin/init as init process
> Starting syslogd: OK
> Starting klogd: OK
> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
> Starting network: /bin/sh: syntax error: unterminated quoted string
> sed: unmatched '/'
> /bin/sh: syntax error: unterminated quoted string
> FAIL
> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
> 
> I'll be happy to provide information on how to reproduce the problem
> if needed. Please let me know.

Yes, I do would like to know the procedure of build instruction of your rv32 image.
Then I would reproduce the error and look into how to fix it.

Akira

