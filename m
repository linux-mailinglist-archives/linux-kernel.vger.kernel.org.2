Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4C34D2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhC2O6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2O56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:57:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB51C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:57:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617029875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89OLqGCmDiFG02ByiCM7EbSbXUpQdtx+NtSMTPYy5WE=;
        b=Lmhimi7O/3OamvzUjpTUvz2LuuakYEsVHAqb1mpThPe5ujFSI0K0XylTHG3MIvcj0B2oiz
        xxDU19NDZlzkZeeBc5Llm+Qj9oo1Co3myfuZ10gTsfn4RFJhZ3+2/mYSpicWuaaEDUWg51
        O6f58nKs8wK0nrCDe5rv4UxDvZpHekR7jtdqJRYWSuaJvjH7U1GemwjZ3TyCCK0557H6YX
        1V50jPDRhmes4V5T/qdNEmxbCMqPCkVjHWpVsYla0/kWfGkaemxuIcABK5DWPuDylNK21K
        6GKYv767eWOLnmqa4vze6T4n3mcd20xiLuOv17qw27y3bZ2kSj6HtPSknyjPUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617029875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89OLqGCmDiFG02ByiCM7EbSbXUpQdtx+NtSMTPYy5WE=;
        b=2c26pYtI3ud0zkqfdmNCtMZdihyn9If20Ml+PVNwyalvPD+LgqpVF0dR+saA11nUnsmGFu
        wu4e/E3BWgkQ1dDw==
To:     Richard Cochran <richardcochran@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an error when TAI has not been configured
In-Reply-To: <20210329142612.GC20909@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de> <20210327032859.GA3168@hoboy.vegasvil.org> <YGGbAIoCKDbZLQQ0@localhost> <20210329142612.GC20909@hoboy.vegasvil.org>
Date:   Mon, 29 Mar 2021 16:57:55 +0200
Message-ID: <87o8f26m8c.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 07:26, Richard Cochran wrote:
> On Mon, Mar 29, 2021 at 11:16:48AM +0200, Miroslav Lichvar wrote:
>> There are at least two issues with handling a zero offset as a special
>> value. One is that zero could potentially be a valid value in distant
>> future.
>
> I not losing sleep over that, but
>
>> The other is that the kernel updates the offset when a leap
>> second is inserted/deleted even if the original offset is zero, so
>> checking for zero (in the kernel or an application) works only until
>> the first leap second after boot.
>
> oh, I didn't think of that.  I hate leap seconds.  Good thing Earth is
> picking up the pace again!
>  
>> The kernel would need to set a flag that the offset was set. Returning
>> an error in clock_gettime() until the offset is set sounds reasonable
>> to me, but I have no idea how many of the existing applications it
>> would break.
>
> I think it wiser to provide another way, sysfs or something else.

I think adjtimex is the right place and not yet another random file
somewhere. Something like the below.

Thanks,

        tglx
---
 include/uapi/linux/timex.h |    7 +++++--
 kernel/time/ntp.c          |    4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -188,9 +188,12 @@ struct __kernel_timex {
 #define STA_MODE	0x4000	/* mode (0 = PLL, 1 = FLL) (ro) */
 #define STA_CLK		0x8000	/* clock source (0 = A, 1 = B) (ro) */
 
+#define STA_TAISET	0x10000 /* TAI offset was set via adjtimex (ro) */
+
 /* read-only bits */
-#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER | \
-	STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE | STA_CLK)
+#define STA_RONLY (STA_PPSSIGNAL | STA_PPSJITTER | STA_PPSWANDER |	\
+		   STA_PPSERROR | STA_CLOCKERR | STA_NANO | STA_MODE |	\
+		   STA_CLK | STA_TAISET)
 
 /*
  * Clock states (time_state)
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -741,8 +741,10 @@ static inline void process_adjtimex_mode
 	}
 
 	if (txc->modes & ADJ_TAI &&
-			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
+	    txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET) {
 		*time_tai = txc->constant;
+		time_status |= STA_TAISET;
+	}
 
 	if (txc->modes & ADJ_OFFSET)
 		ntp_update_offset(txc->offset);
