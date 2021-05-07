Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F78376009
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhEGGGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEGGGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:06:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FC0F613EB;
        Fri,  7 May 2021 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620367544;
        bh=p91nzRYoZhbJ+oxre5HPtdx2qCPPuLKa1IXQXFxDAe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzyiSbDLFctgByR0V9qw9PhGsJ+oby/shB+OHeRX7X+m6uXpkDehpEvAmuu7Tebbn
         ZP5I9o66BZ4Owbc+WbNVM4YH68AjOb5kQp9Wk/ap1qRa8BF7vOgUy/EZjaD7vLcby4
         +eg17gLVIv7AgfOG+yryme1HY2SPrDckPm9MayRM=
Date:   Fri, 7 May 2021 08:05:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] VDM management improvement and some bug fixes
Message-ID: <YJTYtetjqXZZwdhm@kroah.com>
References: <20210506171026.1736828-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506171026.1736828-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 01:10:24AM +0800, Kyle Tso wrote:
> usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work
> - nothing changed since v1
> - Hi, Greg, do I need to add "Reviewed-by:" and "Acked-by:" ?

If there were reviewed-by and acked-by for the original change, then
yes, you should, otherwise my tools lost them with this new submission.

Can you do a v3?

thanks,

greg k-h
