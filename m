Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B4F42415C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhJFPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238124AbhJFPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9E8D60FDC;
        Wed,  6 Oct 2021 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633534149;
        bh=QUoyOL6OKULLLn7PEX8SoWT6GhmIXGbAaIkLoV31JTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6JOPNbpPN39ApHvyDoURRufEqEmkxBN1lZlgjradLHZKy1HHXowQ/s4WWyu6EbZ/
         h4PjXnkejpZz5tzIwEXcosIp4KNadK50ltyM+w0VzFOBlYAg9sMHw8AXT984bmDKpW
         z9JF6DiTploHyc467aKH+7QhuCibhvP+qnOPmCK0=
Date:   Wed, 6 Oct 2021 17:29:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     kuba@kernel.org, neilb@suse.com, mojha@codeaurora.org,
        jkosina@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hashtable: remove a redundant check in
 hash_for_each_xxx()
Message-ID: <YV3AvszXKVBA5BNz@kroah.com>
References: <20211006152100.17795-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006152100.17795-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:21:00PM +0000, Wei Yang wrote:
> The three hash_for_each_xxx() helper iterate the hash table with help
> of hlist_for_each_entry_xxx(), which breaks the loop only when obj is
> NULL.
> 
> This means the check during each iteration is redundant. This patch
> removes it.

Are you sure that the compiler didn't already remove it?  Is the code
output the same or different with this change?

How did you test this?

thanks,

greg k-h
