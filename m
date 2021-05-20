Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934B138A07F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhETJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhETJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:00:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EACCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 01:59:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621501168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXGVI7v2l5GZv6QJ6hatHTiLGrRfl7tnAvPh+UOI1+I=;
        b=GdonHB5zQFOhzEJU4bND6W7H9MufJUu73L4PJR9B/SLteyh1/6h4fKXU9/ALeVio606PJe
        yLpPPI+tbIF+vzEReV49O2n7/qjP5miZy5sBlTAbJCYOnMahJJNHrKzr9STCiYIluIOanw
        UkVzLr1tldbyjpTvMqqiq+AjxP3yLj5UgaWWYaN0zKzLQRVDAsYYi5tIPG5iVqLbcXHfAx
        cXlua85jOPo1oZFGDss7ME630eUbwesFZLFp32XrDm6j0eB+JtAcgIlClm36NYN2ho8b09
        VXc0zKnSQutjveqvjSvBHMcxNAW9ijTsEAW7ygfNqc+VgjWIiww9HpFNVcRLSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621501168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXGVI7v2l5GZv6QJ6hatHTiLGrRfl7tnAvPh+UOI1+I=;
        b=68iA3nVcRDLZE1YxHJ304TJ0PcEtiVWa3BWbciEmTTUEzwRosdMm9+diHTDGtKtoC5jacG
        m9wRv/NWMAwAYYDw==
To:     Jingxian He <hejingxian@huawei.com>
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, hejie3@huawei.com,
        hewenliang4@huawei.com, wuxu.wu@huawei.com, hejingxian@huawei.com,
        Sang Yan <sangyan@huawei.com>
Subject: Re: [PATCH] rtc: Fix hwclock write fail problem in x86 arch
In-Reply-To: <20210519092349.513729-1-hejingxian@huawei.com>
References: <20210519092349.513729-1-hejingxian@huawei.com>
Date:   Thu, 20 May 2021 10:59:28 +0200
Message-ID: <87wnrtbx1r.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19 2021 at 17:23, Jingxian He wrote:

So at 17:19 this very same patch was posted by Sang Yan <sangyan@huawei.com>

   https://lore.kernel.org/r/20210519091908.513593-1-sangyan@huawei.com

Can you please coordinate patch posting internaly?

It has the same broken SOB chain as this one:

> Signed-off-by: Jingxian He <hejingxian@huawei.com>
> Signed-off-by: Jie He <hejie3@huawei.com>

See Documentation/process/submitting-patches.rst

Thanks,

        tglx
