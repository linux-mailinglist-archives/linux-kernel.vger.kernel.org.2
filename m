Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB83AF720
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFUVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:02:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08830C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:00:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so902663wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xA58HD/7gnajS6qk34Ai7OQ9mkRPbhDwepfq+viVvEE=;
        b=jjaBzzj/7EfHBKn4zRPnzH4Uj/gaxV9Ap2RnuYS3uJZrdnBaYqOtOtcgVMhc1/NjvU
         kLoc8wvqKLtTGYlQxZEqTDiypimXvljAOCRxoiKAjWImuirFzZKI6PeVXRgOXJKetR77
         OYl64f7LAKhsJ782dtPt3BewXxS29NRUU5lsPs9TftA6vcWMx/8nWZWz9htWb9fEJLft
         0ziCJyt8G7JZCsGIp4oSqVN4nKUYwt6f+FduOvMaHvJLAKyG2XHnvfbE5iDdKopqe9gk
         WzDwoRCZYEGMTRNCPF26iZcW1v756targ9vE49IEoaaRzZFNPrw+XEJ4HXkLM6W17WAz
         2+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xA58HD/7gnajS6qk34Ai7OQ9mkRPbhDwepfq+viVvEE=;
        b=D26pA6jhrFl1Y7uycg/GVOJJgfDEeh9slSxBn7ba8ln9m9JIoKqVgMUTT6xZDYjesU
         M0WyqDSJIp8P+W1SVD6Wannyu5ZJ8jeryJQdySPtV1/tUq4UGpTXXz6hYvu0HSkClwYR
         E0Ve4pSx8qVQYwxh9vNdbXgBqDFeN/E05bvxgPVvmfNbb0V2EtFnVMgJuNX6pj8s4C3p
         TkdqHLEahIp0XiKC7QRCILupXSGYaYvPzDgx+StrLgBa1B/8v0eXEPd0zLtrAqcJD70N
         54MMCPV4VvSDKibtuYcs5lqcysNP1IFyrikuCr/uSxTWqFvxqu6bQoXig2svigU+Scee
         QVgQ==
X-Gm-Message-State: AOAM531fvXBlWQlS+KcxVu5mcYmEVqt0NQm4bVjOG7CY0nX8y8w5PMLB
        jc2vutw9ogQ5T5uExlPxZvKUOA==
X-Google-Smtp-Source: ABdhPJz8ODwHt5Y5HBln/QPZYlLgKLzimB5hQ6XwJ/lhbau52eKnFqAQAQLjJ58VFQCgXOBMPUnvSA==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr247455wmb.55.1624309202217;
        Mon, 21 Jun 2021 14:00:02 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id z10sm133978wmp.39.2021.06.21.14.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 14:00:01 -0700 (PDT)
Subject: Re: [PATCH v3 01/23] x86/elf: Check in_x32_syscall() in
 compat_arch_setup_additional_pages()
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-2-dima@arista.com>
 <87tulth9j8.ffs@nanos.tec.linutronix.de>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <2fdcea8f-521d-c06c-15f0-b0b6782fd30e@arista.com>
Date:   Mon, 21 Jun 2021 21:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tulth9j8.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/19/21 9:41 PM, Thomas Gleixner wrote:
> On Fri, Jun 11 2021 at 19:02, Dmitry Safonov wrote:
>> Partly revert commit 3316ec8ccd34 ("x86/elf: Use e_machine to check for
>> x32/ia32 in setup_additional_pages()") and commit 9a29a671902c ("elf:
>> Expose ELF header on arch_setup_additional_pages()".
>> Both patches did a good thing: removed usage of TIF_X32, but with
>> a price of additional macros ARCH_SETUP_ADDITIONAL_PAGES() and ifdeffs.
>>
>> Instead, use in_x32_syscall() - the first thing load_elf_binary() does
>> after parsing and checking new ELF binary. It's done that early after
>> exec() that mmap() code already uses it straight away, which is needed
>> to know which mmap_base to use (see arch_pick_mmap_layout()).
>> Add comments to describe how it works.
> 
> I still have no idea what this is trying to solve. All you describe is
> what this does.

Yeah, I still have problems with describing why rather than what sometimes..

How about something like this:

In order to simplify code, new macro ARCH_SETUP_ADDITIONAL_PAGES() can
be dropped as well as a new argument in
compat_arch_setup_additional_pages(). Resulting in partial revert of the
commit 3316ec8ccd34 ("x86/elf: Use e_machine to check for x32/ia32 in
setup_additional_pages()") and the commit 9a29a671902c ("elf: Expose ELF
header on arch_setup_additional_pages()".

Instead of a new macro and an additional function argument, use
in_x32_syscall() which is already valid at the moment of premapping
vDSO. Add comments to describe how it works.

Thanks for reviewing,
          Dmitry
