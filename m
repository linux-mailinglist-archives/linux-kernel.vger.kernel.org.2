Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343EC366D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbhDUNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhDUNxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6CA611F2;
        Wed, 21 Apr 2021 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619013190;
        bh=eS93WFrLaeWM4LksKEZiibcuTPutGPetcYGctLJEJpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ra+RCDJ1ZQTaGokJPCMfrAC6a65V43q2KPtPP1bFRQYVrGZzEd5LSs5+mcbDYmIti
         FKzmJL1y0yJeNLcroekdZAE2vNpaP7uqx1lzmOfQ3VcCm4F5zuE00VHR8GvvvYV9ff
         AyIy9t6oRJG7EXuMDlQXan2XPgdS4gYlwI1P+qyg=
Date:   Wed, 21 Apr 2021 15:53:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 070/190] Revert "rfkill: Fix incorrect check to avoid
 NULL pointer dereference"
Message-ID: <YIAuQ05GEuYB1Zzv@kroah.com>
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

Yeah, these "pointless" patches are not good as they waste maintainers
bandwidth, which is why I want to discourage them.

thanks for reviewing these reverts, much apprecated.

greg k-h
