Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2073F66FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhHXRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240796AbhHXR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629825981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH/laxt92cAPsS5DORg7moxidJ+sFb/ugbwwhp2S/dk=;
        b=BfMltmJ2oONaD9ejn17glMjs9P0bRR9kUzA6Pry+9ECSWyGVz4ycy6wgEUByz+V4JhUJ9s
        HPAmF1i0qqRWSbIfut4PbxJGn5ySNPozWxwmNghWcvg8nVKsNFdG/k1NefB85ZOgXIMYjK
        RoOUIkRd9llpoWWOx8eAPu/aVihsHBE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-soa92xYrMeuWyaB4Ue6H3w-1; Tue, 24 Aug 2021 13:26:19 -0400
X-MC-Unique: soa92xYrMeuWyaB4Ue6H3w-1
Received: by mail-qk1-f199.google.com with SMTP id s206-20020a3745d70000b02903b9207abc7bso14799042qka.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wH/laxt92cAPsS5DORg7moxidJ+sFb/ugbwwhp2S/dk=;
        b=dwXtCvWXmcGkWfejv7hV/ItsuG5tq+AzPJO1sFJyJD7/Kf01yfUwFjeHzAKtmyuGai
         VTBO8LKQoLIE4Ix7C4AUPH0RYWTDCDjJQiFrhgrJy+AtPokLMbuhtVx/7tX288vzAqoW
         XyBPvdppCQTpUAMQBdecoUzwX7yTxHaWIqT/T03UZIvZyza7Oiyt7WgBkbjPf/Y7LPdk
         VuNg7JUOyeKmUkFGY6TFi6E+lCfLxI9ysty+nXnrC4+zpyzPKsRgBE9kei73WzVkl3gL
         K1d393dJHx3US/wNiqBqreiCPmULJBZ8WMad86Y602GgfzkpE/etS/4bkyMYgQ73EAUw
         5zMQ==
X-Gm-Message-State: AOAM532sOqxYDKWyKCsu8ilMaJPJ/9Ckdks0WqKqGau0RavFm9lirAhS
        1i6JxejCvrZElu20jhZ/ORNz1k8GO/xNdbD/inrA+LKxiTRLcXQNQc/Q0GdmUiCAYYAOrtGcM1k
        5P/jpTNFdkuhZMXi5sBILwiMI
X-Received: by 2002:a37:4141:: with SMTP id o62mr6348367qka.380.1629825979547;
        Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPfydha2WMaqbxaCR6qCBIVYjLefJCzf43YSyCq1K9A1bslH6yCHFkMwBJ4tvEQvd0jM3DVw==
X-Received: by 2002:a37:4141:: with SMTP id o62mr6348347qka.380.1629825979334;
        Tue, 24 Aug 2021 10:26:19 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-182-34.ptld.qwest.net. [97.120.182.34])
        by smtp.gmail.com with ESMTPSA id t66sm11093328qkc.3.2021.08.24.10.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:26:18 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] x86: Add support for Clang CFI
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <1706ee8e-c21c-f867-c0be-24814a92b853@redhat.com>
 <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <9349a92d-f2a7-9ee4-64db-98d30eadc505@redhat.com>
Date:   Tue, 24 Aug 2021 10:26:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CABCJKufrpx9arM-hfX_bR-efO+13VBMFNBTe4ff036VEZi1LZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 10:20 AM, Sami Tolvanen wrote:
> On Mon, Aug 23, 2021 at 10:16 AM Tom Stellard <tstellar@redhat.com> wrote:
>>
>> On 8/23/21 10:13 AM, 'Sami Tolvanen' via Clang Built Linux wrote:
>>> This series adds support for Clang's Control-Flow Integrity (CFI)
>>> checking to x86_64. With CFI, the compiler injects a runtime
>>> check before each indirect function call to ensure the target is
>>> a valid function with the correct static type. This restricts
>>> possible call targets and makes it more difficult for an attacker
>>> to exploit bugs that allow the modification of stored function
>>> pointers. For more details, see:
>>>
>>>     https://clang.llvm.org/docs/ControlFlowIntegrity.html
>>>
>>> Version 2 depends on Clang >=14, where we fixed the issue with
>>> referencing static functions from inline assembly. Based on the
>>> feedback for v1, this version also changes the declaration of
>>> functions that are not callable from C to use an opaque type,
>>> which stops the compiler from replacing references to them. This
>>> avoids the need to sprinkle function_nocfi() macros in the kernel
>>> code.
>>
>> How invasive are the changes in clang 14 necessary to make CFI work?
>> Would it be possible to backport them to LLVM 13?
> 
> I'm not sure what the LLVM backport policy is, but this specific fix
> was quite simple:
> 
> https://reviews.llvm.org/rG7ce1c4da7726
> 

That looks like something we could backport, I filed a bug to track
the backport: https://bugs.llvm.org/show_bug.cgi?id=51588.

Do you have any concerns about backporting it or do you think it's pretty
safe?

-Tom


> Sami
> 

