Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6E324E97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhBYKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235833AbhBYKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614249727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLELNZ5FMw6J4z0iKytGOymiuDW68WgnsMFftjnmb3U=;
        b=MujttOYAAXDZVjY+ISeFsbAIIMOJkMLIJTEpdRPYTmxa/grvQlT68Cjt7BpAlMRqhT5z8b
        Ds4LP5sz4P5tCPjDLJTqF9ToLxbEYZvZKQzrYXmYDLLkKeflZdMOZGAHogmmBmWws8Pr58
        7Dr/7BVYikWAPJjZ9JiwycR7ZcUkE5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-9Twa_P-UPompV7D5BK6ZWg-1; Thu, 25 Feb 2021 05:42:03 -0500
X-MC-Unique: 9Twa_P-UPompV7D5BK6ZWg-1
Received: by mail-wr1-f70.google.com with SMTP id p18so2485639wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLELNZ5FMw6J4z0iKytGOymiuDW68WgnsMFftjnmb3U=;
        b=CQbI0WTCBGeH4+M+PmPNqiFZFmvY0SyJhLXwkCSNa1XoEuEMCu2RqDy4R5oz5v2HFZ
         U9F1gIoHaG+pZI8E+cAr2tVEBCB98G/w4fOk+FFOiPmtDFFdQcccROw8ov3umFlq6WIF
         vqgmgdqI5GsMFIqd2oHBaYlChhopo6490BakMK765mHpv5/J7OyOCVpH+d3F+ek2L70j
         IrPyh/OCEfF4pAiOk/lXlSH8tq8zpt2jRex52ge7etmaiG4u/QW1IeJHqeh8zOR8C6nD
         A2my5fyPn/9z/PW2ekjedjlw4ITVcNJUVHi6bLJF2n7kPStn3ZNCcDxJsk07wz0dmZnf
         QYow==
X-Gm-Message-State: AOAM533CAFPZCRb93l+UuwqpUCr2P4ptoENEWfpVDZrRfEdWRxVQnWj/
        8Z3yR7XJR/xl5wj3Z3hHeDMKchglkN1jig5eihOmSube4tkII7K/E/uLWmolM+RqalJRU7PRqAN
        55O06d3/LKdqalMxbv64uUoXa
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2670941wml.85.1614249722767;
        Thu, 25 Feb 2021 02:42:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjHZny+md3A4rkmBqva8+hrRgJTToTSVwt8zHgw2dpZZvzOvM6kHDDFppl9gmd6MGX55E77g==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2670929wml.85.1614249722656;
        Thu, 25 Feb 2021 02:42:02 -0800 (PST)
Received: from [192.168.1.36] (68.red-83-57-175.dynamicip.rima-tde.net. [83.57.175.68])
        by smtp.gmail.com with ESMTPSA id q140sm8013865wme.0.2021.02.25.02.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 02:42:01 -0800 (PST)
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
To:     Nathan Chancellor <nathan@kernel.org>,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
References: <20210211194258.4137998-1-nathan@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ac57db8-3866-297a-dc37-87c565b51ee2@redhat.com>
Date:   Thu, 25 Feb 2021 11:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211194258.4137998-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 8:42 PM, Nathan Chancellor wrote:
> fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> which violates clang's CFI checking because fw_cfg_showrev()'s second
> parameter is 'struct attribute', whereas the ->show() member of 'struct
> kobj_structure' expects the second parameter to be of type 'struct
> kobj_attribute'.
> 
> $ cat /sys/firmware/qemu_fw_cfg/rev
> 3
> 
> $ dmesg | grep "CFI failure"
> [   26.016832] CFI failure (target: fw_cfg_showrev+0x0/0x8):
> 
> Fix this by converting fw_cfg_rev_attr to 'struct kobj_attribute' where
> this would have been caught automatically by the incompatible pointer
> types compiler warning. Update fw_cfg_showrev() accordingly.
> 
> Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1299
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/firmware/qemu_fw_cfg.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

