Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD8450175
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhKOJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhKOJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:34:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6736363217;
        Mon, 15 Nov 2021 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636968674;
        bh=G0fTib9/0b1mnYKVkiUm8km36ge1tFdJyIdv966rJCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O09OIJQiE0uZvSjBlH0bNRrmX2K6ZCEK3q+11SGdz5eN73cOMvhmpKj4uQIj37UOt
         OdQHlhgHuFhUxlJLVcJhHq5+zGuyyic/lFkPWwzPBp9UuI5k9nLiG97Wr6CQ2osG+C
         KpVrsuz3TvYhnZryaCsGM1Vkw5vvkK6fQujQNnCc=
Date:   Mon, 15 Nov 2021 10:31:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: fix camelcase in wCurrentRate
Message-ID: <YZIo4HLyJ0TLT1I7@kroah.com>
References: <20211114090935.GA120704@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114090935.GA120704@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 10:09:35AM +0100, Alberto Merciai wrote:
> Replace camelcase word variable "wCurrentRate" into linux kernel coding
> style equivalent "current_rate".
> 
> References:
> https://www.kernel.org/doc/html/latest/process/coding-style.html

We all know the kernel coding style, no need to have a link to it in the
changelog text, right?

> https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm

Why is this here?  That's a random college course web site.

And random links in changelog text do not age well, include the full
text of what matters in the changelog text itself, it should be
self-contained where ever possible as these live much longer than random
web site links will.

thanks,

greg k-h
