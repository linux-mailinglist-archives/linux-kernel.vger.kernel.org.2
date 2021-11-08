Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE444806A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhKHNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbhKHNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:46:22 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128AC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:43:38 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p18so15763485plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=MS7nnjIZsLVYvAxWmECFlYcPKdLp0NL2xHEapbPg21g=;
        b=QlrcVAvbhGh9RH5+ne0P5+9W7CkIVKDVGkM3lg96WFIxf2nPGkVUO/yIY+x7lz5lpc
         9nKOaZGw2f72CQS+/8NdD3S7cLwj5RS0oPQwoxjTGAeXvuVPpgquVMqIOkPFjXRVUFqc
         9e+fq5fQ3lMTctovhkc8ou4K59lzTK/edSYpLCgg8ETrzGs3y9+hq7td4mylUTwpTyRd
         DtNff0PoReLh8CZv18xmB2bEQ/qM02HD1whSf3Ui8r7AtpcsOy0Vwh01Q9FVV/1RppMY
         fcM+ShM5v09zEhleW8ab+WkR5kie+PGT/He/McA+RG4k5SNyxX5D8eVJyDi6UAjxmzKk
         jAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=MS7nnjIZsLVYvAxWmECFlYcPKdLp0NL2xHEapbPg21g=;
        b=wwUwv9HOpaHGltcjdPIuYK1JJoOlRcyzWFLVuPI0+g8VzQWTfXhQLG2YWZm1T9mWlb
         YeYkqvIJeQWMqcXpTJIH0GSxnSsZK0CHEC3MUuSVxJmPBUM0kdVChGz+e6dbl3rO9kSM
         HNDzn8+n5TtXdomsOzu9h0mjtZ1apUW5CQpfiaNwUx9oQfgVg6eGYnXtDcb0neFsisMI
         Fe3d1Ag4YZuSHRyrmU2xunskaFqVf/WmaI9Pq7URkH/zp3X4St7giZRj4qvg2Dxf7JcL
         WZMMOBprvfMILzISI/zqlZXLuLHWi/qZ1FvYBMmiXWhOVRy0Bep4ldhJzWkVOS1VA23t
         lvJA==
X-Gm-Message-State: AOAM533s9n6KVzFDZB3VtZzzMFyuWylaFPqNsQVJ7LdRKpE5eLm59bcO
        RHHBLvCZ4S539gE+bZ82zqPg8Ky7sJY=
X-Google-Smtp-Source: ABdhPJytgbuVpVIZ+ywoxQcNGlW2/Jyti0syu/bow7XDMBEhswPIVOUTSR6xxoHEpXgPIPEQcYy3CQ==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr51647988pjb.143.1636379017670;
        Mon, 08 Nov 2021 05:43:37 -0800 (PST)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id c21sm17448976pfl.15.2021.11.08.05.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:43:37 -0800 (PST)
Date:   Mon, 08 Nov 2021 23:43:31 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] printk: restore flushing of NMI buffers on remote CPUs
 after NMI backtraces
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20211107045116.1754411-1-npiggin@gmail.com>
        <YYjg/s6oSzZ26Uv+@alley>
In-Reply-To: <YYjg/s6oSzZ26Uv+@alley>
MIME-Version: 1.0
Message-Id: <1636378987.yp4skjpgb1.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Petr Mladek's message of November 8, 2021 6:34 pm:
> On Sun 2021-11-07 14:51:16, Nicholas Piggin wrote:
>> printk from NMI context relies on irq work being raised on the local CPU
>> to print to console. This can be a problem if the NMI was raised by a
>> lockup detector to print lockup stack and regs, because the CPU may not
>> enable irqs (because it is locked up).
>>=20
>> Introduce printk_trigger_flush() that can be called another CPU to try
>> to get those messages to the console, call that where printk_safe_flush
>> was previously called.
>>=20
>> Fixes: 93d102f094be ("printk: remove safe buffers")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> We should add also
>=20
>      Cc: stable@vger.kernel.org # 5.15
>=20
> No need to resent the patch. I could add it when pushing.
>=20
> Plan: I am going to wait one or more days for a potential feedback
> and ack from John. Then I am going to push this into printk/linux.git.

That sounds good to me.

> IMHO, it makes sense to get this into 5.16-rc1 or rc2.

Agree.

Thanks,
Nick

> Thank you both a lot for nailing this down and for the fix.
>=20
> Best Regards,
> Petr
>=20
