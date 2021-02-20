Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3719320511
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 12:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBTLNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 06:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhBTLNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 06:13:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDD364E76;
        Sat, 20 Feb 2021 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613819584;
        bh=CeOaW03d10kbAd6D3R64qI1Da05bexs8Y8mdKcjIP1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLzdakdnzBRJTEYL2jUVQRiMHOjwlBJsWHX+mN6T0HVpWOaizD67mC8exmRh50ugY
         Yck1iWy1d5CK0u7VQnr2rtLGoBW7XuYTZtxayXgEBNvSHooKQxq0inkCZ3+XHLBB8P
         JhmBLn0EUdTiG31BUBlK5POXrQ5fhmeslYSh44HA=
Date:   Sat, 20 Feb 2021 12:12:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Cc:     sfr@canb.auug.org.au, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: i2400m: add space before open parenthesis
Message-ID: <YDDuu6sRtSfWhnbY@kroah.com>
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 02:48:16AM -0800, Rajesh Kumbhakar wrote:
> netdev.c

Why is this here?

