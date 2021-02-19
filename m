Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45F431F50F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhBSGWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBSGV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:21:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 887B064EC0;
        Fri, 19 Feb 2021 06:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613715677;
        bh=h3tseLehzsIKBNkS/hC8AI0YOI2QV+D0PG4f72kEZAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gus+0Z73eMJkwwPTaT5qMZFzGQWGL7AebpV+mEPFEU53PhlTUJJa4rSQnR3BqN2t6
         yA/0uw3N2BJynAuBRk84kmUPFjNs1pErofcDpXsQqyZpBWfZODjhvn3VuCY4h5f+tu
         joChh/mOcik/mF4PWQhMw7EvbVrYeGsV18fosH80=
Date:   Fri, 19 Feb 2021 07:21:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthik alapati <mail@karthek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: i2400m: use explicit host byte-order types in
 comparison
Message-ID: <YC9Y2SKnJ5fu9Ruh@kroah.com>
References: <YC8Gt4sawUiuTTE3@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC8Gt4sawUiuTTE3@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:00:47AM +0530, karthik alapati wrote:
> convert le32 types to host byte-order types before
> comparison

That says what you did, but not _why_ you did it.  Please fix up and
resend.

thanks,

greg k-h
