Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570B139F8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhFHOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233230AbhFHOOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EB3760FE9;
        Tue,  8 Jun 2021 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623161538;
        bh=UU78FkBvBQ+bGhsuFu7iJ2jbXBPQNaYDh0/ReT/swaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlECTdcCEFg8WxBNBWEoa6V4TQGTwh8v5XDRZSW0dYn0HwCk3tDynaAxsS8fPAGfc
         m9/LM9M/VMmepG/fc98rvp3VTg5ig7IMQVN42JLi85FtDPAhsyCbYQM9KnbKrMMR6u
         ORUayTW1zbBHEEvjcERoUtDbF3tIWuqGNJeAfRF0=
Date:   Tue, 8 Jun 2021 16:12:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] staging: r8188eu: use eth_broadcast_addr() to
 assign broadcast address
Message-ID: <YL96vz4okNehxCBG@kroah.com>
References: <20210608141620.525521-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141620.525521-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:16:20PM +0800, Liu Shixin wrote:
> Use eth_broadcast_addr() to assign broadcast address.

That says what you do, but not _why_ you are doing this?

Why make this change?  What benifit does it provide?

thanks,

greg k-h
