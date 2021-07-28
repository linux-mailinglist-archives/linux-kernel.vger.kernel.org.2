Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F034D3D9413
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhG1RJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231624AbhG1RIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627492129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZCIhPQxRBE36WyC9C6HRgZKGU4Bb0HiAlaS/qG8sOa8=;
        b=U6WHIOjnW0BTzcMpaPFHkec2YTZZvrNkbxk9wRYIm8ThRgPMlip5hu1Va7qkrXMOMf5eoU
        p5r2LFNWf99q1RLblqeyTVef49Q0R1Q4z0sbOGE5YutGfXmfC1Bnqlar4mjfb+NYZqlni3
        tVITK+EBZ0YTm3ljJhyLavlZ2O9y1z0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-5VnAyghvPPSm0mjDsSPe0w-1; Wed, 28 Jul 2021 13:08:48 -0400
X-MC-Unique: 5VnAyghvPPSm0mjDsSPe0w-1
Received: by mail-wr1-f72.google.com with SMTP id u26-20020adfb21a0000b029013e2b4a9d1eso1174494wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZCIhPQxRBE36WyC9C6HRgZKGU4Bb0HiAlaS/qG8sOa8=;
        b=dozyJXx6qWg26kgLrXmRtcjvphi4aqDfatkRzUcaUSS/+P/rIzAzoMTu+0jJxv1iJE
         fh2bczgbFyhY6khu8GDGfO8oF4g9YNj9rlEWHSyYFFk37GVPs0SlgjgtDJI5IiFJPfP1
         mt4DHolbV4e1V9KoWbklzxANm71kfM+5qKxUHLhjN/9IrPQLlwg02vWVkbo8GMT4jkCx
         kdAT1M3pe4wJVxbvJViOZXrsNVu2M9PLDKvNIPYYd2RzF4HFxORKMaQT6sGYviECK7rG
         dMR+sQ785W4L3+Yk1WEpWF8Uix0w0MeL8iewatFBNs7wohpN6HgH3IPAKvUxv1p7s0Vj
         wwoA==
X-Gm-Message-State: AOAM530lrIf18fiZ8GqsvZHVUr6N0s3+J0kch29CDc5hVWRgzKa1Afkp
        0fvmgzzwlvmJuhDTmLy9ZGkSkI1DPkK8pC7nw1jZMR+eGi9hpMAnT+gT1j0Zwl2Sh0TWx2W1dyX
        0Z4aBtmG9utYUTHREMGmT4K/I
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr684143wme.112.1627492127107;
        Wed, 28 Jul 2021 10:08:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYk79Qk0VRWyXmQWaG2mg+xFgU4FjQWreqjMPX2GyKfFNK5iGCeP8j9APtHtnKRueB8vNZOw==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr684131wme.112.1627492126875;
        Wed, 28 Jul 2021 10:08:46 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id u11sm401659wrr.44.2021.07.28.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 10:08:46 -0700 (PDT)
Message-ID: <441d94dbd93443839d31fdfe5f6048de35b0d7b0.camel@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 28 Jul 2021 19:08:45 +0200
In-Reply-To: <20210728131610.GA11900@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
         <20210727104119.551607458@fuller.cnet>
         <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
         <20210727110050.GA502360@fuller.cnet>
         <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
         <20210727130930.GB283787@lothringen> <20210727145209.GA518735@fuller.cnet>
         <20210727234539.GH283787@lothringen> <20210728093707.GA3242@fuller.cnet>
         <e0135b88dad323d0abd1ce05081e0b554421af7c.camel@redhat.com>
         <20210728131610.GA11900@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-28 at 10:16 -0300, Marcelo Tosatti wrote:
> > For example, let's say we introduce ISOL_F_QUIESCE_DEFER_TLB_FLUSH, this will
> > defer relatively short IPIs on isolated CPUs in exchange for a longer flush
> > whenever we enter the kernel (syscall, IRQs, NMI, etc...). 
> 
> Why the flush has to be longer when you enter the kernel?

What I had in mind was cost of rapid partial flushes (IPIs) vs full flushes on
entry, although I haven't really measured anything so the extra latency cost
might as well be zero.

> ISOL_F_QUIESCE_DEFER_TLB_FLUSH might collapse multiple IPIs 
> into a single IPI, so the behaviour might be beneficial 
> for "standard" types of application as well.
> 
> > A latency sensitive
> > application might be OK with the former but not with the latter.
> 
> Two alternatives:
> 
> 1) The pattern above, where particular subsystems that might interrupt 
> the kernel are enabled automatically if the kernel supports it.
> 
> Pros: 
> Applications which implement this only need to be changed once,
> and can benefit from new kernel features.
>
> Applications can disable particular features if they turn
> out to be problematic.
> 
> Cons: 
> New features might break applications.
>
> 2) Force applications to enable each new feature individually.
> 
> Pros: Won't cause regressions, kernel behaviour is explicitly 
> controlled by userspace.
> 
> Cons: Apps won't benefit from new features automatically.
> 
> ---
> 
> It seems to me 1) is preferred. Can also add a sysfs control to
> have a "default_isolation_feature" flag, which can be changed
> by a sysadmin in case a new feature is undesired.
> 
> Thoughts?

I'd still take option 2. Nitesh has a very good point, latency requirements are
hit or miss. What's the benefit of enabling new features on an already valid
application vs the potential regression?

That said I see value in providing means for users that want all
features/modes, but it should be an through an explicit action on their part.

--
Nicolás Sáenz

