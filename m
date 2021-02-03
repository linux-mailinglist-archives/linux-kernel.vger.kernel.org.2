Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFED330E5F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBCWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231948AbhBCWSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:18:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1659F64E0F;
        Wed,  3 Feb 2021 22:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612390650;
        bh=H9+kAZiZv0en4Z35zepBDF4aYBxLVTPFEZW1bBF7XX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHZ3Br14AlK7pMeoKPsB5H1Gl/YYCDJ7fYu1xOpFJNXW3xZ+67daBQjmYpswwoSjb
         aVqhrno4EUdgGUhGjUiPBw83Tw/FUMcAwnhxqEmgszBIMdZkmmeB9j2QzewCfOseWV
         RtM+ETC1+ej9ifaWqxnT2n6rI56mtz7uGKTtVnbM=
Date:   Wed, 3 Feb 2021 23:17:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: Re: [PATCH] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Message-ID: <YBsg+FrU47+S7HFl@kroah.com>
References: <20210203210451.9002-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203210451.9002-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:04:51PM -0800, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes since v3:

Is this "v4"?  Your subject line doesn't say so :(

