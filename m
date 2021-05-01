Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6637090F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhEAVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 17:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEAVUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 17:20:32 -0400
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2789C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619903980; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=fxspQE6J46fpci/mpefNS4T/eb7joLnEP0aTqZqFgW0=;
 b=AZsJ8AeZwmXRGrpbeuTLUSxDEcpI14NOygbMazaZe1Al1ADs/zW/05TflRkukTGK3cPgc
 y1yxPOqEMoLgow1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619903980; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=fxspQE6J46fpci/mpefNS4T/eb7joLnEP0aTqZqFgW0=;
 b=MiAu4anbDTn8MQyuu7fzvGVdVevm8qWIPGbZ8EimyoSyf9Q7zTt/j/CfwWjgpszsVABkn
 st/RqdVCbPV+vZjsjxwqbNtCdi5YtQJJLaz7NlS55fZG04ZuI11VI0U5oiQ2RDbBOs3u1SF
 H8rTNHbIKI/AH58t2VHE3JFGR1IIjXaCURsN0/1E+5Yyccqg2ljTTL1mM9hY98P/ETWxg0B
 Uug2gTKbyBYaNzhv4jaXv+ThWRHsogEDft6fsqHLMmXC7lSlqP04cvG+Cxh8KOhZNX3vvhb
 0FOV4Zv3xWOuTIU5FBzZUgbryKHIrVGFBXBuGnCH2Msb8Foq0SA+lLQbT8DA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 9710F160048; Sat,  1 May 2021 14:19:40 -0700 (PDT)
Date:   Sat, 1 May 2021 14:19:40 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <20210501211940.GA11658@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
 <YI2yZ+10MGrlFDBg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI2yZ+10MGrlFDBg@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Sat, May 01, 2021 at 03:56:23PM -0400, Theodore Ts'o wrote:
> I tried running xfstests against the spf branch, and I've noticed it's
> causing regression for generic/619.  It's failing due to a umount
> failure due to a busy mount point:
> 
> QA output created by 619
> umount: /vdc: target is busy.
> 
> I haven't had a chance to investigate, but I thought I should let you know.

Thanks for the report. I think the issue is likely caused by commit
06adfeb8150d "mm: rcu safe vma->vm_file freeing", which will defer
fput on mapped files for one rcu grace period. I expect adding
synchronize_rcu to the proper place (I'm not sure exactly where though)
when unmounting file systems would be a workable fix.

Note though - at this point I am only submitting the anon part of the
patchset for inclusion. That is, the v5.12-spf-anon branch, rather
than the v5.12-spf branch which has the additional / less mature
changes for file mapped vma faults.

--
Michel "walken" Lespinasse
