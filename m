Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE8C31B66A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBOJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 04:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhBOJ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 04:27:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 934A464E05;
        Mon, 15 Feb 2021 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613381182;
        bh=Hx5z1rifcBA0/D3/CR4r4TNMRTRdV57Ll0FCDoT4BLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vncXqGi4e7matg0+/xWPfXJg8qoL7wWZMGF+chJ4lfNjw4m4jyisrxYLtsc+LUXEW
         pUDZubAgws0kEnACtPIURhma/ElgiT9O7Go8YwmKdHMg8TOlr+hJ5RP3+lFpEuRn0K
         NLkv738CJ5FoU4prvhXFBBBR1eUVMgN9kw70fUDM=
Date:   Mon, 15 Feb 2021 10:26:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>
Subject: Re: [GIT PULL v3] extcon next for v5.12
Message-ID: <YCo+OyO6/yBH+R6o@kroah.com>
References: <CGME20210215091851epcas1p1bef95c3b1dcc958bb48667ef7dc820a2@epcas1p1.samsung.com>
 <e52e5d36-f7f1-4a3f-869e-88cc5e15b7c3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52e5d36-f7f1-4a3f-869e-88cc5e15b7c3@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 06:35:16PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.12. I add detailed description of
> this pull request on below. Please pull extcon with following updates.

As 5.11 is now out, I can't take new things in my tree until 5.12-rc1 is
out, sorry.

Please break this up into bugfixes and new features and send them to me
for 5.12-rc1.

Or just send them to me now as patches in emails and I will queue them
up to my trees properly when 5.12-rc1 it out.  That might be the easiest
thing for you to do now.

thanks,

greg k-h
