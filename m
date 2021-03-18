Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6E33FD89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 04:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhCRDEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 23:04:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:37505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhCRDEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 23:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616036629;
        bh=U0o6I/U/pQO1DKY2aDlMprkhG5rI+7yXePtsme76G+U=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cbzTg7msIi+i1kmAccRhjOZfIiJ+jXaBXWz7aEmbBlcb9yIammQqHRC3UsJ/+/qo7
         mymLF/jFqgUv9uyFyiomr97v5/vzD0n0P9jiuBBLAaLrJD++oAYZrh7+YqjtC2k4Ch
         mW0g9fHtk6ueSnL+fEFvkmMWEtOWGNvHHkYx3twE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.159]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1laq5B2BJU-00wYdw; Thu, 18
 Mar 2021 04:03:49 +0100
Message-ID: <b044dac2f59bf351fa213096c430a197ec5d4bd4.camel@gmx.de>
Subject: Re: Re: [PATCH] sched: swait: use wake_up_process() instead of
 wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     =?UTF-8?Q?=E7=8E=8B=E6=93=8E?= <wangqing@vivo.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Mar 2021 04:03:46 +0100
In-Reply-To: <AD2AAwDtDgN4Fh3ZMJ2Tcap5.3.1616033658963.Hmail.wangqing@vivo.com>
References: <AD2AAwDtDgN4Fh3ZMJ2Tcap5.3.1616033658963.Hmail.wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cVi/B0K3ozpYXeLkcE0TSnxmtJiyFIBdhiueQwE8xGK4eLRMkLb
 e+EToD44chvh2X0Ux4C9om8Ab+E0ShVURnJb9c5XkkR7Q9XQ030ohw5P0W1riFLKvwMLUrn
 xxukEEKxwfo2C80t7SdLqXyJESRhxxQAGEV/DLfgktTx8VCHUFm0fsCvWrgLqXywCo/JCK1
 xRtrlSbQgPpXCdY5NMbmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3e2u+x9SY+E=:uv7vd9kym9XJxXBKKXtLdR
 RQD0OPkdSzyseARpX58aVLDyCJf4HwQQ0p8suVB0ZQvAQPc7Vd9bh5oDUe/yhjWo3F9FqHGXa
 likyO66DmqYZtxiP2Uan+P88A4PHZqdjgX3f6aznEhskiC2o3bLBWtsoIfBgGG9DkYZ+8HAVL
 vKFPzWPdUCczDy0JoDmfc7aUvObh3VyPHDgRR8M5g1Ijnwb6/x2yTPmt5XtK8p69XRYCq7FA1
 /wto81kfbyf8JI3bg0HRZ+w4NTbgvC8tpqggNha8YJs5KyrUW5v9aqg4SnWL4oJ4OOEmo0oEH
 63nZTRv/vhMjuMlddkh3WI6VoXsNOReNbTCibejNx/MXIxz6gGd88mhG4uB1LWW596XLy5v2x
 qPHa62EzLuypkk0JkTywbJEYGw4l+kL7RhkSzP5Owii1Tp+MWVEnHE4OVyUMPR5Ju3XS88b6z
 3Aibi3l/efaX4qllYE9DEbPv34Zicj9wcPdQnGG8npFTghL/Yd/8KgBXTWPRGPLLn/pVKtBOe
 /svydjvjAUu/Yx++27Hpvu5dNJs9BaAtbczM5PmUmSczEVxTGA+AxL1Oit82KUjYkbKnTuLIY
 RHXUXS7+p/kQrugbwTKlZw0nhy+3oL0I9Pm6TyzkFl/JtY8Agp1SDWmLdnz+m9cp0TFrOlS2V
 P7qA8sVdSyysLHbPdH4b03AumMFDmlzIiCaqptKfzbcXPzRwaOQ4nrGfxu2XU1zK4vY5G4//M
 vNys97ywO7CjsescyZPDdoGJwDqfoIEQ/+6ir18lZkHe7zBWJ1oR2joNYiLRtCwmwNm1VTehf
 Pj0lqLT5mU14/Sd7gZyyddn0xrhvvllSTCBUVCVWlyzg5K2PE08j2NS0mQ767fcsC0M9gpldu
 iosjTrFtvGvewJZNAl9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-18 at 10:14 +0800, =E7=8E=8B=E6=93=8E wrote:
> >>
> >> * Mike Galbraith <efault@gmx.de> wrote:
> >>
> >> > On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
> >> > > Why not just use wake_up_process().
> >> >
> >> > IMO this is not an improvement.  There are other places where expli=
cit
> >> > TASK_NORMAL is used as well, and they're all perfectly clear as is.
> >>
> >> Arguably those could all be converted to wake_up_process() as well.
> >> It's a very small kernel code size optimization. There's about 3 such
> >> places, could be converted in a single patch.
> >
> >It's still pointless churn IMO.
>
> Using wake_up_process() is more simpler and friendly for beginners,
> and it is more convenient for analysis and statistics.

If that's your argument, that should have been in the change log. That
said, it's IMO still pretty darn weak. When presenting a patch, do what
Ingo did, show the technical merit, that's what will determine whether
it flies or dies.

	-Mike

