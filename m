Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E728F319481
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBKUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBKUaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:30:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8021D60238;
        Thu, 11 Feb 2021 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613075406;
        bh=9BeSxp+LfXzGr7rzTLopFJRujqx6EtqDjtC3aepToeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbQZgb9+yzbi4MXAN9SO5G3v0DJ9VKEz2lREsidbnvUeGg9uiWpiljuXMHOpGRFk8
         w05tsSMgZoOKhhfd4Yvz4XLzqPJPlhw4FBCMAJL849AEsoMdglUNIBRvoryjQqj73A
         sdyXMj1muvY47F7nESCt7YMynHdd4BDRQmJdtVf0=
Date:   Thu, 11 Feb 2021 21:30:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fixed misspelling and alignment issue
 in hid.c
Message-ID: <YCWTyntWHst9TSnt@kroah.com>
References: <20210211153001.10358-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153001.10358-1-pritthijit.nath@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 09:00:01PM +0530, Pritthijit Nath wrote:
> This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
> In addition the misspelling of "transferred" also has been fixed.

When you say "also" or "in addition" in a changelog, that is a huge hint
that this needs to be broken up into multiple patches.

Please do so, and fix your changelog ling length and send this as a
patch series.

thanks,

greg k-h
