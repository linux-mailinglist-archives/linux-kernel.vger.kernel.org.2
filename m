Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09793D1DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGVFJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhGVFJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92B4B60FD7;
        Thu, 22 Jul 2021 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626932997;
        bh=0J89/uP9lXLyoxM1Ee92ERi+4UY4jrHzqQpmE4RqHYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIPLAvK9wWvjJc1eLVZXJ3aVEwRZafhEWM1xR70neXS/99CkcgONkfaZMksw6NUO6
         z74omm3Mtxo3ebR2NDGpwExWa9Sqem0p8UFFwf4ed0shcUk5E7aM6KVuttlU0KLfMQ
         yifYPhh6pFIr0q8p01dN6cFkJQaOeCD8dsGet260=
Date:   Thu, 22 Jul 2021 07:49:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
Message-ID: <YPkHAX1YdmxZtW49@kroah.com>
References: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:50:34AM +0800, xiyuyang19@fudan.edu.cn wrote:

You sent an empty reply???
