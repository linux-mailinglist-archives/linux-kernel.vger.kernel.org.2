Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBD3F8567
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbhHZKh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233929AbhHZKh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:37:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A44156108E;
        Thu, 26 Aug 2021 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629974231;
        bh=oP61BbnAXKACI6JbZ1kT6hbuKd4vxr/fnZYcvDNWbxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vYfhmlRNMLVbPtyB/P5pGpgFcsFwZlWswZh4GEn/yCKJuIPaGhsZzpzZeaKtByhoT
         UdUvE9S0aAQcAw6763DHCs/g48d42z+/G7SIJjY/vsEi1UoPBtzR767S6U2wYs0TW8
         i8uWo8NswbotTNfm7mbRlNQ7098apj+ZstfQV/Vg=
Date:   Thu, 26 Aug 2021 12:37:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Message-ID: <YSdu00zpqfGkKc1e@kroah.com>
References: <20210819221241.31987-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819221241.31987-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 12:12:41AM +0200, Fabio M. De Francesco wrote:
> Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> unnecessary wrappers, respectively to mutex_lock_interruptible() and
> to mutex_unlock(). They also have an odd interface that takes an unused
> argument named pirqL of type unsigned long.
> The original code enters the critical section if the mutex API is
> interrupted while waiting to acquire the lock; therefore it could lead
> to a race condition. Use mutex_lock() because it is uninterruptible and
> so avoid that above-mentioned potential race condition.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

You have changed the behavior of the code here, how have you tested that
this still works properly?

thanks,

greg k-h
