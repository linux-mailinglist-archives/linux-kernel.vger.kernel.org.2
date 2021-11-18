Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD64455920
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbhKRKie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:38:34 -0500
Received: from out2.migadu.com ([188.165.223.204]:45962 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245673AbhKRKhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:37:47 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637231685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glkGTFMv2ZEjE3Lfu42ubj1o/Cf2GJtuycTt7mbS5Sc=;
        b=K7LX/XIntZEpYsfSjjfoJ2Bc6FjxCjNR2Q/7q8gM1DjqEkOgQJIv9hlNw7iPUrc1A2brBT
        kYeV2FZxwfFnfTxa53uc0j32ZV/uD7M9FWbZcJ+kg/nomLnhXua4+nR4gqY3eaILkwMzte
        t+4vqgU+4T9Sls21xsBNfOEj7WyEKJg=
Date:   Thu, 18 Nov 2021 10:34:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <aecc489431c38f170097ae1eb37a7d22@linux.dev>
Subject: Re: [PATCH] refcount: introduce refcount_is_one() helper function
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <YZYSdJh7xpkHJjoa@hirez.programming.kicks-ass.net>
References: <YZYSdJh7xpkHJjoa@hirez.programming.kicks-ass.net>
 <20211118074200.GF174703@worktop.programming.kicks-ass.net>
 <20211118035328.5730-1-yajun.deng@linux.dev>
 <a4b7401c06d3baa5d3d0a43d7aa6c62c@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 18, 2021 4:44 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:=
=0A=0A> On Thu, Nov 18, 2021 at 08:12:56AM +0000, yajun.deng@linux.dev wr=
ote:=0A> =0A>> November 18, 2021 3:42 PM, "Peter Zijlstra" <peterz@infrad=
ead.org> wrote:=0A>> =0A>> On Thu, Nov 18, 2021 at 11:53:28AM +0800, Yaju=
n Deng wrote:=0A>> =0A>> There are many cases where it is necessary to de=
termine if refcount is one,=0A>> introduce refcount_is_one() helper funct=
ion for these cases.=0A>> =0A>> Give me one that is not racy?=0A>> =0A>> =
The following determine refcount is one, 35 count.=0A> =0A> Very good, no=
w get me one that isn't broken :-)=0A=0ASorry, I didn't understand what i=
s the 'isn't broken'=E3=80=82
