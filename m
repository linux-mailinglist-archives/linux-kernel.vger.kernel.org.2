Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C43460B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhCWN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhCWN6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:58:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A7E3619B2;
        Tue, 23 Mar 2021 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616507915;
        bh=WP+mOmqwzaBbFOE2/nQC0Bw5IRGJF26rivDQ6prF8fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAJDh2BuPKNtmt+DkOFpiduS5ENfhI2FUJ4snm+cq9yy2vR85kO+i+e9I3tkradGQ
         q4+ISHSvExo4LL2HfkCj4Geo9S7cllMklx0L19pmA7/qy5lyZ9jCt4S3R9A60OSL69
         E1Dqv3RHCGLasOvg3QJWJ5qIADfzADZHRA0l7wEw=
Date:   Tue, 23 Mar 2021 14:58:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] driver core: Avoid pointless deferred probe
 attempts
Message-ID: <YFn0CFMBfnLWJTdb@kroah.com>
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-2-saravanak@google.com>
 <CAGETcx81SLrDGe3KMR1OfjSgo7T-kbj1ENwkvnfo6_A82E0j7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx81SLrDGe3KMR1OfjSgo7T-kbj1ENwkvnfo6_A82E0j7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 03:26:05PM -0800, Saravana Kannan wrote:
> On Tue, Mar 2, 2021 at 1:11 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > There's no point in adding a device to the deferred probe list if we
> > know for sure that it doesn't have a matching driver. So, check if a
> > device can match with a driver before adding it to the deferred probe
> > list.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> Rafael/Greg,
> 
> Any concerns with this specific patch? Do you see any bugs? I'm asking
> because some of the other improvements I'm working on depend on this
> flag. So I want to make sure this can land before I take my work in
> progress too far.

Looks fine, now queuing up, thanks.

greg k-h
