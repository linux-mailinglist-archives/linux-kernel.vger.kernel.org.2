Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7939913B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFBRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhFBRRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:17:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C9F661C4F;
        Wed,  2 Jun 2021 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622654121;
        bh=4LVBqjtQ1eHxqS5JPGdYeDDj29z+8wybNP6Elx/FQ1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAX4TsVFt8GKpIE6XH93GvkIDXLGaasn+ZgsCMTX6qFcWW4Jza6roM0JnFxpZ2XRX
         5M7IKmokxV+Yq2Z/wxB3l/4vTUSgVF2TI6FgjnrDa6rqyfDO1a/wn7UVVhK9h0O6F/
         /1oZUtUuvYVjlTAQvNOZo4qkgnRkWN+kYJS/Pwe8=
Date:   Wed, 2 Jun 2021 19:15:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix coding-style issues in r8192U_hw.h
Message-ID: <YLe8psfQLCb5bn2W@kroah.com>
References: <20210602160333.62163-1-manikishanghantasala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602160333.62163-1-manikishanghantasala@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:33:31PM +0530, Manikishan Ghantasala wrote:
> staging: rtl8192u: r8192U_hw.h: Clear the coding-style issue

Why is this line here?

> 
> "Macros with complex values should be enclosed in parentheses"
> by enclosing values in parantheses.

I can not understand this sentence, can you please reword it?

> Modified spacing around "|" and removed a space before tab.

This is not related to the first thing, please break this up into
multiple patches like the bot asked...

thanks,

greg k-h
