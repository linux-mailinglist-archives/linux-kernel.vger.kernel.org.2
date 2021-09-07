Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C566F4022F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhIGFBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 01:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhIGFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 01:01:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D3C160ED8;
        Tue,  7 Sep 2021 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630990812;
        bh=zUmx2ULy/blbbM0YNdkMyQFOd/Xq8yYfxL9d420jKck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGGaHNBEC3HcfmcE17GghVqNXqh2qmM2mBcpzsiCnw7ThGhwwfqWbARhQz793YM9e
         u+1WQi9K9PVzCTAAEIDX47yX93RaXHiYveY7mCBVaXGJBsSMDsBr6mVjwmFHabDAUe
         M3NzEw6Z1QElWVnhcA+BI2u3KJzmQPrX5yn7DnHk=
Date:   Tue, 7 Sep 2021 07:00:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/40] staging: r8188eu: remove function pointers from
 struct hal_ops
Message-ID: <YTbx0hAC4jmF6WP4@kroah.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
 <20210906225713.zbkm6tzghjsv3s2t@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906225713.zbkm6tzghjsv3s2t@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 01:57:13AM +0300, Kari Argillander wrote:
> On Mon, Sep 06, 2021 at 09:01:43PM +0200, Michael Straube wrote:
> > In order to get rid of the HAL layer this series removes the next
> > bunch of function pointers from struct hal_ops.
> > 
> > Also it removes some empty functions and cleans up some minor style
> > issues I stumbled upon.
> > 
> > Tested on x86_64 with Inter-Tech DMG-02.
> > 
> > 
> > v1 -> v2
> > Fixed typos in commit messages.
> > 
> > v2 -> v3
> > Added this missing patchset version changelog.
> 
> Can you please hold on litle bit longer before you send next patch
> series. This will make quite bit traffic on the lists and it does
> not add value. Wait for bit for reviewers and after that make new
> series. You can even post below yours own messages if you found some
> mistake and point out that you will change it when you send next
> series. Good hold on time would be 3-7 days with series this big imo.

No need to wait that long, if you know you messed up, sending it again
is just fine so that maintainers and reviewers do not start looking at
things that you know is incorrect.

But you can just send a response saying "oops, this is wrong, I will
resend this in a day".

thanks

greg k-h
