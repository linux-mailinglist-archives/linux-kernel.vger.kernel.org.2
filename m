Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB6400322
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349536AbhICQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349474AbhICQVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:21:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E8660E77;
        Fri,  3 Sep 2021 16:20:14 +0000 (UTC)
Date:   Fri, 3 Sep 2021 12:20:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/vsprintf: add __putchar()
Message-ID: <20210903122013.41552544@gandalf.local.home>
In-Reply-To: <YTJGyk65rv/026+p@yury-ThinkPad>
References: <20210827171155.700434-1-yury.norov@gmail.com>
        <YSuNTVh17CxUNxtC@smile.fi.intel.com>
        <20210903105607.35af6674@gandalf.local.home>
        <YTJGyk65rv/026+p@yury-ThinkPad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2021 09:01:14 -0700
Yury Norov <yury.norov@gmail.com> wrote:

> 
> Steve, if you like it, are you OK if I resend this patch? I just found
> another spot in lib/vsprintf.c to rework.
> 

You may want to wait to hear from the printk maintainers too.

-- Steve
