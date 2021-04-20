Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A10365CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhDTQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhDTQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:10:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087FC06138A;
        Tue, 20 Apr 2021 09:09:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a36so33335114ljq.8;
        Tue, 20 Apr 2021 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oiNPKjGja/cn4PqHGuNqa79j6/rXywBS0WcwE5yleow=;
        b=XvgNluvgCRyITn7dhELaTb9ECwuXIdRvml3L7yJQgqH9HAV63N7m3byVjz5Lyy8mw7
         RppN97US9oND1su3UYbf+p0EM080vzbT0cLB6sDwHKtHBgtEC73JdYputTi3wG5DpbQj
         s9ZX8Xwgz6T/FxcpfLvj1xLN14hl4sqBoXmJcYfiKx4KjCyDvqXdNzPvIvePMDZEE4mj
         wLAt6RJt5dVKIo1lrD7lVj7DckrPN71i0n8mQQVendaAkyqzdBjdzi0mPbJmEvwORL/1
         XOX3umwk/9fBkvNznstFOv767qFtBbd7iwmyYxfsQVE5AyAyZG8/NJqA9+x8t7XUTEz9
         ArYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oiNPKjGja/cn4PqHGuNqa79j6/rXywBS0WcwE5yleow=;
        b=XWt1LK152pfQm31vjRzrUfuK7XBHgwWuEm8ynYzujkBbN8AWJOhq+ldVB6C+Li0/Wg
         2KN9koCAsqj+D2eHCczbOG+bOM+fbxHXywqGIkxzuFja0O3Dh2QK/D+yjnKkJ4oCQRAY
         t1kE5sOnFwJpf4BDAYND3mmpdgC+6TvoinQtFG6C9gXlYYDGVL2brsEx8QLKe/Djx49s
         NXGr6HEPCD/KTJ1EdU3t8jGuAlMPnxsVuQbaXkDXcELfFgq0g3C/HIHPvg/1hm3U74bg
         SDY8Hkw3qoZKs5x3GePAScyDgNRMQa0CV043EWBbNEc2pKRXx/GDrLFAnzDwa+U+vj9W
         qqJg==
X-Gm-Message-State: AOAM532cN04Jobes5OSO2FFPRc7N84/DSs1d63umNFgpeO2ivqjsXMAy
        Nn+zdpyZthcVVJmoPpHi2za8cAc1rdk=
X-Google-Smtp-Source: ABdhPJxREIL/YfIQ8gceBOPx9d43s7dXxfY6UbzoA+BhEYtOlaNebZr2fGI0sCbOo6ZsHeUpR14i3w==
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr13733394ljm.304.1618934968398;
        Tue, 20 Apr 2021 09:09:28 -0700 (PDT)
Received: from [192.168.1.102] ([31.173.85.161])
        by smtp.gmail.com with ESMTPSA id l7sm1175117ljg.30.2021.04.20.09.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 09:09:28 -0700 (PDT)
Subject: Re: [PATCH] ata: pata_rb532: Add OF support and make COMPILE_TESTable
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210420140422.88253-1-tsbogend@alpha.franken.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <712b5cfa-3c68-3048-41c7-07a65c506ce1@gmail.com>
Date:   Tue, 20 Apr 2021 19:09:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420140422.88253-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/20/21 5:04 PM, Thomas Bogendoerfer wrote:

> Add OF support for switching RB532 do device tree possible.

   I couldnb't parse that. :-)

> By removing
> the not needed asm/mach-rc32434/rb.h include the driver could be
> compile tested now.

  I think it's a separte issue worth its own patch.

> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
[...]

MBR, Segrei
