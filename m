Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B693B5507
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhF0TtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 15:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhF0TtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 15:49:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 12:46:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so12128488wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DAErNgS/j8DCnY2ERck8XX1Z4inkZWw1VYk+KrVuhjw=;
        b=d3IvLBXijKA9l46yQ/gF3Sl1dZ7mbgqFHBwnWpWr0Ym1mERWL/B66G89f8LmQSiiT2
         K/qvUkVswZ1mIdDkAKfDo21D1T64OGmQAneu160iTTLF9eBUEYDfnlU7nlxmtZjsMfqz
         cGoRO4sYs9ltL4MPR1ImZ5SxlHJbesXhhb+tcdQAgK1XPS+SM7yv+ptRaMEg/+Cb5IWo
         75Ulw3Sn9OmM8hrx3jHbKwm+z2pxtTw+VZFbnOkdjotJsXkSMr3P3ohzgJKcwx75S0Hh
         DFVL8d19ZdAMSPMotGz50prA4xdu5F235mEdABJfa3Ql0F7iZk+CUhRdoV+E8SLWhFOV
         i7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAErNgS/j8DCnY2ERck8XX1Z4inkZWw1VYk+KrVuhjw=;
        b=fDuxWHjanIh9pDE6oIkkzSfncnheZMhkm7/fsj51u5sYMpFK9WvyZ1OJQ2M9EFGUL8
         U5WcKXLvHW/TvJe27UELypgDnIrGPVCSB0i91ylIPiUuCaq7Vg80lzh2Viz6AHIcW3Kn
         zg5BniqtolyDIyVpgyd6B82O3jSciz1ottv/XwR7kHhvDxm13qewYsL663Lr8JLbWu8v
         FWNHCr6QqcLCMl/CPnEvVl1tXhPQxr4gH9sheWgq+QZ17eDJTXowK2VPOdzMsaf50MsD
         7ugPE43bke12ZpnZikdIANNLFJIF7kOhOa2VMjNiy6VJIRddYHa0dD2Swh9h/QAE7Th6
         wzMA==
X-Gm-Message-State: AOAM532zertTrldODdCqsBKxMJVBOGMJXc9TVWLrZfpTq2d0mvV8bxfz
        SOTLmc9WDcW49TSUNKCA9FVqY81hUOc=
X-Google-Smtp-Source: ABdhPJxRN2p0uVsep9uFsS1xMSmExZeXxLSkk0jSME26BDXwBp/th5Be0d6L+/yjmnRb05ilkTMgjQ==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr23077064wmq.153.1624823200906;
        Sun, 27 Jun 2021 12:46:40 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id g17sm7466428wrw.31.2021.06.27.12.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 12:46:40 -0700 (PDT)
Subject: Re: [RFC] strcpys(): New function for copying strings safely
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     glibc <libc-alpha@sourceware.org>
Cc:     tech@openbsd.org, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
Message-ID: <38428d5e-ead2-bf18-e198-cecd4caeb3e7@gmail.com>
Date:   Sun, 27 Jun 2021 21:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <755875ec-baae-6cab-52a8-3c9530db1ce6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/21 9:26 PM, Alejandro Colomar (man-pages) wrote:
> 
> It is designed so that usage requires the minimum number of lines of 
> code for complete usage (including error handling checks):
> 
> [[
> // When we already checked that 'size' is >= 1
> // and truncation is not an issue:
> 
> strcpys_np(size, dest, src, NULL);

Also, given how unlikely this case is, I have in my code:
`[[gnu::warn_unused_result]]`

I forgot to talk about it in the definition I sent.  I would put that 
attribute in the glibc definition, if this is added to glibc.

To ignore it, a simple cast of the result to `(void)` should be enough 
(or a more complex macro, like `UNUSED(strcpys_np(...));`).
> 
> [[
> 
> #include <string.h>
> #include <sys/types.h>
> 
> 
> [[gnu::nonnull]]
> ssize_t strscpy_np(ssize_t size,
>                     char dest[static restrict size],
>                     const char src[static restrict size])
> {
>      ssize_t len;
> 
>      if (size <= 0)
>          return -1;
> 
>      len = strnlen(src, size - 1);
>      memcpy(dest, src, len);
>      dest[len] = '\0';
> 
>      return len;
> }
> 
> [[gnu::nonnull(2, 3)]]
[[gnu::warn_unused_result]]
> int strcpys_np(ssize_t size,
>                 char dest[static restrict size],
>                 const char src[static restrict size],
>                 ssize_t *restrict len)
> {
>      ssize_t l;
> 
>      l = strscpy_np(size, dest, src);
>      if (len)
>          *len = l;
> 
>      if (l == -1)
>          return -1;
>      if (l >= size)
>          return 1;
>      return 0;
> }
> 
> ]]

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
