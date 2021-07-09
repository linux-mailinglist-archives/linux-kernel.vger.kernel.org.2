Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662893C2360
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGIMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:25:11 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:45145 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhGIMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:25:11 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id EB69F1C5E40
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 13:22:26 +0100 (IST)
Received: (qmail 7021 invoked from network); 9 Jul 2021 12:22:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jul 2021 12:22:26 -0000
Date:   Fri, 9 Jul 2021 13:22:25 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: correct return value when failing at
 preparing
Message-ID: <20210709122225.GZ3840@techsingularity.net>
References: <20210709102855.55058-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210709102855.55058-1-yanfei.xu@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 06:28:54PM +0800, Yanfei Xu wrote:
> If the array passed in is already partially populated, we should
> return "nr_populated" even failing at preparing arguments stage.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

ff4b2b4014cb ("mm/page_alloc: correct return value of populated elements if bulk array is populated")

-- 
Mel Gorman
SUSE Labs
