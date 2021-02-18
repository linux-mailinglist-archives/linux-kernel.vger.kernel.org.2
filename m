Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0379331F16D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhBRUxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:53:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C74E764EBA;
        Thu, 18 Feb 2021 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613681548;
        bh=YlPhddCJ8zuydjvINlkwW2QONdBm3qQQoPopDdieDwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbLyk+0VYVANhqKokUrhD7ABbEfCU8XsI1lrFZ0yWL/u11rdouEFqjISQRbs+RsKp
         lveCsH/2AM2s52Dai+QZe0kQevGbwh6VyMIgNOTrwIvdgFtTaSt413iRZvHsKM6jUf
         Fyz2dUJ4DuAICPcnLbb+wM+tD43igC2rXTJTTB+o=
Date:   Thu, 18 Feb 2021 21:52:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     sergiu.cuciurean@analog.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: code style: fix alignment issues
Message-ID: <YC7TiCzbB+4ppzdk@kroah.com>
References: <20210218202814.14204-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218202814.14204-1-knv418@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:28:14PM +0300, Nikolay Kyx wrote:
> kpc2000_i2c.c:
> fix WARNING: line length of 124 exceeds 100 columns
> fix CHECK: Alignment should match open parenthesis
> 
> kpc2000_spi.c:
> fix CHECK: Alignment should match open parenthesis

This changelog is a bit odd.

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change.

thanks,

greg k-h
