Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9C3D350C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhGWG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234104AbhGWG1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5C1460EAF;
        Fri, 23 Jul 2021 07:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627024102;
        bh=xzDdUW+fc+BhUJXX0JvCEh7MUrwKZ05E8S8Z2CGVKi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLlYGf+j0Z81NpaExnXkO1wkiGbPvGTHbZygmKNTlHNsCXYhkE/xv0jJpyrSXe1Wg
         hGOTndf5UbxMkG3rBshCXQLuh7nPfzwmWSfzMtoGXil7wEv0zk+8M01ErEahZZ9ylK
         dmEktIsJ6Ra/a8Qcg7TicFrU58W1Uxo6WY7ivXus=
Date:   Fri, 23 Jul 2021 09:08:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongjoo Seo <dseo3@uci.edu>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, guoju.fgj@alibaba-inc.com, jgowans@amazon.com,
        joe@perches.com, linux-damon@amazon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Message-ID: <YPpq4u+b/UzAE/3u@kroah.com>
References: <2E16FC36-18B4-4F92-86AE-51249CCDB1A4@uci.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E16FC36-18B4-4F92-86AE-51249CCDB1A4@uci.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 04:02:44PM +0900, Dongjoo Seo wrote:
> Hello, I am new user of this amazing tool.
> I want to use this tool for Nvidia tx2 board with kernel version 4.9.140.
> 
> Do you guys have any timeline or update schedule for different kernel version compatibility?

Use a newer kernel on that board, there's no need for anyone to port new
features to older kernel versions.

Why are you stuck with 4.9.140?  That's very old and known insecure and
obsolete.  Please contact the vendor who is providing it to you to give
you the latest version as you are paying them for that support.

good luck!

greg k-h
