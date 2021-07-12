Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19893C6279
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhGLSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhGLSO7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E15B261186;
        Mon, 12 Jul 2021 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626113531;
        bh=aTmF3S25hxiq1K69vG7fs95s8DooQv8UPJ9Y78xxkK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5ki42d9gQphZz1T6t5yxpE+NrqUR5JdaQUcWNUCLAaE7bzLjh29mMj661ccsJdas
         K/0c6WCraOp+LhAIB/Wx440F/2lxCItTQXrzZk+fIhPkMltyOhDrok+sAEvoJjZtCa
         5FeTozAumxkNXw9xWtFlfybDWdi7pM8kxlLsrAZ5HSy6bgjjzNBBNAAJF2JZ1jBGxA
         JNN0zRo+Prfg1eInKQwfQVt6kn7meZ1anvp0q9Vfg0542XzFjh6q7jGzfU2opjmj30
         fyM9qPHcIJPVIaZAYBLsh7vPd0U1FlIQCiBxMI+nxWJjbPuft+XNaDYfMkiAIaRDci
         Y/DnQE8zOhFRQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7DACF403F2; Mon, 12 Jul 2021 15:12:08 -0300 (-03)
Date:   Mon, 12 Jul 2021 15:12:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Merge uncore events by default for hybrid
 platform
Message-ID: <YOyF+J8xYfI8Vs7k@kernel.org>
References: <20210707055652.962-1-yao.jin@linux.intel.com>
 <YOsWBdoGFkDZKh94@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOsWBdoGFkDZKh94@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 11, 2021 at 06:02:13PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 07, 2021 at 01:56:52PM +0800, Jin Yao wrote:
<SNIP>
> > While for uncore events, that's not a suitable method. Uncore has nothing
> > to do with hybrid. So for uncore events, we aggregate event counts from all
> > PMUs and report the counts without PMUs.
<SNIP>
 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied to perf/urgent.

- Arnaldo

