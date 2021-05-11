Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11B1379FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhEKGth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhEKGtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECED7610FA;
        Tue, 11 May 2021 06:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620715710;
        bh=A52in/mnelv0NkyuPFJOrGOZ3fC9s6hG9ZWVXNNEIec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPk1I5P4cjTGl/oxj9IAc63QI2NdZnOSMrd13DN5PUkaEkTDPg2Mh1UzejbtvuIxf
         ySG3BWDOluTjDxMwgiEHZldmS+f6vRgmbDWO2Tmyo8rucecRMypFOLSp1qAaeKXqak
         YzEc9hXClBvN19QPTBcunDZQEi6lR0AF33ZX1+kg=
Date:   Tue, 11 May 2021 08:48:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: Linux 5.13-rc1
Message-ID: <YJoovFYtvBHZ3RGI@kroah.com>
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
 <20210510025414.GA2041281@roeck-us.net>
 <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
 <20210510193924.GA3929105@roeck-us.net>
 <CAHk-=whcSbW+CprMV4=F2QQG_yuoD9kJRi2Ec2XP8Hu1ixkYOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcSbW+CprMV4=F2QQG_yuoD9kJRi2Ec2XP8Hu1ixkYOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:20:41PM -0700, Linus Torvalds wrote:
> Just adding Greg & co explicitly to the participants to make sure
> they're aware of this..
> 
> Greg? This came through your driver core tree.

I thought Stephen had taken that commit by now, sorry about that.  I've
grabbed it for my tree and will let it run in linux-next for a day or so
before sending it to you.

thanks,

greg k-h
