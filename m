Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DC3A2955
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:29:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92157C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 03:27:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l2so1667056wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5aXyLRP/eJaqROTiZOY62KJX2lcnCHy3+UR6w6g5OIY=;
        b=hisf/PthPnJ1wQONIQvT2dPxd0cFwZZmp2vn+LfRkAHhJwXyK4si519X2EsHinmaBs
         iHcMgn/L8sJ4ydX7swrAtEmj+hK9nh/lMdbXTk5Ctjt7i1XO+bbiDB+/lbwCs7MuAv+8
         JUIVu6m2LbCx+veWgPyGeoX3dGA+Su8pEdDdjFwfldwyNdx4IsISzCERux/dBlCEi6o6
         u41YrBMJk1R++qBySPspB79bbobTSqG8+HHtHLCPTWKk2voA3RRXsft5JlU3vsWD2/ah
         VeLioXMYVOJ/rYYSSbTr1iJPGugXWrcI62JpKuYpf1B6ta0YJQ7dnS/5bAgbaX5tWMPd
         QjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5aXyLRP/eJaqROTiZOY62KJX2lcnCHy3+UR6w6g5OIY=;
        b=P1x9Fw/uUJxhfzvQQ7bv2P1RrJa5tV9WA3Zsr2k38CRaM82bxRm8j/sOPfNmDa/bX5
         iIVxWbJx0CSbCcqbbvEjmmR7EVWCg+xEVXH6hb4AOGABkUxGugQfPgm2Z5Zwl50n8+19
         jcIFAZNCbFzFFXOH4pkp22MqTSpA0DnEGKbtkEceIKEZjoIve2umvmgbwuZ9Wv8mpxe3
         db6ovGRQiFEHfEMgE8jwHJLO/xtctLVq1U2VqqitcvzhBqhDs6UTsTyWOeXBg/N1i9nF
         ufdb6Z8qjsUZfpDtPIyVoB3l3N/lKVVQv35sd7LDdDdYvLya1yO5VJHMb/zAE5+gM79y
         cxqw==
X-Gm-Message-State: AOAM532cdyM9om8eUK1hqAI44XJ74+tVMfXqMwyAW5ftNk0LZ5w7TiDm
        KmQe987XTaRVI9EjRLqWmIRWuQ==
X-Google-Smtp-Source: ABdhPJzpoJHGQDJxjJ984PLFDcplqh2G05FJ8zsUYoqrw8e2ClWm3Da4Se9RiKrUYnv0nqhigjldeQ==
X-Received: by 2002:adf:f946:: with SMTP id q6mr4440727wrr.283.1623320855827;
        Thu, 10 Jun 2021 03:27:35 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id g17sm3013306wrp.61.2021.06.10.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:27:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:27:32 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YMHpFObpW/VzrTW3@google.com>
References: <20210609143339.1194238-1-qperret@google.com>
 <20210610100039.2gvnl3lu6o2hu5yj@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610100039.2gvnl3lu6o2hu5yj@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Jun 2021 at 11:00:39 (+0100), Qais Yousef wrote:
> On 06/09/21 14:33, Quentin Perret wrote:
> > The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> > active task to maintain the last uclamp.max and prevent blocked util
> > from suddenly becoming visible.
> > 
> > However, there is an asymmetry in how the flag is set and cleared which
> > can lead to having the flag set whilst there are active task on the rq.
> > Specifically, the flag is set in the uclamp_rq_inc() path, which is
> > called at enqueue time, but cleared in the uclamp_rq_dec_id() which is
> 
> It is actually the other way around. It is cleared in uclamp_rq_inc() and
> set in uclamp_rq_dec_id().
> 
> > called both when dequeueing and task _and_ during cgroup migrations.
> 
> Is it cgroup migrations or when cgroup uclamp values are updated you mean?
> 
> It is worth being direct and mention that uclamp_update_active() will perform
> uclamp_rq_dec/inc_id() when the cgroup uclamp values are updated, which would
> end up with the flag set but not cleared in this path.

Yep, that's the problematic path.

> > 
> > Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> > things remain symmetrical.
> > 
> > Reported-by: Rick Yiu <rickyiu@google.com>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> 
> With the commit message fixed.

Ack, this commit message is a mess, I'll rewrite.

> Reviewed-by: Qais Yousef <qais.yousef@arm.com>


Thanks!
Quentin
