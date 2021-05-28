Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502E1393E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhE1ITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhE1ITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:19:24 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C740C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:17:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so4076180wmk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AHWFtZ4JtVb0qrwTUD5lBPRsvkcKEz5Qmj3nhhGehuo=;
        b=BkAhcBwQsg5TOd1uYuKBkMFFqIq3uka7Hrkjmgn43dyehF2KDMqvOzcDwgQOlZReFv
         RQVYSR9jBmRP5NWzQTw2oRhydDHPg0jsVmnA9EC5JZGySoMyNKJFXPQjxja3G1O12JBl
         QVLS9bfS6DAJfDEheF2GedEsunvRR800RrCtoQqdX38bb1LRzqGcErYigDnbTtSBWXSj
         9v4ohQ1vt3ekfBiiqCCRaQziW5/YBr+rlSPpkTpy5b0B8TH+Yhxr9wCsakTVoeyEWGQ0
         lEDrUVvzpSySN9F+xaMY1Y4YeuMdBjKPScLg0ww5FN2Ow7zrWp4dVmxV0Tnngouex975
         JnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AHWFtZ4JtVb0qrwTUD5lBPRsvkcKEz5Qmj3nhhGehuo=;
        b=aj/a5/OypR8JTMqvQsyakCugRqqys/HrXezgVKDB/d7HRJ6jYQJL4OkNy3cpx6rDtB
         sdktsOoc9pNdiZqKllfgUcvN/75kZGF7izlzOQnnUN8d7Kr0Qy2eRGl9RQapmtESHkBp
         Qgz9fKKcR4mohfFyMqPDgdytxiH6Dc4SSKeay4IK9NwyMQ9vam5THCO5eGkZX97LGZuq
         BXR1Wew2rTQEGPAIxArJYeyhmUwWfUCLitnbe7BRf+cxV7VfVRWc4OFeAxAXsd5hbhRE
         kamqPfER5vGCYZOle9N5f+Hiu8uk25uExEI0a484vKvsAQ9t5y7ftZdfiwctyhr8sul8
         8I4w==
X-Gm-Message-State: AOAM533+jm7f8pQ8wG6alA0VJpfeurtzjfVUtpZkDe+CBGOJmwdy4k3N
        D/8a+LtlB/r0WMk2ufxRSyh3zA==
X-Google-Smtp-Source: ABdhPJy6PzNqD1BYPWB5auyCe89oOV8OLtsOqwTIL8Kb/M2+C88LJBE3wznE13EspYbEpENySQDPoA==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr12339222wmh.186.1622189866195;
        Fri, 28 May 2021 01:17:46 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q20sm17559400wmq.2.2021.05.28.01.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:17:45 -0700 (PDT)
Date:   Fri, 28 May 2021 09:17:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Sachin Verma <sachin.verma@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 01/16] i2c: busses: i2c-nomadik: Fix formatting issue
 pertaining to 'timeout'
Message-ID: <20210528081744.GN543307@dell>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
 <20210520190105.3772683-2-lee.jones@linaro.org>
 <YK/yyypWeOnBNc4K@kunai>
 <20210528075806.GM543307@dell>
 <YLCjDHmAG0FcePyJ@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLCjDHmAG0FcePyJ@kunai>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Wolfram Sang wrote:

> 
> > > Applied to for-current, thanks!
> > 
> > Thanks for these buddy.
> 
> You're welcome. The rest will also land in 5.13, but I want to give the
> driver maintainers one week more time.

Understood.  There is no rush from my side.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
