Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9C3EB071
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhHMGhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238575AbhHMGhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:37:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E64B960F57;
        Fri, 13 Aug 2021 06:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628836606;
        bh=OWcCVrWs+Nrv4OBKjq7wxpgmmBG8z8MYon/afD2MLQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkvYzqPiCf++jHMx0GFAmCe9nW2fcxCI2cYmkFxWe1NX5aDffwgOI6pzTin6lh5dW
         ZcnIF9eIzz2fvnkm6W1qKJB5zTqtOjqd82Co12V0K3DSEWY6soayHJXG46/WFamS3N
         yFAM8vQ6iufxcNVarUCoOQx3VU8hoi9h8LrszhgY=
Date:   Fri, 13 Aug 2021 08:36:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>, hdegoede@redhat.com,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove cfg80211 residuals
Message-ID: <YRYS+4I58YRnAepF@kroah.com>
References: <20210812132725.18404-1-fabioaiuto83@gmail.com>
 <c2abe840-98b4-cddd-e427-2243d456ec19@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2abe840-98b4-cddd-e427-2243d456ec19@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:51:56AM -0500, Larry Finger wrote:
> On 8/12/21 8:27 AM, Fabio Aiuto wrote:
> > remove cfg80211 implementation residuals:
> > an headeer file and build condition in Kconfig
> > file.
> > 
> > Signed-off-by: Fabio Aiuto<fabioaiuto83@gmail.com>
> > ---
> > Dear Greg and Larry,
> > I thought that cfg80211 had been implemented.
> > Should we add a TODO file telling developers to
> > do it in the near future? Is that a condition
> > for mainlining r8188eu? If so please drop this
> > patch and sorry for noise.
> 
> I thought so too, but something has gone very wrong. Please hold off on this
> patch until I figure out why cfg80211 is not being used.

That's odd, I'll drop this from my queue, we should be using cfg80211
