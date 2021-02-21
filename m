Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA02320C73
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBUSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBUSKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:10:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D1764E44;
        Sun, 21 Feb 2021 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613930966;
        bh=1yPfCwVhYqpXNklZn8fW7ZXjCmje+8uM72sUYiafzAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1+tg246AyNda5RdokK+G+rMEtWBnW32RNfjyowLv3EHD/8lZPK2uDIgSS0vHweGz
         8UaMg/mv8JBi0KBinY7L5qXCIfUR813yHCaTX0CRdPcqAg/9EevAw0ozSGHpVEn4m3
         N2Blf+culgf1HrFSOZw+2rKOhw0hjFEGQcK+mfok=
Date:   Sun, 21 Feb 2021 19:09:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     lee.jones@linaro.org, arnd@arndb.de, johannes@sipsolutions.net,
        kuba@kernel.org, mail@anirudhrb.com, memxor@gmail.com,
        rdunlap@infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wimax: Fix block comment style issue in
 stack.c
Message-ID: <YDKh02dQMhPdLlef@kroah.com>
References: <20210221163758.2996-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221163758.2996-1-amritkhera98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 10:07:59PM +0530, Amrit Khera wrote:
> This change fixes a checkpatch warning for "Block comments
> use * on subsequent lines".

That's not all this patch does, please be descriptive of what you really
do and why you are doing it.

thanks,

greg k-h
