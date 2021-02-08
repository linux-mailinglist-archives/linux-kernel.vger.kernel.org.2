Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02D313285
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhBHMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:39:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:41696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhBHMee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:34:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27D31B0B7;
        Mon,  8 Feb 2021 12:33:45 +0000 (UTC)
Date:   Mon, 8 Feb 2021 13:33:46 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        jing2.liu@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/21] x86/fpu/xstate: Introduce wrapper functions to
 organize xstate buffer access
Message-ID: <20210208123346.GF17908@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-10-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223155717.19556-10-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:57:05AM -0800, Chang S. Bae wrote:
> The struct fpu includes two (possible) xstate buffers -- fpu->state and
> fpu->state_ptr. Instead of open code for accessing one of them, provide a
> wrapper that covers both cases.

Right, if you do the thing I suggested - have a single ->xstate pointer
- then that below is not needed.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
