Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D531245DEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356376AbhKYQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237265AbhKYQo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:44:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E148361108;
        Thu, 25 Nov 2021 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637858506;
        bh=HEzFcPjpLIj3IF4Eia3OGUoygd6d8nC48bFgfzgmwAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQ23rWQktxNnZOoRQtqwV1AXo3X61oJAoaureYfgYRJy9EEv7uH87xC3/i1/3e+2D
         j56PabkZx/SqLA/tu1A9up38+u+f98MPZRp5R1Dk7nghyndKW2TjRdye3zYGU81YWI
         FYAAJ3nThm0bmcG3exxe8Hwqfnmwota64XT0AhIQ=
Date:   Thu, 25 Nov 2021 17:41:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zameer Manji <zmanji@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused code in rtw_cmd.h
Message-ID: <YZ+8x/mLvo0nooED@kroah.com>
References: <20211117143831.1511437-1-zmanji@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117143831.1511437-1-zmanji@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:38:14PM +0000, Zameer Manji wrote:
> This patch removes unused code in rtw_cmd.h.

This is not really "code", it is something else.  Please always be
specific as to what you are doing and _WHY_ you are doing it.

thanks,

greg k-h
