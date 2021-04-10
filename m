Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE71E35ABA9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhDJHas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhDJHaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:30:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA7E761165;
        Sat, 10 Apr 2021 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618039832;
        bh=V2ahhYFun9G88NQxi3nZmo9sLQY6hlpOSG6Jx+hmFsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzO7xqgS1NfRhZiRS1IbnQLcjhMcw7kw4xrwa3qJbrSGXRrkFMqY6W7lRo35IFML/
         py4srfSdjkBPjl9euQbrFv6wzMNg7wJIB3cZ7BNXpNnNiuJh+tiSLf35HD6gSQKUPT
         tYQg5nIXBLvoW1vAOup968WyrrFcRTK+joWQaXZY=
Date:   Sat, 10 Apr 2021 09:30:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [Resend Patch 0/3] staging: rtl8723bs:
 Patchset for rtl8723bs
Message-ID: <YHFUFJ9S1ezqwPe9@kroah.com>
References: <3311077.CXPNp9SFPB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3311077.CXPNp9SFPB@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 06:39:31PM +0200, Fabio M. De Francesco wrote:
> This patch series removes camelcase, changes the type and use of a 
> variable, and correct misspelled words.
> 
> Patch 1/3: staging: rtl8723bs: Remove camelcase in several files

<snip>

I've again, dropped all patches from you from my queue.  Please resend
everything in the proper format so that I can know what to review and
what order to apply them in.

thanks,

greg k-h
