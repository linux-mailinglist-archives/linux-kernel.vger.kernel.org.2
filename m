Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA73101E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhBEAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhBEAyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:54:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EDD64FAF;
        Fri,  5 Feb 2021 00:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612486407;
        bh=+ftuBalar3uDJeGB/zxsPIFh8hbJlcdkDpRI8aW03SE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v8l3XxtTjKriXnNOdxq3ZZALFcdIrSY6F9sLfWy/m8c80zfKFw1HQ+OCYBHlD67YW
         HK/aEoBQHvyo1Nz4HE6+9QHCyjuS9osKXuizXiLLhPDCwxxNaa8JELVolNv2AbsIwd
         7nvgYm+9+PW1riq2rHyBdMRJbQ9wjk5yUMaZOdwQ=
Date:   Thu, 4 Feb 2021 16:53:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+6fba78f99b9afd4b5634@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/4] Squashfs: avoid out of bounds writes in
 decompressors
Message-Id: <20210204165326.7700111635890f9476b479ae@linux-foundation.org>
In-Reply-To: <20210204130249.4495-2-phillip@squashfs.org.uk>
References: <20210204130249.4495-1-phillip@squashfs.org.uk>
        <20210204130249.4495-2-phillip@squashfs.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Feb 2021 13:02:46 +0000 Phillip Lougher <phillip@squashfs.org.uk> wrote:

> This is a regression introduced by the patch "migrate from ll_rw_block
> usage to BIO".

Fixes: 93e72b3c612adc ("squashfs: migrate from ll_rw_block usage to BIO")

> Sysbot/Syskaller has reported a number of "out of bounds writes" and
> "unable to handle kernel paging request in squashfs_decompress" errors
> which have been identified as a regression introduced by the above patch.
> 
> Specifically, the patch removed the following sanity check
> 
> if (length < 0 || length > output->length ||
> 		(index + length) > msblk->bytes_used)
> 
> This check did two things:
> 
> 1. It ensured any reads were not beyond the end of the filesystem
> 
> 2. It ensured that the "length" field read from the filesystem
>    was within the expected maximum length.  Without this any
>    corrupted values can over-run allocated buffers.
> 

All sounds fairly serious.  Should I add a cc:stable to this?
