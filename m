Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DB3DEDA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhHCMMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233906AbhHCMM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:12:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D809360E97;
        Tue,  3 Aug 2021 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627992738;
        bh=WD7PRtJNoSk3edXO13GpxDkMJ+jrPqEMMi2+j8oqOSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXiINIp//0Uv7FPvKRxqBUzxPwMqPQXmuAQfP9oMotzIZYlGEVFHrLP00SaBC/46Y
         BFNvke8Q/zHQ942TTUbxroI2i/g361pb6+CWRCuf196CWEEu7QzPmSBPD7tUp8zetZ
         8kH+Db3L40J8ja9ha8SM6+GUtYsZIRkzKKndsJuA=
Date:   Tue, 3 Aug 2021 14:12:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.14-rc
Message-ID: <YQkynAus79TWhxUw@kroah.com>
References: <20210803112733.9408-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803112733.9408-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 02:27:33PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains interconnect core and driver fixes for 5.14-rc.
> The details are in the signed tag. Please pull them into char-misc-linus
> when possible. The patches have been also in linux-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.14-rc5

Pulled and pushed out, thanks.

greg k-h
