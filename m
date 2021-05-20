Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB687389CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 06:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhETEjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 00:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhETEix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 00:38:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 202DC61186;
        Thu, 20 May 2021 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621485452;
        bh=gO43ZOhPkcJNo9yGF3mXlrZLMZHeVCBHKdULgiPCjCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nEnVB/yKcyeYABp6tY88hU1WKZJJCYZxZaJBkBFthrdHt0XBut4d0W8JFHMo26Ks6
         m+dEdG1kAmHiLQ3NH1vju+XfxHsdVkLsojVlH8eAZl7PxfMzNUFdqLK5kx3NXkF0+4
         z0EB6nlBwjl/9ZSfvPsCBhDWAI03c3G7SU/u5ZSA=
Date:   Wed, 19 May 2021 21:37:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c: silence some -Wunused-parameter warnings
Message-Id: <20210519213731.fd8699098bf79bfd23c73090@linux-foundation.org>
In-Reply-To: <20210519162341.1275452-1-ahalaney@redhat.com>
References: <20210519162341.1275452-1-ahalaney@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 11:23:41 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:

> There's a bunch of callbacks with unused arguments, go ahead and silence
> those so "make KCFLAGS=-W init/main.o" is a little quieter.
> Here's a little sample:

Do we care about -Wunused-parameter?  I suppose we do, as it might
point us at small code optimizations.

How voluminous is the warning output from -Wunused-parameter?  Small
enough to be useful or large enough to be useless?

