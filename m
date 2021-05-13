Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01837F305
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhEMG33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhEMG30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:29:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:28:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t4so13843177plc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AV3i0cyAQqmvIdnehCa8/+iZ0ckotya/+iLpSfcFxfw=;
        b=OvcxGH/M5KSbpBo10SI4pyH2JolAfNM2UQUBry1oXHf0RC3Z1A/laGmOOn4WbekZxI
         aZzsp2zx+/4VufxePm7LLdqWXSs3ovcWfuOQ5BIM+SKobZtP3IkpzD3TpL7TC2naWOuz
         ec9x8OWoxVdePjvP/9jhUDf8uZ+SVGtKWg08qBtMGKJweySYoEb0LDm6teaF/3MNtPRh
         Ek08dnouA2O4hnxhcRhykLIWk7STiXHK1U1mzBdgbf4i+HA2acY29QcDcGfbs0vPeP/f
         dkoAr1VGfbG9qUhwf5m8IdZD1acc7mcY6cIcjoIZf3KMrT0zUCrW8ZkIH7QGB0qlUrBc
         9m0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AV3i0cyAQqmvIdnehCa8/+iZ0ckotya/+iLpSfcFxfw=;
        b=kiGQiTgu+yAmU4mMAO8j88kAKjQ1+az+Xu423jnIRl2AjfcwS7FZsGafuLSrp0Pe5m
         r9JKFpnmBuuJcSf/XaUkDk3C2SeOHpfkZra1RJUj6o4DGLleiUk27+2n0IfihtCjaVvZ
         pket4vs5MbvmFtOsPUJ5+A4YZLjuUe/be+dHd4kwwAWl+Ye0qCL8Tgyh8bI2lZC8Sl+z
         ZgFoQt6O00mlQNeRywPMsux3WPW1tcNfTFEi+kUipPtBQVA++Uck0Db1aMlppDu3hMqo
         mIJ2zD2qyMX7RXevHnnvYYIA0JXpTEZKOyGmO4CSo4bmW/9UaSCYYvhLUjHZ7G2/yGEJ
         wHTA==
X-Gm-Message-State: AOAM530fUoCI6mh/AeUb60JLyDnt6JkslbjlDrkC1j1GibBz2ISxA9Bp
        ANjUm4JIlwq3PLXWzwPBhQg=
X-Google-Smtp-Source: ABdhPJz/1gwa0jMAM7gqj89ueqtaO6w7py+D4zn2NNdpc1Wc72w9aik4ABCiNVyzh1RScVMA2wclMA==
X-Received: by 2002:a17:902:aa46:b029:ef:8a47:ca53 with SMTP id c6-20020a170902aa46b02900ef8a47ca53mr5391879plr.74.1620887294619;
        Wed, 12 May 2021 23:28:14 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id x22sm1270767pfa.24.2021.05.12.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:28:14 -0700 (PDT)
Date:   Thu, 13 May 2021 15:28:09 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, rientjes@google.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        42.hyeyoo@gmail.com
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513062809.GA319973@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 08:40:24PM -0700, Andrew Morton wrote:
> On Thu, 13 May 2021 12:12:20 +0900 Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
> > > This explodes in mysterious ways.  The patch as I have it is appended,
> > > for reference.
> > > 
> > > gcc-10.3.0 allmodconfig.
> > > 
> > > This patch suppresses the error:
> 
> Ah, yes, of course, your patch changes kmalloc_index() to require that
> it always is called with a constant `size'.  kfence_test doesn't do
> that.
> 
> kfence is being a bit naughty here - the other kmalloc_index() callers
> only comple up the call after verifying that `size' is a compile-time
> constant.
> 
> Would something like this work?
>  include/linux/slab.h    |   12 ++++++++----
>  mm/kfence/kfence_test.c |    4 ++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/slab.h~b
> +++ a/include/linux/slab.h
> @@ -374,7 +374,8 @@ static __always_inline enum kmalloc_cach
>   * Note: there's no need to optimize kmalloc_index because it's evaluated
>   * in compile-time.
>   */
> -static __always_inline unsigned int kmalloc_index(size_t size)
> +static __always_inline unsigned int kmalloc_index(size_t size,
> +						  bool size_is_constant)
>  {
>  	if (!size)
>  		return 0;
> @@ -410,7 +411,10 @@ static __always_inline unsigned int kmal
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
>  
> -	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	if (size_is_constant)
> +		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	else
> +		BUG();


kfence is randomly generating size. because kfence is using non-constant
size, we should do run-time assertion or compile-time assertion depending
on situation.

I think we can use __builtin_constant_p here. we don't need to modify
kmalloc_index's prototype.

so what about this?
if you think it makes sense, I'll send patch v4.

I used KMALLOC_MAX_CACHE_SIZE to assure it's safe size.
it's safer than putting BUILD_BUG_ON_MSG(1, ...) to below if statements
because KMALLOC_MAX_CACHE_SIZE can be less than 32MB.

--- include/linux/slab.h.orig	2021-05-12 17:56:54.504738768 +0900
+++ include/linux/slab.h	2021-05-13 15:06:25.724565850 +0900
@@ -346,9 +346,18 @@ static __always_inline enum kmalloc_cach
  * 1 =  65 .. 96 bytes
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
+ *
+ * Note: there's no need to optimize kmalloc_index because it's evaluated
+ * in compile-time.
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
+	if (__builtin_constant_p(size)) {
+		BUILD_BUG_ON_MSG(size > KMALLOC_MAX_CACHE_SIZE , "unexpected size in kmalloc_index()");
+	} else if (size > KMALLOC_MAX_CACHE_SIZE) {
+		BUG();
+	}
+
 	if (!size)
 		return 0;

@@ -382,8 +391,6 @@ static __always_inline unsigned int kmal
 	if (size <=  8 * 1024 * 1024) return 23;
 	if (size <=  16 * 1024 * 1024) return 24;
 	if (size <=  32 * 1024 * 1024) return 25;
-	if (size <=  64 * 1024 * 1024) return 26;
-	BUG();

 	/* Will never be reached. Needed because the compiler may complain */
 	return -1;

