Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7193F5CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhHXLQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235618AbhHXLQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:16:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61DC2604AC;
        Tue, 24 Aug 2021 11:15:59 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:15:56 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 6/6] fs/ntfs3: Rename mount option no_acl_rules >
 (no)acl_rules
Message-ID: <20210824111556.r5llbahswx2nwece@wittgenstein>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
 <20210819002633.689831-7-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-7-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:33AM +0300, Kari Argillander wrote:
> Rename mount option no_acl_rules to noacl_rules. This allow us to use
> possibility to mount with options noacl_rules or acl_rules.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---

Looks good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
