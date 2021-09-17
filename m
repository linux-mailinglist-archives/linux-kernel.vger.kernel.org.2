Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9140FA28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbhIQObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242098AbhIQObL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:31:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 791666121F;
        Fri, 17 Sep 2021 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631888989;
        bh=iChfwsk0r2h/iddeJN+kXh26ykQyn4SHYy6tFcRnB3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdPzbA/8SxytD6u+xlAGXl4nOosROu1Vq5pFoNlDgQN3a+Fo/NCgdqi2WUnHkMN60
         4jCZm/jmobyuCj8Ac4zbNyHSmnddf/gb1bwbegC6BX6wujqbCZw0HsC43So/ftIc+4
         WuhGAgK1WKKfIbLnyVp4cNv2ZGDmUSYluEvNTsfI=
Date:   Fri, 17 Sep 2021 16:29:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tawah Peggy <tawahpeggy98@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: cfg80211: Fix lines should not end
 with '('.
Message-ID: <YUSmWgWX1FV+0TBh@kroah.com>
References: <20210915192110.GA325036@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915192110.GA325036@peggy-InsydeH2O-EFI-BIOS>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 08:21:10PM +0100, Tawah Peggy wrote:
> This patch fixes the checkpatch.pl warning;
> CHECK:lines should not end with '('.
> by replacing  ieee80211_frequency_to_channel()
>  with ieee80211_freq_to_channel()

Please properly cc: the needed people and mailing lists that the
scripts/get_maintainer.pl tool tells you to.

Also please work on your C knowledge some more before contributing to
the kernel.  The change you made here was obviously not tested and worst
of all, not even built tested as it breaks the build.

thanks,

greg k-h
