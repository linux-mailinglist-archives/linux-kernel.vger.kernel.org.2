Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C276C4169F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhIXCVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhIXCVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:21:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C38B61039;
        Fri, 24 Sep 2021 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632449982;
        bh=uRvz0xZK8S9AbE7fs1BoHqNalCLn2tKgUWAEoMpjGnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zq8uYaKimnFsF1TU3JWW3twnMkGg4r3zJ/aFIjZ4zJWO4yDS4laTM8qle3tmC37e9
         MEIxkyAq5uKfeU0LsuUXFh+B67oAgh79Vc6yMJYJpZ8Pk5gRq1O1vwwiZ63PrVC7Tk
         G/gIWDiGdFz1Zz/FeCYIehoqFNqHYynJpjcEzpY4=
Date:   Thu, 23 Sep 2021 19:19:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-Id: <20210923191941.da28da4400c11a3241a07acf@linux-foundation.org>
In-Reply-To: <20210923232512.210092-1-peterx@redhat.com>
References: <20210923232512.210092-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 19:25:12 -0400 Peter Xu <peterx@redhat.com> wrote:

> In RHEL's gating selftests we've encountered memory corruption in the uffd
> event test even with upstream kernel:
> 
> ...
>
> 
> We can mark the Fixes tag upon 0db282ba2c12 as it's reported to only happen
> there, however the real "Fixes" IMHO should be 8ba6e8640844, as before that
> commit we'll always do explicit release_pages() before registration of uffd,
> and 8ba6e8640844 changed that logic by adding extra unmap/map and we didn't
> release the pages at the right place.  Meanwhile I don't have a solid glue
> anyway on whether posix_memalign() could always avoid triggering this bug,
> hence it's safer to attach this fix to commit 8ba6e8640844.
> 

Thanks.  I added a cc:stable to this.  I don't think we want selftests
in older kernels to be falsely reporting kernel bugs?
