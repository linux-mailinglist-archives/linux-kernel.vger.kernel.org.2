Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC3F1656
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhHSJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbhHSJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:36:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:35:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m26so4943246pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fggSCoWOSYwWUO9aqxy9y0PWdARsH0ajovgyZLTLYHM=;
        b=fmcReeUZ8mVgs0OG0lUlbd3UhLTK2DmJsDouqQ8idI3LPiB+lONTIIIf8sIJlDt/05
         vuC3vazb3WskTFwi052LR5L4JMrLts5Zpyda2yGxbuQ0wF9mqm1VKJTBBtqoca5DBBVi
         v2rFx3AAWpTtE1XBHAdq4SvPytA17XJK58kzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fggSCoWOSYwWUO9aqxy9y0PWdARsH0ajovgyZLTLYHM=;
        b=CdF5RPMcTl99WZrPI1jqvb+aNpaPqAQ98Sra/BlBjpGs0kNHnV2nVWXudOCr2ubW5Z
         C3URACEI16gpH23NuRVrtJsgxT3sfj3fPu0fOYZNyDnFHQaO15DtAqerpxK3WTghBa2H
         K9eyL9+ouv1hgRBcydnk4vLR2um1ueth/Nb5CufJ9ei61iTkauae6kdLEG0S1PhyTSlm
         QeLcbUjBBWYbKrGFgBLN4wnWNPvvQGYDEJzrrFyDaCGs/csl9ykw/ZyZsU04RYjjEyT9
         esH0QkGqzJMBwV0HdnzZSR+7u+1ttEU0lpXD59yvVe/fFsjMKvv94e933j7LHyXJWFtI
         T5VQ==
X-Gm-Message-State: AOAM533z2rvKGuXdwqOBgqYJJSrt74DCSi1pget7LN9SN4s6IOdYNiCy
        9bwKR7a76LsjCVX0N9W+fLWBEg==
X-Google-Smtp-Source: ABdhPJy0FOLgmOp7YRmf+UXWCpGnpKm45gNkEgDQE4HhtUq/1GhNPCM3uxUauDsmxvWPecULB6N2fQ==
X-Received: by 2002:a65:690c:: with SMTP id s12mr13334479pgq.401.1629365740650;
        Thu, 19 Aug 2021 02:35:40 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:bc71:80fb:7292:eb8e])
        by smtp.gmail.com with ESMTPSA id t22sm3097075pgv.35.2021.08.19.02.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:35:40 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:35:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] lib/vsprintf: don't increment buf in bitmap_list_string
Message-ID: <YR4l52k6oWrg7G9O@google.com>
References: <20210817193735.269942-1-yury.norov@gmail.com>
 <YRzQHkF8inFrdfQM@smile.fi.intel.com>
 <20210818123651.61e2dfb55aea3b8340ab10c6@linux-foundation.org>
 <YR1o+/8E/FbW2xL8@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR1o+/8E/FbW2xL8@yury-ThinkPad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/18 13:10), Yury Norov wrote:
> On Wed, Aug 18, 2021 at 12:36:51PM -0700, Andrew Morton wrote:
> > On Wed, 18 Aug 2021 12:17:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > On Tue, Aug 17, 2021 at 12:37:35PM -0700, Yury Norov wrote:
> > > 
> > > Thanks!
> > > 
> > > > Increment is confusing as the buf is overritten at the same line.
> > > 
> > > > Fixes: b1c4af4d3d6b (vsprintf: rework bitmap_list_string) (next-20210817)
> > > 
> > > Fixes tag has its special format. I don't think we need it here, just to ask
> > > Andrew in comments that it needs to be folded.
> > 
> > I'm assuming that Sergey will be handling this one?
> 
> This is a fix to recent bitmap series. If you fold-in into
> b1c4af4d3d6b, would be also OK.

This type of patches simpler to handle when they sent as a reply
to the patch they fix.
