Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D683655F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhDTKRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhDTKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:17:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:17:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e52003145dfcc247b909a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:5200:3145:dfcc:247b:909a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE7571EC0347;
        Tue, 20 Apr 2021 12:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618913819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHKWCU6z/Def+S0XFUqT3Jd+HhaFJheSWWNeZEIUM0I=;
        b=eGLMA1y4e9m6z6KXY6CN1sEVnvAOCxsMIzgZjG1nnbCQ62afOenS42QnvgPnXkrLoHQa6l
        mLqj70tomCM8s8K3igeg8uWtQP4d/SbjVOQS3CDY5K4aVM+UrKxHG0ehl6NAAVdRKzBwjD
        8B3QPAfNkUMO5O6h3aIHy98f0FWyOZU=
Date:   Tue, 20 Apr 2021 12:16:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210420101657.GF5029@zn.tnic>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
 <20210412224320.1747638-2-nao.horiguchi@gmail.com>
 <20210419170538.GG9093@zn.tnic>
 <20210420074625.GA24451@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420074625.GA24451@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 07:46:26AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> If you have any other suggestion, please let me know.

Looks almost ok...

> From: Tony Luck <tony.luck@intel.com>
> Date: Tue, 20 Apr 2021 16:42:01 +0900
> Subject: [PATCH 1/3] mm/memory-failure: Use a mutex to avoid memory_failure()
>  races
> 
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Along with introducing an additional goto label, this patch also

... avoid having "This patch" or "This commit" in the commit message.
It is tautologically useless. Also, you don't have to explain what the
patch does - that's visible hopefully. :-)

Other than that, it makes sense and the "sandwitching" looks correct:

	mutex_lock
	lock_page

	...

	unlock_page
	mutex_unlock

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
