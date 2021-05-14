Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76F3808CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhENLpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhENLpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:45:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDE1961457;
        Fri, 14 May 2021 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620992675;
        bh=2wK2s4uzHrcpMX4AVT39GF12wNkvgwnZVjSBdmwo7IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPJ8GSJ02jG+yTazbperYBkPoie6vURrfZzw6FI7xXUwq1lQjJltzQWUR2Eje/EkB
         F8pXOtwR5ILQGN8TZvdgyIDOlQ4QOUtT5b4SCac2uW5BuE32tMpKN00CxBxSN+rWa8
         bsNAILfkxOejvTAere1+7cFTZ7/W1PWyEYA5JBI0=
Date:   Fri, 14 May 2021 13:44:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v1 1/1] video: ssd1307fb: Drop OF dependency
Message-ID: <YJ5ioEaP3UctfdVH@kroah.com>
References: <20210409164140.17337-1-andriy.shevchenko@linux.intel.com>
 <YHmiPMcgMqHCzaur@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHmiPMcgMqHCzaur@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 05:42:04PM +0300, Andy Shevchenko wrote:
> +Cc: Greg.
> 
> Greg, can you pick up this one?
> 
> The subsystem seems orphaned and I see your name in the git history for the
> recent submissions against that driver.

Now applied, thanks.

greg k-h
