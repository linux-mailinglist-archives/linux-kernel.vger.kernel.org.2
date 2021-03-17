Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2B33EE84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCQKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:42:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:52185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhCQKmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615977683;
        bh=fwJbdYQp3N1KJO0bad75ywV6sY5wxEPWieUAe4FlmB4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=afzCaMCB9cGBBmy73pB1xCSRItSl97neUejk0vnEbISRsFnuv8RUtAveAwvoQytcI
         ODfFtY+3VTFE3g3rHQJSZmqQZ2/FB/tp0UIKYGPvQxm9ZCpW119Hu7xCrvE9JPkarl
         gA05KN1FnPMcv4obzLe9dhyipeBu4sHcY7NRyew4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1lAbEi1zEd-00WpNz; Wed, 17
 Mar 2021 11:41:23 +0100
Message-ID: <16b579d7e48b7ae58b77b9eaa9757566f57408b8.camel@gmx.de>
Subject: Re: [PATCH] sched: swait: use wake_up_process() instead of
 wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Wang Qing <wangqing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Mar 2021 11:41:21 +0100
In-Reply-To: <20210317094618.GA1724119@gmail.com>
References: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
         <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de>
         <20210317094618.GA1724119@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DvaVsf+TnI3/VWq8Ug8ziWoEJj7DvZEe+auHQa3A8eA0Wr5JEtk
 HwYNAfYW+7DC79JdqP3WiWCyzwziFqz7e4ilIn74VMeJJ94e+CXam+KrrjC8Ar55VZgft+i
 VXTjKDgH5RCeUWbg7Y4/k1TU8wLb5x26Aop55XmYIkBSazh78a2e992+RDDU5P/ME8jPiew
 Wg9RR6O7ka0H9SCB5rx0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NVq7xqjYkjY=:HosjvoVY4DnF+3ty13V5SG
 X2zCuvX/fayF4nwQ88epyZWsvfSvOc+GgDuI4E3z8AS/bWKHKcv2ALb9W5sx2r0h2gLYxrkKt
 IA1xgZ+1osBmQkG/JyMmH37uyq+nTmBOcoMu/MPPdJGgrknUd5w3TyMz3jPvHiJ+POxR/BtUd
 A38SjIiD6B6+IwhYAlz2fzpxsenBt/etTl+nA3O5XFACZ6zeB805714wVmX5Rfgagxo/XZBau
 dt5J+d9pnUk5W0sXOaqakdwqjnBORhgB8zhn75xihLVZ/ICHLIY09f8qeCWDRNOw0Mwln5VJC
 K4F01r6GmohwOtsyi+jb09v5aKntm8RLjKDxkkuufyY4rSGM0mivc/O6Xu/He8Knpi6F6CqF1
 hJi1jpC8rmrwD0cs0uNafsbpE9XhbaCbREPgbDmGDEHLB8Nx90rYVKTd45xsPxqbn4klXsriY
 XmuODp3MlGYQphCWCcWtnqBWPKguLdbILXHQqE64IUJHT7uf8APVwNAVH31sQHPWhX49ICRrL
 VAKt6o5ySte1F0+dSwlOpzDStcpWOREoGJt5lG2uCI/9YKvxOiWADIr0Y8fXKJDhlJZTPw1Ya
 yBeartNPXKC2ZcdxjZW9iaOaIVr+XdOF40EjydZEnJAedQmdumOC9hu+OY3BG4Zt7j8mIE64G
 cqyKdChA12CRfgi7lBFeapD80kML+l2iU6cjgazE9heJeBzgEAnHpe1uHYd7m8I+RbUESB6LP
 Kkdf5dDY5nuonXMARDashZT45E4yXqET18odprnkqe5ZaBhCr5kg0oerQBC59J/yC4OfFyTYX
 36RnFHw/EaA62BBidUSj2iVkZCXMn3cjKJmkVbX1RFhOikN3r8s/B5Uwu/CCTbdJ0mxv29g7K
 7FkDYXqK9TKG8SGGLaVg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-17 at 10:46 +0100, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
>
> > On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
> > > Why not just use wake_up_process().
> >
> > IMO this is not an improvement.  There are other places where explicit
> > TASK_NORMAL is used as well, and they're all perfectly clear as is.
>
> Arguably those could all be converted to wake_up_process() as well.
> It's a very small kernel code size optimization. There's about 3 such
> places, could be converted in a single patch.

I still prefer the way it sits, but that's certainlyly a heck of a lot
better change justification than "why not" :)

	-Mike

