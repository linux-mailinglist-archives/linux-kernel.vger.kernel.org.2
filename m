Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2738331EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCIFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhCIFhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:37:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D6716518A;
        Tue,  9 Mar 2021 05:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615268238;
        bh=hmD3UkvOhmgPEIlYWZbQKRstKfX1ya1CgO7lMiascIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZkoUB40gNnfL6kAGhMzXQRkkzQB6m3VlAdwXsRpOoHrHV0Wv3Ik0RyUJn3ka1uO6
         hguzcqaFTNFg3yOFcd8ZTLc9hUBsULQgA+Ok6f5lyQsy2yzEh75nmDaFnXN74Sp05v
         6hgporgleSYRcjT1wHzpIndsktCaAgq9LDQvmlWY=
Date:   Mon, 8 Mar 2021 21:37:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Squashfs: fix xattr id and id lookup sanity checks
Message-Id: <20210308213717.e319cbf5675a5e427efbdded@linux-foundation.org>
In-Reply-To: <2069685113.2081245.1614583677427@webmail.123-reg.co.uk>
References: <2069685113.2081245.1614583677427@webmail.123-reg.co.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 07:27:57 +0000 (GMT) Phillip Lougher <phillip@squashfs.org.uk> wrote:

> The checks for maximum metadata block size is
> missing SQUASHFS_BLOCK_OFFSET (the two byte length
> count).

There is no definition of SQUASHFS_BLOCK_OFFSET.  Makes compiler unhappy.
