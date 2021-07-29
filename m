Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897923DAB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhG2SqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhG2SqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8A3A60EBB;
        Thu, 29 Jul 2021 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627584371;
        bh=CItWsyj0okwdDWLuvrL6BV6hzvuVIo91hkT4yneGFvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKyUK5hC1FaY/ORXxerYNHc8lVX32quAQQhLwQZxTAEv6Aj4gExL2UTAV+EwG0nMt
         YlQYCFzrHRDu/Ox8sLVODP3JniIcrXmbr6bPtaFSwnQHTwACy7alOby4YYONmn+poX
         TukglGofpiS2Ma8TGuleoJl7WBY4cz/VU3w7hB64=
Date:   Thu, 29 Jul 2021 11:46:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm/page_owner]  866b485262: invoked_oom-killer:gfp_mask=0x
Message-Id: <20210729114611.13ff7c1c43c883bd039dab40@linux-foundation.org>
In-Reply-To: <20210729014019.GA22801@xsang-OptiPlex-9020>
References: <20210729014019.GA22801@xsang-OptiPlex-9020>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 09:40:19 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 866b485262173a2b873386162b2ddcfbcb542b4a ("mm/page_owner: record the timestamp of all pages during free")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I don't see how this can happen unless it's a side-effect of making
struct page_owner 8 bytes larger.  Does setting
/proc/sys/vm/oom_dump_tasks tell us more?
