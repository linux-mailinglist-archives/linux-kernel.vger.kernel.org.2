Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85332B756
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhCCK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:58:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239582AbhCCAf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:35:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E634F64FB0;
        Wed,  3 Mar 2021 00:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614731681;
        bh=BDh207ZAqrr3mS94Pdy26gF2+LAmCf2Xc5f+sP/CPsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j1eg14xJMPcr8O/WYQ/yKD3+Rm3DwE7O8/dSYN6YQs68j0we6d4KL/3jEX4QoupBq
         kq9odd0NYYrqCJJtZiuSiYKODHPMMpUuOOtFwqCJm0mFiD09QJBcrvtf6O159+C35Z
         Luj7zSyFN5V5FBprfgoOEdPL0hqz7+otOXhVHVH8=
Date:   Tue, 2 Mar 2021 16:34:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Squashfs: fix xattr id and id lookup sanity checks
Message-Id: <20210302163440.730a51442f9ce87d728c9ffd@linux-foundation.org>
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

What are the user visible consequences of this bug?

> Cc: stable@vger.kernel.org
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Fixes: f37aa4c7366e23f ("squashfs: add more sanity checks in id lookup")

yes?


