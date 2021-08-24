Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB853F5CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhHXLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231980AbhHXLRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:17:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3CE06120A;
        Tue, 24 Aug 2021 11:16:30 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:16:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 4/6] fs/ntfs3: Make mount option nohidden more
 universal
Message-ID: <20210824111627.7iph6vlfdizoqjsr@wittgenstein>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-5-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-5-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:31AM +0300, Kari Argillander wrote:
> If we call Opt_nohidden with just keyword hidden, then we can use
> hidden/nohidden when mounting. We already use this method for almoust
> all other parameters so it is just logical that this will use same
> method.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---

Sounds good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
