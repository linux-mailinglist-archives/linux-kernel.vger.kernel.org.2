Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34782314AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBII5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhBIIsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:48:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4665164EC7;
        Tue,  9 Feb 2021 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612860461;
        bh=dbMxB38xpbRK7LA36nkBy98Hiq0eLtfVXeswVUJw1bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uz2qf2l39nH4wId4+k6qT6MNzlRIXsz8uEYGM/l6YNw/GKLJ6snDPp7xyt2+bDb7+
         PCplVrWFGKJjuw7UsRiFLV7PXK0A8bY5R+gEIHaCmo+BMLknIpOsFzCQNh4PW0bfx7
         7rEnK6DhfLnqMYU2zYSu0vIvTznmnksf3kIUAizc=
Date:   Tue, 9 Feb 2021 09:47:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        linux-kernel@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net
Subject: Re: [Industrypack-devel] [PATCH v1 1/2] ipack: Fail earlier for
 drivers without probe function
Message-ID: <YCJMKzSgtDzwwiYi@kroah.com>
References: <20210207215556.96371-1-uwe@kleine-koenig.org>
 <e86534902fce9b82d2a69b7ec24e697b43c9ef6f.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e86534902fce9b82d2a69b7ec24e697b43c9ef6f.camel@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:40:12AM +0100, Samuel Iglesias Gonsálvez wrote:
> Hi Uwe,
> 
> Thanks for the patches!
> 
> Patch series is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Will be glad to, thanks!

greg k-h
