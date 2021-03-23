Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B861345EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhCWNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhCWNIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FA56619B8;
        Tue, 23 Mar 2021 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616504919;
        bh=tD39tcRIJ10/gX0BkNZq+Tb2OQEH0T3v47HYVYUZ0r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDcyHQKTp4WIDk2jKQWP7QixXlPbWg7xkuJAwjYdyh3hTfzjdDF6owmcykrcdUj8J
         mxV6j4ocVgCwRgkMRzxKyuSjYxNgSq7WJR8bwPzRLZ8tXQZuiGv4mfPhB2Icl2lyG/
         O0qOG8i52RsF1dVmTrSAJnBPfUq8Bb9JFYxyz9m8=
Date:   Tue, 23 Mar 2021 14:08:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] fix extern declarations checkpatch issues
Message-ID: <YFnoVGOJQNtssYIV@kroah.com>
References: <YFjBHNkQFlFzZKpV@kroah.com>
 <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:56:27PM +0100, Fabio Aiuto wrote:
> Fix extern declaration issues warned by checkpatch.

Nit, we have a new mailing list, you might want to use that now instead
of driverdev in the future, thanks!

greg k-h
