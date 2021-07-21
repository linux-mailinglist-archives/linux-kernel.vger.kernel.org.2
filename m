Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D691B3D0ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhGUHzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236463AbhGUHoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:44:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4958D61019;
        Wed, 21 Jul 2021 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626855853;
        bh=XhnHeBoYkaCZCBf/RqL6mJUJh1G/RSkhLv1VfzoiC8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPbHPyVsKw2mKOAanYkc/POtAf6HlZetFN3+kzMKR8RpeJE63o57iKc6gCFGeU6u2
         IOpE+uU/4M/eBSGkzMIv1MFUasJ6YfP9suwx8UhnimOsXOgceYMetNqnJluGbNhZ6n
         RxCI9kvleKMcEG09EEyxkaVyCOqj4TpVXGKDDaSM=
Date:   Wed, 21 Jul 2021 10:24:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com
Subject: Re: [PATCH v2] staging: rtl8188eu: Remove no more used functions and
 variables
Message-ID: <YPfZq8tIiIEI7uIb@kroah.com>
References: <20210713190358.11864-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713190358.11864-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 09:03:58PM +0200, Fabio M. De Francesco wrote:
> Remove the functions and variables from rtw_security.c that are no more
> necessary since the patch that replaces getcrc32() with crc32_le():
> https://lore.kernel.org/lkml/20210713184629.7358-1-fmdefrancesco@gmail.com/

Can you send this as a patch series?

confused,

greg k-h
