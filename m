Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF98355C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbhDFT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbhDFT4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:56:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SmuAICY7BfV2FQ+TWZqN5rr6C144dVwfzZ62LXjDgDI=; b=EhawNeEXpMRPlr1ZhJ3QQHx5Zf
        +LoaIUlKOpitU0CxrCHiXJT68Dr645j4vuu6J0PZIqVtqW+RSRoyPzocyN6tBo86mm169kTIUAJtW
        mOvce3s1KJ2x+9bIgfqJvCInxD1dYguBlOwvsXwYLNrYsw2sQwdODQCAeXh/5Uk5YWT2hnYX+XISl
        jS62mWkspKvymAoUOuSRrTnQl85OXp9zr4dygdB0YHq7xCDExbcMdAGsxkascDc7hUSWDVFiYVg+F
        o8KUXoNpkgVQcglfei6ujXuv5GOLqI99o4p2Gy25H/aLjM9VvyDckYLORCgvK7qj29C1PuVGB2CJE
        Nm3geIqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTroD-00DLMI-Tr; Tue, 06 Apr 2021 19:56:27 +0000
Date:   Tue, 6 Apr 2021 20:56:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: emxx_udc: Ending line
 with argument
Message-ID: <20210406195621.GU2531743@casper.infradead.org>
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
> Cleans up check of "Lines should not end with a '('"
> with argument present in next line in file emxx_udc.c

I appreciate that you've removed the checkpatch warning, but this is
still harder to read than the original used to be.

> -				_nbu2ss_writel(
> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> -					p_buf_32->dw);
> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> +					       p_buf_32->dw);

> -		length = _nbu2ss_readl(
> -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
> +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);

> -			regdata = _nbu2ss_readl(
> -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);

The real problem with this driver is that their abstraction layer is
wrong.  For example:

        /* Interrupt Status */
        status = _nbu2ss_readl(&udc->p_regs->EP_REGS[num].EP_STATUS);

        /* Interrupt Clear */
        _nbu2ss_writel(&udc->p_regs->EP_REGS[num].EP_STATUS, ~status);

If instead this were:

	status = nbu2ss_read_ep_status(udc, num);
	nbu2ss_write_ep_status(udc, num, ~status);

that would be a lot shorter and clearer.  Cleanups along these lines
would be a lot more useful, and would fix the 80 column warning.

