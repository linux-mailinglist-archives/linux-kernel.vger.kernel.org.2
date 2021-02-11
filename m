Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54231952A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBKV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:29:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBKV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:29:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E15E9AD19;
        Thu, 11 Feb 2021 21:29:04 +0000 (UTC)
Date:   Thu, 11 Feb 2021 22:29:03 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: clarify eviction order and distance
 calculation
Message-ID: <20210211212903.GA3597@localhost.localdomain>
References: <20210201060651.3781-1-osalvador@suse.de>
 <20210211212645.GB2872@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211212645.GB2872@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 10:26:45PM +0100, Oscar Salvador wrote:
> Hi Andrew,
> 
> is this on your radar?

Please, disregard this, I was obviously blind as I did not spot it
in mmotm.

> 
> Thanks!
> 
> -- 
> Oscar Salvador
> SUSE L3
> 

-- 
Oscar Salvador
SUSE L3
