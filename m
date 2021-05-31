Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9853967BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhEaSU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232543AbhEaSUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:20:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D07186124B;
        Mon, 31 May 2021 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622485130;
        bh=fhTlAV9FbP3RKsNYKn99jc787I4gVcF+x+r2wL+ZjYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnHl9qpRk5y6ghMwP4AQom98xWbShk9uaOB2rJLWXuS8/LYAHcwi5rmGHdMARWkpO
         iK6M2n6v8+B32tYqJ86MlvytH73oKjqHzb865t0Iy1Z0Qtf6bsvFI5HNiaIUmVjqBx
         aBHwtu8pKsT2wT0VJukMGDBr78N+QOLbjnyZdIcPULk9NH+mxCGX7md0ri1jkiJcTr
         rZhgfbgYmYml20u2Zy0kkgbT3NKyddE2hE1M4YVzjxW7oZFiKAwKb3RMs2ySq11A2A
         3J1XSYhjONs2rEnqRAg5SWeAKpa/Tzbouywhb4MNvOThOI0HwNuIsPFjh4eytVL/84
         x53CPrENoaKdA==
Date:   Mon, 31 May 2021 11:18:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     samitolvanen@google.com, wcw@google.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 6/6] pgo: Fixup code style issues.
Message-ID: <YLUoiJr5+7WX+roL@Ryzen-9-3900X.localdomain>
References: <20210528201213.459483-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528201213.459483-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:12:13PM +0300, Jarmo Tiitto wrote:
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>

This should be squashed into 4/6. Do not introduce issues in the middle
of a patch series. A couple more comments below.

> ---
>  kernel/pgo/instrument.c | 106 ++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index a95c86d668b5..b30104411879 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -31,7 +31,7 @@
>   * ensures that we don't try to serialize data that's only partially updated.
>   */
>  static DEFINE_SPINLOCK(pgo_lock);
> -static int current_node = 0;
> +static int current_node;
>  
>  unsigned long prf_lock(void)
>  {
> @@ -55,58 +55,58 @@ void prf_unlock(unsigned long flags)
>  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  						 u32 index, u64 value)
>  {
> -    struct prf_mod_private_data *pmod;
> -    struct llvm_prf_data *start = __llvm_prf_data_start;
> -    struct llvm_prf_data *end = __llvm_prf_data_end;
> -    struct module * mod;
> -    struct llvm_prf_value_node * vnds = __llvm_prf_vnds_start;
> -    struct llvm_prf_value_node * vnds_end = __llvm_prf_vnds_end;
> -
> -    if(start <= p && p < end) {
> -        /* vmlinux core node */
> -        if (&vnds[current_node + 1] >= vnds_end)
> -            return NULL; /* Out of nodes */
> -
> -        current_node++;
> -
> -        /* Make sure the node is entirely within the section
> -         */
> -        if (&vnds[current_node] >= vnds_end ||
> -            &vnds[current_node + 1] > vnds_end)
> -            return NULL;
> -
> -        return &vnds[current_node];
> -
> -    } else {
> -        /* maybe an module node
> -         * find in what module section p points into and
> -         * then allocate from that module
> -         */
> -        rcu_read_lock();
> -        list_for_each_entry_rcu(pmod,&prf_mod_list,link) {
> -            mod = READ_ONCE(pmod->mod);
> -            if(mod) {
> -                /* get section bounds */
> -                start = mod->prf_data;
> -                end = mod->prf_data + mod->prf_data_size;
> -                if(start <= p && p < end)
> -                {
> -                    vnds = mod->prf_vnds;
> -                    vnds_end = mod->prf_vnds + mod->prf_vnds_size;
> -                    if (&vnds[pmod->current_node + 1] < vnds_end) {
> -                        pmod->current_node++;
> -
> -                        vnds = &vnds[pmod->current_node];
> -                        rcu_read_unlock();
> -                        return vnds;
> -                        break;
> -                    }
> -                }
> -            }
> -        }
> -        rcu_read_unlock();
> -        return NULL; /* Out of nodes */
> -    }
> +	struct prf_mod_private_data *pmod;
> +	struct llvm_prf_data *start = __llvm_prf_data_start;
> +	struct llvm_prf_data *end = __llvm_prf_data_end;
> +	struct module *mod;
> +	struct llvm_prf_value_node *vnds = __llvm_prf_vnds_start;
> +	struct llvm_prf_value_node *vnds_end = __llvm_prf_vnds_end;
> +
> +	if (start <= p && p < end) {
> +		/* vmlinux core node */
> +		if (&vnds[current_node + 1] >= vnds_end)
> +			return NULL; /* Out of nodes */
> +
> +		current_node++;
> +
> +		/* Make sure the node is entirely within the section
> +		 */

Move the '*/' to the end of the previous line.

> +		if (&vnds[current_node] >= vnds_end ||
> +			&vnds[current_node + 1] > vnds_end)
> +			return NULL;
> +
> +		return &vnds[current_node];
> +

Remove this blank line.

> +	} else {
> +		/* maybe an module node
> +		 * find in what module section p points into and
> +		 * then allocate from that module
> +		 */
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(pmod, &prf_mod_list, link) {
> +			mod = READ_ONCE(pmod->mod);
> +			if (mod) {
> +				/* get section bounds */
> +				start = mod->prf_data;
> +				end = mod->prf_data + mod->prf_data_size;
> +
> +				if (start <= p && p < end) {
> +					vnds = mod->prf_vnds;
> +					vnds_end = mod->prf_vnds + mod->prf_vnds_size;
> +
> +					if (&vnds[pmod->current_node + 1] < vnds_end) {
> +						pmod->current_node++;
> +
> +						vnds = &vnds[pmod->current_node];
> +						rcu_read_unlock();
> +						return vnds;
> +					}
> +				}
> +			}
> +		}
> +		rcu_read_unlock();
> +		return NULL; /* Out of nodes */
> +	}
>  }
>  
>  /*
> -- 
> 2.31.1
