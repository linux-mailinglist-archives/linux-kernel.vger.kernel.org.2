Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA337456ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhKSMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhKSMcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:32:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5712E61353;
        Fri, 19 Nov 2021 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637324980;
        bh=6N81grncfiDuTYZXAKPvFzVgX+xa34AIWa2uglCnKls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzFVHv/NlO06c4dZ9NmQyMPFoIqJp2zTEwMb6RJB6ZQmt4O2D0ktTlTme8L8fnfqo
         GOuIGCnz4574TKGL///YjowFbjSPV05+da/zqrQdSgOKgE70f8m2yllTA6alFOqwSD
         BWRK9rHSDwnZ6KQ99eIgeWQV4I4S7YUOssTA30fM=
Date:   Fri, 19 Nov 2021 13:29:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <YZeYsip9CD8YkKgl@kroah.com>
References: <20211118202718.GA152832@t470p>
 <20211119085138.GR26989@kadam>
 <20211119122351.GA2519@alb3rt0-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119122351.GA2519@alb3rt0-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Nov 19, 2021 at 01:23:51PM +0100, Alberto Merciai wrote:
> I'm using the master branch of 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/

Very odd, why?  That git tree has nothing to do with the staging
development process, and especially not the master branch.

What caused you to pick that one?

thanks,

greg k-h
