Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651CB3AB2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhFQLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFQLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:41:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:39:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h12so4816502pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yclVrwqPGhUvimc8CwIG9SL/Y2EGnIDn3pohj+uriwg=;
        b=h8j+OkWM68Hh/SzuW8UfucveRyD6fOOTQP7qgh++v3NuAVjYWPMgXKPMDVA5x6RnJq
         rcZSQAO0E3iD4vbZSnlkaoWDwLVa+dSmR4BkinA0uoYx5a3KSGK9O5V1od3iM/MDD/Jf
         /5+yUA2MC98qdXaA707UtUY/lYIUVr9PzC3ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yclVrwqPGhUvimc8CwIG9SL/Y2EGnIDn3pohj+uriwg=;
        b=qi0v/xdWH21kTKt/hw64NIXYby5qRVEH9BSI+6EWO+WmDjnh3qNN6g3CFLF6BI8Ro4
         HYeImyGLAbTnsO/ZdS5wDc2tqIjMXz/zr8DA2gWuPEfnGcqtSTz/1L/u1syYZe0ImsDn
         4z/HlrgLZ7xiy7jXxt4WD7MEEcxkjo54u2w8l5OSf3pEo5OT97GAPr4lkXxh4GcErVFl
         3/bTCS90sJdnhJDFjlILjZaNVb4gvLnrRwK0EO2c2vtZZNXGP/MD9WGob7FgXUlEUHm5
         guszTNnF0tiAgo/Sy1z3fZzxl+u/UuAlOvmNgGsQZ57yUpf14ACreACbU9Aw651zBK69
         ClXA==
X-Gm-Message-State: AOAM532Qxb3sVZSSohS85i83T1OX43tD8/XUdd1iO16hhY1oFbDzJWwX
        PafWD/wxOheOAMfAIGgAoUxLfQ==
X-Google-Smtp-Source: ABdhPJxXmnPa1gr131ie/DQVg7wlrciiO15HHca/g1gXIn0aNfTYAnIK2ROkbQO/DOn1t50FMl8lRA==
X-Received: by 2002:aa7:8b07:0:b029:2f7:d38e:ff1 with SMTP id f7-20020aa78b070000b02902f7d38e0ff1mr4848538pfd.72.1623929974147;
        Thu, 17 Jun 2021 04:39:34 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:32ae:4292:bec1:e4])
        by smtp.gmail.com with ESMTPSA id y66sm5163256pfb.91.2021.06.17.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:39:33 -0700 (PDT)
Date:   Thu, 17 Jun 2021 20:39:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v4 0/2] introduce printk cpu lock
Message-ID: <YMs0cCklgBTwhrbo@google.com>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617095051.4808-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/17 11:56), John Ogness wrote:
> John Ogness (2):
>   lib/dump_stack: move cpu lock to printk.c
>   printk: fix cpu lock ordering

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
