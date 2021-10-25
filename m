Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FAF439012
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJYHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYHMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C6B760F6F;
        Mon, 25 Oct 2021 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635145801;
        bh=ekVPHsWSQGUmC/hsU73qpMXP3NYnURrkjKH4BVQopEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Ja7Q0u2YTThGPHH4sgxRIUWefxt0aZ5FzWAkA6NciMd1jlJoz9rm53QcHPZJtxQ5
         Hgc6yZXSONkq9rnUCa7IEpiQBVY80Ly+e0dNXQsKLgC97wgcXdliA7MDWEe1QEAe7O
         4l8jiHSxEXuMQ7/2c0V8VHcAS/BJCxpSs59ygEBs=
Date:   Mon, 25 Oct 2021 09:09:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: r8188eu: remove struct sreset_priv
Message-ID: <YXZYR3FHnrPqB7hP@kroah.com>
References: <20211024180448.20624-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024180448.20624-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 08:04:43PM +0200, Martin Kaiser wrote:
> The sreset_priv structure is not used by the r8188eu driver. This patchset
> removes sreset_priv step by step.

Nice cleanup, thanks!

greg k-h
