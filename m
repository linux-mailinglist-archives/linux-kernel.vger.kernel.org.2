Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1783C203A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGIHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhGIHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 03:54:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185AC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 00:52:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so5467129pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9yEJ/RI8DyqTUqQc7qvFOA41xcGAb9AUJUpJSi1YCk=;
        b=hykJA/Js2Xkhhe70Ko9i6iWvtj5MCdYDu7B/4u+DpVpsKePBnWY5j4t4PmJ+/N5Tma
         i74pAgLdfgxkaGf4SgAwZgceXKJ7rvLOQBWSmhuTfRMGbGSTEGg8Y90WlqU6AxZc1+ne
         VnQDpGlScVjcXYoN01FMKeV5pUHPa6XpOQzAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9yEJ/RI8DyqTUqQc7qvFOA41xcGAb9AUJUpJSi1YCk=;
        b=H6MJXSUlPsksRRKYJqd+rDjk6Os5PPBbD7TR8sTde2K8LfFExh9gcW6nNmFBb2aasI
         Nxuwsv7cJwPaZ9V2qOmRgzHmF3PvddXy5h8TWikZZJHG2M+gchzcjujt7a9m5QlwitRY
         v48ci8pQiAlC08qRqGBCQun8bznOrTg7vV9CoshM+MEWCp5EpFWlyyK6Tvmuq8j4PDm6
         6jY2OkG36fVjEOid3C2mTjin4FLpaNqZ4NiqlOdLvKYXRd4uo7Xb3/13omW88GtU4NQQ
         9KvtYXP3L2lhUzKJjH1rf7FlwxV/upCjq8r2ErgAwD7GJkX2NwG8Nj/g0hxeCG43ti/N
         vzeA==
X-Gm-Message-State: AOAM530Bmbz2cgHa+4/xkRm1sQUpHaBbo1epPq1hFahMwXEHaS8ezqDQ
        9GUqbJfKnNPLSzx0gnpiFvhTGQ==
X-Google-Smtp-Source: ABdhPJy5Iba/1n9IqX8ohIsdLkvuWXlXJvMJv1c0Hhbuj+FFhPRYR/07l1fWcSHSalGaLyrQsw0tBg==
X-Received: by 2002:a17:90a:5d16:: with SMTP id s22mr36261212pji.48.1625817125628;
        Fri, 09 Jul 2021 00:52:05 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id 194sm5349713pfy.51.2021.07.09.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 00:52:05 -0700 (PDT)
Date:   Fri, 9 Jul 2021 16:52:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     David Edmondson <dme@dme.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
Message-ID: <YOgAIOBVhhD+on93@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-3-senozhatsky@chromium.org>
 <m2v95k2axe.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2v95k2axe.fsf@dme.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/09 08:39), David Edmondson wrote:
[..]
> > +
> > +static bool has_pv_vcpu_state(void)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	/* To detect the presence of PV time support we require SMCCC 1.1+ */
> 
> "PV VCPU state support" rather than "PV time support".

Indeed. Thanks.

[..]
> > +static int pv_vcpu_state_register_hooks(void)
> > +{
> > +	int ret;
> > +
> > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +				"hypervisor/arm/pvstate:starting",
> > +				vcpu_state_init,
> > +				vcpu_state_release);
> > +	if (ret < 0)
> > +		pr_warn("Failed to register CPU hooks\n");
> 
> Include that it's PV VCPU state hooks?

Ack.
