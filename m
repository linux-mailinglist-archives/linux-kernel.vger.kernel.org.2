Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2CF406647
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhIJEQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:16:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:39079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhIJEQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631247284;
        bh=rVhS98kJuXOnQaP7kFU1p2+ZpKPQj1X3psyXiI/RJPw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=k7cNoLKduf3CbFZ+DBR2k5ZUz/lnn3roEJzz7udeLJq2kce5dAPiuELyYIMin1MVK
         4X8rQ06rvWUXWJVE6HJ/l6Agz4ieoKrngvqDkZQ5FUXqN/TytJEHr8QYCXeQVzX+jY
         RNyvCGtLY0IsZYNOlqbp4K+Kes+MxiMpRoQPmHnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1mkQLM3CAi-00md8r; Fri, 10
 Sep 2021 06:14:44 +0200
Message-ID: <817e71d3987224bbacfd916b2d953fb528ecb4d5.camel@gmx.de>
Subject: Re: question about isolcpus and nohz_full
From:   Mike Galbraith <efault@gmx.de>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Sep 2021 06:14:43 +0200
In-Reply-To: <b39eca5b-98e4-6b9e-c65b-63aad84d8caf@windriver.com>
References: <b39eca5b-98e4-6b9e-c65b-63aad84d8caf@windriver.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HnBSxbAoExudxLQpb9sxZIRqna151B5g7WT8YRL5SJpE0Ct+kH8
 1OfHlbK96BwBVQ4MFoeJSF5mynf2o6O8KHoIvSOFdOeOGk+qoUSeTIj9+OilH0wPKqbtIqC
 1dIQhI9s6vkKxLecK8Omuq60HJBKxgCv2hPrlh44gvH5/su1RPXKKSwqJsj8OWZroOXrDFu
 jnoZe9J92M3oYf1AwOquQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8mbqzdPw2/Q=:CIw/2qX3eUZX4tdXIBY5Yx
 CyAKaSb40Iinr2MR+IBF7ChsGedEbP56KZ5Ya4nZSdQggjmpFlB3jPVcqN1du8Sadh1PpgxPJ
 alfBh6O402Uy7PeeRm9P8TTEbn8czjJeg4iyHLMtISjM2EVqQnLPGqkvSu4RJZTV6m02q1mE4
 0vYcBujUklVFq0Q3OInZ2Erb8jXNQvNFFt7tVMqHhuPfOfydLXfbTfn5mdlh/aU5Uu+2gRCrQ
 3rHPW0mo4la4uBTAN/XbqTYTcIHkuGWj963a4RgNgQCEsWhS9qnL+rZ9qJcXLborWuy+dClFC
 SEZ/0QG8ArORxjWpjQyOeIBvj8kgj8Xy4JKqYMYLN8JrQIFvi0euLK9GtTJZGA6WSgeTfQbcz
 F+jkihRrfe9AysMDHmXPvKuak7VR9iMn+tKmM3K5TKdHdA5dVYR0w4KvPLDypEiDqDs5lGSmw
 536DVrBhg8gK5XeGbUKcaZmTrRQ/kWXvuv80WWmPCJkBBL2TqW7MjQJUIv3HGDsy+XUOSuvBH
 BjQe3bAjaystWqTkJtYbXmMSe9S09KLa6e9Nh6RLt71lgniF3K0C8L5lI14cRNbCSOyFkcbZM
 E+0xfOWRHxQL/kCiCKI5nbgD4EJMCeTR0PxIohVvjkgrskxSZnBZaFEWwKOuMbrO0/vTFGROX
 aax4W0FjgEgfMNmIGOYTWraLzAnGCKm0hxiOC+maZCw3Rzi0gZiZbp+1IPaG7LKTWe/VPvHBO
 5tjIgnhHtUCtBzlDmpaOXzwp0F3MiusjpHsFsFKAPppITq/K9kN7k/QfSEMkwdScxc5KR5U5v
 wfuRbjm4CrCU0qzR52LFYu2RSiNH+jAU2nQQn5k5PsezTvMqPqidamZ8dq1pCYjWn1PgVXi+p
 +AMhPwXTQyAQgl1KHvERJzIggP8EvTWMR3E+aSz+5rtb2n2+IRztmLQWty+qdFgMybzHsBJgS
 mIXGc1WrVHnBuS+l6LDsgb8HfWLg3U0C6EfUtCbDmyYu5SCZLe17OlVzvIvcjk4ugyoxWT7hK
 lT8cFdGLvNIrjoJQ079fHmzmCgUFIgdJZQV3jWtThyUIuf43R6FHbEc+U8712SuySMAurgdEV
 fcSrr2QJn55X7Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-09 at 10:26 -0600, Chris Friesen wrote:
>
> 2) Is it allowed to specify=C2=A0 "nohz_full" for some CPUs at boot time
> without specifying any isolcpus?

Yup (IM[not the least bit;]HO the proper way to partition a box).

> =C2=A0 If so, what happens if I later isolate
> a subset of those CPUs using "cpuset.sched_load_balance" in cgroups?=C2=
=A0 Is
> that allowed when the equivalent boot args are not?

That's what an old shield script I still have laying around does.  I
booted master on my little desktop box with nohz_full=3D1,2,3,5,6,7 and
shielded cores 2 and 3, after taking down cpus 4-7 (smt), and it still
seems to work fine.

I used to also override (via ugly.. maybe even fugly, hack) nohz
dynamically, turning the tick on/off for subsets, on having proven best
for jitter of heftily threaded RT app spread across many isolated
cores, thus could at need even partition a box with a mixture of
ticked, nohz idle, and tickless sets, albeit in a rather limited
fashion due to nohz_full preallocation requirement.  Would be nice for
some situations if nohz mode were to become a fully dynamic set
attribute.

	-Mike
