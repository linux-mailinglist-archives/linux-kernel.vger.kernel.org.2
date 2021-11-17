Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3504546BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhKQNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhKQNBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:01:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04DA163236;
        Wed, 17 Nov 2021 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637153893;
        bh=f3jQncDFPhBcMwfDCqxv/iJk088YIDPlBfWcvT7y0II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQgkurASHyw9B2yZ2SZ8GTna3AwKF/d1GxyBOsMI4aDQJWiAxyE7YlYnEjKNp1BHQ
         os+d/qW8Sn8hdFOmfZy6KN2PNE5g0Iti+bWP3FJN1vK+Ib35hNUkMTeXmLN8boQM9+
         iWlSgP4qJaaYJ9b8V85IZ25c2YXDI4m7BwxHPA6o=
Date:   Wed, 17 Nov 2021 13:58:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: vt6655: fix camelcase in wCurrentRate
Message-ID: <YZT8Yrk4f2gMhWTs@kroah.com>
References: <20211115140856.GA4220@alb3rt0-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115140856.GA4220@alb3rt0-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:08:56PM +0100, Alberto Merciai wrote:
> Replace camelcase word variable "wCurrentRate" into linux kernel coding
> style equivalent "current_rate".
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>

Does not apply to my tree.  Please rebase against the staging-next
branch and resend.

thanks,

greg k-h
