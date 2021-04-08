Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3E358DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhDHTq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:46:26 -0400
Received: from verein.lst.de ([213.95.11.211]:36820 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhDHTqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:46:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 293A068BEB; Thu,  8 Apr 2021 21:46:12 +0200 (CEST)
Date:   Thu, 8 Apr 2021 21:46:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH] MIPS: uaccess: Reduce number of nested macros
Message-ID: <20210408194611.GA16189@lst.de>
References: <20210408181437.19570-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408181437.19570-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define put_user(x, ptr)						\
> +({									\
> +	__typeof__(*(ptr)) __user *__p = (ptr);				\
> +									\
> +	might_fault();							\
> +	access_ok(__p, sizeof(*__p)) ?					\
> +		__put_user((x), __p) :					\
> +		-EFAULT;						\

Why not merge this into a single line, which seems a little more
readable:

	access_ok(__p, sizeof(*__p)) ? __put_user((x), __p) : -EFAULT;	\

Same for the get_user side.

Otherwise looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>
