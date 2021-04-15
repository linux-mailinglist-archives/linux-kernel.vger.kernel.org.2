Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2035FFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 04:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhDOC0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 22:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDOC0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 22:26:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565AFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:26:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d15so10795243qkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pZKbTgJnvPwOaUYzf3pb93PEk5cL8bWVMYrrjP/xOH4=;
        b=Qlpt5ZpSWroQ7rYeDQVSrQSdxxEXRRo69YO9IVS5fWVDNoasfnswUPnJgyknFRHyDd
         EpBBKrWcPjtGfeDigjaYQvwaKoJcd4+5P6cv7Qo3niTww6YLT7lbBsEVlVnW5NX+T7ED
         VENGLJofkUiQI8XMMdajfn2VlpdFYx8nw6DCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pZKbTgJnvPwOaUYzf3pb93PEk5cL8bWVMYrrjP/xOH4=;
        b=MMqdDPsKmFJVx17RHxJEoFN63GHUbTw790T4bflGXuOryKEr2Ey6JxfmKKJVMvWB3i
         x3q9b9vhUh32GFeQvjuGCgkx0ZEsj3KwLZ/oFvynH3vPBE2Wg3XypXWpNmMoj9jGpLTO
         LCdRlrZcfjbnrZwNuLoC7XTekYvr/UVzqvCuPRwy8yAO7XtDlfy/d3mN2rkGQiLZ+dxO
         LN10t2VebIoaCZxbELmLIN7byCLjTB5Na1Ozw5HZyq8e3fdsaNxxadX0zzMG7O2CJRN6
         nH85K2jPOECvDSpN93rZ1bO06ZcHq7J04lzffTuhSIt/xOJJTvG+eiXuNU1jE/aNi3yH
         JyLQ==
X-Gm-Message-State: AOAM531L0G/3jEBJG7TBXzXMYM4+J7poDxaPePjO0X5rzHTHS5S09bWZ
        6j2sXjpA3lylAauNNGjok1dnK8Rv4py9deg4
X-Google-Smtp-Source: ABdhPJy//y8HLOaczheOwyPBn4LzZ8Gv3A4UCYqLYLsnHCfJ4RS+zPv5nnkiQ1sc5Y4PVVX7atqKkQ==
X-Received: by 2002:a37:a52:: with SMTP id 79mr1470698qkk.162.1618453560475;
        Wed, 14 Apr 2021 19:26:00 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id m2sm874009qkc.14.2021.04.14.19.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:26:00 -0700 (PDT)
Message-ID: <e596d27c0cae71685bcee8eef61f781ffdc42e11.camel@kepstin.ca>
Subject: Re: [PATCH] Fix turbostat exiting with an error when run on AMD CPUs
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Date:   Wed, 14 Apr 2021 22:25:58 -0400
In-Reply-To: <20210415022600.GA341188@chenyu-desktop>
References: <88d11c19e662f67ae492eb4b93e12e1b24e68c1d.camel@kepstin.ca>
         <07f5e30a2af1674f0a2f8995641bbaaf64e47d34.camel@kepstin.ca>
         <20210415022600.GA341188@chenyu-desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-04-15 at 10:26 +0800, Chen Yu wrote:
> Hi Calvin,
> On Wed, Apr 14, 2021 at 10:08:07PM -0400, Calvin Walton wrote:
> > On Wed, 2021-04-14 at 22:05 -0400, Calvin Walton wrote:
> > > The current version of turbostat exits immediately upon entering
> > > the
> > > main loop, with error code -13. This is a regression that was
> > > introducted
> > > in these commits:
> > > 
> > > 9972d5d84d76 tools/power turbostat: Enable accumulate RAPL
> > > display
> > > 87e15da95775 tools/power turbostat: Introduce functions to
> > > accumulate
> > > RAPL consumption
> > 
> > Ah, I failed to check the mailing list before sending this patch!
> > Terry
> > Bowman's fix here should probably be preferred:
> > https://patchwork.kernel.org/project/linux-pm/patch/20210331155807.3838-1-terry.bowman@amd.com/
> > 
> > My patch was simply the minimum necessary to get turbostat working
> > again.
> Thanks for reporting this. We had a fix for this previously at
> https://lkml.org/lkml/2021/3/12/682
> 
> I'll check with Len if this patch has been merged.

Thanks for checking.

I notice that the linked patch doesn't include the other part of the
fix - correcting the type used for the MSR offsets to off_t (the AMD
MSRs at 0xc0010299 exceed the range of a signed 32-bit int), so if that
patch is in the queue to be merged, I can submit the off_t patch
separately.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

