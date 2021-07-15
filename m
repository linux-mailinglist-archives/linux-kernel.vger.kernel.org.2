Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6A3CA53E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbhGOSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhGOSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:21:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA29C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TGVdwq/5bAU2MHG7qmOxbHi3C9igc19rOJuXMsOJcdg=; b=ZOXi3u00QNMyZFzIOik4S8eyrr
        hey+iuVVOQ3TY5AJojjy8eAASosdliZN0vD8Dxo2+KJjDf8BB8uf8+XJjW48NIko8Ghi3vuQPoWC1
        ZDP0GmBmmcTdLxM0hGJj2x+6g7JIdmKlYZGdH2v0pgAXXrJcwIiUsXjxaMZ9q6q6mBeIW4lddwqEo
        MCx190oCzVzlNPSEkHPWJxxW3Mgw1yLxzBp1ucX0HHSzuZbp0nC32NivSCWSO5kzXIGYWERFETtaG
        0yp/iir1czmatqe7xRKGR3HmQs33Ya9oJeyJSMYFSflCApj+/aZy+MSxg1Fjvr7nM9aW1P7sVy6jN
        XqM/vt/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m45vA-003cG7-3y; Thu, 15 Jul 2021 18:17:22 +0000
Date:   Thu, 15 Jul 2021 19:17:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     akpm@linux-foundation.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
Message-ID: <YPB7rBlU1SinK6FR@casper.infradead.org>
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:01:01AM +0600, Zhansaya Bagdauletkyzy wrote:
> +++ b/mm/ksm.c
> @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
>  #define KSM_RUN_MERGE	1
>  #define KSM_RUN_UNMERGE	2
>  #define KSM_RUN_OFFLINE	4
> -static unsigned long ksm_run = KSM_RUN_STOP;
> +static unsigned int ksm_run = KSM_RUN_STOP;

Should this be an enum instead?
