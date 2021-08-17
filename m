Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F83EE0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhHQARA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhHQAQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:16:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A97B60F39;
        Tue, 17 Aug 2021 00:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629159385;
        bh=KG4aBz3LsYlQoj4ZmeJ8bEqC+SJgiUisze7eXuaacNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FH21FE+LDI3lyirYFQijw7ZRz0nDvutSJqqu4l7oDJW0uI5WqA0yzgFjJMbKUGf/R
         l2FmB9sYbVeuC8J0cBjwDOjmK3haT9rq+8hUDnNdKUizhmoMNufsWg3rkoTVwRIzk3
         3AnVZVR4inSti0ydlAddPzmoE/2tBuKWCC1+8HyMHjZP26suketwsTBdXJ87PhEDZY
         WaoWbGtUBUDcckPN+zD1qzg1zqoBeEAjSxAcKoGYx6f0WXDKclYTyZOyXShsah2d9g
         Zx/TjFr5FBhNsXHq2jOA4/9oIig53WsOYpd81YFqSL7j7hNpXhKf8hTEBY1Hzvd9WC
         MbBqKVIQs5SJQ==
Date:   Mon, 16 Aug 2021 17:16:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: add sysfs nodes to get discard information
Message-ID: <YRr/2DM84TishToA@google.com>
References: <af34f9cd-8972-583b-bae2-f11fe9058e63@kernel.org>
 <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AGwAWQBVD3NfsYDCdBIWb4qP.3.1629094420548.Hmail.frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, 李扬韬 wrote:
> >>>> I've added new sysfs nodes to show discard stat since mount, which
> >>>> will help us analyze whether the performance problem is related to
> >>>> discard.
> >>>>
> >>>> issued_discard  - Shows the number of issued discard
> >>>> queued_discard  - Shows the number of cached discard cmd count
> >>>> discard_cmd_cnt - Shows the number of cached discard cmd count
> >>>> undiscard_blks  - Shows the number of undiscard blocks
> >>>
> >>> We have exported them in debugfs, can you use that?
> >>>
> >>> Thanks,
> >> 
> >> But now Android is forbidden to open debugfs, and in fact we have not
> >> opened this configuration for a long time.
> >
> >Weren't them be used for debug purpose? can you please explain more about
> >your use case?
> 
> During long-term aging test or normal use, sometimes there will be performance
> degradation problems. It may be caused by storage, or it may be caused by the
> filesystem. For example, the filesystem accumulates a large number of undiscard
>  blocks. Although there is some remaining space, the androidbench test will
> show performance degradation. Therefore, it is necessary to export information
> related to discard so that we can confirm this situation.

I think you can mount debugfs for that case?

> 
> Thx,
> 
> 
