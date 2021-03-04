Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE732D419
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhCDNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:25:08 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53422 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbhCDNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:24:37 -0500
Received: by mail-wm1-f53.google.com with SMTP id e23so8025098wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DoVnS8k4RQkogRp+7VshFY8vize0VBYuT9zkrZVLJkc=;
        b=EXWUwy8x/cPB3VSZzM64rsyIEJSUJSvGF2ylK74H+R0cj0c+G4gyRREEB7tIE+jvoh
         1oPhRQU8+FFaJqC+OGyXGQIT/Bqa85/auwLRtfMjK34xhfHGEfl4UwGvhaIeZE6KSI5m
         ie5abWmEVSvwxhf89e9BCu3aNDyKov4ubOFir33L2AaHFx2ZhtxfrEwjh9ffqw+GxLBe
         RaymseJ2uBlPKVatqmHcjnmrv6Qi6EFd+31RCR+AdTu/sB29VdmQ2T6qdWccSwhA/5uj
         c2wDvIuvKW4xVXbiNmD1M4njcq7ahTESB6JyzTEdX+NnWvIru7SFEXSov7FQwiq/efnk
         fIwQ==
X-Gm-Message-State: AOAM533Vds8/zGnlJHLipJMgUT2JvJFSuViqgWghuW0FB0P9mD8Kjrdn
        jFLhaR8Mbfqma9fgY27MtNX8+YqCh+0=
X-Google-Smtp-Source: ABdhPJx/G5yN/NV+CBY6nEY9j/S3wF4hfe7w67ailvszUrbB+NcQY6WccO4PEOwhJn4Y8gjWuQA8LA==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr3942271wml.44.1614864235373;
        Thu, 04 Mar 2021 05:23:55 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 21sm10037848wme.6.2021.03.04.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:23:54 -0800 (PST)
Subject: Re: A note on the 5.12-rc1 tag
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <20210304124314.GA9979@duo.ucw.cz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <f99457f6-38fb-fd30-da2c-0d5d86e9af39@kernel.org>
Date:   Thu, 4 Mar 2021 14:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304124314.GA9979@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 13:43, Pavel Machek wrote:
>> One additional reason for this note is that I want to not just warn
>> people to not run this if you have a swapfile - even if you are
>> personally not impacted (like I am, and probably most people are -
>> swap partitions all around) - I want to make sure that nobody starts
>> new topic branches using that 5.12-rc1 tag. I know a few developers
>> tend to go "Ok, rc1 is out, I got all my development work into this
>> merge window, I will now fast-forward to rc1 and use that as a base
>> for the next release". Don't do it this time. It may work perfectly
>> well for you because you have the common partition setup, but it can
>> end up being a horrible base for anybody else that might end up
>> bisecting into that area.
> 
> Would it make sense to do a -rc2, now, so new topic branches can be
> started on that one?

+1 to this idea. I already applied few patches, well, on top of
v5.12-rc1, so would be nice if I stop this sooner than later.

Best regards,
Krzysztof
