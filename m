Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11332D12F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhCDKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhCDKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:51:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 02:50:54 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900e15878ab9d7a3926.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:e158:78ab:9d7a:3926])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FF231EC04D3;
        Thu,  4 Mar 2021 11:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614855052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EMFWSIOJL9yUaUl/Q8ozyjU4IOFaaWCO1QDdvg1FdCQ=;
        b=rgrcN51EQtPgf+5Xq2kh6mz0dUjHQIAjf5UK7pwmIAcowfbuJC2eSeP4GY68oFMaaHxf0D
        KnMwRYrnR4G2m5I3ttd8fSHM88I5HwT6CU3bQSHI0YKQNblcmJlklfsanL6tM3hCvPuAJu
        VxSZcrsMCNuvlrG+jzIIJV67h1BfNYU=
Date:   Thu, 4 Mar 2021 11:50:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v9 17/18] virt: acrn: Introduce an interface for Service
 VM to control vCPU
Message-ID: <20210304105052.GB15496@zn.tnic>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
 <20210207031040.49576-18-shuo.a.liu@intel.com>
 <20210303173719.GA30356@zn.tnic>
 <20210304013657.GC9695@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304013657.GC9695@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:36:57AM +0800, Shuo A Liu wrote:
> This patchset could fix it.
> https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.

Yap, it does, thx.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
