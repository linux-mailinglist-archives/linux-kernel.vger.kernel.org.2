Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056F3FB5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhH3M1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:27:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47958 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhH3M1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:27:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C365422125;
        Mon, 30 Aug 2021 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630326413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GTpwtrUyWO9XgpVlTZOkCC2qFNxtbNrsk7UywRyxcY=;
        b=IiKxQxGSqSvsx87sUzydkrKMT2quQGaTHNUap9hixIkB5lGtPdLeXs48T+4OuBXquZZ9s2
        9rAEOYC7vSLZdrP1WZHilueHAjBW7HXlMVie+Sqda4ExKnC4o2BJJW+iqbNOYfeOtxEiF5
        9OomZg6un9qYoolKkA0zvT3mz++3ifc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630326413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GTpwtrUyWO9XgpVlTZOkCC2qFNxtbNrsk7UywRyxcY=;
        b=uCuEtT3WqENb+c1xZUhlPwRagSoYeaonm0vEiUmwBT2OBcBciYdC2MlagTO/ZgUjgwvHkV
        Z+9TquRtI2VBLtCw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3083CA3B8C;
        Mon, 30 Aug 2021 12:26:53 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:26:51 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kamezawa.hiroyu@jp.fujitsu.com,
        lee.schermerhorn@hp.com, Krupa.Ramakrishnan@amd.com,
        Sadagopan.Srinivasan@amd.com
Subject: Re: [FIX PATCH 1/2] mm/page_alloc: Print node fallback order
Message-ID: <20210830122651.GB4060@suse.de>
References: <20210830121603.1081-1-bharata@amd.com>
 <20210830121603.1081-2-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830121603.1081-2-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 05:46:02PM +0530, Bharata B Rao wrote:
> Print information message about the allocation fallback order
> for each NUMA node during boot.
> 
> No functional changes here. This makes it easier to illustrate
> the problem in the node fallback list generation, which the
> next patch fixes.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

While the message is just informational, I think it's possible that the
bug could have been found earlier if this message was present so...

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
