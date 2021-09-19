Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E750410DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhISWl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhISWl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E8EA60C51;
        Sun, 19 Sep 2021 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632091202;
        bh=GuEk0gNS4MnI/zqtpKABR7rKjnbnL6OqyGpa++pLW4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gya7g2DehzyQg8knIIoM8bOAse/WVChb3od20NpjLg5Coy9nArtY5oC0/CpE/Ou7D
         ZAWJYU6/MdUVjM5vhHnEgOX4hJhY7oCxRhw2/mq3dplsZXTWNMgTkEb5a7wZngCNZH
         xdJ+W9VXP2NMBrBYpP2hBsuEqe+tboFW+UFgKGpQ=
Date:   Sun, 19 Sep 2021 15:40:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-Id: <20210919154000.2dbd44c146c18e65d5dbce37@linux-foundation.org>
In-Reply-To: <20210918233920.9174-1-sultan@kerneltoast.com>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 16:39:20 -0700 Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> The OOM reaper thread uses wait_event_freezable() without actually being
> marked as freezable. Fix it by adding a set_freezable() call.

Oh.

What are the runtime effects of this defect?
