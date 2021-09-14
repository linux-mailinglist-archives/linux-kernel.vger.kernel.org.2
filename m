Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73040AD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhINM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:28:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhINM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:28:22 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631622424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMs7eRVf7WZVlO2rvbc4ggFxzEshoEoI2sMVNW5jfHA=;
        b=S2dlEmMPnzFVj0Yr5uaW98D0wHnA7TWdKIEKAmCdMMiVT6OP/CW2jFfN9iBoCONXaQ4Yyc
        ssirJ6oOfonmLhPrlyZVLTwQgcBSzS2VBJ6NVeOa0Bbro9p43Wy/Nux1XCYczHsdDS5KtN
        exPeb/irwKDHAbwg1iHTGJdl0t0T6VtpuU3BGdGciKXXtbN0EgtoZhx3KCMpbm63lvPMWe
        qGDR/FTp6jv54kQmHW4toU6OCns7qe4AtAu6t2M+kIW1NPtxQ8Zq4UZi1xErEjVDo2FsZj
        KCk8SsLmmdjtpi6rRclplQibStGD6h8kRnqx3ZNkxfGfmonjd5QsGrXXpQAoVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631622424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMs7eRVf7WZVlO2rvbc4ggFxzEshoEoI2sMVNW5jfHA=;
        b=lOkQle13+r8kObXOu+Agg331vU9fX/KVjjA+VrT7DumI9GZ3k9KbONNR0BEbYBbM3rHi5e
        ERtBgxzZ+TlZmPDQ==
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re:Re:[PATCH 6/6] irq: Potentially 'offset out of size' bug
In-Reply-To: <1631609290-2830831-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1631609290-2830831-1-git-send-email-jiasheng@iscas.ac.cn>
Date:   Tue, 14 Sep 2021 14:27:04 +0200
Message-ID: <87k0jjcpgn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 08:48, Jiasheng Jiang wrote:
>> On Fri, Sep 10 2021 at 03:26, Jiasheng Jiang wrote:
>> The find_next_bit() use nr_irqs as size, and using it without
>> any check might cause its returned value out of the sizei
>
> On Fri, Sep 10 2021 at 18:28, tglx wrote:
>> Why exactly is this a problem? The return value has to be checked at the
>> call site anyway.
>
> There is really a check at the call site, but the annotation of the 
> irq_get_next_irq() is 'Returns next irq number after offset or nr_irqs 
> if none is found', which tells the programmer should not check the
> return value of it. In case of a programmer write a new call for the
> irq_get_next_irq(), he may not check the return value because of the 
> annotation said.

The return value has always to be checked because nr_irqs is guaranteed
to be an invalid index.

> Therefore, it had better to add the check inside of irq_get_next_irq()
> to fit for the annotation.

Care to look what find_next_bit(..., size) does?

    * Returns the bit number for the next set bit
    * If no bits are set, returns @size.

So for:

    res = find_next_bit(addr, size, offset);

res is guaranteed to be:

    offset < res <= size

IOW. irq_get_next_irq() is doing exactly what the comment says.

So again, which problem are you trying to solve?

Thanks,

        tglx
