Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83F33D334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhCPLiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234011AbhCPLhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C8D65023;
        Tue, 16 Mar 2021 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615894662;
        bh=seOeQvzpZ0WrDzqZTo3cjmdGR0901pXobco+OtyWEm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZiCySnzomMKKJmKRYGFFGtPn28l+2w6ojVny19il1h+ILrstyBcTyRv3pUx7dx1K
         zRjd7nXdet5Kg6Zsmjal5Bxf3TNsxhN1cVrghh/lg5/2RYsMQIu5nIGrL0QVF4O2eY
         +Dv71NXCiZbGsRjAsiJv0Sjj9soE4rf1Ak4+i9AY=
Date:   Tue, 16 Mar 2021 12:37:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Peng <penghaob@uniontech.com>
Cc:     ross.schm.dev@gmail.com, izabela.bakollari@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: remove extra space in rtl819x_BAProc.c
Message-ID: <YFCYg1sGbPDRFEUI@kroah.com>
References: <20210315103320.18536-1-penghaob@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315103320.18536-1-penghaob@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:33:20PM +0800, Hao Peng wrote:
> Remove extra spaces in rtl819x_BAProc.c.

That says what you did, but not _why_ you are doing this.

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change.

thanks,

greg k-h
