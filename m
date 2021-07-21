Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DC3D0E44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhGULRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237773AbhGULMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 751D46109F;
        Wed, 21 Jul 2021 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626868319;
        bh=hEJvu6/cow0FvseVKzbhqeQsfEPQOVHFme9rz9lVotk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pU+YYoq3108Oq4wVKJY/mjGW/J6p2z50PLnpKyCLFFAoHdeO3j8uTwg7PRvaixFIl
         jwX55IS0msfH/94B4a6miF5/knSAlhrluvN0zy648W0pnBfmSSiJ6T5XJxWmmEQgi8
         nHVna0fdHCRxiswPV+jhs9dCO7MFrMeB5M/Xd0po=
Date:   Wed, 21 Jul 2021 13:51:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: Convert from atomic_t to refcount_t on
 gru_thread_state->ts_refcnt
Message-ID: <YPgKXBTjgO6ko0qQ@kroah.com>
References: <1626517043-42696-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626517043-42696-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 06:17:22PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/misc/sgi-gru/grumain.c   | 6 +++---
>  drivers/misc/sgi-gru/grutables.h | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 40ac59dd018c..9afda47efbf2 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -282,7 +282,7 @@ static void gru_unload_mm_tracker(struct gru_state *gru,
>   */
>  void gts_drop(struct gru_thread_state *gts)
>  {
> -	if (gts && atomic_dec_return(&gts->ts_refcnt) == 0) {
> +	if (gts && refcount_dec_and_test(&gts->ts_refcnt)) {
>  		if (gts->ts_gms)
>  			gru_drop_mmu_notifier(gts->ts_gms);
>  		kfree(gts);

Related to this, shouldn't this really be a 'struct kref' instead of
hand-creating the exact same logic?

Want to make that change on top of this one?

thanks,

greg k-h
