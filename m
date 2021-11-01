Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D91441FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhKASXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhKASXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:23:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788EC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FmpiN0JeXadxFm1B2urNgZ7EEIDPC1g3NeWyJIxU4xc=; b=vZBvRvvoQyzUZ0nzL1nfdCdAJa
        UuWKEpz7BppRy8V60iZKv/6ahu4CEFkDcgAqvrQ0OeBDaH7IpgbXLKeeZW0fvYhwSKZE7yjh6pNq7
        1Quf+xa42oC37/Ubck5r8JOUP5gJ7MakQUPrg0tMYRxVpMsTu4/heWTGfSzW2hrTEUWsKMLEiERjE
        pkUk8g7oXcu7rO5HzwvrBs6OvMLsBrneMhGL9T+27o/K2yfTrFPd42NeLh8IWzqzoj0DdKtMZpeZT
        syZu1lXYCtRwKjaEmN+++cM+6IloimGd01WIxVTs35XHBwDpmT7yTUmL+5XZIWdqu/bibUuexGlAY
        io9zmYLA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhbvM-00H0LB-Ov; Mon, 01 Nov 2021 18:20:48 +0000
Date:   Mon, 1 Nov 2021 11:20:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question regarding register_sysctl_table()
Message-ID: <YYAwAEPN2/itbz7+@bombadil.infradead.org>
References: <565W1R.3MI0EBO1N6WW@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565W1R.3MI0EBO1N6WW@effective-light.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 07:27:41AM -0400, Hamza Mahfooz wrote:
> Hey Luis,
> 
> I recently came across [1], and was wondering why it is desirable to
> unexport
> register_sysctl_table()?
> 
> 1. https://kernelnewbies.org/KernelProjects/proc


https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200528-sysctl-cleanups

But please read this thread completely:

https://lkml.kernel.org/r/20200529074108.16928-1-mcgrof@kernel.org

So I'll refresh this work soon.

  Luis
