Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B3434771
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhJTI6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED0161004;
        Wed, 20 Oct 2021 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634720168;
        bh=Zb6cdSPaiuzX2LILzLYpQZahassfoYygri0Z+gn9Gz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FicmaPqpkSATWNrLIg8kQtlJwJHkROycKClRvuxklISlxxuO30+tNoBPYHiBsCIBY
         C6Ud01eugF8PkSmgVqo2XsImrPWY0z3qR/a/K0N43SLAWSUD0W9ULDN/+B15nFQJQs
         i5RvQMtOvPKejoj1RYvlevNKvsQtmDmgDVSO0SRA=
Date:   Wed, 20 Oct 2021 10:56:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YW/ZpdHa35kStzbt@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <d56c2c23-3e99-417b-8144-cf1bb31b5f6d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d56c2c23-3e99-417b-8144-cf1bb31b5f6d@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Oct 20, 2021 at 04:47:23PM +0800, Xianting Tian wrote:
> hi Greg，
> 
> Could I get  your comments of this new version patches？ thanks

It has been less than 5 days.  Please relax, and only worry after 2
weeks have gone by.  We have lots of patches to review.  To help
maintainers out, why don't you review other patches on the mailing lists
as well while you wait?

thanks,

greg k-h
