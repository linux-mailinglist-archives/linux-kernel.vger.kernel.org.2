Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E832F3D3DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGWQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhGWQJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACEA160E73;
        Fri, 23 Jul 2021 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058993;
        bh=hKmvrifTJ5hhxNB0OlIO2o7MGmqI0xoWAGvLb6SWyd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAJXmewXuMBnpHRwYsxoWlieOqoi0ilWkttro/u/Lwt3l6z023p75En98+3yrxf+j
         NuQgQk5oc+IYL/tmHWZ6vnzDjroZVpzuSwRt9lIX4S4xFBwm+3i+0+3uXVyKJd9+qm
         HYtISptKYviTWX3efKfIqhWUips26lsOpsUndBMPNCwsPxUEWD5KP9JnUy44HfpEo4
         DACRbL63IeP0mHAMue0/HQDUoISur+W/zF3Zuu6f9X/uw4s/nFGFivldwpYRrssADH
         fvV66iLs0q90zzKtpnDGllRVZ2wv/XiRqwneEOF1LN6oDm/QOEYmKGmXgof1LkJs37
         v50ch+ivgI7EA==
Date:   Fri, 23 Jul 2021 09:49:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/9] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YPrzMI6P7MzO3V3K@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-1-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:34PM -0700, Satya Tangirala wrote:
> 
> Changes v3 => v4
>  - Patch 4 in v3 has been removed (Eric points out it isn't required
>    without some of the changes in the device mapper patchset at
>    https://lore.kernel.org/linux-block/20210604210908.2105870-1-satyat@google.com/
>   so I'll add this patch to that series instead.

Wouldn't it make more sense to have the blk-crypto-fallback change in this
series?  My concern was just that it didn't make sense to have it split between
the two patch series -- it seemed like one logical change.

- Eric
