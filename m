Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5654741A6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 06:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbhI1Eoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 00:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhI1Eon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 00:44:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 074D161153;
        Tue, 28 Sep 2021 04:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632804184;
        bh=4PWPaxkWVDJgHf9CECpBwrvksA5D5ixImo5ByqYDQR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7WooI0peHLV6xAfbcCQ7NN40bcf4xPYX24vqVOIqIMS7TlrV5LDTU6sDFzio6Ni6
         iHzaWVT6ENzaHXbx/fsWmERgUHuraSmCwH+KqHm/3JhM8eOJav00HICrPNgxiWzAtQ
         SvkGa+E9dh9UqlxSTKCqH1FPDwT95ytne9HXUKa4=
Date:   Tue, 28 Sep 2021 06:43:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <YVKdVCaVwmPG7DVx@kroah.com>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927213515.GA6953@tom-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > Replace camel case variable bShortSlotTime with snake case
> > > variable b_short_slot_time.
> > 
> > That is a very odd variable name.  Why did you pick that one?
> > 
> > What deos it mean?
> > 
> > You do understand where the original naming format came from here, and
> > what it was trying to represent, right?  If not, please go read up on
> > it:
> > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > 
> > That style is not used in Linux, and so, when converting from it, do not
> > attempt to keep the same style present here, that is kind of pointless,
> > don't you agree?
> 
>   You are definitely right. What do you think about "short_slot_time"?

"time" implies that this will hold a value of time, right?

What exactly does this variable do?  That might help in naming it
better.

thanks,

greg k-h
