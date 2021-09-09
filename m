Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC094059E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhIIPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbhIIPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:01:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:00:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id h133so2831264oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPTQJvchvvJSjw3IrhGnZ6LhjBiRp3GxG1NEafoFX50=;
        b=lZwetvwT7x3BLYBepUtqy4iz1HZaQQT44n5FdvmpvhfYkj7Jyv7H9nMJcrwE7ErTMq
         KkpHC+SC9U6afuPGOiZX6cIAQvkOTSLRj7jOw8MqxBU5lHNsJ6KqwQg//RfnsWN9iDo6
         waGQe+AclrOEA6Ybykoi1ZlEEw2OOaqNKfsLJM1csrxiYFhdaUiXzsMnV2nHOa58AYp5
         DAhmYshKLbNQKoxtmNu3V6vlX9pvadtR8cxtuefGBSwBc2gb5bnWcFEwp8mghMjieidb
         JFaSlaMIOK5F+Kbsg9pkHNq24FWU9AQTysxSD1WClNvUXKCcoh1Qa+nD9TPjef25O1EM
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPTQJvchvvJSjw3IrhGnZ6LhjBiRp3GxG1NEafoFX50=;
        b=dNGZkywMzfQOYbXUxNhJ6vQRFpkDfcjg2PTqnSRUK4K3JxMpvTVtnzchduegDo0sXU
         Z4Iggi/6zv5G1vXDFlGVXaPD86yDWTPjozvjSSOj6F0U5g0ifIh6A68iJIIbdmgA+/ux
         xvallXAXqwVVEVrZJQgAUcNekh4VmxHSJuT5xtXd3lpRfyJSl2WYF5/wi17Lv/IuZ0yV
         9v6H/p/Zfibyv5B4EKsNOJpH/TetBuiPGVvRhYg3d5jPfWun8MK5WlcamevM1n1Ff5u7
         nMYHl8iu/13UHK1L1MePw7ezX4brPMvw2+dbfwhpbyQ5d107AiHpR3uMKrEUrrYItfhR
         wm3w==
X-Gm-Message-State: AOAM530hCY44iPctQVH2Fu0iChD0Nwz8GauQ7zyEI98uhySANNlHcjbL
        NZopZB+nhpibCnRvyoBDCaDHwFvd0ro=
X-Google-Smtp-Source: ABdhPJxDdrURS3VwJZIw1b+uWlG3dnMirxWDODaZt7/hS7AnHcNvaZCHi6y2/qzFW6P2k6jXIEm1UQ==
X-Received: by 2002:a05:6808:319:: with SMTP id i25mr110467oie.141.1631199630661;
        Thu, 09 Sep 2021 08:00:30 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id q7sm481717otl.68.2021.09.09.08.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 08:00:30 -0700 (PDT)
Subject: Re: False positive EXPORT_SYMBOL warning with NS variants
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
 <bef77537a67749df31fc7cb5549744ff7b76f6de.camel@perches.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <95eaf91f-0a15-e3e3-0e14-ed0d03713874@gmail.com>
Date:   Thu, 9 Sep 2021 10:00:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bef77537a67749df31fc7cb5549744ff7b76f6de.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/21 12:51 AM, Joe Perches wrote:
> On Fri, 2021-09-03 at 11:01 -0500, Ian Pilcher wrote:
>> $ cat foo.c
>> // SPDX-License-Identifier: GPL-2.0-only
>> void (*foo)(void);
>> EXPORT_SYMBOL_NS(foo, FOO);
>>
>> $ scripts/checkpatch.pl -f foo.c
>> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
>> #3: FILE: foo.c:3:
>> +EXPORT_SYMBOL_NS(foo, FOO);
>>
>> The non-NS EXPORT_SYMBOL variants don't trigger this warning.
>>
> 
> Try this:
> ---
>   scripts/checkpatch.pl | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 88cb294dc4472..91798b07c6cb5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4449,6 +4449,7 @@ sub process {
>   			#   XXX(foo);
>   			#   EXPORT_SYMBOL(something_foo);
>   			my $name = $1;
> +			$name =~ s/^\s*($Ident).*/$1/;
>   			if ($stat =~ /^(?:.\s*}\s*\n)?.([A-Z_]+)\s*\(\s*($Ident)/ &&
>   			    $name =~ /^${Ident}_$2/) {
>   #print "FOO C name<$name>\n";
> 

Seems to work

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
