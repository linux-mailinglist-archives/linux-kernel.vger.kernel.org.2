Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D0422A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhJEOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236315AbhJEOJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:09:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 421FA6115B;
        Tue,  5 Oct 2021 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633442828;
        bh=cnL/sf+hUo4gm74iG3lE21vurF1Az8bAampwQ7TaiAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhvWtXGKLs/EcIil4Qn1gria7uNWcxsINfw0mkwTdbaeLFIdI7kHGp/ZuY+UMZG7l
         TKTCwk17ziUxoS7W6ULVtfbtH4Bs3pxlc+CrDShWqjpmleZ48sZdWrqjbFUF3xfF4C
         LWE+Ph7lAO/Zc4QP+OlmfUNR0KT/n03HPGO8SOUI=
Date:   Tue, 5 Oct 2021 16:07:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] staging: most: dim2: fix device registration
Message-ID: <YVxcCpuz9C6XpEex@kroah.com>
References: <20210929205619.2800-1-nikita.yoush@cogentembedded.com>
 <YVwofSvwGTv3kHjh@kroah.com>
 <d309b4cf-12f5-5f49-fcbe-3141dff9e73f@cogentembedded.com>
 <YVxX1f6sgYjTVYt7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxX1f6sgYjTVYt7@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:49:09PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 05, 2021 at 04:33:02PM +0300, Nikita Yushchenko wrote:
> > > > Commit 723de0f9171e ("staging: most: remove device from interface
> > > > structure") moved registration of driver-provided struct device to
> > > > the most subsystem, but did not properly update dim2 driver to
> > > > work with that change.
> > > > 
> > > > After most subsystem passes driver's dev to register_device(), it
> > > > becomes refcounted, and can be only deallocated in the release method.
> > > > Provide that by:
> > > > - not using devres to allocate the device,
> > > > - moving shutdown actions from _remove() to the device release method,
> > > > - not calling shutdown actions in _probe() after the device becomes
> > > >    refcounted.
> > > 
> > > Should this be 3 patches?
> > 
> > But these three items are deeply interconnected, and fix the issue together.
> > Must not manually free device structure passed to register_device(), thus
> > must not allocate via devres (because otherwise, devres will free it). Once
> > not using devres for it, must deallocate it somehow else, thus must rework
> > the release paths.
> 
> Ok, but that was obvious.

That was *not* obvious.
