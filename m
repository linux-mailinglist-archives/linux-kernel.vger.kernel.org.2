Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BEE357263
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354358AbhDGQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:50:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:52354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235801AbhDGQuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:50:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617814239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWU3Uw013phP+5Jyksq3HX90ifPFm5gLyXDiR5rUIrE=;
        b=m6+WRvmmH+g7124eFx4ypgiNd+KeikLc/4TeP/xIFh9qlKMQvI/h07HYU4F7kVqdsFeN9k
        UrUkxPzG1F3doXw1wk7a13/2O7S+uQzieczVyAQLft7ZOdBYFQ6N16odeET0llll72QfUG
        uGl/pqrFc5ZWRrFpYyHcQBnECOpsN40=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BFC5AD41;
        Wed,  7 Apr 2021 16:50:39 +0000 (UTC)
Date:   Wed, 7 Apr 2021 18:50:32 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YG3i2JF2vBY4CseK@blackbook>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojP5lI8yh47avJ/L"
Content-Disposition: inline
In-Reply-To: <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ojP5lI8yh47avJ/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

IIUC, the premise is that the tasks that have different cookies imply
they would never share a core.

On Thu, Apr 01, 2021 at 03:10:12PM +0200, Peter Zijlstra wrote:
> The cgroup interface now uses a 'core_sched' file, which still takes 0,1. It is
> however changed such that you can have nested tags. The for any given task, the
> first parent with a cookie is the effective one. The rationale is that this way
> you can delegate subtrees and still allow them some control over grouping.

Given the existence of prctl and clone APIs, I don't see the reason to
have a separate cgroup-bound interface too (as argued by Tejun). The
potential speciality is the possibility to re-tag whole groups of
processes at runtime (but the listed use cases [1] don't require that
and it's not such a good idea given its asynchronicity).

Also, I would find useful some more explanation how the hierarchical
behavior is supposed to work. In my understanding the task is either
allowed to request its own isolation or not. The cgroups could be used
to restrict this privilege, however, that doesn't seem to be the case
here.

My two cents,
Michal

[1] https://lore.kernel.org/lkml/20200822030155.GA414063@google.com/

--ojP5lI8yh47avJ/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmBt4tQACgkQia1+riC5
qSjb0BAAgEKtpTvMmS8odId7gPyWX6Vkn1BI3HMu4pXWvekwXCiVXssyn2KMJkwx
xEXytGkPohJzpPYr7mq7PdK11L6Nlt8Qi9lq+ggvHF/nxcWLyRuELjp1Ypv/WDJ9
mXc370PYJ+kUEe3kOb2JGpDX0X6oGN1cplQy/UBPIH+5GspUrWyqmC2vvAvIkjx1
Vj+Jsa5Ek1TY+6LGmKTuqJ7LbCHB24acCTMZXDSFuhR1abAUnV1RalNYws3Te73Y
kStEMiaGrnTHn7p+ogLoLBidr8lZAdNwn3+o1uaRFtzF39+WlS2mxsxMfrekf9Td
kRCtmuXjUDTEfDqoiBtG+OcUAaTBRIxbW8kNnRvTcaAi31A7i6/KLxAiRdm8hlU5
bhG4hqIRJk4iM6YYz0mkDa1UZetpYqq9SEhQGdtSJQvuUydgRTpLMkiu4EygMyeI
0J/3cTNeYzEflswnpxlOOQLL4xyL0FsXUUUtBkRjHM8t/uyIfiNFU3DWl8jKPkVK
Y54gxtUdTJ5opE4r1ffSbeHsehnPgqM71yzDXnbknLuRc4MeMOGIdt83Hsz0qpi+
KeKCq3+JuDaoalOf+zEmqMWbiLAdz0FC8pGh4FVIOAkn9tJiyp7IyXwc9y71boxq
zAPeWngpWdzoTaeJ8YPN3fxYVdzyjJ0G+e12fI/o6a9tZ2iBdVc=
=9N/g
-----END PGP SIGNATURE-----

--ojP5lI8yh47avJ/L--
