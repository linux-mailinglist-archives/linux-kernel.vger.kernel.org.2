Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5976401CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbhIFNvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242989AbhIFNvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:51:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BE9460F45;
        Mon,  6 Sep 2021 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630936198;
        bh=Oc0yRowwr2RWee7fH/21myDQmy8r5h2obyPq+HeSit4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vyLoVfngKqby7thz3HaOVnMDYjeOXL42SWskDM2NxdueE96KEmVagJXtx2SVUJKH9
         08IgYI5VNGhbPGBoXGmCoG9kukJP79sDEGYmGw7dSGn4ZFYshCVNdH4CePSDzLn7J1
         L3f33c4Cs+UA6NLiO0Kd+NQ1rUlklOwVUK3k37tw=
Date:   Mon, 6 Sep 2021 15:49:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove duplicate structure.
Message-ID: <YTYchKn/l3GboOsd@kroah.com>
References: <YTSj7upqzTiccWH2@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTSj7upqzTiccWH2@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 04:33:10PM +0530, Saurav Girepunje wrote:
> Remove duplicate structure mlme_handler and action_handler. Both
> structure are having same member. Replace it with mlme_action_handler.

Why merge both names together?  Why not just pick one name and stick
with that if they really do the same thing?

thanks,

greg k-h
