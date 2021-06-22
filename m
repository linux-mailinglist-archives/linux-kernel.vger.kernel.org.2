Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672303B0B37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFVRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFVRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:15:33 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53494C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:13:17 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A053FC01C; Tue, 22 Jun 2021 19:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624381993; bh=tdLraN26AJmikOf9cCVnkJCdq/46SM04tSpwRtDPI0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPD0vIhjEgIK/7VLyfIEKk+KgzZcyvhboSKraCCTRRI0u5zXjARYCd7mfzzMxXiCM
         ZbuZh+1dbGSLpxLQKkRRdBHoC3TEcjaPDD5bHT04KSY112Qu3NSAWOC7ai5M73PCVZ
         ZX/Nz9kcn1A92OV7Vj1PjLRhEzjwgetsxBJNZRKiBiSnROivuXq5xHmFf1CTdvQNDz
         0Om35vyKwALuIqFJnBDsdkjT3+OSoroUEFnXqlG8BxYZDN24vo4YJoKawBC8qzbY8c
         K70kFLKCQ0X5QTv9Le7g93jruuzp1sh72eic1o08ARNTmsY8x3CSRCED8S+KH0Fvoh
         NeBWH8oXbFgLw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id B4B08C009;
        Tue, 22 Jun 2021 19:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1624381993; bh=tdLraN26AJmikOf9cCVnkJCdq/46SM04tSpwRtDPI0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPD0vIhjEgIK/7VLyfIEKk+KgzZcyvhboSKraCCTRRI0u5zXjARYCd7mfzzMxXiCM
         ZbuZh+1dbGSLpxLQKkRRdBHoC3TEcjaPDD5bHT04KSY112Qu3NSAWOC7ai5M73PCVZ
         ZX/Nz9kcn1A92OV7Vj1PjLRhEzjwgetsxBJNZRKiBiSnROivuXq5xHmFf1CTdvQNDz
         0Om35vyKwALuIqFJnBDsdkjT3+OSoroUEFnXqlG8BxYZDN24vo4YJoKawBC8qzbY8c
         K70kFLKCQ0X5QTv9Le7g93jruuzp1sh72eic1o08ARNTmsY8x3CSRCED8S+KH0Fvoh
         NeBWH8oXbFgLw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5de002b9;
        Tue, 22 Jun 2021 17:13:09 +0000 (UTC)
Date:   Wed, 23 Jun 2021 02:12:54 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jim.cromie@gmail.com
Cc:     kasan-dev@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] KCSAN BUG report on p9_client_cb / p9_client_rpc
Message-ID: <YNIaFnfnZPGVd1t3@codewreck.org>
References: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6SucSdJFMdQFulNL"
Content-Disposition: inline
In-Reply-To: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6SucSdJFMdQFulNL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

jim.cromie@gmail.com wrote on Tue, Jun 22, 2021 at 10:42:58AM -0600:
> I got this on rc7 + my hacks ( not near p9 )
> ISTM someone here will know what it means.
> If theres anything else i can do to help,
> (configs, drop my patches and retry)
>  please let me know

Thanks for the report!

> [   14.904783] ==================================================================
> [   14.905848] BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc

hm, this code hasn't changed in ages (unless someone merged code behind
my back :D)

I had assumed the p9_req_put() in p9_client_cb would protect the tag,
but that doesn't appear to be true -- could you try this patch if this
is reproductible to you?

The tag is actually reclaimed in the woken up p9_client_rpc thread so
that would be a good match (reset in the other thread vs. read here),
caching the value is good enough but that is definitely not obvious...

-- 
Dominique

--6SucSdJFMdQFulNL
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-9p-net-cache-tag-in-p9_client_cb.patch"

From 1135d60baa5d743e8a123812428a342b101e290e Mon Sep 17 00:00:00 2001
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Wed, 23 Jun 2021 02:12:20 +0900
Subject: [PATCH] 9p net: cache tag in p9_client_cb

req->tc.tag is not safe to access after status has been set,
because tag is reclaimed by p9_client_rpc and not by the p9_req_put
below as one might think.

Reported-by: jim.cromie@gmail.com
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index b7b958f61faf..3e95a56ead80 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -419,7 +419,8 @@ static void p9_tag_cleanup(struct p9_client *c)
  */
 void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 {
-	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc.tag);
+	u16 tag = req->tc.tag;
+	p9_debug(P9_DEBUG_MUX, " tag %d\n", tag);
 
 	/*
 	 * This barrier is needed to make sure any change made to req before
@@ -429,7 +430,8 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 	req->status = status;
 
 	wake_up(&req->wq);
-	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
+	/* req->tc.tag is not safe to access after status has been set */
+	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", tag);
 	p9_req_put(req);
 }
 EXPORT_SYMBOL(p9_client_cb);
-- 
2.31.1


--6SucSdJFMdQFulNL--
