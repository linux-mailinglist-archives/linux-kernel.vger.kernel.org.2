Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5F3164BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBJLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:11:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:51437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhBJLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612955211;
        bh=mgx3ymtQ1de15m2eafNIPVv5s/CjjEQXbMYNmwH6d+A=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Gu/Em9lbrGfcBQNm1I47zihxj5+FxT6E2MQUAND62VSr7oAApnRPFj+jJHT8bYRJL
         gVbJ5qOUkZlg09akW7byUv7vBZwSgGZdrXgOmOEq+ISurX5HmiVqSoAzKdM/YuWib5
         YnDXo3k85iQk2uhd3cmZqiX2cmrr2CRArpXVIyYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.231]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1laqMQ2oSb-00jXE2; Wed, 10
 Feb 2021 12:06:51 +0100
Message-ID: <2d09eca022b9909f69e3d738208dd13f96f5148b.camel@gmx.de>
Subject: Re: drm/nouneau: 5.11 cycle regression bisected to 461619f5c324
 "drm/nouveau: switch to new allocator"
From:   Mike Galbraith <efault@gmx.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 10 Feb 2021 12:06:51 +0100
In-Reply-To: <3104ceee-72b9-bc40-a5f6-2c5a7920e443@amd.com>
References: <1d663cd74af91e23f4f24ebbdd65ef3ba72c15fc.camel@gmx.de>
         <43924195-c4e1-fce4-5766-aaefe2d6f766@amd.com>
         <9d221e6160813fd188de26d3b56443129e9f8003.camel@gmx.de>
         <3104ceee-72b9-bc40-a5f6-2c5a7920e443@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e+i9Yv+gazBn9KC8hnSPUn30v2SHjYREatZ91dLzNKBYyfHMtsm
 N545jaYKhFg+X4St1P4NTEUGPgKP+AQXYt//80PXY/PxZMFpWQVfdw7t03WS78KLB4vyEGZ
 e7j9DnYs3+zt71FA0cZb1g/Fd2qvUJfkWjcH60umN1NpFm0CRc9TuYRy2y6c7mXs3h/Ye2u
 Ce4arSL20xDEI9MM0qagg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jDEV5mnxqhk=:vgqkoONp5x2cGRuMVsPA/g
 eaw1WWpXHKSCjxSYUgte4lVtKQUxZ4BnRDOh1+eum+UiCuxRPnf92oomqqsxF4xBAac9ZRvUo
 8148nOys8/CkuVvyFjMClTpBtH9/nvdeDuSzuf8j8gz2y8lBpMY42Mp3T+mMxZgB6HXHag0S3
 2rpyEWQN9rq5T4T6vUKljB5wX9N8yW0gaqasI33WjWpTJfa2Fs3fDx/EmNyZ/oQk8HJJtZ96A
 BpjJkaQiPphmiU7hGVe9XMJYwy0xaLuaWtmMaxSZ775/dJxR0UAFrDfsB6/gzRxVbYSw+QcI+
 /BTQUu86OE0x7/fyyl8+qU7p3l/zjOgS1DUwNifo01o/oT8DSHw6PuEcw1QfiXzGeuYjRON6D
 gq8pQ64lfIamL14/HrXvRqlAq9KWJQU1gvtwS4O/zpLAnAlAQFK6E5wNyy6K3RwLh6IVg/mU0
 uQB7uWK+SDhKxdqnGRKtSLTjZhvjFVdrL71+2Ufo77jWsTIqh7oGdGU+H6W4DdgRiCZXzYHfZ
 Foe0equlgcduE6+7cTM4v/Ol+Ey1zw91dpWwVMjxjl7EOVLX3zH6JYYa4M8sx/LSwYkj/q1FM
 ddKKUPaho3hNJfdlsfwstCmITYyILksEUWHJWLVoo9iAbh8KXaozHhz5F6G8ebRBkzDbrenDS
 aqYHipLgxYGi6vTeK7CaVUcCmksVY583dqjagliKjRQbj1Zra0g+11pt2O+bw/QitWjWNd4jV
 TGLAXaNrfdnaF6v/Fnurlw/7fBeTfvUjqoj2oVQopNhKc3WV/Zhz0BEjpa9dB9bJ8BQERHyfR
 kwt46srgAtUw8c0EdWLTS0OIlvJl4GOxL1pFiHcOH30IQJnLVEZmUG3e6xoh3vmfnA3b446Dr
 H+rYlhB1rqVj5+BXyGwA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 11:42 +0100, Christian K=F6nig wrote:
>
> Am 10.02.21 um 11:40 schrieb Mike Galbraith:
> > On Wed, 2021-02-10 at 11:34 +0100, Christian K=F6nig wrote:
> >> Hi Mike,
> >>
> >> do you have more information than just system stuck in a loop?
> > No, strace shows no syscalls but sched_yield().
>
> Well you can try to comment out the call to register_shrinker() in
> ttm_pool.c, but apart from that I don't have much ideas.

Nogo.. off to suggestion #2 I go.

	-Mike

