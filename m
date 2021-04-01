Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757E7350E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhDAF60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDAF6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:58:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4EC561001;
        Thu,  1 Apr 2021 05:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617256690;
        bh=iBrB88K5OvkJTJ0XirgbUl7GKOoW9cpRiFq0uQoRzVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbScCll3vX7xaD53HQtfIc2WoPxqbVWI0C+gxvXSYJFx/9wnchWopinpb7PVARzSf
         YbSkMLqmikj/JavTfxhGuGzv5EG/0KJ1oiWd0g4exgmmUWp+aR6lVQ+Ojrpf0Wdp06
         7ZnPHmfzQ5568fbPdiUzU50OniQfW7BCdJI73Ngg=
Date:   Thu, 1 Apr 2021 07:58:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        phil@philpotter.co.uk, amarjargal16@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 0/3] Fix block comment warnings
Message-ID: <YGVg7TbrjGDyadUx@kroah.com>
References: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617221075.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 01:05:34PM -0700, Deborah Brouwer wrote:
> This patchset fixes checkpatch warnings arising
> from the block comments

Note, your 0/X email subject should also have the subsystem/driver
prefix in there so that we know what this series is for.  Much like your
individual patches do.

thanks,

greg k-h
