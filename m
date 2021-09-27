Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B04197DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhI0P1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234500AbhI0P1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:27:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 126BE60F91;
        Mon, 27 Sep 2021 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756376;
        bh=zOTYtImCLca9S+yictRsMbXs3evr7x+36sm1zHHoQCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyUKchGE9/bcB887Zwbjn09ge/SwiLmbQZ3VneTPLZBU24HUm7+UmW6L55NuWHrZQ
         8VnVBf/Z5rqyOS8ccsmVkkXyYlTZaaRLc95qqZnOiNrErwf7RqfUwUcwbj1784KfJl
         FLiSqS0s9PVmKvmt89sN3yGlNmkzeWUj9uzjwnvg=
Date:   Mon, 27 Sep 2021 17:26:14 +0200
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
Message-ID: <YVHilhCk3cgGhXrZ@kroah.com>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926162527.21462-2-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> Replace camel case variable bShortSlotTime with snake case
> variable b_short_slot_time.

That is a very odd variable name.  Why did you pick that one?

What deos it mean?

You do understand where the original naming format came from here, and
what it was trying to represent, right?  If not, please go read up on
it:
	https://en.wikipedia.org/wiki/Hungarian_notation

That style is not used in Linux, and so, when converting from it, do not
attempt to keep the same style present here, that is kind of pointless,
don't you agree?

thanks,

greg k-h
