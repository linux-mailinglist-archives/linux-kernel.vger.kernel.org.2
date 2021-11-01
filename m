Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52924412E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhKAFOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhKAFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:14:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1742C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 22:11:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 127so15314143pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 22:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+gy4ZHgkNOY/BP2CTwX/6iD0OJ4gwZx+tJZjl+zW0M=;
        b=SL+XZ93QCYUn6g9HxEgUJ5QNZ6q4ALMBhOcfw9P2nerr2sVsHn1ggyEGqOBo4CKqre
         oZxZKFi9XdHbtqxdBi/J/MHYhk7qlWtxD8eXpdWHHmRFaST58CmNUYmBVecHcscV8ZiL
         82vKxfVbCBaaZe8LOBQtryXAP5/zRNxVoXxTiRUrfWWztrBd6Rd0OuKFaiu0p1Zi1BaR
         cvKn+hWH6JXz5qaIY0Hg79aI+YOl83QfFmRKuMGFX7NcF0Ny/7ofILY6c35LJm2UuXJm
         c6SNNREkRnOMWHQyV6EPsPtejY83OsfWllIbSJtBTI96x9d4dZWgULeLPiUHqSrB5ZAz
         RB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+gy4ZHgkNOY/BP2CTwX/6iD0OJ4gwZx+tJZjl+zW0M=;
        b=C3GP8NCq/cgp18gJtkYMf3CXARVzMO9lE9UCz2XsNxzxbBV3W0MDa2pJwBgaROt+aJ
         hvaoT8A7ex7FxnYKUQXesezT6Wx+yZihZ2TnMt/Rchj6kIlw+kJ7DBfgoM1uEMPoZU7l
         bXBr2ANDXIeDCFkB/OtLjdUaypEqLrL75iRYrrg1fhFG9mQYqc2SExgFzQDxJHvqdA5X
         JeO7BFUW4PQok9P0t+K3jtZrNq0w93D23aAC0at/qGpJV1kt0u1ZKRTrLgMpGpcYvNXt
         BJlIV8vRc7YOy6Svc3p1iQ6gSbq8fAmegMIABx1c4JVFOK166zKZGyOWuuQx2MFhd0hk
         zMYA==
X-Gm-Message-State: AOAM533OF6skGUCOAfZpuwNVs1vtnn6Y/60heGdRIFS5vsrvb/GJAeYD
        P/wBZnOp+k4HHUulvgAjI0Y=
X-Google-Smtp-Source: ABdhPJyRTTGtedZA4Pexqtrk2YQjxluNocy/QJmN0OSJJ8pvytJgcNLwhdDwYQ31kGg5E8J4lVFVxA==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr26472239pfm.65.1635743497328;
        Sun, 31 Oct 2021 22:11:37 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id 1sm13332702pfl.133.2021.10.31.22.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 22:11:37 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id A48D5900823;
        Mon,  1 Nov 2021 05:11:34 +0000 (GMT)
Date:   Mon, 1 Nov 2021 05:11:34 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Marc Zyngier <maz@kernel.org>, guoren@kernel.org,
        anup@brainfault.org, atish.patra@wdc.com, tglx@linutronix.de,
        palmer@dabbelt.com, heiko@sntech.de, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
Message-ID: <20211101051134.447647af@gmail.com>
In-Reply-To: <20211028135523.5cf4b66b@redslave.neermore.group>
References: <20211024013303.3499461-1-guoren@kernel.org>
        <20211024013303.3499461-4-guoren@kernel.org>
        <87a6ixbcse.wl-maz@kernel.org>
        <20211028135523.5cf4b66b@redslave.neermore.group>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 13:55:23 +0300, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> This indeed happens with SiFive PLIC. I am currently tinkering with
> da9063 RTC on SiFive Unmatched, and ALARM irq fires only once.

Happy to see someone else having this issue. I hit this issue in July
and tried to get feedback, but nothing happened and I gave up:
  http://lists.infradead.org/pipermail/linux-riscv/2021-July/007441.html

My uneducated guess, by spying on the registers behind the kernel's
back (see the python script I attached), was that this could be
specific to level-signalled interrupts, where the IRQ re-triggers in
the PLIC right after being cleared but after being unbound from any
hart. Then the "IRQ pending" flag is set (causing the IRQ edge which
would normally trigger interrupt handling in associated hart) without
anything noticing, so it will never be cleared and never be handled.

> However
> with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> begins to work fine.

Great news, so this issue will be fixed in a better way than my RFC.
RFC which can hence be discarded in patchwork, I believe:
  https://patchwork.kernel.org/project/linux-riscv/patch/8c36c1a28ce63b5120765fd3c636944bfec8bee9.1625882423.git.plr.vincent@gmail.com/
(I'm not sure if I can do it myself)

Regards,
-- 
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
