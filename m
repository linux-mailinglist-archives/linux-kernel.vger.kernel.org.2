Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9740C0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhIOHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhIOHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:50:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38038C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:49:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631692155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8ZsftnXQY0yr5QVgLvw1STRelfZ7fLDoxanpwIPIh8=;
        b=qh4zLOU9gnPI5NHI/OZb7dJhDxulvNioQPVqr8DiElQ/8KejY4xH+MI7VZhKzRj3Iz87Ws
        lXWA0n+h+haQPRs9+OoAFzWXFUvNFYBTC2UWdW2MW2HruQx+cCMwgJveE85du+I5VMRfnl
        JvH5Jio+ayuDGBSPaKZ3H/6+CH9jpRSzwBUYm7mmFyTYnq15LXa3lhzlv3tAMZSFZ+xvEQ
        Y9nJC+wx8P5RNyAqUBKwiO/lhbxn7E7d0m0FvKdMtYxC8vzflkNEEEaHFIEocEf3GETj8z
        gIuO9iL4rJjDvpDE3nR50UDQo5iD5kScko+fea721Yvo78EUtYi5c2E7T2dYsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631692155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8ZsftnXQY0yr5QVgLvw1STRelfZ7fLDoxanpwIPIh8=;
        b=mgriXtZQ8i3MFvlDqFr6u9VdZ/Rqgtrx8dqTC3IQM4OW5XXR60fFRH6W7+CiHF7698AAzI
        8wD07xImxQfBWYAQ==
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, john.wanghui@huawei.com
Subject: Re: [PATCH -next] irqdomain: fix overflow error
In-Reply-To: <4f614b66-ad85-7fa3-6e6e-2a672e8148e3@huawei.com>
References: <20210908014623.61357-1-cuibixuan@huawei.com>
 <87o88vcqvh.ffs@tglx> <4f614b66-ad85-7fa3-6e6e-2a672e8148e3@huawei.com>
Date:   Wed, 15 Sep 2021 09:49:15 +0200
Message-ID: <87pmtab7no.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2021 at 10:03, Bixuan Cui wrote:
> On 2021/9/14 19:56, Thomas Gleixner wrote:
>
> And kernel/irq/irqdomain.c
> struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
>                                             unsigned int size,
>                                             unsigned int first_irq,
>                                             const struct irq_domain_ops *ops,
>                                             void *host_data)
> {
>         struct irq_domain *domain;
>
>         domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
>
> All 'size' passed to __irq_domain_add() are unsigned int.
>
> So I think it's more appropriate to replace it with unsigned int.

Appropriate is not really a technical reason. Making the code consistent
is.

But that has nothing to do with the completely bogus compiler warning in
the changelog you provided.

Thanks,

        tglx
