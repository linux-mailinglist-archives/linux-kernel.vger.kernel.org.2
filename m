Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69F3ECF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhHPHo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhHPHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:44:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C79C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:43:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r6so22207663wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZqL0RGrRiTOD68QIEn9gbIo3HjYGdm7ebHQq8KAmFwI=;
        b=m2U/rhpi57WfQtcrjZShp+0U0iUZrCIeIlL3o+QA8dx/Znh9WXz8YKHNBycvwTff6B
         r4CpSM11RJkPX15PcDtkD1u6NuCBghhqBlHHuvr+w8poh3t2NnI0mTo3iFGoa/98mzSH
         ik1T10K8BXVUrfQdQgRv1wdMsSWqj736m0eSdVijmoOL1EQngLvxrUEjW6Fh9blV1N8b
         300O70y/IItVEuTAQQQgu8sZU55xGJbDcCTw1XFtcOr0dL8Dv1w5etRJXXXiSVEOaQke
         h/hJJxCqEjMRBo93LKo+hg2SW1l+gz6MgsBHvdWDbUNxzzTA1pk3hrZNffZ7713vpqlr
         Pfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZqL0RGrRiTOD68QIEn9gbIo3HjYGdm7ebHQq8KAmFwI=;
        b=DtS1usjGCwCJgDaVPN2sdReRCZERTEEc5W802pA9vWEZYnVo73aE91oWc6Hj+sr3Ov
         xTCjirX3+ZxlJUOP6boD68T8+g1qH3H0GtpgIEnj6lEgmm3FK2QSvEaodqUc0AHpygbU
         eAL5U8ICcUmaKNZOJgEA9Pt2lwfL+7qaPPrvf3+KaNPg3GyBath7hq9qQlBGdyvR8mvN
         bbUvG6BkaKgMUGrJyTcc7CudTI9zeffbWtWOcD3FKjGkKw2l9VpjRHWWQTh5eRVdc+iR
         csgOcQfhqSj7w8lxREhP+i9iNeckw4oBqmlP3i2anV+/uaaZctmkBO9MtLB9JVOm0lfK
         xj2w==
X-Gm-Message-State: AOAM530Yh6qD6/flW1ZS3bEykFnycv1zh3/JfBNhahzBGVtG0/h321kH
        tca2GMDgUeUVa7sv/W24XeOlRg==
X-Google-Smtp-Source: ABdhPJyN5it7Ymm9ZTJeLU7IN52N9VqFMrVEYXMmgmJ++xpct2mZFk4mzNlgx1OKoKqKKCLP5rTY8g==
X-Received: by 2002:a5d:634a:: with SMTP id b10mr17103251wrw.305.1629099832597;
        Mon, 16 Aug 2021 00:43:52 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id f10sm10391869wrx.40.2021.08.16.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 00:43:52 -0700 (PDT)
Date:   Mon, 16 Aug 2021 08:43:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: Bump debugging information print
 down to KERN_DEBUG
Message-ID: <YRoXOTRstjKEojuA@google.com>
References: <20210617073136.315723-1-lee.jones@linaro.org>
 <8735rhs7n6.ffs@tglx>
 <YROC5avuGQyBIpmD@google.com>
 <87fsvgp4jd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsvgp4jd.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021, Thomas Gleixner wrote:

> On Wed, Aug 11 2021 at 08:57, Lee Jones wrote:
> > On Tue, 10 Aug 2021, Thomas Gleixner wrote:
> >> > @@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
> >> >  		 * If this happens then there was a missed IRQ fixup at some
> >> >  		 * point. Warn about it and enforce fixup.
> >> >  		 */
> >> > -		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
> >> 
> >> This one is clearly a warning as this should not happen. See the
> >> comments around that.
> >> 
> >> > +		pr_debug("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
> >> >  			cpumask_pr_args(m), d->irq, cpu);
> >> >  		return true;
> >> >  	}
> >> > @@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
> >> >  		raw_spin_unlock(&desc->lock);
> >> >  
> >> >  		if (affinity_broken) {
> >> > -			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> >> > +			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
> >> >  					    irq, smp_processor_id());
> >> 
> >> Maybe, but distro people might have opinions on that.
> >
> > The trouble is, even if these are real warnings, they have an affect
> > on performance on real products.  To the point where so much logging
> > builds up during pre-release testing, that it sets off the watchdog(s)
> > on some high profile consumer devices.
> 
> I'm fine with making the second one debug, but the first one really
> should not trigger at all.

Understood.  I'll follow-up with a subsequent patch and report back
with your advice.  Thanks Thomas.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
