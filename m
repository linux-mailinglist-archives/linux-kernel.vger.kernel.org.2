Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73D93ECF03
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhHPHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233546AbhHPHNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA21A61A86;
        Mon, 16 Aug 2021 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629097955;
        bh=0EIutyxBcPAy4Gsng5ZI5cvPBBrZm15P1me8EvH/hK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhwKEfNbJrgNfLqEkccmncSo9d9Iag7LyYDvERlcCCX9OB31THi6sSVCz2YEVQOze
         gSsV613N3+Fk3gU8MyQnmYmxm73+s9V3DpLAGZRoCj+rcBtKkiSO2qjxnWwhgxp3aB
         V3jcuvxC6DhzPAMaN5Lzfpc3y7R6dmDxp1Kn5/X0=
Date:   Mon, 16 Aug 2021 09:12:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: use common ieee80211 constants
Message-ID: <YRoP4T4W9Iub1sLG@kroah.com>
References: <20210814165518.8672-1-straube.linux@gmail.com>
 <CAA=Fs0kkhzvu134zOpb69Z6WFCCpmcfGLR-4KJeDd3n1d8g-qw@mail.gmail.com>
 <9f13258d-5fa1-aa28-e2e6-14f0721b8eb5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f13258d-5fa1-aa28-e2e6-14f0721b8eb5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 10:04:58AM +0200, Michael Straube wrote:
> On 8/14/21 7:36 PM, Phillip Potter wrote:
> > 
> > Dear Michael,
> > 
> > Constants seem to be correct values still, nice. That said, the other
> > patches that have come through from others before this prevent this
> > applying to my copy of staging-testing branch. Assuming Greg takes the
> > patches in order, this will therefore need reworking. That said, it
> > builds fine for me when applied directly to fresh staging-testing tip
> > without the patches that have come in since, so:
> > 
> > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> > 
> > By all means apply that Acked-by to v2 if needed. Many thanks.
> > 
> > Regards,
> > Phil
> > 
> 
> Thanks for the hint Phillip. Sure I can send v2 if needed.
> 
> Greg, is this ok as is or should I send v2 rebased on staging-testing
> with other pending patches applied?

This applied just fine, no need for a v2 at all, thanks.

greg k-h
