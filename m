Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA11C36D254
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhD1Gkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhD1Git (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:38:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B40C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:37:54 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s15so72835174edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H2MBTNvsrMqWEHkmYsxdcgfxC68PzfrMdSTO7rP4y5o=;
        b=i84V/ev2P714PbNslabL5l9hLlbdi2YaN0M+ELAABRzdnfBmQwNyKQjF6tsc+DWT68
         4DLOoVm83eP60xCaWgZv+M8xY1JnpJlS8yqM7dw+IaSmVKMhGWlhvv6a7uG5gG9e81LU
         DwW4EYKZL7b1dJL/c6ORnkzfn0XTDMYLiwEO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2MBTNvsrMqWEHkmYsxdcgfxC68PzfrMdSTO7rP4y5o=;
        b=Pod8f/LZKl7aGOWZvQmQKm60ek61UAyFEbUwNjQhiml/w7npnV1vyQA4QSbbFOVj4x
         /kF4qehm3guzdlJEdTq8bSImbWrg83px1/7wSdQ7ujefIGiT2phvviGoEgwQJIN+6eOd
         X9gNUfWvpF8l4B1y2w+YXGDUSmGTig3uLZJh3dtInmVVtr64cfmH/jRVC7tEB7fKkPa0
         gNRDurJ9niKxyJk2CM/ciQCN0ziEH7TE7KYH/QNxIkI9sLutcpRmnahYo1C9W7oup87C
         B/EoZLKL3EaYcl8PCpH60iH+WBDSS5SVVWLLC7/M/kXeyP503hA9y0ltaflQNYbOlA4D
         zijg==
X-Gm-Message-State: AOAM533x+dfsJM3WPFcHo5kYgW5EBsPlArk6F8EzKxP54WCJ06IY0BII
        qe4foKwGRtvbosCjmAziEQ4Nzg==
X-Google-Smtp-Source: ABdhPJyQuljWqP1ndOlVjWURUtYpufdshc8XG3yrG6ftQJx5KiHRohI/5e382rYD80udA+UfHKBR4A==
X-Received: by 2002:aa7:c2d2:: with SMTP id m18mr8799900edp.96.1619591873494;
        Tue, 27 Apr 2021 23:37:53 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id w1sm4166299edt.89.2021.04.27.23.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 23:37:53 -0700 (PDT)
Subject: Re: [PATCH] lib/string: sysfs_streq works case insensitively
To:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     ndesaulniers@google.com, gregkh@linuxfoundation.org
References: <20210412113315.91700-1-gi-oh.kim@ionos.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <24530d5a-5611-469e-a4f7-cc704589e9a5@rasmusvillemoes.dk>
Date:   Wed, 28 Apr 2021 08:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412113315.91700-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 13.33, Gioh Kim wrote:
> As the name shows, it checks the strings inputed from sysfs.
> It should work for both case-sensitive filesystem and
> case-insensitive filesystem. Therefore sysfs_streq should work
> case-insensitively.

What in the whole wide world does case-sensitivity or lack thereof of
filesystems have to do with whether or not the sysfs_streq API should
work case sensitively or not?

The sysfs filesystem itself (1) works like any real UNIX file system
(i.e. case sensitively) and (2) sysfs_streq is not in any way involved
in readdir or lookups or other such filename operations in sysfs.

Very confused,
Rasmus
