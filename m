Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6D432D71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhJSFxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJSFxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:53:43 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70DC061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:51:31 -0700 (PDT)
Date:   Tue, 19 Oct 2021 14:51:19 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634622688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRm1waGFsFZddIRpW9GKTq+mIkydebynPJigexG560c=;
        b=fMcSu7O+8yWcwyyqBotwvSc8gDodG3tIc4lkvn1dlC9skQ5NeXO7pFHD0Vhp3blf5r1pKq
        /vdPMX0azzfWDbJCH088GH7kzU6ISXiDe8WRjlG65DE92likQ/PcpYhetFBFBye4xVVFgA
        C7EVyRWZt665saCoG5d4Giy1zaCD6Q0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 3/6] mm: filemap: coding style cleanup for
 filemap_map_pmd()
Message-ID: <20211019055119.GB2268449@u2004>
References: <20211014191615.6674-1-shy828301@gmail.com>
 <20211014191615.6674-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014191615.6674-4-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:16:12PM -0700, Yang Shi wrote:
> A minor cleanup to the indent.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
