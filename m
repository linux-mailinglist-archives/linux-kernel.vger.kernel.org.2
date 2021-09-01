Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E973F3FD84A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhIAK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234901AbhIAK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39AAD61058;
        Wed,  1 Sep 2021 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630493924;
        bh=jaJYQCkVx50jcmDjK8CMOwrT2+J+DckFvsNJFBKDHw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oM/tQ/pvTbkXsmIRbsCTUmeJn8c7rJUHH6wMyNzVDdAwDe4s3MWytzi0wj8t18fh4
         qb7Zsoimg1lxV4qGi9gKu6ORFiToVNrDrOUOMbj5tcuRNSVtJHgymuO/1XoKaixbPn
         Rn5mE+c6cjIo5GJmRiISQopnk0CvnbCLisGW2d/A=
Date:   Wed, 1 Sep 2021 12:58:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, toybox@lists.landley.net,
        stable-commits@vger.kernel.org
Subject: Re: Patch "fscrypt: add fscrypt_symlink_getattr() for computing
 st_size" has been added to the 5.4-stable tree
Message-ID: <YS9c4qZP9MeiEp2U@kroah.com>
References: <1630493566193250@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630493566193250@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:52:46PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     fscrypt: add fscrypt_symlink_getattr() for computing st_size
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Dropped from 5.4 as there is no need for it now that the other patches
failed :(
