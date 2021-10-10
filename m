Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE442816C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhJJM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJJM7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:59:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7635460EE2;
        Sun, 10 Oct 2021 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633870636;
        bh=jMKprDtSDUuryJ5jHXv3kadbXCJNGZ1aD8piqWTAmQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzSYd+1uThyn6OLYpDrXsFBTx3ovQDE/ul0LYUdF8B14FRObL+ErOHC0NDWMWiuqP
         TkRBa6Q0NaOqzi69Mee50NwAxpd5cw7pPkV1ykF9s/hCY/qL+vqbFsyIXECDfv3K2R
         uHyQq3T48fvvy4pguPUlsCxd2vsYOjy2bws5hpTw=
Date:   Sun, 10 Oct 2021 14:57:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: r8188eu: remove struct hal_ops
Message-ID: <YWLjIwKnruameNBg@kroah.com>
References: <20211007103943.8433-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007103943.8433-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:39:38PM +0200, Michael Straube wrote:
> This series removes the remaining pointers from struct hal_ops and
> the struct itself.
> 
> Note that I sent the first two patches separately yesterday, so this
> series makes the separately sent patches obsolete.
> 
> Tested with Inter-Tech DMG-02 on x86_64.

Nice work, thanks for getting rid of this unneeded structure!

greg k-h
