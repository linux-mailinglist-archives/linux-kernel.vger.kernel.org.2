Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA13F6D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhHYCQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:16:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65634C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:16:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e18so7963853qvo.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=WylDhi10Z8INFhL3TLkCqJfdX8oHPgpvkgps3lJl60Q=;
        b=Dm6zIXTcEx4Xo+wY3AjkZdTXi8XEcFbaJP/9B4N8a8yZIQgvI/dsujLL63KXM1Br3C
         og+1U8904fmFpDbpnhhwUHOQ4z3HrFKt3Ev/kW1TxWrlJ2MGOcySuz2VvOl7c0AKuk02
         xRRqM96wL1iEVlZHw/WhRbCfCDFEnincHgLm6uYQdtYMLd28n9GmY8tr/GrCH7k9ZXBj
         X7tA8fFtJOtdXpFjFvXov+RPVoMoeLjkSzhvvlC/kR7b2IziFPejXsnCt0qF0fUWSRPb
         f6GjvLUCHSl0S+6DJwmpeDZfqQOV0zEV4bHyR4590B7O5p4CxNMPI4+7uiQA9UbjhsZZ
         odMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=WylDhi10Z8INFhL3TLkCqJfdX8oHPgpvkgps3lJl60Q=;
        b=DEgNpVtnRu9350w7iYVBxAz7DLMRRO3cEc3oz02tBkXQBVkudptMH4VoxxpRR3UfmJ
         Tc0dCiQ2AEFkOwNVVIWm3gIWIvZcElnaxk7cj9VffkY3otgL176FGudft7J3MUMt7755
         P0gJMvMDUZW5825mPKzSCBVDHlmeym94HW1u4O/TV8i9VLxaNjomW/sx2l+8LlhSHWdW
         iYcOl8yVdxHVaEuJtU/kXhkbZJpDjlQGACWK0TTa4EJlstA9CvINGb/9mrvotKmOAj4M
         pxkCvaTxtJ47X0tIbQsx77M/OhAEsut+8Q2Ow6Fev/YE7VfUed0uwWlm1GjjTLVEuwLh
         IQfA==
X-Gm-Message-State: AOAM530xtOSt+TMIbXs9HIalAUvg2REJ7ZbZqWIppYOZEbepa08/h8bC
        wXUT0uvVUgWUgW0Y5SyroT5EEg==
X-Google-Smtp-Source: ABdhPJwr9U7AiEdRQzu7abC0Us/KAzIyt/x5xkh2gruBgtJyP184fAPKlNw/j6KMAUMuhl0bSIJRzw==
X-Received: by 2002:ad4:5b8b:: with SMTP id 11mr8164166qvp.51.1629857766511;
        Tue, 24 Aug 2021 19:16:06 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id j23sm11479011qkl.65.2021.08.24.19.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 19:16:05 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
In-Reply-To: <20210824091430.20367-1-sjpark@amazon.de>
References: <20210824091430.20367-1-sjpark@amazon.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1629857764_8510P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Aug 2021 22:16:04 -0400
Message-ID: <8784.1629857764@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1629857764_8510P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Aug 2021 09:14:30 -0000, SeongJae Park said:

> > > ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> >
> > That's a different patch, am working on fixing that one now..
>
> I didn't take a deep look here, so I unsure if this is an appropriate fix, but
> I was able to work-around this issue for my use case with below change.
>

>  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);

Aha.  That's the part I wasn't finding.  Would you like to submit your patch,
or shall I send it in with a "Suggested-by" for you?


--==_Exmh_1629857764_8510P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhJafkAAoJEI0DS38y7CIczX8IAKXfYLPoHllQ5kfFFy76I2aW
Fo8vHcnLFDx6LzS+DPLw+uFnvfUvJq0+H+zvB+x4h40s/xlG3IWAsrtkqds4n1d3
8/dD9/2jHp+qxQ37Yon9ODWtwalXv4zkFkcGwz+zAlXq05iu8k6ZI+1e4LMg3daJ
jxD7miWYWjNkQwvgrzuYv3Mvuqb266YTB/FZkn9n6mt2vhLd6WBSFORF8XIboO/d
cO5oKBd985k4MD3vQI948VRuoswKLAHM9BZtzvKOzqTZGr31l9T7MRWk+u1aWqI8
7pDduE3CMPGlXvJiPiukhVK9amxPhCXIH5lgoWskJ/VgHH8k7FdsOuPvFvRyKeY=
=DCep
-----END PGP SIGNATURE-----

--==_Exmh_1629857764_8510P--
