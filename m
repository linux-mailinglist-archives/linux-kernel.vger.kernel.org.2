Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB464234E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhJFAXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhJFAXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:23:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA5B61130;
        Wed,  6 Oct 2021 00:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633479690;
        bh=ltKsTN9cZ4N8XPWfPdkSWUVeIpLJzf3W7XZH7D6zU+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S03C9f3C4Q4+KP1/KFfr03vmY5lzBVy0D4IpwpVkXnmO+thjW1Fv7bB4p65NWgTU/
         5Q7KQGaaaF31hx8cBfKS1WL+5FKZnk4O3rLfiGARWzZ/Y3g/cwWkcx6iHdbrjmU3EC
         043YloI9L5buArku8zgAq+DihYuUyz9gRnkPbHL0=
Date:   Tue, 5 Oct 2021 17:21:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-Id: <20211005172129.4092cc4148bbcac36a128b55@linux-foundation.org>
In-Reply-To: <YVmd7D0M6G/DcP4O@localhost.localdomain>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2021 15:11:24 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Kernel assumes that ELF program headers are ordered by mapping address,
> but doesn't enforce it. It is possible to make mapping size extremely huge
> by simply shuffling first and last PT_LOAD segments.
> 
> As long as PT_LOAD segments do not overlap, it is silly to require
> sorting by v_addr anyway because mmap() doesn't care.
> 
> Don't assume PT_LOAD segments are sorted and calculate min and max
> addresses correctly.

It sounds good, but why do I have the feeling this will explode in some
unexpected fashion?  Because it's elf, and that's what it does :(

