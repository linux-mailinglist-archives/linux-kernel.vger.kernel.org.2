Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2083187C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBKKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBKKEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:04:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75C6564E92;
        Thu, 11 Feb 2021 10:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613037844;
        bh=jYOmfA2ySnqXWmc7HI+nczhGasVR4U01sAyBqP9xOkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqixWdqs4hL5QrKtcM64hQ1SNtwuB26IImiT/CtmwxyZms33VE1iY/lIRzZzUbCH2
         y4sLGH4kU56F82JBRxN+XNCZyPLUbXjRbl8Mm61nfV3V9OAuq0vcY4wSo6ygJlPtsp
         LBmwBAN9ZBX9yopKzm2bi1kneUG++O6s8q+U5JYI=
Date:   Thu, 11 Feb 2021 11:04:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCUBEMUyvRcQkFF7@kroah.com>
References: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
 <YCQxeMVM92dtfEpO@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQxeMVM92dtfEpO@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:48:16AM +0530, karthek wrote:
> check this out

Why ask us again when you already sent a patch?  Do you see any other
developers doing that on the mailing lists?

thanks,

greg k-h
