Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0B307060
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhA1H4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:56:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232217AbhA1HzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:55:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD6B6146D;
        Thu, 28 Jan 2021 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611820461;
        bh=bXGnTJYHb794Pb2vCMTkFYeXSZ+dzkW/2YPkPZg8Slg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj1nmphKRIfOfGTj9JVFV4FxRBqTWjMcpmRvjIvsrojctM5Mm1gb4FRnQAXfKdClX
         tBF2zKHrlS22NnNDSlCO5fIGiFDyImZPZfqA/hNFXBciStW81bgu2YhGATtDAqjA4D
         YNSDPTvBWNHjNY/x7kXpQMW+4N3N0jdvFSlErG48=
Date:   Thu, 28 Jan 2021 08:54:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Make dectlk flush timeout configurable
Message-ID: <YBJtqGn/ZpdFpNlg@kroah.com>
References: <20210127234444.1038813-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127234444.1038813-1-samuel.thibault@ens-lyon.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:44:44AM +0100, Samuel Thibault wrote:
> In case the serial port or cable got faulty, we may not be getting
> acknowledgements any more. The driver then currently waits for 4s to
> avoid jamming the device. This makes this delay configurable.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  drivers/accessibility/speakup/speakup_dectlk.c | 11 ++++++++++-
>  drivers/accessibility/speakup/spk_types.h      |  3 ++-
>  drivers/accessibility/speakup/synth.c          |  3 +++
>  drivers/accessibility/speakup/varhandlers.c    |  1 +
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
> index d75de36..580ec79 100644
> --- a/drivers/accessibility/speakup/speakup_dectlk.c
> +++ b/drivers/accessibility/speakup/speakup_dectlk.c
> @@ -78,6 +78,8 @@ static struct kobj_attribute direct_attribute =
>  	__ATTR(direct, 0644, spk_var_show, spk_var_store);
>  static struct kobj_attribute full_time_attribute =
>  	__ATTR(full_time, 0644, spk_var_show, spk_var_store);
> +static struct kobj_attribute flush_time_attribute =
> +	__ATTR(flush_time, 0644, spk_var_show, spk_var_store);

__ATTR_RW()?

Also, no Documentation/ABI/ update for the new one user-visable
attribute?  Please fix up.

thanks,

greg k-h
