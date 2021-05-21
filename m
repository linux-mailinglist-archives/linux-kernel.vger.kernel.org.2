Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDC438CBFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhEURWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhEURWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621617677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwR/0GNmU1erDIzfTwdpHCjLZxYNU+OZQVJXmXfAYfM=;
        b=W5fWme5Hd+Jcv5dARmQY20ECe0ju151UZ2O4BRqkF9W7SpHktRUhD452X9/vUAxRBtNVxy
        kCb+SSt1RjAeP0VBG0j9twQuC+M0EKckf8fiOi48pwgVw77eUXZd04NbKtCIAZJYgBch0d
        i6gzM/MpCDuLtqoC/M1TI39U0pQ/UiE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-iVqz53gPOHShsLFeiK43ew-1; Fri, 21 May 2021 13:21:16 -0400
X-MC-Unique: iVqz53gPOHShsLFeiK43ew-1
Received: by mail-ej1-f72.google.com with SMTP id jz28-20020a17090775fcb02903dc26615f46so1793829ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qwR/0GNmU1erDIzfTwdpHCjLZxYNU+OZQVJXmXfAYfM=;
        b=MTk3LyyPZwI8oymEc3PvzUNVNb1t89reLnEPRc9SBPrYl86BFBWlUtArXH9OLtJkhO
         +sV5RZyJnF31u0BdNvvGujV/1Ep8xSufNy5ejUSADWIpIrYJ9AzWRxBg1/m275/4HCtg
         14n3zwIX9bcV6O5JC3RshWRS/WkfnXhCPnLMj4PP3qwGwWtqfGWmF5qiencdXGpYmmHy
         YURdjIXMN4dqlABVta2ETYBBglhVuQkpBMi8HSbHDfQovYmXaKdWTnBfSG+sG/kETQ7Z
         6XrlKgE+mVfdvx4vQnn2xuJs3UE+5c9YFjisX8cyllgjn+cyJ84uUMaL7obmFaO14Ezp
         uAHQ==
X-Gm-Message-State: AOAM532UEwrr+ph2tkp2YA03XFs74jzaJHCfO9O9ltrwD2b9AAXWA0Dy
        CyFse3YkAnBlYuhS+HXL+KLgpgra8We/Mj+x6JG0oBBHFHB6rbWEcGibASqa9t0M6LYa7e80WC5
        aDQXbZmmFKc+pvUK9+0fcTTZB
X-Received: by 2002:aa7:cd03:: with SMTP id b3mr12350061edw.206.1621617675165;
        Fri, 21 May 2021 10:21:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs1PPEtRit2YsbPl3fyEJzFG+BMaVTPI5cJbO+TcDqnJ8UNSbmnYU1JgZsPGIv6fh/e498XA==
X-Received: by 2002:aa7:cd03:: with SMTP id b3mr12350048edw.206.1621617675016;
        Fri, 21 May 2021 10:21:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m12sm4079494edc.40.2021.05.21.10.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 10:21:14 -0700 (PDT)
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, graf@amazon.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <mhng-37377fcb-af8f-455c-be08-db1cd5d4b092@palmerdabbelt-glaptop>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v18 00/18] KVM RISC-V Support
Message-ID: <ff55329c-709d-c1a5-a807-1942f515bba7@redhat.com>
Date:   Fri, 21 May 2021 19:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <mhng-37377fcb-af8f-455c-be08-db1cd5d4b092@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 19:13, Palmer Dabbelt wrote:
>> 
> 
> I don't view this code as being in a state where it can be
> maintained, at least to the standards we generally set within the
> kernel.  The ISA extension in question is still subject to change, it
> says so right at the top of the H extension 
> <https://github.com/riscv/riscv-isa-manual/blob/master/src/hypervisor.tex#L4>
> 
>   {\bf Warning! This draft specification may change before being 
>   accepted as standard by the RISC-V Foundation.}

To give a complete picture, the last three relevant changes have been in
August 2019, November 2019 and May 2020.  It seems pretty frozen to me.

In any case, I think it's clear from the experience with Android that
the acceptance policy cannot succeed.  The only thing that such a policy
guarantees, is that vendors will use more out-of-tree code.  Keeping a
fully-developed feature out-of-tree for years is not how Linux is run.

> I'm not sure where exactly the line for real hardware is, but for
> something like this it would at least involve some chip that is
> widely availiable and needs the H extension to be useful

Anup said that "quite a few people have already implemented RISC-V
H-extension in hardware as well and KVM RISC-V works on real HW as 
well".  Those people would benefit from having KVM in the Linus tree.

Paolo

