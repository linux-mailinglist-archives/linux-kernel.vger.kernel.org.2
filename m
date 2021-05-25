Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFC0390CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEYXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEYXS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F9A861042;
        Tue, 25 May 2021 23:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621984616;
        bh=1L+wt9+EMclSFh/NImV8VXARHos+R8K+93TCAp42yGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XAsPL0sTczCZgtSYc1suxOXPRTi+wtwTzolMB7oyFsPRG3TE2eUow3D+VjQSWwdqO
         jrD2xkHhN9GJhAUaoRlNsZAi9H7oRwWTM0lIvBAEQKR+TYhJNQzWCryVRYgD1UN18x
         ClFCYF+jOvH++Nq09N50WoXd2zK41Riuz3kK4ukc=
Date:   Tue, 25 May 2021 16:16:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yejune Deng <yejune.deng@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH 2/2] mm: slub: use DEFINE_RAW_SPINLOCK init
 object_map_lock
Message-Id: <20210525161655.bd9f91e9c29758142eb955e2@linux-foundation.org>
In-Reply-To: <427f87d6-b506-a225-1887-cf8c13d99634@suse.cz>
References: <1621938235-11947-1-git-send-email-yejunedeng@gmail.com>
        <1621938235-11947-2-git-send-email-yejunedeng@gmail.com>
        <427f87d6-b506-a225-1887-cf8c13d99634@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 12:46:35 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 5/25/21 12:23 PM, Yejune Deng wrote:
> > Use DEFINE_RAW_SPINLOCK instead of DEFINE_SPINLOCK object_map_lock
> > that won't be preempted on mainline and PREEMPT_RT kernels.
> > 
> > Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> 
> RT tree also has such patch, with IMHO more thorough description:

Yes please, a more thorough decription is needed.  The description
provided with this patch could be applied to every spinlock in the
kernel!

