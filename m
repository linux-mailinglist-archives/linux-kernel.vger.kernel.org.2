Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0633D5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbhCPOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhCPO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:29:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF75C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:29:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z2so7555013wrl.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/67JlL4XAW5mzmo5zvI5lnSjesASdzJ288R/r/boih4=;
        b=Rl1e1sgSA+j+wW40O0525WMi6vFtI6NhJ4n4bpyu3tI/m7gFZxqJ5KB6gt3G7RDN3n
         7LAbIs6WzuY1PMr78vgdfkz1gyq8EHfnqojbe82o+hpz+1pCYB9hv+KNrjZUAGiqKYaR
         fEun6V4QrR+U7Xt1n1pGAdYiWDt7kHGGf8AVQ4MCmR4hwWMoyHnPeSjYo7NLXkvS0YAq
         a8qHyXM8X58Z0bm1HSDvm2QFJ+fdR+FFPpMS6MV5dKjzAWq+0LtspyDZjPUfnyotQtTT
         I5XzyN9l5359/xLD9LIpeCUKV6OWLH10lD0A/T5jwakEUOD3hiatqmjLbb4aG+y02a23
         xmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/67JlL4XAW5mzmo5zvI5lnSjesASdzJ288R/r/boih4=;
        b=lmJwWKp0dLzzKvodIp73nSIa3lNKab9Ki7ggZjCP1tSZZJtaVKUFBMLMwd0L5072Ov
         yQaqsZEDS3EWYjrfs7Gw9GZisWSdzXSoaMYsR0JY5swhtgEJ8HK0pgx9wCKr9g/RmFTD
         L67drxzX+AD7T9zjTiaLLE6Iw7WMWVfD1GJirrDNu8Iik66I038quC1kfqfQkZ1x/b9u
         U3wI5Aeb2H/VN8jr0Tl7cGpaz+xmC//moJ06JU9VWIniGDeyXahf6DQGDp6xHh/GETgA
         pfz1XGt2pgtogY7Yi+lTZ8pNd2rIaW//Tb7tpedWE3ATGP4ac5mD/Az3bybpP6L63D8q
         S+Hw==
X-Gm-Message-State: AOAM530oM461KOW2LEj1EJ5QqiOXm8H01c4G7FQFFc4owqCrLOMeMkQz
        4D3MjHlU0N6ofLjK1OWEHxXWrA==
X-Google-Smtp-Source: ABdhPJyar0PDtR9PziUEdK0q4Lj3lv5hEyxzPSqinrBmYUkeCvkWvc7ADuJUVK9+9pY/pIHWlS9hmg==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr5266544wrn.255.1615904973496;
        Tue, 16 Mar 2021 07:29:33 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id u2sm22610401wrp.12.2021.03.16.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:29:33 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:29:30 +0000
From:   Quentin Perret <qperret@google.com>
To:     Mate Toth-Pal <mate.toth-pal@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
Message-ID: <YFDAyhjPEsnZ4N3P@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
 <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com>
 <YFCqYT3Ib8kAN7/c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCqYT3Ib8kAN7/c@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Mar 2021 at 12:53:53 (+0000), Quentin Perret wrote:
> On Tuesday 16 Mar 2021 at 13:28:42 (+0100), Mate Toth-Pal wrote:
> > Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, and
> > the resulting memory type would be device.
> 
> Sounds like the correct fix here -- see below.

Just to clarify this, I meant this should be the configuration for the
host stage-2. We'll want to keep the existing behaviour for guests I
believe.

Thanks,
Quentin
