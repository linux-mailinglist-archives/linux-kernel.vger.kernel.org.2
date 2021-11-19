Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAC457077
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhKSOUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234371AbhKSOUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:20:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0833061211;
        Fri, 19 Nov 2021 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637331472;
        bh=+RxiXEg7wGSS27hAwXjldJTMuDaXaWKo5W+XpV+nLIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5pl7hmgXITGNrGn8MBKChKd+6SyJQ34Q5p5oyD0fO05IkisYR52kHFE8dGhsK+2L
         nXiPJCAPzdfHtTBaXEkDnaU/ZKl5+v7xDPkzh2eyAjt3pbgbUsFekgRVtgoIvJbLDs
         HzaF4Bqx2tsSy6VPfqS29snc0xH9zA7r8PbAdF7c=
Date:   Fri, 19 Nov 2021 15:17:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <YZeyDSa6ujv6rPMT@kroah.com>
References: <20211118202718.GA152832@t470p>
 <YZdGaAVSVM8/4ZB2@kroah.com>
 <20211119133644.GB2519@alb3rt0-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119133644.GB2519@alb3rt0-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:36:44PM +0100, Alberto Merciai wrote:
> driver-core$ ./scripts/get_maintainer.pl drivers/staging/vt6655/device.h
> Forest Bond <forest@alittletooquiet.net> (odd fixer:STAGING - VIA VT665X DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM)
> Alberto Merciai <alb3rt0.m3rciai@gmail.com> (commit_signer:2/2=100%,authored:2/2=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
> devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)

What kernel version is that?

The driverdev mailing list is very old and should not be used anymore.

Please always work against the latest version of the kernel, and for
development stuff, linux-next is usually best so you do not duplicate
any work that anyone else has done.

thanks,

greg k-h
