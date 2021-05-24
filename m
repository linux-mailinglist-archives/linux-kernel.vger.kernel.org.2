Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03E38DFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhEXDQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhEXDQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1104A61159;
        Mon, 24 May 2021 03:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621826125;
        bh=zUQe/8ynwMDvSe70xdTPDgG1ssh4xt32o6GF40Jp1f8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pKwX1w1hrJr0qc5d7sxHlQJYxqQKK2JRptermCADi6GQkoDPPzKjbUBDdJtDX76XX
         kdxarHxeDRoUp2UVLr+9qGy+IQRtAxUNVhmydXM55AgP1kYC+WkDvuaWXL/QOFrdog
         IogG2Pq/pZ5M2y82ihMVhw1ZjNc4s83rG/FLsTFEQCSwRhFGPcsL55SbNWLM/g8yo3
         q0BVSdgi1b62qhZRMzEFbASayi/cUeKCKAK51X2awy8fo9zgbZgEGve02HdgEVoc8z
         JN+A58jL4lu0DjpWpF0xJ5OqdNjQJ5LPfNpPPYeAacqgdF3nhllrp/7Vs6FgI18Eb1
         tQbezgvK3VOGQ==
Subject: Re: [PATCH v5 24/28] x86/fpu/xstate: Use per-task xstate mask for
 saving xstate in signal frame
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-25-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <de9f67eb-2be7-8950-749e-cc8eef5cc142@kernel.org>
Date:   Sun, 23 May 2021 20:15:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523193259.26200-25-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 12:32 PM, Chang S. Bae wrote:
> Entering a signal handler, the kernel saves xstate in signal frame. The
> dynamic user state is better to be saved only when used. fpu->state_mask
> can help to exclude unused states.
> 
> Returning from a signal handler, XRSTOR(S) re-initializes the excluded
> state components.

If I'm reading this right, it means that tasks that have ever used AMX
get one format and tasks that haven't get another one.  Do we really
want that?  We could instead look at the actual XINUSE mask.

BTW, the current FPU signal restore code is horrific.  I'm not convinced
we want to make any changes to the signal handling until that code gets
cleaned up.

--Andy
