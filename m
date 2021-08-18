Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138EB3F0C73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhHRUKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 16:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhHRUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 16:10:40 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4125C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:10:05 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m3so2392577qvu.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FhzHj5sv419eg4vkp0/wpA8+yyYPo/W/3OvIv+FtkqA=;
        b=nZTYI2kwbm0+LhsHtMdTYGyyULsY4+K3zKCYP8Dwki6OsnTBBdrOMxPCyUPqc60uhs
         TVisD49OT/7Jr3FYEfi+l/2UmQk+dZiLDYzDpiOhTOS0cQtDQw5/wrz3HaMfnTwqlGHk
         f5H4LtwOMn6pE0c9D4colwPSv0YxVEpTTFAQ639sGWRLmyw9loC+fEAprHFuf7w9HWQX
         dWHCw/uNqWusjMjVzdDuNVcwb29PZQNm1RQtQm5GmsXgZb3KzAafn8vJi4HcaPXyevNy
         wUokiX8J0XBqhNh3OvJVXO3aYgM1rYnKDgYhxSxXhOkDP01pNg8u9Caf6lwLiNRLzq6E
         +LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FhzHj5sv419eg4vkp0/wpA8+yyYPo/W/3OvIv+FtkqA=;
        b=DxH/UFIqgyx9YdbipMLiGlyr5zp9kYKBZqrOz2m/hfwbNpxqaYMOaWwY9b7n+P3Q1+
         DsAT8uetHOW/mlwHgYrZwEm7aJQJFJvSxYvj+dfulTZNhC1tGAKVTV1qzBZl4P9Ui8J9
         63RLpgW8QfdR7EEAx7L12IBti8V45YFMn62m53Y/iblUSJv2v2nCs67DUoOd3ifclLsn
         DUjuL+jxh1bE9EnixcYeBesymFyfsIoz0sVjDSSdfo26zq9O+s8gmJXvxjp0DEbQVxeM
         8RHENXMXWsAQUvWjCQPna5Io+FRs1GELneR9SRGWfkuLlNovlYLlhV537C1aRuif60EA
         Pevw==
X-Gm-Message-State: AOAM533Qcn/WJTd2IbAoujt67dwet4rn16ecpP2/+5CvJML6PKESY2Qy
        ZsuKw78WdSiu8M0bogBccrM=
X-Google-Smtp-Source: ABdhPJxLHKRMnrSvrIwktl/4Z+dwoF0fMJcu/SAGo/Bp/MLzTLubCsjvrKMckQzw0JUvAPJ/XjDD/w==
X-Received: by 2002:a0c:c247:: with SMTP id w7mr10927847qvh.31.1629317404861;
        Wed, 18 Aug 2021 13:10:04 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id 187sm446951qke.32.2021.08.18.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 13:10:04 -0700 (PDT)
Date:   Wed, 18 Aug 2021 13:10:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] lib/vsprintf: don't increment buf in bitmap_list_string
Message-ID: <YR1o+/8E/FbW2xL8@yury-ThinkPad>
References: <20210817193735.269942-1-yury.norov@gmail.com>
 <YRzQHkF8inFrdfQM@smile.fi.intel.com>
 <20210818123651.61e2dfb55aea3b8340ab10c6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818123651.61e2dfb55aea3b8340ab10c6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:36:51PM -0700, Andrew Morton wrote:
> On Wed, 18 Aug 2021 12:17:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Aug 17, 2021 at 12:37:35PM -0700, Yury Norov wrote:
> > 
> > Thanks!
> > 
> > > Increment is confusing as the buf is overritten at the same line.
> > 
> > > Fixes: b1c4af4d3d6b (vsprintf: rework bitmap_list_string) (next-20210817)
> > 
> > Fixes tag has its special format. I don't think we need it here, just to ask
> > Andrew in comments that it needs to be folded.
> 
> I'm assuming that Sergey will be handling this one?

This is a fix to recent bitmap series. If you fold-in into
b1c4af4d3d6b, would be also OK.
