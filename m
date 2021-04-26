Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F536B7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDZRMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhDZRMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6D561077;
        Mon, 26 Apr 2021 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619457091;
        bh=9Edq1aMG8CWRijFR5pQXoKydW6XW2KTeiSta2MJaTCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEbJy/DrroN/NRd+QpaXWeZSdwo4xp7Oeyo+JNEzoD+6mR4XYpy/TxxsnUa+x8zM7
         V9LP8Ln3qRFQq6BL4kTfRJVIpTqNoBQ0IVdEe167mWmRVjL/TxhYxYLe4H2KLbXCWP
         iJd5cDw4iM6bzHZkAW81iuMvfC5zwerPRHvgJRNs=
Date:   Mon, 26 Apr 2021 19:11:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 070/190] Revert "rfkill: Fix incorrect check to avoid
 NULL pointer dereference"
Message-ID: <YIb0QQO+0kQIKJQv@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-71-gregkh@linuxfoundation.org>
 <911d4b8d3e9c68860ef4163fc4cce3b5fbb485c5.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911d4b8d3e9c68860ef4163fc4cce3b5fbb485c5.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:43:31PM +0200, Johannes Berg wrote:
> On Wed, 2021-04-21 at 12:59 +0000, Greg Kroah-Hartman wrote:
> > This reverts commit 6fc232db9e8cd50b9b83534de9cd91ace711b2d7.
> 
> This commit was fine, though the commit log is misleading since there's
> no dereference yet, just a pointer calculation. I may not have seen that
> at the time, or have decided that the slight commit log inaccuracy
> didn't matter.
> 
> I'm inclined towards keeping it, since it removed a BUG_ON(), but
> there's no reasonable scenario where somebody could end up calling this
> function with a NULL pointer.

I've dropped this revert from my tree now, thanks.

greg k-h
