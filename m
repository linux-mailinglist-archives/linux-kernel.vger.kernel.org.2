Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548440ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhINL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:57:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhINL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:57:52 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631620594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgr1WY0ptWXwp1GY0AayvdB+LemAOWeDFerYEs3bOh4=;
        b=g6VnGSeXbdoyzc23BO2nmG1RNmf+wWQU4cMW6LKq3h9z3ouDUpuWB8GYSY86TSpXFnjh0H
        kQphiQw5hKuj1pqGaezBc4fcLMn/okHWEPcS41ivSIn98DLYBv1HMy0OBaMmbSeLT2yApR
        pVRJ7SjJYL9GvrGUB/YTtyY/zLyUmDz7nCXVk9lceHlVVQWrWvsjvIdvxtx1eWgUHpbPWr
        WZsQBCbI33+Z4/ubtHv0ezKxzq1P1y0pPVbjwWnA8v1maVmyad9xihkUT4sJqsbcCS2OeB
        dUG1JMjGiXn2OgXj8qPtYjIANiwBfHa4GageC2dRi07B5gYZNO7VkO91AniumQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631620594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgr1WY0ptWXwp1GY0AayvdB+LemAOWeDFerYEs3bOh4=;
        b=FpZYy1fZzpPSixu+14fWVAgjbLNpKR1OdIs6JBtsBOTSJb6T7mQ0Qik/gMOq34h37tfD71
        UQs53VSc+poQ+9AA==
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, john.wanghui@huawei.com
Subject: Re: [PATCH -next] irqdomain: fix overflow error
In-Reply-To: <20210908014623.61357-1-cuibixuan@huawei.com>
References: <20210908014623.61357-1-cuibixuan@huawei.com>
Date:   Tue, 14 Sep 2021 13:56:34 +0200
Message-ID: <87o88vcqvh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2021 at 09:46, Bixuan Cui wrote:
> In function =E2=80=98kmalloc_node=E2=80=99,
>     inlined from =E2=80=98kzalloc_node.constprop=E2=80=99 at ./include/li=
nux/slab.h:743:9,
>     inlined from =E2=80=98__irq_domain_add=E2=80=99 at kernel/irq/irqdoma=
in.c:153:9:
> ./include/linux/slab.h:618:9: error: argument 1 value =E2=80=981844674407=
3709551615=E2=80=99 exceeds maximum object size 9223372036854775807 [-Werro=
r=3Dalloc-size-larger-than=3D]
>   return __kmalloc_node(size, flags, node);
>
> The 'size' can be negative here, which will then get turned into a giant
> size argument for kzalloc_node(). Changing the size to 'unsigned int'
> instead seems more appropriate.

What's more appropriate about that?

Thanks,

        tglx
