Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD845A5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhKWObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:31:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:52635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238116AbhKWObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637677721;
        bh=0t29Om9r/3mHJ6xqk8ert1AIeVa7sPaveonn0gHt0VE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ErS0ctqk/0vIw1MX1sLKJO1ElTBQCUQXp/6f4YBesMgNwTrxGTRg8s5TdabNLD/Yp
         EV3nVx1M5Lh9BbCsfNa7+48aYFCOwrbZP6StKkIczfH4yyOEFzbHZE9h4gf92RTyXJ
         jGueZfqp3atK6COv/6jFH5Dk4o4ojoMBtDE8a0Q4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.50]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1mohyP3BrR-001VaL; Tue, 23
 Nov 2021 15:28:40 +0100
Message-ID: <606dec7f03feaeb1ed519a8d79516dd5648ef1a5.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Nov 2021 15:28:40 +0100
In-Reply-To: <904392102aee146723ebd442c6289db10f85f421.camel@gmx.de>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <20211123091304.GC3366@techsingularity.net>
         <21c3489c7ce8342d392c08547a3222a9c289e9fc.camel@gmx.de>
         <904392102aee146723ebd442c6289db10f85f421.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ANJ0ESxxhuderbrKIidPBzzyPekYSZ1NBVJ0dgovBIaDunxKJm
 xbrv1t2wllJxZgm3tfDr5KGpOB6me09b6pqk4E19qXr7nhFqFk390kSgkLL+N+TM+Ejg+9J
 7EnS/IEASM4RIDJ4CfF40NYMtmIXipQMP8CZkOpgMPUE7ojONpp3NPNrZ+jSI+397o4SXzw
 RI51YGE84VSkzyN2Dq6HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NaGSgrSW6yc=:ZbR7gGE17i2AaEXhF4BVzB
 +c6HtiCUiiHLd8za2SVSP7eF7f010HgmIJojBy2qAb0J4aRtukduHt48ANg929LF3qGBbfEkJ
 gg8c2kYydYlkar1tib0jWf7EcFPCLF5Z6GZOUeZSGEcDLXHnuFI2d+U9y/S4cRyxOr55K/SwQ
 O9lB3zO2KthqJAUjLEEkAhv7KJyLvtAKXDaSg9sSnLC4ZOMSvZgJtpD5CvxROZJqNTlsAavvF
 epB8Ksq1Rso3yOIMmab00QNAQr07y988Ccnn3CM93BMi4VYr1ZkwJSViWnCwk3bLJ3+c+TtYB
 RnPaIT+eOvE6OJZV9h8kyqeNX8zodqwFIoBjc3z9TWhSZcJTFSMOh5RJHXUsuAhs2pWpzW0YH
 jrz504kxs/YxXoRg7EZ3QwxaaXqWfzD5lJeyvHeA3ceXhH4fY3lFlxA2r5X+bfQlmL6uDdnDN
 YyZp7aZdACRoJau/1uqwICnUe2XldKPR726HVtfNEPAfmeNnbFq8iZfz4I4V/t+7XF9hPNHYu
 gfqqVK3FMK2xjdtKcM/NlfnWLSjuqFrIiCNF9NWK28Z+i0OtFAb51IDM13W4+IPaOq5Y7hw9b
 8oABOp4EiYV8KdKETljHpAIL8ZMq7vHyuPvFn3E8Gef0OXg8u9yqr8a+MXYblW7ao4JcuXNuT
 G6KycaA2Uk39EPfCxS0iz7Z9kIb36+ynEZSdS8iVij0CqgFtzpdmAlI5HYW+QjM4PJ2bXJ7wd
 8fUFDJtUf3JyKip4hqTEaibixkIX3frK4dSgrwSB20EJzrdxfzMuK/Y8jipkl0fWabW14KiWX
 GvFur9RL2fbHwBi0OGFfNKyDz7BpzrKbFHvbijlVH5eqfTcmj6P5UNGlxURAL/ly/H9q/ADPR
 HcgWVzYLlAdhRD8VczFjB5+v29f1Uq/bw0eAW5hPkqzntEGwhDtku7bOs7GB9uvicYUjmsWEr
 7mCt93NECwNs9fWa5jZJbIbvb84BAiQfJmLMnDRBhQoOycYFVqVdL8n+TmpILYsdraa2fSZIu
 Rv9pCEtrD5CamEXp6bEVG+UHkOQ5mJKFidDOXBU5ZaH54c+5NClbkgTkrdGQMc6s62b53wATF
 qRbvPn4GzpvNmo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-23 at 14:12 +0100, Mike Galbraith wrote:
>
> ...I bet if I were reeeeeally patient, I might see the test pass.
>
> LOL, and as I write this, it just did :)

real    30m27.524s
user    0m0.206s
sys     0m0.162s


Hohum, this one looks like there is a genuine buglet in in there
somewhere, as oom-kill _and_ penalty box surely wasn't intended.

	-Mike
