Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C11314923
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 07:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBIGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 01:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBIGym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 01:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA9364E3B;
        Tue,  9 Feb 2021 06:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612853642;
        bh=BNSYLp3ioBVGsc8rUJwVikVM+1rP8S7o+9FcABtHl2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nup6oGAvTkfDbr+wl9ac1EQSI/Xod0gRQ9J+WDu3IHPbRayCVosMvhZ2eZ33BbmFy
         uxBOIyi/LovVazf2H7RR7ljszFpTb8ZNczQqwR5wLlfht3SAKB7WQIIg4HA7R5YDIW
         2BTh0WzoJPHDdb+u/kCNV0NrG35gQ6yk41dWdspU=
Date:   Tue, 9 Feb 2021 07:53:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukul Mehar <mukulmehar02@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: drivers: staging: most: Fixed styling issue.
Message-ID: <YCIxhTu2HHs2KuD7@kroah.com>
References: <20210209062311.GA10016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209062311.GA10016@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:53:11AM +0530, Mukul Mehar wrote:

> >From 29bcaf0066003983da29b1e026b985c0727b091a Mon Sep 17 00:00:00 2001
> From: Mukul Mehar <mukulmehar02@gmail.com>
> Date: Mon, 8 Feb 2021 01:03:06 +0530
> Subject: [PATCH] Drivers: staging: most: sound: Fixed style issue.

Why is this still an attached file?  These lines should not show up in
the body of the email.  Look at the thousands of examples on the mailing
list as what needs to be done here.

thanks,

greg k-h
