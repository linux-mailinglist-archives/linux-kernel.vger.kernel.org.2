Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5437731889D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhBKKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhBKKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:46:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EB2B64E30;
        Thu, 11 Feb 2021 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613040364;
        bh=LwGqfeqndjouoBOTmTl++2nGkzNAHPW3aZzYw4jG8Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKG60i4HiYI/zfsUUtRI3tJ6nEJ9AoEqJeOLeXBBQhhfugS7tfIA3NWFg1JayAtYb
         lI9Ad/TTxQDveeD/07RGq1iJZx5moSlfZhiGvHR5/XzIxgx5F750g6nm94NnwSKND3
         JSerqobmuELONH2GkhSIGALGaSr4ATxTo/YvV7ZM=
Date:   Thu, 11 Feb 2021 11:46:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
Message-ID: <YCUK6Bi9lFziF6qG@kroah.com>
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
 <20210211075715.GD2696@kadam>
 <CAJ5zXr3ONFFHL7g8Xt=BjM9SJK16HEwiqhkBPTbrBTwa=DDqog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ5zXr3ONFFHL7g8Xt=BjM9SJK16HEwiqhkBPTbrBTwa=DDqog@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 04:00:04PM +0530, karthek wrote:
> Should i send them as patch series?

Please do.

thanks,

greg k-h
