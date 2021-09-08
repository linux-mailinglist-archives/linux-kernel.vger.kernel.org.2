Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21BD403F02
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349640AbhIHSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347196AbhIHSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631125254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Odli6n5utx6iQ2PGhXktTIOLzBm1o5C6yHyZID46228=;
        b=F/9eI3jynW60VU50pwr7HQTB7XJfiHiLnUDtj5e6mEs8vHw2CkHWube8qHIaswxD+XrZj5
        hG1AqUutx6std+7Af2Q1HDHCcBPsVacfktNTw+Uq3iZJ7R8Jkp9IWvzaalDYhp8LQIpj+I
        qp1Ip4mzB9UFd58L4+UrAmuGpwheREI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-rr0CD_CoOhS1QMyd-CwEew-1; Wed, 08 Sep 2021 14:20:53 -0400
X-MC-Unique: rr0CD_CoOhS1QMyd-CwEew-1
Received: by mail-qv1-f69.google.com with SMTP id a10-20020ad45c4a000000b0037774ba4e8bso5494024qva.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Odli6n5utx6iQ2PGhXktTIOLzBm1o5C6yHyZID46228=;
        b=pIjFvEaqY1Xh/WCMWTX8VgVUcSUHHp5hf5PahhDyerruFsbWWvIry6bmZpEIIdWr1k
         HWuoKvQ8JrfDL8Kji+vscyKxZxNfgXoeZ7ImPwvGEPgjIzWY4Scx+F1ZLdf+rQMVIDM1
         gdvyFV8+Kv2u1gs3A07M4NLwPtCGzvOcgmiFpFUad9XyJOxs1rT3EKIEXoqxCwXStOQt
         x6H5DJ+Q8kFZmUgBu0p+dkoynnhrjocmt/Vu1EHD2TsoUO+KR9c5aAiZoHuK0GHI1WWP
         53/ib6QdASJQAa1dYudQxU7idqkVLoz4WRTwMWXEZVtj60tJC9TkhJttWPra4L8Cr4Sz
         E/4A==
X-Gm-Message-State: AOAM531mmjTCvxEQxKQ38mXQEJgUPLydXy4b15JoAehVq/ogr2PzcI2Q
        CMKd0G8ETrKujipIjGImpwGvIDclUQM0nBIEOex2Y2WNfRBeXN7eDbjP2llF4sBtHlkpF4A9IE2
        EznEifPsibzjPr/1GwC2Az13t
X-Received: by 2002:a05:622a:5d4:: with SMTP id d20mr5060605qtb.376.1631125252895;
        Wed, 08 Sep 2021 11:20:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPaeAvoUaD+xtpB8KwHR40y9qXCvGLUPqMAf4ghrKiqlK0Iu9Fa98T3Ot5hCZoS0vnTrw1Vw==
X-Received: by 2002:a05:622a:5d4:: with SMTP id d20mr5060576qtb.376.1631125252608;
        Wed, 08 Sep 2021 11:20:52 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id r4sm2069337qtw.5.2021.09.08.11.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:20:52 -0700 (PDT)
Date:   Wed, 8 Sep 2021 11:20:47 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     "Moger, Babu" <bmoger@amd.com>, bp@alien8.de, bsd@redhat.com,
        corbet@lwn.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Message-ID: <20210908182047.lcor52bjzrt35gsq@treble>
References: <20210812234440.tcssf2iqs435bgdo@treble>
 <20210902181637.244879-1-babu.moger@amd.com>
 <20210903000706.fb43tzhjanyg64cx@treble>
 <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
 <20210904172334.lfjyqi4qfzvbxef7@treble>
 <35a32225-25d3-88eb-f427-14c93c38c97b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35a32225-25d3-88eb-f427-14c93c38c97b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 06:15:53PM -0500, Babu Moger wrote:
> >>> Because trying to give them separate interfaces, when PSF disable is
> >>> intertwined with SSB disable in hardware, is awkward and confusing.  And
> >>> the idea of adding another double-negative interface (disable=off!),
> >>> just because a vulnerability is considered to be a CPU "feature", isn't
> >>> very appetizing.
> >>>
> >>> So instead of adding a new double-negative interface, which only *half*
> >>> works due to the ssb_disable dependency, and which is guaranteed to
> >>> further confuse users, and which not even be used in the real world
> >>> except possibly by confused users...
> >>>
> >>> I'm wondering if we can just start out with the simplest possible
> >>> approach: don't change any code and instead just document the fact that
> >>> "spec_store_bypass_disable=" also affects PSF.
> >>>
> >>> Then, later on, if a real-world need is demonstrated, actual code could
> >>> be added to support disabling PSF independently (but of course it would
> >>> never be fully independent since PSF disable is forced by SSB disable).
> >>
> >> Do you mean for now keep only 'on' and  'auto' and remove "off"?
> > 
> > No, since PSF can already be mitigated with SSBD today, I'm suggesting
> > that all code be removed from the patch and instead just update the
> > documentation.
> > 
> 
> Hmm Interesting..
> Just updating the documentation and without giving interface to enable or
> disable will not be a much of a value add.

It's also not a value add to create controls and added complexity for a
feature which nobody needs.  There's no harm in starting out with the
simplest possible solution, which is no code at all.

Code can always be added later if really needed...

-- 
Josh

