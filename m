Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C8402E33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbhIGSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbhIGSMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:12:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:11:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f129so26701pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/23xqaes2XTEieQoEC3hXOVOrS1/VG6sVUwEzA4poY=;
        b=I53v0vNVcXjLUAzgN6FABSj/CpajH90TchdbeflSijyCy/S5z85IqohRum5yaNlzq3
         6yyxJ7b2BJlYRuWxWGiRgrUPTmMviDqWUtIh+vm1yp44d5oq0Trnw1QkiRCoq4NpLTVA
         YBbHyOX3+1JOgv9WN/11gNZTK6Nwjf3Dtt/co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/23xqaes2XTEieQoEC3hXOVOrS1/VG6sVUwEzA4poY=;
        b=gHP18qJHCvrfR6ABD1lpc8ULPdEa9iV7ZlnxMu/VRkK2SfWoSTLayQPiyBtnTfXmCL
         Dvbjin/GUeUhopkbFDTzxSZIfRcDxbmyonIOTS+UhUdXQ5x35ZjFjKpJXyvM6mC/o2Jn
         S6wyycEVnjT1aTEk4dDqVb6Sx6Ht9vidOGNNl0mMD9qaHGrGKnrkCmrlRbKFnHl0TAuy
         jztxnV6NrPfs03mMY4+UPXs5sQXIgky5ljMyrCDzK8hycbYKVhD4pQUH/IeBmylDa8kI
         sVDPSP/R0Av0mSOgBq+5KutzKjZRUY0C5N6pVQ0XgMNOL/yQeyfEJmEPSYzC8XCYhzhM
         r51g==
X-Gm-Message-State: AOAM530/su5fCC3FkU8vYIBLF3ykNiJ4dEMYE7+4x4NITg/zw4CSX3LX
        FoE3k8abq050JLTL+O+qRFlP3w==
X-Google-Smtp-Source: ABdhPJwvTjM+WRKARPvOY9pppfCCr5cnbhUPMqU4TuILvTxoMwyy8qFcltQrhIaNJAzdDsSAdOYp2w==
X-Received: by 2002:a63:5902:: with SMTP id n2mr18155671pgb.305.1631038305244;
        Tue, 07 Sep 2021 11:11:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c133sm11158629pfb.39.2021.09.07.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:11:44 -0700 (PDT)
Date:   Tue, 7 Sep 2021 11:11:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Chrisanthus, Anitha" <anitha.chrisanthus@intel.com>
Cc:     "Dea, Edmund J" <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/kmb: Avoid warnings on impossible plane_id
Message-ID: <202109071107.1E6C9DA5@keescook>
References: <20210825181807.1138053-1-keescook@chromium.org>
 <BY5PR11MB4182ABD607EB99C1F68777928CC69@BY5PR11MB4182.namprd11.prod.outlook.com>
 <BY5PR11MB4182FEB7263045FC3855723B8CD39@BY5PR11MB4182.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4182FEB7263045FC3855723B8CD39@BY5PR11MB4182.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 05:32:53PM +0000, Chrisanthus, Anitha wrote:
> Hi Kees,
> This patch https://patchwork.kernel.org/project/dri-devel/patch/20210728003126.1425028-13-anitha.chrisanthus@intel.com/ is pushed to drm-misc-fixes. This change should fix the below warnings.
> 
> I apologize for all the inconveniences. 

No worries; thanks for the heads-up!

(sfr, this change should fix the warning[1] uncovered by the KSPP tree now.)

-Kees

[1] https://lore.kernel.org/linux-next/20210830184429.1ee4b4d8@canb.auug.org.au/

-- 
Kees Cook
