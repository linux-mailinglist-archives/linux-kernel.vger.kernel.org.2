Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C379E3EF011
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhHQQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhHQQTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:19:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1EEE60FD7;
        Tue, 17 Aug 2021 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629217149;
        bh=c3yM9yH02sF/UxNTtj1k+yB9Q+PZZvDHvTQgx1BtO4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySi9W0uDlo0hDPfupwRzT3AAz4e2kZXuGC4UNUuthQThDED7Ghakc+BsXdN89TDvM
         dV6TAaLU1EdycZGUHSYOmn33SqcGIOyy8YUbAm+lVTkKvYvMa3/vUDsTVOig9KmS7r
         SloOT/oHK0t7WhWqw1TR+henNplk6iyPlwAyYA/g=
Date:   Tue, 17 Aug 2021 18:19:07 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Daniel Steger <dsteger@xilinx.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: sysfs: do not remove files if group is null
Message-ID: <YRvhe2B+uz2MToiu@kroah.com>
References: <20210809204228.2987376-1-daniel.steger@xilinx.com>
 <BY5PR02MB68170E18D6B5C79BB0AC9083C1FE9@BY5PR02MB6817.namprd02.prod.outlook.com>
 <YRvhP3qchzjAPsdA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRvhP3qchzjAPsdA@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:18:07PM +0200, gregkh@linuxfoundation.org wrote:
> > -----Original Message-----
> > From: Daniel Steger <daniel.steger@xilinx.com> 
> > Sent: Monday, August 9, 2021 1:42 PM
> > To: gregkh@linuxfoundation.org; rafael@kernel.org
> > Cc: linux-kernel@vger.kernel.org; Daniel Steger <dsteger@xilinx.com>
> > Subject: [PATCH] fs: sysfs: do not remove files if group is null
> 
> What is the message id of this, I do not see it on my side at all.

lore.kernel.org also never got this, so I think the issue might be on
your side :(

