Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9B3CC82D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhGRIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 04:33:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:55411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGRIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 04:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626596972;
        bh=C3fcgolBPCedQ4D/+2yjkrUfly9qUKkzLQRI38gnXHI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=SVF8uOrJptlEy8CVf02KS8Z+FVgkzDLxKYeKuLmxDpJa1Yqr4M/8wPKnnufzsdJiv
         EtSei88k0Dq+goFlyagQt2uRqH//bOpAkg3/XUYe7s7hsT01gYj/D/6aNwjoTjOD3R
         qF0geb1qDUaHtVOZccvZlQw12ySP9c12j7NgelTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1ldypd3rAw-00Qyjq; Sun, 18
 Jul 2021 10:29:32 +0200
Message-ID: <64eda4de845c8d98e0dcb7f6fa3177037120e317.camel@gmx.de>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Date:   Sun, 18 Jul 2021 10:29:29 +0200
In-Reply-To: <ef4903e2-c2ce-9a64-68b0-c7ee483eb582@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210702182944.lqa7o2a25to6czju@linutronix.de>
         <891dc24e38106f8542f4c72831d52dc1a1863ae8.camel@gmx.de>
         <ef4903e2-c2ce-9a64-68b0-c7ee483eb582@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d/PpY/pSlP89e6xkF6+DLWyRoolVhRkrqKuKZngBrPjkaZDXmv0
 x2Zs2T37BPv1BPLqoimnU0QP8hDl50p7tJzdBXMNT4khvFQWje+QnL6BBk5aha+bpeBkADl
 PPXQskXTT+WczYLebDwWrJIi7SYKvLNvVTF5fLW+s7KMm2VulzCVBQpAHYdN8zkaJTZTBOx
 FAQFKa9uoOruX46n7MoLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VMIpsfVM0uQ=:E+L/pFjyeV1dQu/kkE5be+
 5LH6iTiMMufwwTnSm3sCNVuLZVJFekQqBRBWv09XTj36kWJmWbFZS9uy5sh4Gb4qjt6SdUDeA
 lEjjbYmx8LzV3ChpCvEfoSvieHDRS+o31nbLwvOE4UwDdU9t7zTlMq+ZTclvRhD4/5mDVMdRB
 Aj57qJlYXffUdlbGpdHJawlxhKodbK6avosZTySvhz6ZNLprGD4I+w3T5ZGbMnw9cxY8hMnXt
 SsfTJrlIfdoFVhKdxkrhp9EQCm593mtuX8fktcDiTazE2vdyhJp03MZGunF4YXctpgYF0MNMU
 +ameMF5QEDnJqyeRXruFrrL8NnlHgJawl37edl7y0ARSrQ6Zhpw6MF0rWirX3NyWbYXUquJ/y
 XfSdVdcXILyL8zR2pbhGsCZEUT48liZvBMyIFUjTPXIvE3rvz2asMMruAF0Nr2AsTjkOmgxDK
 GXGWoZxA7wM35IkJ+yReSxR6Dwm5nOxnKCW3qN9rbbABKFW6HTpDbEK3m9y4ECBR/bE4KXhTN
 JinikKEAAEcS9FcNkNTBl/nliGNrYadCBrNejCVz6G6LX60dXuMq7qQhuVhrONwO8Ug+cmC48
 JQIGhz178WLLNtSymgQxjWWxsJZvhzdl0Hsi3PW8LnxZq9HgeoAdTXhwqSHxzekvJUWWFMo8C
 Gm290Ir2gzpOGP/kovjOgSQaMQzQBl0IVR7KdqUhA1EskXehD0KDf3C1aUDmDL3CnnUnMTAaV
 +PatDUbcgMfFSZSWcBdQBeRtO8v1BONweHKHyIVJaSTCP39lwjFlSYopXkvXgvuUwWnvLCaWP
 0qXFo2qscfuZjhq0iUtWuaf7Vx16ockPpF08RjKeM5kKxXfh5sDpxU1lFA4GELsZmm1GUtgOz
 WN0UZiKXeNQ7SR79WhWzkRqPyAbnONddr8GAmSCOGSqSnLKwBNe0uxb3HMkTiAwSYNWb3c694
 bu/OuipZth8xvHOHPeN0UZhm4cyWBBSubhiUxlpVq2FNQWuQk/ud1jO25HKYc+5MEDMGthiKk
 ej5JH93P8MQQxJn8n9fnVJGxIDMJroeZpBPntDAPH4Ohbugh4CEucyAU3TbXZKXiIb+GVCmB1
 ttIXum2z1ptkSxInsOgMCxoMQyyfbYjO981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-07-18 at 09:41 +0200, Vlastimil Babka wrote:
> On 7/3/21 9:24 AM, Mike Galbraith wrote:
> > On Fri, 2021-07-02 at 20:29 +0200, Sebastian Andrzej Siewior wrote:
> > > I replaced my slub changes with slub-local-lock-v2r3.
> > > I haven't seen any complains from lockdep or so which is good.
> > > Then I
> > > did this with RT enabled (and no debug):
> >
> > Below is some raw hackbench data from my little i4790 desktop
> > box.  It
> > says we'll definitely still want list_lock to be raw.
>
> Hi Mike, thanks a lot for the testing, sorry for late reply.
>
> Did you try, instead of raw list_lock, not applying the last, local
> lock patch, as I suggested in reply to bigeasy?

No, but I suppose I can give that a go.

	-Mike

