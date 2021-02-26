Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0A3261E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhBZLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZLTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:19:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1155564E6C;
        Fri, 26 Feb 2021 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614338300;
        bh=CV2eVk/4WwcqzsV+ldYXBw9lPTOow4MrUi8k6XKYZLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtZBTo8E3CdJa4rmGbJm92MUmhH+5DBC21zyAtVoIekOvkpHmcHQJJM951GcDBcAi
         btH+bFKkdTtinG/5sN/XEYWAQJ+9Rro1ELiSbSdUv+MuswXAlB613AjGyIQFq3gKw4
         XvSvmroO+XTqjA3OsvjzOG8znNZQdIRN7suHAN54=
Date:   Fri, 26 Feb 2021 12:18:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add linux-phy list and patchwork
Message-ID: <YDjY+Ucvkw/zIvV6@kroah.com>
References: <20210226111233.2601369-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226111233.2601369-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 04:42:33PM +0530, Vinod Koul wrote:
> Linux-phy subsystem gained mailing list and a patchwork instance. Add the
> details to MAINTAINERS file
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Greg, Linus: Can we merge this patch for -rc1?

I'll queue it up after -rc1 is out, no rush :)

thanks,

greg k-h
