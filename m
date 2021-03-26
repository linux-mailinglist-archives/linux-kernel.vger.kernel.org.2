Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBB334A0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCZFIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCZFIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:08:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE8FC0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:08:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gb6so2034451pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t3Vz1DNN/DHoh2CZjLnX3X8cFqPZaAphuGqCqL7Zx98=;
        b=pbtMnjCGhkDhR19+oZWLz5/B02OypboZhdFMbOtPIvS2pw1zrbYUtCFvW9LzCWdzhp
         8/8d57T9EUokUZg+6ovNrDuE2Nos+ejaNl7Wlrfl21p8P53D73Sg070st5DKmsO3TLCM
         3Lo+/LzpBcFlQyoBRACTOReOfWpl3UBw65Juk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t3Vz1DNN/DHoh2CZjLnX3X8cFqPZaAphuGqCqL7Zx98=;
        b=nxUzZbgC9XLXROMriWtjojVO1jtHXTxl7pqLiwHx8Oo4GA3tptKjKjmpsp2nziU+Zb
         7H/yeWgqZFOEufTFxG9oRbADCNaPN8eJcnmqla+vd+2HN1jKo3ZaQfRRLpWeW5s92mXH
         kSAQA2yq/IMYx/lgRzlu3GpsNz/KEFikO8ltpw7EEteBGmcN7UyMYJIqbz1133z3+wl8
         WWcRUdF66Z8bzIi6/I6QsmaQ6vvLWni61e7C7lh0QSUMbDgjb+aI14gqXPJS52zV0pyx
         Y/6EWTy0celta/alaEpDA2ltuD5KdHpI2gQ+ysF7RBI69qaDb1Tdm9GBM7dLI9GXPUoN
         o9Pg==
X-Gm-Message-State: AOAM530nQXsz4vZoLCnVa7In+w20MpeCxbakUobSUR+y5wyPsecpT+db
        ic1cgeMTzyDPHjHyrnvFVxBxIA==
X-Google-Smtp-Source: ABdhPJxGiUoXiax+af4oqEeYZNTpxf07cPtfl19WQJmQl1KpMADWoL8+VMJyUt6eQD50p0f3OotOYw==
X-Received: by 2002:a17:902:106:b029:e7:32bb:fd6a with SMTP id 6-20020a1709020106b02900e732bbfd6amr1044243plb.2.1616735298091;
        Thu, 25 Mar 2021 22:08:18 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id h15sm7697503pfo.20.2021.03.25.22.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:08:17 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     YueHaibing <yuehaibing@huawei.com>, ruscur@russell.cc,
        oohall@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/eeh: Remove unused inline function eeh_dev_phb_init_dynamic()
In-Reply-To: <20210324140714.19612-1-yuehaibing@huawei.com>
References: <20210324140714.19612-1-yuehaibing@huawei.com>
Date:   Fri, 26 Mar 2021 16:08:14 +1100
Message-ID: <874kgy8ptt.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> commit 475028efc708 ("powerpc/eeh: Remove eeh_dev_phb_init_dynamic()")
> left behind this, so can remove it.

I had a look: the inline that you are removing here is for the
!CONFIG_EEH case, which explains why it was missed the first time.

This looks like a good change. Out of interest, what tool are you using
to find these unused inlines? If there are many more, it might make
sense to combine future patches removing them into a single patch, but
I'm not sure.

checkpatch likes this patch, so that's also good :)

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel
