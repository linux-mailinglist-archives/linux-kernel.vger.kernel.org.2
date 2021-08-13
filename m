Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289E83EB119
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhHMHIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239222AbhHMHIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DBD26056B;
        Fri, 13 Aug 2021 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628838493;
        bh=TpgsIa/y2++/G1mwfOPNpyBa1LqSYUt4QgccMUO9r8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXKy9Ri1s0kB+LiLpOZdXFA6fFRSTjTDbWplJQjTiuEI5hW7WhKRQCFK8vMhCtyKy
         I+6nZmsm/F7mVfnKj1nQ0TvETfYMaxo4Qcl7g5tfjZtR/nTOWYOJyo8x7KRYTPR3M2
         tyWsuZs0lHQPY6HNXSQbXkGxcQZHbSVKlOnApJVE=
Date:   Fri, 13 Aug 2021 09:08:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: add loop timeout for hw_ep_set_halt()
Message-ID: <YRYaWgiWmO0lHcPg@kroah.com>
References: <20210809112048.GA3319230@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809112048.GA3319230@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 08:20:48PM +0900, Jeaho Hwang wrote:
> If ctrl EP priming is failed (very rare case in standard linux),
> hw_ep_set_halt goes infinite loop. 50 was enough for zynq7000.
> 
> Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
> ---
>  drivers/usb/chipidea/udc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index d0cd1de1b6c7..92ca0b7e4310 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -210,6 +210,9 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>  	return 0;
>  }
>  
> +/*will it be enough?*/

Please use ' ' characters in your comments.

And can you answer this, please do not add a question in a comment, be
sure about this.

> +#define HW_EP_SET_HALT_COUNT_MAX 100
> +
>  /**
>   * hw_ep_set_halt: configures ep halt & resets data toggle after clear (execute
>   *                 without interruption)
> @@ -222,6 +225,7 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>   */
>  static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
>  {
> +	int count = HW_EP_SET_HALT_COUNT_MAX;
>  	if (value != 0 && value != 1)

Please use checkpatch.pl when submitting patches :(

