Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216CD4039EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349077AbhIHMdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhIHMdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62B646108D;
        Wed,  8 Sep 2021 12:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631104328;
        bh=o6tcok3SiCX2NAJZ1TXHt2b3v45b5/2Tl2q5XnE75I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlI/Ztq73jUW+HQpfB8jbmZVcaT48QxAjei8CKUiV+7f58DxZGF00hPiGlMJEsIna
         gnCuIBB4DM2fKqdW9qWv8ni8XkHXqcBWPp/rJAArbap1zGS8H4mHhtkXR3v71qPoNv
         qtXVD+JB0MJuYB78mgEJwBRZDeqQC5p35FFsQRC0=
Date:   Wed, 8 Sep 2021 14:32:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lang Yu <lang.yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTitRjOZtWPTyRHd@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120723.3920701-1-lang.yu@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 08:07:23PM +0800, Lang Yu wrote:
> The key purpose of sysfs_emit and sysfs_emit_at is to
> ensure that no overrun is done. Make them more equivalent
> with scnprintf.

That's not the only purpose.

So why are you changing this?

What in-kernel users are being tripped up by this, shouldn't we fix them
instead?

Remember, sysfs files are "one value per file", so why are the boundries
not properly set here?

thanks,

greg k-h
