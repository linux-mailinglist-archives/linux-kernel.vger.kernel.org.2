Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FDE3D759E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhG0NJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhG0NJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:09:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B5A6128E;
        Tue, 27 Jul 2021 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627391372;
        bh=cnOCxpBWFy1ZSQIeT84x/eo5g+Ecsp8pOFOwNxv9+eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwtOyKI9p04aB4SNAeQkELSUmSJwOoIZrNoAg7oCvnJ/1+EZdfaZZiMwd0VegjzcU
         klOfQwKU/eJEEYoQQKAaWZUUOCU+JuLrvX7pJlgTvQcIVfhE5JFO7FDOF4HlUXJ5E6
         w5TMoUI8wb4sEc9LtsZ7wBIURIwpxAG8IZ/C0eevkOybw5c3zKHG1AI1y8lTrsk/9Q
         AYyMUxXg/ShXJfLnTDjgJn6sVItf7vth4b6PaDt2erpcjtOq1/1QxZGN7vCEx5qwjw
         7kBm7PXUUQAb9/lqP3ifm/o5JOTEfaRDI1YIEu466lD9RSGcm81VaWHumwIk7xZ9+Q
         ZdkBO9Au0+EAQ==
Date:   Tue, 27 Jul 2021 15:09:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     nsaenzju@redhat.com, Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210727130930.GB283787@lothringen>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:38:15PM +0200, nsaenzju@redhat.com wrote:
> Hi Marcelo,
> 
> On Tue, 2021-07-27 at 08:00 -0300, Marcelo Tosatti wrote:
> OK, sorry if I'm being thick, but what is the benefit of having a distincnt
> PR_ISOL_MODE instead expressing everything as PR_ISOL_FEATURES.
> 
>   PR_ISOL_MODE_NONE == Empty PR_ISOL_FEATURES bitmap
> 
>   PR_ISOL_MODE_NORMAL == Bitmap of commonly used PR_ISOL_FEATURES
>   			      (we could introduce a define)
> 
>   PR_ISOL_MODE_NORMAL+PR_ISOL_VSYSCALLS == Custom bitmap
> 
> Other than that, my rationale is that if you extend PR_ISOL_MODE_NORMAL's
> behaviour as new features are merged, wouldn't you be potentially breaking
> userspace (i.e. older applications might not like the new default)?

I agree with Nicolas, and that was Thomas request too.
Let's leave policy implementation to userspace and take
only the individual isolation features to the kernel.

CPU/Task isolation is a relatively young feature and many users don't
communicate much about their needs. We don't know exactly how finegrained
the ABI will need to be so let's not make too many high level assumptions.

It's easy for userspace to set all isolation bits by itself.

Besides, those bits will be implemented one by one over time, this
means that a prctl() bit saying "isolate everything" will have a different
behaviour as those features get integrated. And we really want well defined
behaviours.

Thanks.
