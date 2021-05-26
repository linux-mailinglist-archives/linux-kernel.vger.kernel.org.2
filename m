Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06A13912AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhEZIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232537AbhEZIqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:46:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 846AE613B5;
        Wed, 26 May 2021 08:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622018711;
        bh=aZiZDYa2rf5Fxx+HribOsNGXIZH+nQIh50qzwgEDY6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y8PpcE9n5dsYJntRV+W0DDV2gI4ln9mDcAUwQ6JqTu3ixa0vj0Xitc2ihpOd2n+Vy
         +U9nS+1L6gWoiABM01FN2a79WZkFad8+3LPLbybX4XAM0U6R3DDe/J3s9L/47J8rwE
         sOsEuiF1zHEzxbMsxTab4emXdlw9ntNdVjCgXL4g=
Date:   Wed, 26 May 2021 10:45:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Johan Hovold <johan@kernel.org>, Nikolay Kyx <knv418@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Lee Gibson <leegib@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] staging: fwserial: Fix potential NULL pointer
 dereferences
Message-ID: <YK4KlP0ZpwPOUU2G@kroah.com>
References: <20210521114339.8469-1-novikov@ispras.ru>
 <YKefCpAnVWLCDVtg@kroah.com>
 <219911622016850@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219911622016850@mail.yandex.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:21:36AM +0300, Evgeny Novikov wrote:
> Now I see that we need to restrict in specifications those values that
> can be passed to the install callback of tty_operations according to
> a first actual argument of tty_alloc_driver(). Thank you for pointing
> this out.

I do not understand what you mean here at all, sorry.

What "specifications"?

confused,

greg k-h
