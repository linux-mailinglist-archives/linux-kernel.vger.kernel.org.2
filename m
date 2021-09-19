Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB035410BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhISNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhISNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:22:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF4C61268;
        Sun, 19 Sep 2021 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632057689;
        bh=vIBHbYJ+iogWwScWGi9RnpUhYnJqTlR6bs1ucQO4Z/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjUb0Y9oh4ISjwoy++MY83HVvxQtQ3TPfHN/0Nc+U6KbJDCwqnANcvPLNMv5fapB9
         CfnGis0RtoUNXc52NG+BcLNC7LNiug5odo+e3nJZUF6gbFlJCHhvtnUhZ/+J3dkEsW
         4pacfBwfOZ8qiQuzaqLgv4Un5Jpk4jc39lHhDlxU=
Date:   Sun, 19 Sep 2021 15:21:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [RFC v2 PATCH 1/3] mm: add PG2KB/KB2PG helper macros
Message-ID: <YUc5VkZzUqEnnGPg@kroah.com>
References: <20210919131248.489798-1-oleksandr@natalenko.name>
 <20210919131248.489798-2-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919131248.489798-2-oleksandr@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 03:12:46PM +0200, Oleksandr Natalenko wrote:
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

I know I can not take patches without any changelog text.  Perhaps other
maintainers are more lax :(

thanks,

greg k-h
