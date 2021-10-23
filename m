Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4C3438534
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJWUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:16:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E26C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 13:14:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l203so2053559pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2q2Ai1W7zLMeyRuJVIqJmYh8Gpg5gJL9O2P05Fxiya8=;
        b=jDXIeRw2lMvP9QXCRDr98k0E3NG6kVLbc6ibvQMLhmNJyYeTgi4pPlxhZcjbZJk4i0
         IyQm7LA87ns61cISjW228eZeKxZX/ER4AgwIF/+WHCjuXZfUYFPEKppPOzh2aZ+d694B
         3ha3oMnfaNs0Bg9g9NZ/V5ReGH7gGeb5VROrVGM5yVuv044NomMEUZvHZtLJ0ZoJvJCf
         oyf1uFtcZVb2eFeH5yDs9W4QWqBC9p05Tzmf2LP6bEws0Zyyg/7aofj26QQ+Qd4Tyz4s
         9gNeXHwZtVHL59ZDzTVkUHqn3ofTNxjOG4GQv4x7Z+P6uh311NhS3FBoydSMXNvB/WWK
         GkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2q2Ai1W7zLMeyRuJVIqJmYh8Gpg5gJL9O2P05Fxiya8=;
        b=b3BJs2wPMJbJ8E7RA8QqTBTzRU1yIUV5ZGL+3/wc3Jo1D/uWmICyNJBrDyN1luVmI2
         5OTvhzqcNkJn5vTYZJ5XQVJ5toK0lWpKhAVBLsOZjxA03kUlHiPshFgUGAj2e/OdK8z+
         eu6xe11fIk2Y0r9AukKgecUFXXt7P9xc+oRqtIo4K3b+DIWSfUundrdPgBswgGsWiaoh
         bq9gb0RuEF7Ie965nPJfITlMby/rlI+LACwpgCao+L9y3A9yC7yec5jSfLpvZYWzsvEn
         1x/K8g2HlJ96Sj2NTU/54Eb8y1li5sCZsdj5M9GmzaDfm/0zlNnveJeuZ02nAXdQTpZP
         wvBw==
X-Gm-Message-State: AOAM532JPLfBA3KUFFrh0OnFT72i1rW/Atps7RMYIb8KVnKn2sPqtweD
        y8t5KVaUMhIorwO5g8GLjNqVng==
X-Google-Smtp-Source: ABdhPJw4wq16pwdD9R69riGYv3v4DtTpscpbmhP+5/EUwMF5d/exuQRw/i3eOSBVVEhc8KDGM0yrrQ==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr6020435pgn.296.1635020051809;
        Sat, 23 Oct 2021 13:14:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a11sm15191155pfv.11.2021.10.23.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:14:11 -0700 (PDT)
Date:   Sat, 23 Oct 2021 13:14:11 -0700 (PDT)
X-Google-Original-Date: Sat, 23 Oct 2021 13:13:38 PDT (-0700)
Subject:     Re: [PATCH] riscv: Don't use va_pa_offset on kdump
In-Reply-To: <ae122f06f0de1075cf266b639ce36da3@mailhost.ics.forth.gr>
CC:     alexandre.ghiti@canonical.com, mick@ics.forth.gr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-b28fa0cb-24ee-40d1-9f02-619605a4cc9a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2021 06:18:48 PDT (-0700), mick@ics.forth.gr wrote:
> Στις 2021-10-06 14:13, Alexandre Ghiti έγραψε:
>>> +
>>> +       /* This will trigger a jump to CSR_STVEC anyway */
>>>         jalr    zero, a2, 0
>>
>> The last jump to a2 can be removed since the fault will be triggered
>> before even reaching this instruction.
>>
>
> Just switching SATP to zero doesn't generate a trap unless mstatus.TVM
> is set (for visualization purposes). The hart will try and execute the
> next instruction but it's not clear in the spec what happens in case the
> code is cached, I don't want to rely solely on STVEC. I prefer having
> this instruction there, note that some earlier QEMU versions also had
> this behavior (the original kdump patch didn't set STVEC and it worked
> fine after setting SATP to zero).

IIRC this came down to some very specific wording in the spec.  
Something along the lines of the 0 in SATP meaning "no translation", 
SFENCE.VMA ordering translations, and the general "if the spec doesn't 
mention it then it has to work" logic.  I thought I opened a spec issue 
about this for clarification, but I can't find it.

That said, I'm perfectly fine taking the safe approach here as it's not 
like the performance matters here.  Warrants a comment, though.

>
>>
>> This patch fixes a regression introduced when moving the kernel to the
>> end of the address space, so we should add:
>> Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear
>> mapping")
>>
>> And it should be backported to 5.13 and 5.14. It seems that the
>> following tags should be enough:
>>
>> Cc: <stable@vger.kernel.org> # 5.13
>> Cc: <stable@vger.kernel.org> # 5.14
>>
>> And finally, you can add:
>>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>>
>
> ACK, thanks ! I'll resend the patch with the tags you mentioned.

I don't have a v2 in my inbox, did I miss something?  Also, if it's just 
the tags then it's generally not necessary to re-send something.  The 
comment does, though.

LMK if you want me to deal with this, or if there's going to be a v2.

Thanks!
