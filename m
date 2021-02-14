Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7188E31B0FC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 16:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBNPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 10:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBNPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 10:38:41 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 07:37:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBJT0-00DumA-3J; Sun, 14 Feb 2021 15:37:46 +0000
Date:   Sun, 14 Feb 2021 15:37:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] fs: configfs: Fix sentence with a better word in the
 file symlink.c
Message-ID: <YClDypipbJHTvhyJ@zeniv-ca.linux.org.uk>
References: <20210205123235.1365780-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205123235.1365780-1-unixbhaskar@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:02:35PM +0530, Bhaskar Chowdhury wrote:
> 
> s/fucking/wonderful/

NAK.  For one thing, your crusade (pardon the obscenity) is idiotic.
For another, in this particular case your attempt of improvement
changes the meaning to nearly opposite.  "Magic" here is no
compliment - read the comment and try to understand what it says.
