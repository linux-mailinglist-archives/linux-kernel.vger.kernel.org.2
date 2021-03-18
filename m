Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB0340622
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCRMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhCRMxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8988E64E28;
        Thu, 18 Mar 2021 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616072004;
        bh=O6Dn8NZFxasAbkOei1SvMJ8c2d5xYbf+Kh/CSiUh3eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVox8nhx/698cmu+cLC1aCV4oXooyg3HRW/xfKhEr911Zuw4K2NGgFFBujBwm1l+q
         iiAYfQ5fpY43eXN7c7m9AGQz912G65ScoF98LiJwKlg3DslbPMMoeIwx0WjvWhytHb
         Q9ZMdy/MalRm9feP8ERA+ezecztcdk5iWXxLrbxc=
Date:   Thu, 18 Mar 2021 13:53:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] devtmpfs: fix placement of complete() call
Message-ID: <YFNNQSTTeN8wRDhR@kroah.com>
References: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
 <b9db4269-2e7e-76ec-4f54-e871d3798d45@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9db4269-2e7e-76ec-4f54-e871d3798d45@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 01:44:04PM +0100, Rasmus Villemoes wrote:
> On 12/03/2021 11.30, Rasmus Villemoes wrote:
> > Calling complete() from within the __init function is wrong -
> > theoretically, the init process could proceed all the way to freeing
> > the init mem before the devtmpfsd thread gets to execute the return
> > instruction in devtmpfs_setup().
> 
> Greg, ping? Also for the other one.

I'll pick this up for my tree, give me a chance to catch up, there's no
rush with this one :)

thanks,

greg k-h
