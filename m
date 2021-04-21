Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC12D3672DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbhDUSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:51:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243061AbhDUSvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:51:08 -0400
Received: from zn.tnic (p2e58483a.dip0.t-ipconnect.de [46.88.72.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EC381EC01B7;
        Wed, 21 Apr 2021 20:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619031034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=woEG6I0sfEGGLeu6jOQkQD9fV+v4+KVZGarzOOeRXwE=;
        b=B6FCFTmrbZfFBSyHDjWVsyU7iuc4b6PJEwAogaQydwLo5UA9TuEBpaTjJvfWy/fRC0tIE1
        vqSO9CvCqEaHN8q1qBVCXQG1f1lH2POkrNCZqwP3X8WFBR8jlfMqmAubmN/159p/L11D6F
        2bKLPGLb6bjRDG983501aGhSfEJcOGo=
Date:   Wed, 21 Apr 2021 20:48:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bandan Das <bsd@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
Message-ID: <20210421184826.GA3120@zn.tnic>
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
 <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
 <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:32:13PM -0400, Bandan Das wrote:
> Maybe, rename the parameter to something like psfd_disable, then off
> -> disables mitigation and on -> enables it. Or just rewriting this to
> off -> turns off predictive store forwarding is probably ok too.

Yes:

	off - Turns off predictive store forwarding.
	on  - Turns on...

Ramakrishna, you don't have to call this a mitigation - this is a flag
which controls the feature.

Also, those 4 patches can be merged into a single one which simply adds
the feature along with the boot-time controls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
