Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3424528AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhKPDqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhKPDpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:45:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB4E61546;
        Tue, 16 Nov 2021 03:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637034165;
        bh=kqrHW0Z2i3TP9CCuWx0YTCSfOlkcWLFN4jtBhh9WwNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MOhf8qVF90zmnSJdE+A7/0QJrLaBqNUYxdgFDqc563MsBG8nnN8QvNl41OX2mf+Zd
         xr97nyEuTLmHVMk6dQ4efDmLxJVaBG4+rGKdgv/wjXGKkCXHzBYyJkSgKKGzjjh2ce
         inLOr6vdP52mMKkJSwaCeExkg84K+dSdEpa+Giwg=
Date:   Mon, 15 Nov 2021 19:42:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] DAMON fixes
Message-Id: <20211115194243.8faa12c3a9fdf881eb498d7a@linux-foundation.org>
In-Reply-To: <20211110145758.16558-1-sj@kernel.org>
References: <20211110145758.16558-1-sj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 14:57:56 +0000 SeongJae Park <sj@kernel.org> wrote:

> This patchset fixes bugs in DAMON.  Those cannot cleanly applied on
> v5.15.y.  I will back-port these on v5.15.y and post later once these
> are merged in the mainline.

Thanks.  I added cc:stable to these even though they won't apply.  I
think that fits Greg's processes better.

