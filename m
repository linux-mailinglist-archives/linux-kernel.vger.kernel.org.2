Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D3A357C93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDHGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDHGZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A953610CF;
        Thu,  8 Apr 2021 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617863093;
        bh=sjxX9tCZgh/Blz8cOgBNQ0zrgLRPpvtKQKsvkokDa+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmahgufK5maORTGIza2vLT0hMnIbROyczIFMOJNODaNaADo654CQQHB69gYa91mfy
         8rpoCvMzQKNrDsmSdif9p3nsX1ZSekbx/x+KEx+Krf8acX5Nj+5HuOBn6QNGQi0rMy
         yybXmYKjwqxlzn1UEo23h9Yl1dtddBE0VSnrxVJs=
Date:   Thu, 8 Apr 2021 08:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8723bs: hal: Remove
 camelcase in sdio_ops.c
Message-ID: <YG6hsvA54ieV6ujj@kroah.com>
References: <20210407181914.7079-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407181914.7079-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:19:14PM +0200, Fabio M. De Francesco wrote:
> Changes from v2: Remove unnecessary comment. Shortened a function name.
> Changes from v1: No changes to the code but only to the subject for the
> purpose to differentiate this patch because other removes of camelcase
> have been made in other files of the same directory.

The "changes" need to go below the --- line, not here in the changelog
text.

thanks,

greg k-h
