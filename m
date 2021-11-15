Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF74501BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhKOJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhKOJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:54:33 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD842C061746;
        Mon, 15 Nov 2021 01:51:37 -0800 (PST)
Received: from localhost (unknown [151.82.209.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC20C845;
        Mon, 15 Nov 2021 09:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC20C845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636969897; bh=Sh459AP8VB6RqU7cxvM/rkvxi9zbrKxgx4z0+VYxHjw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s+iUKMWhaE8/sBMxZ6tkwX3K2N/CZzrplqOHVT6wz+MOrSVOr8On+wmQLfXefSebL
         M4HpLYB8Z89Fuf3dTGR6DwzyToPjHlLaFSHO3EzM/jsGNBeLbdfIOU75dlCkf8UULp
         OIZMZGCVDfDjjIol1ilV+ixlIpIQNlrFTbP3XJgakzyi8Pr7krKWUl9UQPzkDM5uuM
         oOjszcBbjPwgZaEdqSuJDD5z+4t9mwqX/NsZleNcQJuU5odW9iDEmcCFsQ9TSPJ0gb
         RQy0zaqFCa2A0NjVhuu8wysvJXV3JcFjILRzIXAfYQSGUFtTOwhH1NC3i+sj578MAx
         vFfzGITuuqvFA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     mingo@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ftrace: fix the wrong path of tracefs
In-Reply-To: <20211113091145.05ba14b5@rorschach.local.home>
References: <20211113133722.GA11656@pc>
 <20211113091145.05ba14b5@rorschach.local.home>
Date:   Mon, 15 Nov 2021 02:51:33 -0700
Message-ID: <87wnl9lpay.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sat, 13 Nov 2021 21:37:34 +0800
> Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
>
>> Delete "tracing" due to it has been included in /proc/mounts.
>> Delete "echo nop > $tracefs/tracing/current_tracer", maybe
>> this command is redundant.
>> 
>> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> Jon,
>
> Can you take this through your tree?

Applied, thanks.

jon
