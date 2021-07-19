Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212D03CD621
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbhGSNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbhGSNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:10:58 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F626C061766
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:14:22 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so6458322otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6MwYyfQ7hWYMM8FEazyj6+PGlDAQxVO02bzWLIZ5AY=;
        b=hj0dhjZ5Jnrq0wnLeD39kxY2zFJbc0JkNv00IalygYNJ3E8rmuvZfs7ojbG1hVnYE7
         +6X5m1aumTOtEOShM59Q74bb27lD0B5YUrn7cW8tI8gWo60MYcv6St38IHpf94mrclno
         ir243xYtz3IYzxqyVMp4K8X4fuSAy/6DbyUnXmjA4flnGWrBvwq+ufE11Hjg+djxtQhl
         eZchId3HUUvJfiR2/2s8/H/6suP7uaoD94cpvxvf2YLf/EGBcU+mf7mfiB/omSsATC2n
         6GXAtMGCF4KNHYFEfYYsja61Zrb0KByPZm8d1BrvAY6e5cBFdjVhUA55IjneEV8+L0EY
         VpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6MwYyfQ7hWYMM8FEazyj6+PGlDAQxVO02bzWLIZ5AY=;
        b=QqV62pvkpjuWjRN+MMOaSMwqfagNn8gXag48MfyUM8iG/w7uSfDyyUqXVX/V1H2H2P
         bUk6u99zV1I/ySCQqtlUoLr5NMuIWhqP/4Ttl7dkumVXoDW8IzRv3y2kl1793pHkh1Jw
         yD+XjZ3TDgIQFeqi4lJZxAock///qjRACuVNEP6v5BD8RnD5OjjKBtI3vdST+SJx6AIY
         KyNvZKUszrB1GhFLx2WJMoy1r6z3y2wCnc2lp1a4BKLvCoRy5+siYRSfb9k8ffB7xajY
         dob4OCEhkYhH0UAt2Iu+Eg13SVyFy/n16KHuAzUY4+5eZD4mADwbsggJDSIGdESCr2m8
         fToA==
X-Gm-Message-State: AOAM530Mu9sBpHNsEfGMzoqfqYTA1Y/zZq3OalWrqlFDW6/rD5dDPUIc
        1zA0NAkSH69JMgk484gEUEPZ3J0D1FY=
X-Google-Smtp-Source: ABdhPJy18zSSDt3JevOP6vVdaJbAZPIWCx+ATWkru0QavxZrggE4SSHexm+jtcXhxGlaBdB2vZey9A==
X-Received: by 2002:a9d:3a49:: with SMTP id j67mr19812527otc.114.1626702669812;
        Mon, 19 Jul 2021 06:51:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x129sm3734177oia.26.2021.07.19.06.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 06:51:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
Message-ID: <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
Date:   Mon, 19 Jul 2021 06:51:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
> 
> This patch will reduce cpu usage dramatically in kernel space especially
> for application which use sys-call with large buffer size, such as
> network applications. The main reason behind this is that every
> unaligned memory access will raise exceptions and switch between s-mode
> and m-mode causing large overhead.
> 

I had to revert the original patch from the mainline kernel prior to applying
this patch. Obviously that means that there may be other changes affecting the
outcome.

riscv64 images work, but riscv32 images still fail with this patch applied.
The error is a bit different than before, though.

...
[   11.899979] Run /sbin/init as init process
[   12.152666] random: fast init done
moun: applet not found
"�����V�t: applet not found
/bi�����V�F-: applet not found
moun: applet not found
swaon: applet not found
hostname-F: applet not found

After this, the image hangs.

For comparison, the mainline kernel (v5.14-rc2) fails as follows.

[   10.788105] Run /sbin/init as init process
Starting syslogd: OK
Starting klogd: OK
/etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
/etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
Starting network: /bin/sh: syntax error: unterminated quoted string
sed: unmatched '/'
/bin/sh: syntax error: unterminated quoted string
FAIL
/etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution

I'll be happy to provide information on how to reproduce the problem
if needed. Please let me know.

Thanks,
Guenter
