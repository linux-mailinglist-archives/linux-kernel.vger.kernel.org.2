Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39353FD842
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbhIAK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238930AbhIAK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8982661056;
        Wed,  1 Sep 2021 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630493811;
        bh=Fwbfjip1Qv3snloRf4ueTwlb0YqnghiwC8Rsc7a9fXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvEWI0o0rfZ+Pgr+0lQNXh9SFlejPb+NQO3G19+9gZ+JYDUNzhyDDTrpQIACCb+Dn
         ZwSstocv0xGgF4F+l0ZCAavL+r8E6k0I2gBNetwrpsx56H6BGYuvTRdl9BzVZbFBVJ
         57UdIcmZVwq8UmmDt2W5pMastx5UuRDlbzlMZCKU=
Date:   Wed, 1 Sep 2021 12:56:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, stable-commits@vger.kernel.org
Subject: Re: Patch "f2fs: report correct st_size for encrypted symlinks" has
 been added to the 5.4-stable tree
Message-ID: <YS9ccE1YRbZ9qrqK@kroah.com>
References: <1630493566203214@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630493566203214@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:52:46PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: report correct st_size for encrypted symlinks
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, nope, breaks the build, now dropping.
