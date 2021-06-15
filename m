Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53B43A88C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFOSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:42:58 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:62321 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFOSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:42:57 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15FIen0g054091
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:40:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623782444; x=1626374444;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lU3S79OL8aRFG8ZByT/siWnFf5JF+7RmA4BPFIBrq4I=;
        b=RxKhO0KuZKkNykzDOLAoyMVll28GHzN3MXSgEPavidtja4FgNOXQ6OgfYYEHvKR7
        rCxbg6+AmwNj62zrLI0x62BvwIOSRGyAdjyV6lDOyN2n0GZysnIG55oh4vvfDEuE
        dsqGjGDr2qU17Xw6taVnLCREqJTmbdtDAO4SCL81B1Ut/tja2bcPZFAEblbn/34n
        2U573H/zV0Nj//7ALGb6hSa/eruWcy7JUbJvBYVihg395W/gnoX5TBbhNLX4R8kB
        9ySrxkKPcJ8olyvHIraCsB8dAoI2pjy1eVYy894DHtHvNcxe6MBiqkhWcrqOzJ7y
        SJJ+xN7zxQ7S7XFBQwKOVA==;
X-AuditID: 8b5b014d-96ef2700000067b6-32-60c8f42bf9cf
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 3F.54.26550.B24F8C06; Tue, 15 Jun 2021 21:40:44 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 15 Jun 2021 21:40:43 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
Organization: FORTH
In-Reply-To: <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
References: <cover.1623780059.git.geert+renesas@glider.be>
 <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
Message-ID: <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42Lpjp6urKvz5USCwd/FzBZbf89it3i/rIfR
        Yv6Rc6wWM9/8Z7OYO3sSo8Wmx9dYLS7vmsNmse1zC5tF87tz7BYvL/cwW7TN4rdo3XuE3aLl
        jqkDr8eaeWsYPd68fMnicbjjC7vHxLO6Hjtn3WX3eLjpEpPHplWdbB6bl9R7XGq+zu7xeZNc
        AFcUl01Kak5mWWqRvl0CV8bjk3dYC35xVczauZSpgbGDs4uRk0NCwERi0q0dTF2MXBxCAkcZ
        JR7+eM4GkTCVmL23kxHE5hUQlDg58wkLiM0sYCEx9cp+RghbXqJ562zmLkYODhYBVYl/DxxA
        wmwCmhLzLx0EKxcRMJDYev4ZG8h8ZoHfzBL7DrezgiSEBXwlfs28yA5i8wsIS3y6exEszikQ
        J3F5Vxs7xEF9jBKzXr1jBFnAK+AisfetCcRtKhIffj9gBwmLAtmb5ypNYBScheTSWUgunYXk
        0gWMzKsYBRLLjPUyk4v10vKLSjL00os2MYLjitF3B+PtzW/1DjEycTAeYpTgYFYS4dUtPpEg
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnJdXb0K8kEB6YklqdmpqQWoRTJaJg1OqgWmOnO2lS2Kz
        3wuGGSy8uGHPVHHf0FK2AzXn8rLuvSpdOt8wp0t/E2cgn26o5+6znEXfcvM2FtlOULl/wNgv
        UvXMyi6+yoUbv03c8W9mgrvv7/OvJs9d+feWiem9ta8OKuWomW4+ILjcdfvJDhb78lOZvAde
        X7Ky/huw8GX0r1X7mUMOxRk7epRlsp7lCGM31Lv36lTdr+2vf7McEyqIduo/m/Tm4NzcRfaH
        FMTibFT/e+2dsEW+Z8Ws263VqvOenpQ3KCh9H3H/iq3R7RMvns1x2h6y1sv5HJvri/Df80UY
        RbbsjJK/utXQ4CfX9mtnN1ie1e+Jby5VU52ZeHT9T+tNvYdPTOKY72hnK1ubd+WbEktxRqKh
        FnNRcSIA8LuqARoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-06-15 21:17, Geert Uytterhoeven έγραψε:
> RISC-V uses platform-specific code to locate the elf core header in
> memory.  However, this does not conform to the standard
> "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
> with the "linux,elfcorehdr" compatible value, instead of on a
> "linux,elfcorehdr" property under the "/chosen" node.
> 
> The non-compliant code can just be removed, as the standard behavior is
> already implemented by platform-agnostic handling in the FDT core code.
> 
> Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

NACK

There is nothing standard about "linux,elfcorehdr", it's an 
arm64-specific property on /chosen and it's suboptimal, it gets the 
addr/length of ELF core of the previous kernel through that property and 
then goes on to reserve that region at:
https://elixir.bootlin.com/linux/v5.13-rc6/source/arch/arm64/mm/init.c#L155

Why on earth is this cleaner than just defining a reserved-region in the 
first place (a standard binding) with and hook up a callback with 
RESERVEDMEM_OF_DECLARE for it to also initialize elfcorehdr_addr/size ? 
If you don't like the compatible string I'm ok to change it, but this 
patch breaks kdump on riscv since that region won't be reserved any more 
and kernel will corrupt it.
