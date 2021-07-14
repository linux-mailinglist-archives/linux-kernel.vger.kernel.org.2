Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242203C7BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhGNCWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbhGNCWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:22:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A2C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:19:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y4so590383pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUWPTzB4dLR17/T5lZ7IYCIE7LvDfGsZbPME2WfdaEQ=;
        b=Skmc4/PTwW2vYOAvkxNEp/sYehALwIe3vbYmis9pp8B8s8+wKbwKLLkS2x6Uw0hnu3
         0svGx8KcIUZK3SigWkrI1LBoqGu1Gr/zfFuUkQYY1z+GkIQJyZmhGqeDKIrbtkGJkA9/
         pV4SFmb6Em4EJHyfkvu52ERl3YZgKA2kl4gFPSlJlROoiehQQIfHPqiC99fxTZvdJuLd
         EiLrpiwCuiSYVnmy8yfgjiy36rHG6vuajRXQqWXRpeItlXDPp/KYqloeAmd8U0ejyp7Z
         +rOKfLdJcEVKX2jUAiZJFb1dHgMx8bLQzO3xc3+iNg0jTqpv8EwU3a8X/RGDZ9tV/fe8
         53JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUWPTzB4dLR17/T5lZ7IYCIE7LvDfGsZbPME2WfdaEQ=;
        b=fYmu+S1NS5WA8xFDqsEJMu1+ltc3eNU6a3sdeC2gwC8LwQQ7uk7rrCdsGxnlkXxVYQ
         fJzPs0Y8ziPjSMLk/IEvfEx7erYyf6rZDgBHyCAUC+bBPy40glgxwAbyXKIO8GnNz2J1
         8Dmj5AaQtTzz8B4f+vNmKstG/c8TuGmo/Bc1kICMqHOrug7Dh5DP4p3F0epyyL2qPWJu
         PIfViB6fpHB7rT0liI6k0lOSOCn4ghDG6e0BMcVKaPChbOs960qcTf25XRZ7HgAv9r5H
         SwiVBZkkpTSCXR5wG2nTyBa4lQII5NBXK3TtAIaLsruGiuHTToeUTEDA/DAYcVKGRD3G
         1QuA==
X-Gm-Message-State: AOAM530vzY/E+o1e2+x4Ge+jWER7rrdAY1dMwb27AuXiH3pkQQba4Ck7
        OSkwFaIcuth0qdjPrj+X4v3+pw==
X-Google-Smtp-Source: ABdhPJxLOPLEDHG4baKqARncau1utGS0ltDshGrrtQ4HLM6pZ8LZIXvVGdAGINqm7KHcuA2FTBkJpw==
X-Received: by 2002:a63:6e09:: with SMTP id j9mr6980452pgc.275.1626229167125;
        Tue, 13 Jul 2021 19:19:27 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id a6sm437140pjq.27.2021.07.13.19.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:19:26 -0700 (PDT)
Date:   Wed, 14 Jul 2021 07:49:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714021924.uob5wrasipzhbyrj@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-21, 13:34, Rob Herring wrote:
> On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > We already do this for linux-event-codes.h and so I thought it is the
> > right way of doing it :)
> 
> Humm, maybe it's okay. Please double check then...
> 
> > Else we can create a new copy, which will be a mess, or use hardcoded
> > values.
> 
> Though you may not need the header based on what Arnd and I have suggested.

Yeah, we may not need it at all. New node or not, reg property will
get converted to a compatible anyway..

Thanks.

-- 
viresh
