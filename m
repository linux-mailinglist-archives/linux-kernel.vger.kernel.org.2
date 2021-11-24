Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD745CD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbhKXTTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:19:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbhKXTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:19:42 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637781388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmsvgnsSUwaCsHrtNAsS05IGGIqDZzIag/Ga4puBnFA=;
        b=ZYV4UDZU4N/9cyayPsDgxcP9nx9QGeNGBYaNM0GDMjFGqaY/bnG4V/FmYEtNvm6P8rY5MJ
        3rccYp1WWsnQDAg7saxO4zgvdgYAT1pp+X+Tzi4Sh4giMC9gPm0UpMfRuV073XgnCIyy/o
        xBXGgrzlH1VUd/opSROMO5Sv/6tIGnFxNNhSqBxArzqXgXesgOt97BqaUDPoK87if/muTw
        oIYAqcYGvZ8mb+7Dm7aL6SDXxbjYYjCwR9rrE46eyt0v5xQzMXF7QabuArj72jGOPi4oxv
        pl8AF7zPFbXGbjcGg33FiU8Wms8OhD1dYLbJ9bX1YsUDGbhLWFtrHJqBBV9Zjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637781388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmsvgnsSUwaCsHrtNAsS05IGGIqDZzIag/Ga4puBnFA=;
        b=K4QHXbtZnem9T9E/60f74Ej5cgfbIHVqk1qjSlUXc0vEH4klTv4AN+wb0J2GQJwgZniQr2
        f5mSdnK6Qx1pdDBQ==
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] genirq/irqdesc: Add state node to show if IRQ is enabled
In-Reply-To: <20211116123447.23902-1-srinivas.kandagatla@linaro.org>
References: <20211116123447.23902-1-srinivas.kandagatla@linaro.org>
Date:   Wed, 24 Nov 2021 20:16:28 +0100
Message-ID: <87ee75l5yr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16 2021 at 12:34, Srinivas Kandagatla wrote:
> While debugging some issues with SoundWire WakeUp interrupt,
> I did not find a way to figure out if the interrupt is really enabled
> or disabled.

You can find this information along with more details when you enable
CONFIG_GENERIC_IRQ_DEBUGFS. Dig into /sys/kernel/debug/irq/

Thanks,

        tglx
