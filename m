Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6911377B96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEJFkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEJFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 01:40:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25554C061574
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 22:39:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m190so12541311pga.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9QjThyFdbfEEV7YSdHD2NDT9j0pnbAN4OFRmYnpNSIo=;
        b=DKMxWczXLRPdyDMhH+2pAoS1NdrO047RvAa8WncZUx2FUyJuMKjct6U1MGuwcKf7cr
         VauDMDqhf9NmEQWm/wEECCvM0nJ6eWzC4eQW/JCOEbe/5z9wPzf8O4tpoHyNqS77XW3Q
         SXK2fmtlAJP9gZ1PSj6n9xgvxdJNy3ZQGBPpP9CP9kfFaLvIloQlrCviSCBR303IlpSb
         KAuQZpfBuBLzPQQ3zhW9s9gN9NzVcC767e8xv4kOG9Ef56xbU6cFnmznaN3GQ2H1IJJv
         GDDtlOxpsWr8tfspvWLM25f2JO2oi0KTKfnNvTZrRCaPBOKt1m7J4+bZ6sWs/MwkAGPn
         i6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9QjThyFdbfEEV7YSdHD2NDT9j0pnbAN4OFRmYnpNSIo=;
        b=oJ3dnCyQR9D/znAkjW4wm3T23bJ9AX3tqf9MUzh+1xrhRAuoFwDEuCdivTfSooU6eM
         +KkQ+WNjtwiCfrE8eT46zxwy0HxeOD3YEnPkf10SkfOt7WqkJtaBA044GTqpmdP3PF2k
         1Y2Scmj8aVEqtO/y0kfmyLUYbuoITJkacro85qFwQ6+TrS/6Io1AebjXhZJkDdBV9OMh
         vktL85LrAl1E8Ti3vg/PL7146xv9bb29DjTDfyK+iWavv5+lbLZ4oDt+yDCdBs05Fm0i
         xCgOcwIR1NmZet+WpTRaYiqWsAg/VrB+ddiwTGLsdaYzrzdzv4h7A/YUmENy+Qv4MFHT
         Kgmw==
X-Gm-Message-State: AOAM531EbZC9U5vHjeoIrQdwcBYsBo3Dkwz5jB3zqwIGKkq7XB4Ex1MJ
        A/49Itnlt84zBnK2C3w3t37XVA==
X-Google-Smtp-Source: ABdhPJxL55uYLzlLBONLZRKY3c1FonDeJ3FtOdbAxVYVL+2eHBP7EPjqAldCxGZF7Kptg6CqOMgSAA==
X-Received: by 2002:a63:175e:: with SMTP id 30mr23397809pgx.48.1620625151365;
        Sun, 09 May 2021 22:39:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id gw7sm10270030pjb.57.2021.05.09.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 22:39:10 -0700 (PDT)
Date:   Mon, 10 May 2021 13:39:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <20210510053904.GB4835@leoy-ThinkPad-X240s>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, May 07, 2021 at 01:02:35PM +0300, James Clark wrote:
> 
> 
> On 07/05/2021 12:58, James Clark wrote:
> > There is an intermittent issue on Trogdor devices that
> > results in all Coresight timestamps having a value of zero.
> 
> I've attached a file here that has the issue. From the dump you 
> can see the zero timestamps:
> 
>         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
>         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
>         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
> 
> This doesn't have an impact on decoding as they end up being
> decoded in file order as in with timeless mode.

Just remind, as Mike has mentioned that if the timestamp is zero, it
means the hardware setting for timestamp is not enabled properly.  So
for system wide or per CPU mode tracing, it's better to double check
what's the reason the timestamp is not enabled properly.

IIUC, this patch breaks the existed rational in the code.  Let's think
about there have 4 CPUs, every CPU has its own AUX trace buffer, and
when decode the trace data, it will use 4 queues to track the packets
and every queue has its timestamp.

  CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
  CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
  CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
  CPU3: cs_etm_queue -> ... -> packet_queue->timestamp

The issue is if all CPUs' timestamp are zero, it's impossible to find
a way to synthesize samples in the right time order.

[...]

> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index b01d363b9301..947e44413c6e 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -320,7 +320,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
> >  	 * which instructions started by subtracting the number of instructions
> >  	 * executed to the timestamp.
> >  	 */
> > -	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> > +	if (packet_queue->instr_count >= elem->timestamp)
> > +		packet_queue->cs_timestamp = 0;
> > +	else
> > +		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;

Actually here have two situations: one case is "elem->timestamp" is zero,
another case is the overflow for "elem->timestamp".

So the change should be like:

   if (!elem->timestamp)
       packet_queue->cs_timestamp = 0;
   else if (packet_queue->instr_count >= elem->timestamp)
       /* handle overflow? */
   else
      packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;

It's better to think about how to handle the overflow in this case.

Thanks,
Leo
