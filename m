Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345C350B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhDAAZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 20:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhDAAYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 20:24:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08D961001;
        Thu,  1 Apr 2021 00:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617236676;
        bh=gLUa9Cv36lS6Ye58IN3xZXaCNCRPQPiULeyeri4i3N8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0e/o12XugAFbYd+f0XIAkAcKxPNnub8+C2c1HMNSvRWYKnCMimNnl1D8tYNWymnYU
         ZN/lzNfAhk3ofH784OKlAPyEHsvGYNHpQWWmC65DW31nfFPqA2caBLrAEc8ph+3663
         Affqxwp85K5WZvjMpXOr9Q7W0nwN7ja4N2qzkSL4=
Date:   Wed, 31 Mar 2021 17:24:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] userfaultfd: Write protect when virtual memory range
 has no page table entry
Message-Id: <20210331172435.7d06f805c803553517f03271@linux-foundation.org>
In-Reply-To: <YGSL91uL1K2RwOWY@dhcp22.suse.cz>
References: <20210319152428.52683-1-minhquangbui99@gmail.com>
        <YFhuDf6L7nkUoT7q@dhcp22.suse.cz>
        <YFiU9YWbYpLnlnde@kernel.org>
        <YFigbjaTT+YEEAO6@dhcp22.suse.cz>
        <YGSL91uL1K2RwOWY@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 16:49:27 +0200 Michal Hocko <mhocko@suse.com> wrote:

> > Thanks for the clarification! I have suspected this to be the case but
> > I am not really familiar with the interface to have any strong statement
> > here. Maybe we want to document this explicitly.
> 
> Btw. Andrew the patch still seems to be in mmotm. Do you plan to keep it
> there?

Dropped, thanks.
