Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C334AD14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZRGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCZRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:05:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12554C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:05:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u5so9470460ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZpUocbZkJ2maV4+ZrCzVZctv3jGZXxi51+s/78q/tc=;
        b=ePZ6WU52Q2uUd1dLXBsT9YpSnh5fEW4yFErve3aYmxADNweSt5RPQuCMCLjcEJO8Kl
         KHhdmVzIhKXclp8LkHx4xNihuhqxl5+QbM6jxdayu2XvECiJiO/ulJG/+3IlmFPxklSU
         EwtLDp9N5D2VQDjpot//NnkXIxFaoklPaBhC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZpUocbZkJ2maV4+ZrCzVZctv3jGZXxi51+s/78q/tc=;
        b=qt5tANL32cldnN7WKdgrPlnEPe5JHbDd8FNtEthzuHys+M7NOMCAFL2iTZWCC3sNbI
         hBq0Gb/sEJ3Ai/XFKscJ9KBCMXsy9SDzbW9Krox+lp0v4EPXlI+a6WOw5GaRksP8u34r
         l+kJuhD3pUZSLhv7br5QIU1QDlB8w53TNAXu4sZguleyqaXrn+pTV1Z+5hUdBL3hSpXY
         clX/u183n+oj4/DqaV5GMlCm20wob07L89AKLOUyGWS9EpgNtAbQNc019lyxYuNMZUJK
         TGcm8uVygwO0tbxsC8Zg3tLYf/C2QfWp9Ts79hBMLwo51DVaIQG0GUS1Fwa2LSSjrtZm
         ttog==
X-Gm-Message-State: AOAM532SMA4gSAQUwQ/3/4ywxkUixEnMmvUHYi8wB+39Yn5cyVXct20U
        YediBu3KmU34xc8FRGEE1rz17ox2bVovzg/6
X-Google-Smtp-Source: ABdhPJybappXfN7dWpVL5+yt5MX2ruCnnHlsUmQ5duDm/DTZ9e0TkroNuFHKlW7Wcvht4/IDPhL09w==
X-Received: by 2002:a17:906:5d05:: with SMTP id g5mr16374503ejt.489.1616778348539;
        Fri, 26 Mar 2021 10:05:48 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id n3sm4046213ejj.113.2021.03.26.10.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 10:05:48 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] greybus: remove stray nul byte in
 apb_log_enable_read output
To:     Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20210326152254.733066-1-linux@rasmusvillemoes.dk>
 <3a04ad94-f8c3-4d2e-c6a2-d498ac3cbeb0@linaro.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bca9a507-0cfb-936c-5fce-a5fa3f05b0cd@rasmusvillemoes.dk>
Date:   Fri, 26 Mar 2021 18:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3a04ad94-f8c3-4d2e-c6a2-d498ac3cbeb0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2021 17.31, Alex Elder wrote:
> On 3/26/21 10:22 AM, Rasmus Villemoes wrote:
>> Including a nul byte in the otherwise human-readable ascii output
>> from this debugfs file is probably not intended.
> 
> Looking only at the comments above simple_read_from_buffer(),
> the last argument is the size of the buffer (tmp_buf in this
> case).  So "3" is proper.

The size of the buffer is 3 because that's what sprintf() is gonna need
to print one digit, '\n' and a nul byte. That doesn't necessarily imply
that the entire buffer is meant to be sent to userspace.

> But looking at callers, it seems that the trailing NUL is
> often excluded this way.
> 
> I don't really have a problem with your patch, but could
> you explain why having the NUL byte included is an actual
> problem?  A short statement about that would provide better
> context than just "probably not intended."

debugfs files are AFAIK intended to be used with simple "cat foo", "echo
1 > foo" in shell (scripts and interactive). Having non-printable
characters returned from that "cat foo" is odd (and can sometimes break
scripts that e.g. "grep 1 foo/*/*/bar" when grep stops because it thinks
one of the files is binary, or when the output of that is further piped
somewhere).

At the very least, it's inconsistent for this one, those in
greybus/svc.c do just return the ascii digits and the newline (and if
one followed your argument above and let those pass 16 instead of desc
one would leak a few bytes of uninitialized kernel stack to userspace).

I said "probably not intended" because for all I know, it might be
intentional. I just doubt it.

Rasmus
