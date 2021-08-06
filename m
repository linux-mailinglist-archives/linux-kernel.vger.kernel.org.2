Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D63E2025
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhHFAnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241044AbhHFAnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B21361179;
        Fri,  6 Aug 2021 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628210605;
        bh=vxaqsL1AApn/h201ehhxErufT1pf3QeNsfPtFGfEzaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZoQaemxLRKY9mKAT01XMOTKN8eJg9Yv9yUI+DIAxs/gTAdN7vCQvIEqXcHOgS5cBK
         K79Xd6S0w28uPdZOX9cOeDhT2i7GjfSasYwfqh+iODoDuGArovOazT8QGy3njRAnNK
         3sNCmXvrzinEACJzRyLqtMMBbuffOU4f9PXoQuqk=
Date:   Thu, 5 Aug 2021 17:43:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Message-Id: <20210805174324.2aaf0fb67cd19da893a86d80@linux-foundation.org>
In-Reply-To: <20210716081449.22187-1-sj38.park@gmail.com>
References: <20210716081449.22187-1-sj38.park@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 08:14:36 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> DAMON is a data access monitoring framework for the Linux kernel.

Merged, thanks.

Presumably there are companion userspace tools for DAMON.  Are they
available?  Is there a plan to release and maintain these?
