Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7513BAB9C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhGDFlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 01:41:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:45593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGDFlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 01:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625377076;
        bh=arnfTZBwNvGLZwUtAVTdYmP0q7oaOHvftfLOkK6UrMo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ebQRJe3uhk7ZOncnqg5UtLNZe8Hgb8E0rcQbsvbZTjz+3r3sDDEkoZe+rFLFuEQbS
         8fCCkq2Ze1MxbanSkCzULyPRgI4N/a/4DSUqh6sUma03Dv8PTmJ8kjCv31tb3FDgPC
         IFYkpopu/AhlO0bsdkavMcgdC9eBTtDtt1Lzq81A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1lyaR43q29-00GnzP; Sun, 04
 Jul 2021 07:37:56 +0200
Message-ID: <b7e5ce7837acad87b54fee5e30e0e6d0ea0b35ac.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Date:   Sun, 04 Jul 2021 07:37:53 +0200
In-Reply-To: <ca0474137c1e5a16a1215693298c9cd93218e24c.camel@gmx.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
         <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
         <ca0474137c1e5a16a1215693298c9cd93218e24c.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ujmV8DUSfYq29RjSzDm+4tehRJmb1Jp0Xc+uEIVqkVXI7973u+f
 Y/OnAdOjGbApFZPSG35k1LdGlDqOVbRBStpqX7FiX+u6SfCf0gG7hF01Uyd/e+9VselZOhS
 hX/jKNWOeGO2uAJ5N0bXHHX+t/SGDkJnG9FCAtFJPWJOXVpJ7AXEtSVCr/d/oD/YQzrSu9w
 LgGAaQwhVkyBSHsxNfcuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QakDQzSDsy4=:k8wHEv5FrCCPFlbOsFYT5U
 vWBNKVxTKV9qh5rQEYlEnO4wbciT+RrKR4ZgRH9WX9LykCD1uSF5/Cc6AIlv7YkYu5sXV2OZm
 hd+cOT5Cy0PLjV7P7P0l7U1RTih0EsQBvkrqxW5hJEpppaJe+HygV+J5w1V5vviyH0SVTyWva
 1WdJgPxmROTI0l8S0plQSBVitwBf1qYPzyOIwUAO4uveczxNLSsIa0yuYLgq3lbOzHL0TEThq
 mZ40EqkUBVDxdfr2zJNHuaHbc7l26UmeTnfoO+Gw4zfxz3Xufmux9H6/tDT1NPrFDucf/zQIO
 wrJwbKJmKZw2nRzw220J9HfeqDCZpnCwkV0pjzJRqbYtJ33I1HZ2q+Y+lPePg8nw1H++J5j4Y
 fquBFbqdXlQChpttRCoCISZJqlKa2k4qrMlkOjXeFyCWBJ4g0zFbfkOFP3K0Fr1nnNkvbpsCd
 lpelKHMDeNYjmiw6ba1D6J86IhdJc9fq60E3C24oCbIsUy77kUWDcQv/GuGpdZiva57cmGx5y
 hzpHcJJi/LGVwSVw2kp4GSiTRggW2dkJpI4bDAZ8AnHsgIJN68qa/poJZhQCWR9PHF4mTaH4C
 HW5FCofYZsOrw46iP4FFoqED+TPffwTCOhd1y8Y39fjF4eBDA4RY6Gyer4/2PUcBF3BmT2aSO
 /bFheuz5wA3cpZIKo81ZsMfkwRjbi4b6n+wWmS1tGyP6H9rAF/dVkwiESpSvVSceu45DEOco7
 O9fdf0bsJ7DNQNWzdKuGY2TYBBTLW3Oh+WGbppaKDi9K2Xh2Oq10lwD+ncB+k5jj5yX9Kfh7u
 diFydRAvvqm1eSko8O9Ch8VvTdp3dXGgxBYV/nyaW7P5ebdVMs4Icx6ypS5wXjk6RpSEq9x+m
 Rkuph4g9zP18cstf7bKZIGojKymr1L9ttqnPNprofzVIOLKojXgJNQ7i14eXQ7EnHKQJdl3px
 Xwi3us7l0/cogcBorWxcgLIu3XWKgJnC/XcnQ+ITGSvIfDgqQO+1qEGHRF++fVPPfaXpo2iX2
 0Yr6QlePUoU8sCqWnHvReL3IbdlHCPMgX+cP9gBFbOfMrMkhwa3DUdcClhfIZfR6puHUeR1dF
 z4MaY6HDGW25mrbSvFzadErf287MD4iMqW/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-03 at 17:47 +0200, Mike Galbraith wrote:
> On Sat, 2021-07-03 at 09:24 +0200, Mike Galbraith wrote:
> > It also appears to be saying that there's something RT specific to
> > stare at in addition to the list_lock business.
>
> The what is ___slab_alloc() consuming 3.9% CPU in tip-rt-slub whereas
> it consumes < 1% in both tip-rt (sans slub patches) and tip-slub.
>
> The why remains to ponder.

Ignoring odd distribution in the profile (red herring whackable via
prefetch games), and removing perf/debug options from the picture, the
remaining RT specific cost is just that of forced slow path.  For
hackbench in my little box, it adds up to right at 3%.

	-Mike

