Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D53B505B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 00:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFZWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhFZWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 18:21:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5430C061766
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 15:19:03 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so13809849ota.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hL4UYM2SGkybwhGKeNVxRc3RhwhOjX0QboFkuvBmxSI=;
        b=gPLAQUkBSs4K1Iyg7nlLQ/Di9cZnlIsOhjJYah1/ndHUfP+UuOwlG+gejgqQJCKSV1
         MUw36uxralpQUiWvIyF0aqn3Yrj73aWwwLBtQTaPhjxUki4ky3Il2oC1Azt3hbGAfjyC
         bbdlT7fo6N/nTsbmiLeblzvTYK/WmzP1YQi9Xwd0XeAGcwUlirB4hYCLSMUsGgOX82dB
         mnNIW3xg9C9tlzbeCtnLTyeM/IoNls8iuZ386wT9zOpk11vgT67UcihHwg0kDXapUqJy
         uVYPnIFONm9jX+XVBIg6X99gH/SXHNi5frxyks1cnl1ShzPP8OdWW8J0twuu5FKIS5gX
         RCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hL4UYM2SGkybwhGKeNVxRc3RhwhOjX0QboFkuvBmxSI=;
        b=R9LyDbzhRXjLcV3JMb+BjflgLpxH118Wzu1vg5ofp6lnUNddF8fkY4+YGtKiEgMrQg
         MAIZ8g+ob+W+/12+wXA/sc3nIRX5AtqctC+JLhNVE+hyB/JDg1luprrF+TTp65kjSMhB
         4y90aoQ6W/M/GiE01DN6hYNJxkYE+fmywAsHASjZwUfwO4gnW+GoHPu12IU0WgQ5uIe0
         IKR3n5PkQ9K2uYga2rZRsQOv2U/ImnZUkEDtBTj+5v9GXG+L3utsTmABUtu5T+41dAlf
         OI1h2B/uq4JZ5vbTz3aje+ZiiT/V0MUWMrA/x9T0unOQ9AcqV7BBI8UwI1S1RT5D7315
         8gIw==
X-Gm-Message-State: AOAM533hwpTPOqVXR2QntuhyWmT/Ivi7wqVtaBjBj4zq7vnzUlHzqFxX
        qu7xQw5daA+nv3q8SSzSx/6egY9/PfLMPB/a
X-Google-Smtp-Source: ABdhPJzIBYiDwN+vs4Juiju+SrRswUfU+7eER9WObXr+x/xzu9mdFDLFiX/Zu9aD6NeZSS/2M7F/iw==
X-Received: by 2002:a9d:80a:: with SMTP id 10mr12880537oty.192.1624745942815;
        Sat, 26 Jun 2021 15:19:02 -0700 (PDT)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 35sm2389066oth.49.2021.06.26.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jun 2021 15:19:01 -0700 (PDT)
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
Date:   Sat, 26 Jun 2021 17:36:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623133205.GA28589@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 8:32 AM, Christoph Hellwig wrote:
> Hi SuperH maintainers,
> 
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?

We'd like to convert them, but have to rustle up test hardware for what _is_
still available. (There was some motion towards this a year or so back, but it
petered out because pandemic and everyone got distracted halfway through.)

(We should definitely START by converting the r2d board qemu emulates. :)

> The reason I'm asking is because all but one users of
> dma_declare_coherent_memory are in the sh platform setup code, and
> I'd really like to move towards killing this function off.

Understood. Is there an easy "convert to this" I could do to those callers?

Rob
