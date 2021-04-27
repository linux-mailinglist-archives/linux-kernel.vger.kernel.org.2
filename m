Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68B36C789
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhD0OJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236220AbhD0OJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3F960FF1;
        Tue, 27 Apr 2021 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619532546;
        bh=4gi/KVdYpTr36w28jGu/Sc24MGDXzzEMUhbN1FJnQXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw/CEQPVI9OY3dZOABY6iVgj09Ie+k7SLDu2ATBRHG3Yl4BJo/2tjf8V6TVek1D1w
         fTzXU5XvM9J6HK573g+HF8b83zr0562y9ThXOYtNY6uf4cHs6lENiE/DRFz8yKGYFU
         Kp2Y9kojNViYlZLbCQLi4HQle56dMiUKtnTMEGRs=
Date:   Tue, 27 Apr 2021 16:09:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 069/190] Revert "mac80211: Remove redundant assertion"
Message-ID: <YIgbABXRyqhsr/FJ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-70-gregkh@linuxfoundation.org>
 <685d055406cb9fd28fec3ac0b9ba3fc3fe039f08.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685d055406cb9fd28fec3ac0b9ba3fc3fe039f08.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:39:47PM +0200, Johannes Berg wrote:
> On Wed, 2021-04-21 at 12:59 +0000, Greg Kroah-Hartman wrote:
> > This reverts commit 1ee7826ab68f7e9fa1a01533983acf6a6f62e297.
> > 
> 
> That commit was actually correct, though sort of irrelevant. I think we
> can go either way on it, but better not spend any (more) time on it.

I'll drop it, thanks!

greg k-h
