Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE330D8F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhBCLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhBCLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:41:25 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C3C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:40:45 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09l0HL9z9vFR; Wed,  3 Feb 2021 22:40:42 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Deep Shah <sdeep@vmware.com>, Juergen Gross <jgross@suse.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        Waiman Long <longman@redhat.com>,
        Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210120132838.15589-1-msuchanek@suse.de>
References: <20210120132838.15589-1-msuchanek@suse.de>
Subject: Re: [PATCH] powerpc: Fix build error in paravirt.h
Message-Id: <161235200842.1516112.5240192209581561083.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:42 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 14:28:38 +0100, Michal Suchanek wrote:
> ./arch/powerpc/include/asm/paravirt.h:83:44: error: implicit declaration
> of function 'smp_processor_id'; did you mean 'raw_smp_processor_id'?
> 
> smp_processor_id is defined in linux/smp.h but it is not included.
> 
> The build error happens only when the patch is applied to 5.3 kernel but
> it only works by chance in mainline.

Applied to powerpc/next.

[1/1] powerpc: Fix build error in paravirt.h
      https://git.kernel.org/powerpc/c/9899a56f1eca964cd0de21008a9fa1523a571231

cheers
