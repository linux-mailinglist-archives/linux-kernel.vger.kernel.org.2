Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC13D1287
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhGUOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239960AbhGUOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF1D761003;
        Wed, 21 Jul 2021 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626881783;
        bh=tru3kqetbspDjeMDVw0XOA9y9T4GJK+oEr7pOGN/0qY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaD66n0Xh/qP6UZzAIK8Z1ch5qA5vtVrYoS2yoxNGcIMuk0kNJ4C8mCXSvE7VOtHd
         ZTfrYLuTX6AXmtwtu3MzLG/gbE4IgXZI2TSYLjlY5fcoE8wbTonuhsWnYcMRX5XL0x
         K16vCJ6BlVzHlyVDTNX8BbpbzZgwpJVQ2JAqBgtw=
Date:   Wed, 21 Jul 2021 17:36:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
Message-ID: <YPg+9MGnEOxj9PB3@kroah.com>
References: <1626683601-64278-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626683601-64278-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:33:21PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.

But this really is a count, not a refcount.

So are you _sure_ this should be changed?

What did you to do to test this?

thanks,

greg k-h
