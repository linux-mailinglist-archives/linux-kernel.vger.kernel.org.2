Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBBE42D58F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhJNJBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhJNJAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03CF4610EA;
        Thu, 14 Oct 2021 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634201918;
        bh=pbQLrLxcAZRoYN1Vz5nfVpkkPUBqZZxofu3//oPv/+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcTRixj2FVE3GHzJY+0CfRQ06bMwoNWFQ3rjnbkhP1JoQS/6h1KanWe35hKBs1zyc
         Cx9ThyoD162M9L0yd6gnV6+bG3pE9FRmzbdb2c5Oks9JBYakSXeV/ntPEL7vwJNUTO
         5ClvvMOMtPFnxt0xvrYs2QEZzQIRoFeqlcP3Vuqg=
Date:   Thu, 14 Oct 2021 10:58:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dyndbg: fix spurious log-level change
Message-ID: <YWfxPLpBTQLzm6Bk@kroah.com>
References: <20211013220726.1280565-1-jim.cromie@gmail.com>
 <20211013220726.1280565-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013220726.1280565-2-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 04:07:24PM -0600, Jim Cromie wrote:
> HEAD~recent inadvertently altered a message's verbosity from 1 to 2, restore it.

I do not understand this changelog text at all.

And always wrap your changelog text at 72 columns, like your editor is
asking you to.

> 
> Signed-off-By: Jim Cromie <jim.cromie@gmail.com>

Please put a proper "Fixes:" tag in here.

thanks,

greg k-h
