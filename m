Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D727E3A055B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFHUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFHUzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:55:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50FDD61185;
        Tue,  8 Jun 2021 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623185608;
        bh=LNh7Y6mVzEZqHsWDQ4sClUvLVuVgzf2mb6C9pDd6JCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IPlcdF4AtoRx+wHzooyA152aUyb07j+tLH3zvr99iBtOmD12hleyCTQMETMnX1j2f
         wxt61+zZoxqQgLKwL1thbqXR5O5Ji/1kw82dSi0wBg179Rb9GTK9Tyw6M6jCDo4f40
         86Jax7a0feg5gC4p1coavdk/ua5pJD4PFXTkTUyc=
Date:   Tue, 8 Jun 2021 13:53:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Lin, Zhenpeng" <zplin@psu.edu>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Actually fix freelist pointer vs redzoning
Message-Id: <20210608135327.be8a120ba3b1686bc62e6d7e@linux-foundation.org>
In-Reply-To: <20210608183955.280836-1-keescook@chromium.org>
References: <20210608183955.280836-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Jun 2021 11:39:52 -0700 Kees Cook <keescook@chromium.org> wrote:

> This fixes redzoning vs the freelist pointer (both for middle-position
> and very small caches). Both are "theoretical" fixes, in that I see no
> evidence of such small-sized caches actually be used in the kernel, but
> that's no reason to let the bugs continue to exist, especially since
> people doing local development keep tripping over it. :)

So I don't think this is suitable -stable material?

It's a bit odd that patches 2&3 were cc:stable but #1 was not.  Makes
one afraid that 2&3 might have had a dependency anyway.

So I'm thinking that the whole series can just be for 5.14-rc1, in the
sent order.

