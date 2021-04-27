Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0677B36C554
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhD0Liy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhD0Lij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:38:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:37:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619523473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTL0kIF4lu16gCKIWhQIYg8Pa9C90pwv2ntrD1vqDxk=;
        b=l/VMVbpuDgGOBph9up52ed5OmvPpQASwV5E5TkVayjdylsT34dyyKE1go1ioBaP5nw+aKU
        iF44gm05xVcZ0N/cA/B7n6ySTW5pQh32Et5eMGKa3aAgalZ15Hl7g/tf01R4mFp96blZOc
        QqLplkzcaNiVSWpM4zMm2gsTXEmleHYu4R5au/oF8P8M+jFCKfaJTuTbiKRMDLfoi+3NyG
        MWt5jSIye2g/bmnUMTNlIL3Ig3nuzwRZpiXgjwpjIJhIyeWzadMndSWiQ+Qlbh4xrKkg6j
        Il/1rQo/iCkjUzfag3U38JDRHbQjzaBfzcoHhAxfkFtfDAZD4+/f5vmVxay6AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619523473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTL0kIF4lu16gCKIWhQIYg8Pa9C90pwv2ntrD1vqDxk=;
        b=uCWrJ/pIHQMY6PZybYNyqj2kdwxQHeYb/RM68L7vywo94g4dYFpkmURDIwSTPqZ3dXSWJD
        ZplpmmxEvcOZNICw==
To:     "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp\@lists.01.org" <lkp@lists.01.org>,
        "lkp\@intel.com" <lkp@intel.com>,
        "ying.huang\@intel.com" <ying.huang@intel.com>,
        "feng.tang\@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing\@intel.com" <zhengjun.xing@intel.com>
Subject: RE: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2% regression
In-Reply-To: <de61a3b5b6b1467ea7d377377c443572@hisilicon.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020> <de61a3b5b6b1467ea7d377377c443572@hisilicon.com>
Date:   Tue, 27 Apr 2021 13:37:53 +0200
Message-ID: <87im48nejy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2021 at 09:20, Song Bao Hua wrote:
>> FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to
>> commit:
>> 
>> 
>> commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN
>> for request_irq/nmi()")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> 
>
> Might be relevant. Can't figure out the relation between getppid and
> request_irq().

Me neither ...
