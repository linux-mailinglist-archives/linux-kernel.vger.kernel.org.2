Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0EF34D716
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhC2S2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhC2S2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:28:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:28:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617042503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQY7QWHv7LEsXYxSmIErYnCEcVuldkfvWYrKuwdwWyE=;
        b=gUz++t+tzAbbenklc4/Dx9jU6TFU+VeP1XjTNRweLHDKNd3Zc4ozHVDJuDwJJ1xazsLX9K
        LN4fhtb6B0GLIXrAxDSqN1T09pth01Oxe885mmdBzk+qElBHB+b+nQrCls4yczGKZBqwOk
        +A56gPAv9xHMQYB1wzW3K1WrlmxED/VVABpoZH5eJwY/BomMEpXkYS+JmZF0nvUQfELGbO
        5IjjlcsEob5wlUaYv0tzCc58bHf9eOvCM42n6vb0/wCn4Z+tPctgj7HLUSeGIRPz/VGqq7
        1F4mYCIgyTT7en/o+Cnuk+gI/2sO7CXSPxLtB/WrX+lzB20/xDUxfqssZGPy2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617042503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQY7QWHv7LEsXYxSmIErYnCEcVuldkfvWYrKuwdwWyE=;
        b=dDQr5Zcm0XGIGmoSgOLJsR7j4gkf042KIAPRYm1PfNAWAai7/JtGn1pfUJGnu5+rQHNteC
        L2eUUEEYis3e3ABg==
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an error when TAI has not been configured
In-Reply-To: <20210329153604.GA21716@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de> <20210327032859.GA3168@hoboy.vegasvil.org> <YGGbAIoCKDbZLQQ0@localhost> <20210329142612.GC20909@hoboy.vegasvil.org> <87o8f26m8c.ffs@nanos.tec.linutronix.de> <20210329153604.GA21716@hoboy.vegasvil.org>
Date:   Mon, 29 Mar 2021 20:28:23 +0200
Message-ID: <87im597r20.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 08:36, Richard Cochran wrote:
> On Mon, Mar 29, 2021 at 04:57:55PM +0200, Thomas Gleixner wrote:
>> I think adjtimex is the right place and not yet another random file
>> somewhere. Something like the below.
>
> Perfect.
>
> Acked-by: Richard Cochran <richardcochran@gmail.com>

But one problem is with that trivial bit that the interface does not
tell you whether that bit will ever be set or not, i.e. it won't on an
older kernel even if TAI was set by ntp/chrony/...

So that needs some thoughts. The trivial hack is in the updated patch
below. If you want to spare the extra bits in status then you could use
one of the spare int's at the end for this.

If someone has cycles and can turn that into a proper patch with all the
bells and whistels (changelog, manpage update, example ..), that would
be appreciated. Otherwise I stick it to the other things on that ever
growing todo list and tend to it Ma=C3=B1ana. :)

Thanks,

        tglx
---
 include/uapi/linux/timex.h |    8 ++++++--
 kernel/time/ntp.c          |    6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -188,9 +188,13 @@ struct __kernel_timex {
 #define STA_MODE	0x4000	/* mode (0 =3D PLL, 1 =3D FLL) (ro) */
 #define STA_CLK		0x8000	/* clock source (0 =3D A, 1 =3D B) (ro) */
=20
+#define STA_TAIREF	0x10000 /* Set TAI offset is reflected in STA_TAISET (r=
o) */
+#define STA_TAISET	0x20000 /* TAI offset was set via adjtimex (ro) */
+
 /* read-only bits */
-#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER | \
-	STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE | STA_CLK)
+#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER |	\
+		   STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE |	\
+		   STA_CLK | STA_TAIREF | STA_TAISET)
=20
 /*
  * Clock states (time_state)
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -57,7 +57,7 @@ static u64			tick_length_base;
 static int			time_state =3D TIME_OK;
=20
 /* clock status bits:							*/
-static int			time_status =3D STA_UNSYNC;
+static int			time_status =3D STA_UNSYNC | STA_TAIREF;
=20
 /* time adjustment (nsecs):						*/
 static s64			time_offset;
@@ -741,8 +741,10 @@ static inline void process_adjtimex_mode
 	}
=20
 	if (txc->modes & ADJ_TAI &&
-			txc->constant >=3D 0 && txc->constant <=3D MAX_TAI_OFFSET)
+	    txc->constant >=3D 0 && txc->constant <=3D MAX_TAI_OFFSET) {
 		*time_tai =3D txc->constant;
+		time_status |=3D STA_TAISET;
+	}
=20
 	if (txc->modes & ADJ_OFFSET)
 		ntp_update_offset(txc->offset);
