Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E24001D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349580AbhICPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236367AbhICPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:15:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3B761057;
        Fri,  3 Sep 2021 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630682076;
        bh=C5nXm0M+t2rPgWKmC7QH9OmY/LS8v83rWfblSw5clYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMXKc72jGvB09FBO2ehj57A4HPS+XtythideFXCmZT9nYuHXyy1yXx2qehaWqpAMt
         2T7U6IrYdFKVCArqdcYpgN24Wiuz82npYN4Hz8/q4wdqU5BGclBznOOGVb/a6/Y8SP
         EqSpcMs9wpc18TlSB3ujzw2T+LoEu5l4g0alApgBVTTHCLFTQwseV9oMHSab1gl7Ft
         WiHbgbABMEjwj2qt/QTcKCQVIVEHLWqziW8mZqE0vIAAWbSuc29ccL3fagh4nPJL7w
         0nwB4DVyQj9JZO/W7A1xIVCzLSnTfWEsDcRVbSO9WK0+cAw4W+cK5Qr81kWti9PmsK
         KSo03seH13ulw==
Date:   Fri, 3 Sep 2021 08:14:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix
 CONFIG_SND_SOC_SDW_MOCKUP select
Message-ID: <YTI71k5EsyTgstkn@MSI.localdomain>
References: <20210802212409.3207648-1-nathan@kernel.org>
 <20210902181217.2958966-1-nathan@kernel.org>
 <20210903102738.GB4932@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903102738.GB4932@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:27:38AM +0100, Mark Brown wrote:
> On Thu, Sep 02, 2021 at 11:12:18AM -0700, Nathan Chancellor wrote:
> > When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> > CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> To repeat what I already said in this thread: the reason this will have
> got buried last time is that you sent the prior version in reply to an
> old thread.  This new version has also been sent in reply to an old
> thread which almost had the same effect.  Please stop doing that, and
> also please pay attention to feedback.

Sorry, I was not meaning to ignore feedback. I interpreted "this was
sent in reply..." as "Pierre-Louis's message was sent in reply..." not
"the v2 patch was sent in reply...".

> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

For the record, the documentation for sending patches has the "Explicit
In-Reply-To headers" section, which frowns on doing this for multi-patch
series but never mentions this for single patches. I have never had a
maintainer complain about me doing this in the over three years that I
have been doing this. It is helpful for me as a developer to see the
review history of a patch at times so keeping them altogether is nice
but if this is going to be a problem, I'll just get in the habit of
providing links to the previous postings on lore.kernel.org in the
changelog section. Maybe the documentation could be updated to frown
upon adding In-Reply-To headers to new versions of patches period? I can
draft up a patch to clarify that.

Do you want me to resend v3 without an In-Reply-To header or can you
pick it up as is?

Cheers,
Nathan
