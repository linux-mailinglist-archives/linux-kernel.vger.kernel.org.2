Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99B359BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhDIKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:21:22 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:31883 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbhDIKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:19:51 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 139AJb3U022165
        for <linux-kernel@vger.kernel.org>; Fri, 9 Apr 2021 13:19:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617963571; x=1620555571;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FcdW2pK1FPyss3ZOQ0A9eTn1YvwQct1bsYua2abjDLo=;
        b=VV+0cvFlY6micMneUT8WZPCnHrE3uHm9bZeW/lUexAGBbb23Q+AuEzn0fFPcH41n
        ahSBcUZ8UYJFf8rV3o0rTKl9tG5/EXQQ0Jzc72kjuVTguSUERzArqP4m2PBiZhJX
        HSvMwP7NVjHgbYkRzkwSdhTY1AXkL1K/0Uc9pxkhdAcWLUiyAiDHONuu9dgMoZbL
        haCJq8y8lui8Ad5VRo4VdzlCdTQT9PVbXdyqZjkpxf5SKlSLQwfRwgestv02wQSZ
        p/3Yk8QXkoXU7Vxz4VEdM+KMLShXnlGo0EgIw44+poUwvwiB+QxAumrQKzerl1vC
        KqG2bmaE8ubf1J1cuXWCoQ==;
X-AuditID: 8b5b014d-a4c337000000209f-bc-60702a339219
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id B9.20.08351.33A20706; Fri,  9 Apr 2021 13:19:31 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Apr 2021 13:19:28 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] RISC-V: Add kexec support
Organization: FORTH
In-Reply-To: <386bf260-006a-62c4-2d7b-1a22a43b3513@ghiti.fr>
References: <20210405085712.1953848-1-mick@ics.forth.gr>
 <20210405085712.1953848-3-mick@ics.forth.gr>
 <386bf260-006a-62c4-2d7b-1a22a43b3513@ghiti.fr>
Message-ID: <3c821aaf141651f5c58c84bb0f294e9b@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXSHT1dWddYqyDB4HSXmcWzO19ZLS7vmsNm
        se1zC5tF87tz7BYvL/cwW7TN4ndg83jz8iWLx70T01g9Hm66xOSxeUm9x6Xm6+wenzfJBbBF
        cdmkpOZklqUW6dslcGU0rX3EVvCTpWLnpJmsDYwvmbsYOTkkBEwkXrdcYe9i5OIQEjjKKHHr
        9wZWiISpxOy9nYwgNq+AoMTJmU9YQGxmAQuJqVf2M0LY8hLNW2eDDWIRUJV49vMsO4jNJqAp
        Mf/SQbB6EQE5ibbuI4wgC5gFljFKbDy+AqxBGGjB3tkbwBr4BYQlPt29CLSYg4NTwEbi1cZy
        iINmMkrcXzyVBeIIF4kzN24yQhynIvHh9wN2kHpRIHvzXKUJjIKzkJw6C8mps5CcuoCReRWj
        QGKZsV5mcrFeWn5RSYZeetEmRnC4M/ruYLy9+a3eIUYmDsZDjBIczEoivM3N+QlCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeXn1JsQLCaQnlqRmp6YWpBbBZJk4OKUamE47rWj9XzrPqz5gyZ6v
        wTt6Jf7fOa5r8GwPM3dX7ok1GkVbXAMLDWrSzuSKdIhercnVefoqWS5NKcHPi69ypmqzXfLq
        XpWVN3ee8ltUw1tp6vgxedl2PXOt9kL5L+cf58+RDKz4Mfvh6h0VUrwJ29QnnDHX2H35qO+c
        EItLrKxL1rs+cj8YdO5Aj0Si0ud/j3+4fc2e6Cy4teDh1IbwcLa86V8tJRiPc0VvlP0WkfbV
        IKSzzs/WdV0hD/fiP3ZvRP/Pbzsu/oRDhmfyhv8atQmSWbUtl+c2rWC7dlN4Lven1dMt2qfZ
        sLlq3do2b32f8+nJV+1KdTnk5iot7O71zwvUy61fMFePSVuxtW6tEktxRqKhFnNRcSIAHbEJ
        f+YCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-06 21:38, Alex Ghiti έγραψε:
> Le 4/5/21 à 4:57 AM, Nick Kossifidis a écrit :
>> +
>> +/* Reserve a page for the control code buffer */
>> +#define KEXEC_CONTROL_PAGE_SIZE 4096
> 
> PAGE_SIZE instead ?
> 

Yup, I'll change it.

>> +obj-${CONFIG_KEXEC}		+= kexec_relocate.o machine_kexec.o
> 
> Other obj-$() use parenthesis.
> 

ACK

>> +	li	s5, ((1 << PAGE_SHIFT) / RISCV_SZPTR)
> 
> 1 << PAGE_SHIFT = PAGE_SIZE
> 

ACK

>> +#if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> 
> Shouldn't it be defined(CONFIG_SMP) ?
> 

It depends on SMP anyway, I'll remove the second part.
