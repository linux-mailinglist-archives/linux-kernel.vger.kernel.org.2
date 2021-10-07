Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D342516E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhJGKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240366AbhJGKsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:48:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16F7060FDA;
        Thu,  7 Oct 2021 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633603577;
        bh=sHsXb6j2XGLEMRY8EPn4Bha7/rOnPjWyi5RmmprPe9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C6yZ+rTBUfxiSNefLhrkF8LfeQRKIefw5Kf0qEQVh5uinEWLRJvWXuuMqhKqgLUB1
         DwYRWhg043JBsr7SXjkLhgJB3Qwdw4L6iNG61SD4fU75409YURIl4C7ejjJCE7BVaO
         VM/EvOqsjoTA/uXf2PAbrV4SD6vgcOXzZGwEHWEg=
Date:   Thu, 7 Oct 2021 12:46:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     hirofumi@mail.parknet.co.jp, angus@akkea.ca,
        linux-kernel@vger.kernel.org, kay.sievers@vrfy.org,
        lennart@poettering.net, harald@redhat.com, david@fubar.dk,
        tytso@mit.edu, alan@lxorguk.ukuu.org.uk, akpm@linux-foundation.org
Subject: Re: [PATCH] fs: fat: Make the volume label writable when mounted
Message-ID: <YV7P91dCRU3H+WGG@kroah.com>
References: <20211007095639.5002-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007095639.5002-1-martink@posteo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 09:56:39AM +0000, Martin Kepplinger wrote:
> The motivation for this change (probably) has its origin in a whishlist
> for the kernel that popped up in 2011, see
> https://lore.kernel.org/lkml/1319135973.1020.9.camel@mop/

Nice, I love it when a 10 year old TODO list item can be checked off!

Nice work.

I don't know if the FAT maintainer wants to take this, but I like it,
consider it:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
