Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1A427A86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhJINUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 09:20:55 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:17795 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhJINUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 09:20:53 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 199DIstP033910
        for <linux-kernel@vger.kernel.org>; Sat, 9 Oct 2021 16:18:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1633785529; x=1636377529;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ckKyUHmU7gJo2+oFHkmh6RC60f+uVdxjSMn5gB9IgbY=;
        b=Qwc+i07qGWbXH0b7vJAVLxw2ZH19m7ZBDydSyaSvcejdyZ+1gqm8MnOTOwKFoNrn
        CdRJJiEhrP4SakknRldySe4UGSZfma8xQYc1afXgu4/4eDsweJ1ECdM0gTNIDMah
        uY8tEwUKG0dHT5VWwmg+ncmWLYR32B82AX8sWyK8S5GZ9BlMwdo/cewHxktW1fMh
        rIIjtpHgWRIMQofUcOWskTYGKbYKf/jDt2ohegLKJA1bzB6RAQg63lZVXXK2JPns
        r8d7vt6geI6k04qIc1yIr8TRqeSfL2vVPsKA8QtvENwxG6GCxKbJRSCINc7Vf/m/
        fL2VcXEuA83eSZyOhD7Y1g==;
X-AuditID: 8b5b014d-b84f570000005d46-85-616196b990c7
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 4E.86.23878.9B691616; Sat,  9 Oct 2021 16:18:49 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 09 Oct 2021 16:18:48 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Don't use va_pa_offset on kdump
Organization: FORTH
In-Reply-To: <CA+zEjCtJqNVrtr_Wkij2c=3+P5kL6jJN5RPULfZj2c5mGzCVjw@mail.gmail.com>
References: <20211002122026.1451269-1-mick@ics.forth.gr>
 <CA+zEjCtJqNVrtr_Wkij2c=3+P5kL6jJN5RPULfZj2c5mGzCVjw@mail.gmail.com>
Message-ID: <ae122f06f0de1075cf266b639ce36da3@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXSHT1dWXfntMREgxlfJC3WLbrAarH19yx2
        i8u75rBZbPvcwmbR/O4cu8XLyz3MFm2z+B3YPWY19LJ5vHn5ksXjcMcXdo+Hmy4xeWxeUu9x
        qfk6u8fnTXIB7FFcNimpOZllqUX6dglcGUtaZrIUbOaqmHf6NnsDYydHFyMnh4SAiUTb/MWs
        XYxcHEICRxklDs1oYIZImErM3tvJCGLzCghKnJz5hAXEZhawkJh6ZT8jhC0v0bx1Nlg9i4Cq
        RN/lT2wgNpuApsT8SwfB6kUEjCUen5jIDLKAWWALk8TP00fYQRLCAtYSHb8eg9n8AsISn+5e
        ZAWxOQUCJTY9uwc2VEigXmLLtW1MEEe4SOybO4UN4jgViQ+/HwD1cnCIAtmb5ypNYBScheTU
        WUhOnYXk1AWMzKsYBRLLjPUyk4v10vKLSjL00os2MYJjgNF3B+PtzW/1DjEycTAeYpTgYFYS
        4dUySUwU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsurNyFeSCA9sSQ1OzW1ILUIJsvEwSnVwGSw
        5ruPkY3r7XOrlqRtNmWsenIj6vXyx/uTPx9qjGC2m9/xImfnknXiLz+02Nf4aj1vV3ruXlO1
        c9LWbW3qb5hn8HYkuUYYiLGelZ0pffCr641/SzZeSdsomj+h0f1vRNSXvW2XU25K8cQcnSb5
        bpbP1sfiQS4tDhXKEifsOcIL/zI9PqRV37ivktn1k5zUAr/essre4oK13+/NW5z/XHjd74Rf
        D/xrFKPL7rboV/ctyPy24EQQb+Rtn8e/WabW/tYvlme8/r39QqdlosT9uCmxs8LUvzPcNbPP
        kfSundW0lyuJdf7pK1Pku1tur6lReezOM1NU31to0fs5cTuSZGe2z7GYmOlb2/FA9cABUyWW
        4oxEQy3mouJEANaGCTzwAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-10-06 14:13, Alexandre Ghiti έγραψε:
>> +
>> +       /* This will trigger a jump to CSR_STVEC anyway */
>>         jalr    zero, a2, 0
> 
> The last jump to a2 can be removed since the fault will be triggered
> before even reaching this instruction.
> 

Just switching SATP to zero doesn't generate a trap unless mstatus.TVM 
is set (for visualization purposes). The hart will try and execute the 
next instruction but it's not clear in the spec what happens in case the 
code is cached, I don't want to rely solely on STVEC. I prefer having 
this instruction there, note that some earlier QEMU versions also had 
this behavior (the original kdump patch didn't set STVEC and it worked 
fine after setting SATP to zero).

> 
> This patch fixes a regression introduced when moving the kernel to the
> end of the address space, so we should add:
> Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear 
> mapping")
> 
> And it should be backported to 5.13 and 5.14. It seems that the
> following tags should be enough:
> 
> Cc: <stable@vger.kernel.org> # 5.13
> Cc: <stable@vger.kernel.org> # 5.14
> 
> And finally, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> 

ACK, thanks ! I'll resend the patch with the tags you mentioned.

Regards,
Nick
