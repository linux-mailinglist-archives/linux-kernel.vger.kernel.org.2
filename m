Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC7403726
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbhIHJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbhIHJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:44:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0BC061575;
        Wed,  8 Sep 2021 02:42:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so3715918lfu.5;
        Wed, 08 Sep 2021 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tcxDxLsWHGr7j1cvxMG2JLruNGk37pPqhVGSTiHNRTI=;
        b=geGIKAXuwrxvpukyugOKBZCm3v64zHneGc4gUrxldK2pKi2rdjMNXnfj8dgx8K58uf
         ogvILTSHxVVBAyqLgjYHreu0k52T++uJp9lOvpiKnpIQ8Bjyz2BIX7YxHlOjn1gortwr
         QOkCGYy9DhxEIO6grVDNeIYuzaEpDIKRHkrvbnADXd+UfND9vaLyUaIZYjH3EbSwN7zu
         hs5MGlB4oIUF1M2DKo6NAAxX4oQmhFNJxeIdmT7c6S72Ui3a+eZ0yvPXJLtQ+owtPjvi
         S8dDAis6RFUobhVc7tVIRcEpEso4uMkcIqQrszZhhuu47/TXi4vZaBTUqGSAjOO/A+Pr
         mauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcxDxLsWHGr7j1cvxMG2JLruNGk37pPqhVGSTiHNRTI=;
        b=sejXb2knxRiBfHkL5IFAG5/MeeSFZWuJgc5FY3VajtYf5Yo9n4iSJ8CgtRYsPEhB0n
         gKXVDWQjBCBSda4bhTvoMA884m0tK89UcbuXS0fOIzqMm4wUACjMenu8UgykUFWBbnwT
         7gnrJ0x2ymlyTZIxQhwsEHUruz1fS88Cah6sQIvtizbvl6mm72AR+DD95O/Sfuq9ycyQ
         DugQ+45mnDds2mXnob6ZxnhVWfkTxYXzdZecejbqREc1YxLpIXrsul2cwjGJLjaEIEbS
         YTnAhboqOk8D3zWNOWmKPwJOwryMoYB1SucCYC8PGiJBAQuDe6aegFWshwqgxJc75iGT
         TKZg==
X-Gm-Message-State: AOAM531wMXNHE3DkG/EpEO0xPPBkOR8Ttsh960QIWFx2gwkT2SZHWGTr
        lm6QwX+RHu0dW82awYCyKL0=
X-Google-Smtp-Source: ABdhPJxrOHq4d4XwI1TCtF/j7UjWh+chOlUNydbJM4p4e9w/eyyWqy8UuaUlIgCkRr7/6Fru0VeUQg==
X-Received: by 2002:ac2:4185:: with SMTP id z5mr2080264lfh.391.1631094175380;
        Wed, 08 Sep 2021 02:42:55 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id o8sm142625lfr.265.2021.09.08.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:42:54 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 1889gpxA015666;
        Wed, 8 Sep 2021 12:42:52 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 1889gnns015665;
        Wed, 8 Sep 2021 12:42:49 +0300
Date:   Wed, 8 Sep 2021 12:42:49 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        lee.jones@linaro.org, osk@google.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: Re: [PATCH v2 0/3] arm: aspeed: Add UART routing support
Message-ID: <20210908094248.GZ23326@home.paul.comp>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 02, 2021 at 10:18:13AM +0800, Chia-Wei Wang wrote:
> Add UART routing driver and the device tree nodes.

Thank you for working on exposing this functionality in upstreamable
way, that's so much better than all the register-level hacks in U-Boot
and similar approaches!


One (somewhat) related question that I hope you do not mind answering:
is there anything special regarding the routing or other configuration
that needs to be done for VUART to work with IRQs?

The reason I ask is that I have tried hard (and I know several other
developers who have too) to use VUART functionality but somehow as
soon as Linux was booting on host and starting to use the IRQ-based
16550 driver the communication was halted both ways. Basically, the
BMC firmware was enabling VUART in DTS, then setting LPC address to
0x3F8 and LPC IRQ to 4 and reading/writing using the corresponding
/dev/ttyS* node. The datasheet is not clearly telling what other
actions need to be performed for this to work. Not using VUART and
instead routing UART1 lines with exactly the same pinctrl/pinmux
worked just fine. One detail is that with VUART the host wasn't seeing
new interrupts but when they were simulated by exporting the LPC
interrupt pin via /sys/class/gpio and toggling it manually the data
was getting through.

Does UART1 need some explicit disabling for VUART IRQs to work? It
looks like setting LPC address and IRQ number in VUART is enough to
override the register part but probably not for the interrupt?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
