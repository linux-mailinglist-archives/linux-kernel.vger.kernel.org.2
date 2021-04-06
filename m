Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9735502A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbhDFJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244899AbhDFJg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:36:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FFD0613C9;
        Tue,  6 Apr 2021 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617701805;
        bh=J009fz95W1yp7dSEEvcQHAB/rNi9vWwOuHc1FlLXl0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKQBQARblV68vQSDK3VKfeoxmvxv7g81RjXpQ8RzCHbVVtiEfZvwE+AMvGNbCLaPA
         /NussvoRNsbHm53jXgIfSjGxUKGXv6jlUVZSBKf8qb6qRHx/fCexFNLvtBwio1lWZV
         GVTzlP4Eg3YgQUcqFl/X1mTT49Xe86VKu7oi3qCw=
Date:   Tue, 6 Apr 2021 11:36:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Convert camel case to snake case
Message-ID: <YGwrqUkAUWzccKA2@kroah.com>
References: <YGwncT6RGvYlL9yj@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGwncT6RGvYlL9yj@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 02:18:41AM -0700, Pavle Rohalj wrote:
> -	struct dvi_ctrl_device *pCurrentDviCtrl;
> +	struct dvi_ctrl_device *p_current_dvi_ctrl;

Does this change make sense?  Why keep the "p_" here?  We do not need or
use, this type of variable naming in the kernel.

Also, please break this up into a patch series where you do one
structure change at a time.

thanks,

greg k-h
