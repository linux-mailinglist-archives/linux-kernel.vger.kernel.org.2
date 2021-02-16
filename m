Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4031CF92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBPRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhBPRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:49:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2A1964E04;
        Tue, 16 Feb 2021 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613497714;
        bh=+WmbEpL5TQzZgV2633H+PRBos/ZyurXcxG9Yaf/vsPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfLxxktZGpCdY6t+BB2FewXmei9MpsoKrwpECT6vHQbk+zd9Uqs2VxlTHtIMIwaxB
         KeeJXXvOHejzphs7KNQ0gX0UqUbwQKBd9VXeprmBGKV/qWUnE/9jk4a3apNfuzA0vU
         pmYVuuEjVIagD2SW0LzO1L7SjNaJ0eOUR9aRCUhg=
Date:   Tue, 16 Feb 2021 18:48:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 12/12] gna: add a char device
Message-ID: <YCwFb2X96fAaMICn@kroah.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-13-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216160525.5028-13-maciej.kwapulinski@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 05:05:25PM +0100, Maciej Kwapulinski wrote:
> +static inline struct gna_private *inode_to_gna(struct inode *inode)
> +{
> +	return container_of(inode->i_cdev, struct gna_private, cdev);
> +}
> +
> +static int gna_open(struct inode *inode, struct file *f)
> +{
> +	struct gna_file_private *file_priv;
> +	struct gna_private *gna_priv;
> +
> +	gna_priv = inode_to_gna(inode);
> +	if (!gna_priv)
> +		return -ENODEV;

Why are you testing for things that is impossible to ever happen?

Please go read your own function for proof...

{sigh}

greg k-h
