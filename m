Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135B357014
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353469AbhDGPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353463AbhDGPXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:23:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0D77610CB;
        Wed,  7 Apr 2021 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617808994;
        bh=LoDcrAeLj2cIGYDihQohQ8HAxhMR3ppOEnDlucGC+nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IR/OmnxjYxWKxsZsrFBBY3m1M4fuZPZxTPPSVCY6T+5Zz8PTWOWvx1btgwKoiM82H
         DmyLyp7NZFbvsB2M++/fBm/uR/TmhawS1v3NbFxWmLbUSmAjsRT86WeabhwIxuBs1Q
         cj1WW7NtHOXzKfcM1NugImXcTN+FQQrS/T0XL9gY=
Date:   Wed, 7 Apr 2021 17:22:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] tty: TIOCSSERIAL fixes and clean ups
Message-ID: <YG3ORQcI5DRw7QL/@kroah.com>
References: <20210407102334.32361-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:23:18PM +0200, Johan Hovold wrote:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> This series fixes up the various ways in which driver authors have
> gotten the implementation wrong over the years, like, for example,
> jiffies conversions, permissions checks and error handling.
> 
> The de-facto standard for error handling is to ignore any unsupported
> features and immutable parameters (cf. UPF_FIXED_PORT and deprecated
> ASYNC flags).
> 
> Permission checking should prevent an unprivileged user from changing
> anything but the ASYNC_USR flags (and custom divisor) by returning
> -EPERM.
> 
> These patches are against tty-next, but the staging ones could otherwise
> go through either tree.

I've taken all of these through my tty tree, thanks for cleaning this
mess up.

greg k-h
