Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A83271AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhB1JEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1JEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:04:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D13C06174A;
        Sun, 28 Feb 2021 01:04:02 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id r25so14788384ljk.11;
        Sun, 28 Feb 2021 01:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3Uu/ZsgdYlP08kLSEVkeDEOcieYxfw0pQ354JPC2Q8=;
        b=IGC6oxBgqtzKuECaslYLe0rrGIsJ4UFxxy4GL4v/Zs8RE/qpumzSmXwsvH9mKfU7Uj
         dZEnVt3oVbN5duSQthBazjmPgd4/gXFuecaEtAHNWlRMGGTNiYJOrE+A/8ut47CupCet
         Iq5JjE0rSivojPuiG6oDZ1Vscq579fbYjoIy7ez2wwlFgK/lOGW2QSaOciDeRFAIlTpq
         Miak5nST3JWg/La8t9L4iAPOGqj03qI4rPHMMw5Lq18AWI9oZHYGjmzV5M0k1M9NxO6U
         i8ZTEnHYoEBcAL9gtm/pLqabb2ilr+FtUK+dX0qUE0U66Awq7ygP9TJHpiO93Z9rdm2c
         EaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y3Uu/ZsgdYlP08kLSEVkeDEOcieYxfw0pQ354JPC2Q8=;
        b=LKzOi9D5JpXeJiommoWkIwonBsy84Gj3f2G5N0YhUjSacWJaUPVF7px8EqmEoi1HTR
         WTYP+Fje8HvEl421BnXwzyXc/Oqql5vGeoAXp+76wUgfkQn5jxQVCNbDyTHsiVuf+ZsY
         LOh7buUM0Os1M8+ayMtGOC5wlK73dOHqb5ImTh2U0GyLrfVlbfuWK7woMPMFZ3s4M4iv
         XTOvAJxdsXdcUeY59EfeGbk3sz6URk0M5gDvDxlfdzYA7WGPSK2W5OKij07Tkm3aZ6TK
         zMNg7leELDcpaoTx7y79ei6Tm/FwugVB6MmGv+C56qa6OP4r15x1Up2nrtVoHjAZRbSu
         nMog==
X-Gm-Message-State: AOAM5312jyqRoQHaPrxQR7P9enxc38MhndLvX01zDwSpN6gk1NtxsMMo
        L+a8wJwJMhek6IfE5CIjnbGqzpZ5YGOI/w==
X-Google-Smtp-Source: ABdhPJwRbm12LrWwbcR6zUKZ9YTXpgi2ThJ1DGoXccMSMQ5SbAREgYAFsD/S4IzWXMwy+RvvMSRvTw==
X-Received: by 2002:a05:651c:1318:: with SMTP id u24mr6298895lja.426.1614503038657;
        Sun, 28 Feb 2021 01:03:58 -0800 (PST)
Received: from [192.168.1.100] ([31.173.86.90])
        by smtp.gmail.com with ESMTPSA id a1sm2035353lji.22.2021.02.28.01.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 01:03:58 -0800 (PST)
Subject: Re: [PATCH 19/20] usbip: usbip_host: Manual replacement of the
 deprecated strlcpy() with return values
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-20-romain.perier@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <045eb376-f490-9608-6e54-68d39e83c3f9@gmail.com>
Date:   Sun, 28 Feb 2021 12:03:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222151231.22572-20-romain.perier@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22.02.2021 18:12, Romain Perier wrote:

> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.

    Length. Possibly?

> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values
> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
[...]

MBR, Sergei
