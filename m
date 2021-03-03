Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD632BA7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357669AbhCCLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:23:43 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:48032 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237904AbhCCCKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:10:11 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1lHFqc-0003v1-QL; Wed, 03 Mar 2021 00:58:42 +0000
Date:   Wed, 3 Mar 2021 00:58:38 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <2145953354.2456187.1614733122707@webmail.123-reg.co.uk>
In-Reply-To: <20210302163440.730a51442f9ce87d728c9ffd@linux-foundation.org>
References: <2069685113.2081245.1614583677427@webmail.123-reg.co.uk>
 <20210302163440.730a51442f9ce87d728c9ffd@linux-foundation.org>
Subject: Re: [PATCH] Squashfs: fix xattr id and id lookup sanity checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev22
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 03/03/2021 00:34 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>  
> On Mon, 1 Mar 2021 07:27:57 +0000 (GMT) Phillip Lougher <phillip@squashfs.org.uk> wrote:
> 
> > The checks for maximum metadata block size is
> > missing SQUASHFS_BLOCK_OFFSET (the two byte length
> > count).
> 
> What are the user visible consequences of this bug?

The user will be unable to mount the filesystem, because it will
fail the sanity check.


> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
> 
> Fixes: f37aa4c7366e23f ("squashfs: add more sanity checks in id lookup")
> 
> yes?

Yes.

Phillip
