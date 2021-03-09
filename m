Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70583332714
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCINZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCINZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:25:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9762964EBB;
        Tue,  9 Mar 2021 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615296338;
        bh=NyXOl2NuApJTT+C5q0M/pah7sdr6CZ1hEWNqGRvVsXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x/lthFm2Dt9Zrta0Jgs5v5vVC6dPjamv02TdG4/tBc/b5MAzE144yN9Kg5HnsbfkF
         eO1WtjEsGKFR/mD6co3krTXvGKHEqUvEYjSb74MOIo0cCsK4d84lqx46jiZdAuk1Ce
         cn+AcSAwNYEez3cJDABUltPwE1hwR7mwnWQcq1RE=
Date:   Tue, 9 Mar 2021 14:25:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: fixed whitespace coding style issue
Message-ID: <YEd3T9D3kMWTU+Pe@kroah.com>
References: <20210309125445.15167-1-selvakumar16197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309125445.15167-1-selvakumar16197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:24:45PM +0530, Selvakumar Elangovan wrote:
> Removed additional whitspaces and added space around the binary operator in the rtl8712_xmit.h file

Please wrap your changelog at 72 columns.

And you are doing 2 different things in this patch, please only do one
"logical" thing.

And finally, you sent 2 copies of this patch, I don't know which to
apply, so I'll drop both and wait for a v2.

thanks,

greg k-h
