Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A642D43906B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhJYHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231653AbhJYHfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:35:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3455760FD7;
        Mon, 25 Oct 2021 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635147199;
        bh=39U7zNLEwA87RE5PJQOdIUZwBwhHR+JBeEhHxTPhiSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSBRbavOezeV7w6FoDRU62rgJc2KqLOlljzPjhnAhs/F9WcfpE+DUfnsIicJUMLsi
         +DkWPDypg9/LKAgM3xYO4qiEpauO9xykHVs5yZuBdJtgvoJpRT8od76cJq3a4lM1GV
         q8y0CxursNFEaqI5S2V2CzDON3RlTdNZRe3PgBZk=
Date:   Mon, 25 Oct 2021 09:33:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        hdegoede@redhat.com, marcocesati@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mike.rapoport@gmail.com, kushalkothari2850@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: Refactor nested if-else
Message-ID: <YXZdvdj6EQsrfhqt@kroah.com>
References: <20211025072528.152028-1-kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025072528.152028-1-kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:55:28PM +0530, Kushal Kothari wrote:
> Refactor nested if else by combining nested if into a single if condition and removing unnecessary else conditionals which leads to removing unnecessary tabs .There is no change in logic of new code.

Very long line, please break it up at 72 columns.

And your space around the '.' is odd :(

> checkpatch warning : Too many leading tabs - consider code refactoring

What does this mean?

> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 65 ++++++++-----------
>  1 file changed, 26 insertions(+), 39 deletions(-)
> 

thanks,

greg k-h
