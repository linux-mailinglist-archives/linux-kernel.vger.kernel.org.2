Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121B441E489
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 01:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349300AbhI3XCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 19:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbhI3XCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 19:02:52 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA6C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 16:01:08 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 02D12C01C; Fri,  1 Oct 2021 01:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1633042867; bh=co/eYQssZq7rS2Huuw9XLYWOjbjK+U6Qfir0717BDLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYGkjuH8ZeuV7vFva+mw0mjlVZMl3feOY2QdbjW0+Z82jcxMHo6MCQOZCJx3M7t0o
         OQ6bSHnJFei3L66gdPwnx6JeV3lMx4zwyB3iJ/FV1Es++8VVppcVoqnS8lMJnp17w+
         mYqrKZuZSc+i54NoMV9TQY1tcjR5HM5scR/l1UWmRifrecYN8Ah6Gan47BnVFUHYUw
         XSLOxRnZWzAghEBi5ng1DmQfy2KwmZivhQngpziVH4qzdPKzbE7srqw7IurXtwkatI
         C7gFiLOLVv9WS+bSRcy4yX4Wu7JPbs5D75k/4EDbFYX26KWoeRaMtn652ATyf5UsjG
         WSKOdR0w2Jsow==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 919EEC009;
        Fri,  1 Oct 2021 01:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1633042865; bh=co/eYQssZq7rS2Huuw9XLYWOjbjK+U6Qfir0717BDLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jv6hq4hHavym9uuapAsbRAqnpUvFcxHyLoKionzlfa4d6jTVc5dE1ShN5SKpMs9/N
         q5wLHfPzPlcKPyT38dz7XjaUoPJ7W9eTQ5Yv+A+HcjTE31Vp5eTlaaIJOxRiaUfA/n
         W3tej0aVfscvGImFBNLJ7tjLIB9natcCUfJ1OQzHvbE37/mtOTxSSXEIuAYhGWjyQx
         mXprr5Vrc/agXXfjHxD/nzXnzs1BEgfQHx1mehNTEnP5+cxH90h/IhqR2eG2ZUx+Mp
         XxlQCw4OSb80YB4GKrfhNWu0mSiHGCTPsMvNoKRekoO80BILhiyPfpjecgGHpEuFvx
         rB3vG9kCtyaow==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 18c6b030;
        Thu, 30 Sep 2021 23:00:59 +0000 (UTC)
Date:   Fri, 1 Oct 2021 08:00:44 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: 9p: cache.h: cleanup some format warning
Message-ID: <YVZBm+uG2k22x8Yt@codewreck.org>
References: <20210930212455.30047-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930212455.30047-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sohaib Mohamed wrote on Thu, Sep 30, 2021 at 11:24:54PM +0200:
> Warnings found by checkpatch.pl

All this code is gone in linux-next (fscache work), so skipping this
patch.

The other patch is good, I'll take it tonight/this weekend - thanks for
the cleanups!

-- 
Dominique
