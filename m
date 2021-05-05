Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2463746EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEERc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239927AbhEER0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:26:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73F3D608FE;
        Wed,  5 May 2021 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620235548;
        bh=0ntYBEJnbuEScJ5IjmsmmOH/9BzYiIMdYg9Cbp6hrvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wkf8/dFy/D4NRhSyMEruGZUogg+eyKrmZgmGTM2uvRsdZ3zBtIf0kWOjFX31RXHaG
         EMQgBO3qow63K7JgOgsBM7Ivai2J6I57/BtSJwfwkhXfguDSWiKqNM5gERQ+R1MGEf
         6NPqjcr54ZS+2xwgG7/QPDOyXiI5I30uDNQ51xm0=
Date:   Wed, 5 May 2021 10:25:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Aili Yao <yaoaili@kingsoft.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
Message-Id: <20210505102547.8ee8ed1848370cc259dbe857@linux-foundation.org>
In-Reply-To: <bedd4817-5b2e-4041-3b55-f8ebfd98505f@redhat.com>
References: <20210505135407.31590-1-mhocko@kernel.org>
        <bedd4817-5b2e-4041-3b55-f8ebfd98505f@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2021 15:55:42 +0200 David Hildenbrand <david@redhat.com> wrote:

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

cc:stable?
