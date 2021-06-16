Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEA3A90B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFPEnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhFPEnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:43:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C297BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:41:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k7so951910pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yNLs0De7jThuF+2jQNPxEWOcx6TgeD4ov6vuIyTpd+A=;
        b=lKJIvf6pt1/GdaW2KeqS7wKBIja3w5kpORjD4jLrNWSEFfEOkW3onHIDqBu0GFngkS
         lxkWv44pwySHTfYWybvEhaBirmSWSJMqraifs7VnqCLsdljizzbcTlkUb4DkuOyQKb70
         r/j3tlzKy+Tk59kdBEbDxcnNRfRigkfAmLaJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yNLs0De7jThuF+2jQNPxEWOcx6TgeD4ov6vuIyTpd+A=;
        b=ks0XU++9h1HV6LDMHyb++ixuKP2q6fbkRrTbsUhO0P6B5nMH2+D5fTtj7yNPEH9BpC
         jjYQctsZzgARFqfqVN/pLT5m8W7XOCspy2WEgewtUNrXDsBVRyP78+2ozVtNRpigl9tK
         xxXeLoSwJWSvc0onpt6GuH1OiNOPfX0JvWpP9ay+h3Gc5QxfJQrapQsk2C8mxqfmrBNF
         gCHc2Hkr9P+oLjcJPzgRFlnCsjWxC8JOMNTZxsFuT3pfLUZVjeifrqrfIQrUIhL1RuMS
         PM5RkAdtX9I62CT+jD2kr3XZnjuRYMQqGQiILRECvpGx0pWoq9QB2lB07Vc5/wG73nPn
         wjNA==
X-Gm-Message-State: AOAM5301l07xiCG9I5p/mqKW4V3piGTQG3JxtPcYMRAUvK3rCfTstYMg
        qGbFZYyOqNmXqz/0z/giXksUxA==
X-Google-Smtp-Source: ABdhPJxh2trs7JHKAmnz6ypTMfnczKQwyngda5/fDSTUi8HksJLDs/vs/uzec4cWsIlm+tLEn9utjQ==
X-Received: by 2002:a17:903:228e:b029:101:af04:4e24 with SMTP id b14-20020a170903228eb0290101af044e24mr7415002plh.3.1623818503317;
        Tue, 15 Jun 2021 21:41:43 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id v10sm726962pgb.46.2021.06.15.21.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:41:42 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 2/6] kasan: allow architectures to provide an
 outline readiness check
In-Reply-To: <CANpmjNN2=gdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB=s_ZWndJLg@mail.gmail.com>
References: <20210615014705.2234866-1-dja@axtens.net>
 <20210615014705.2234866-3-dja@axtens.net>
 <CANpmjNN2=gdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB=s_ZWndJLg@mail.gmail.com>
Date:   Wed, 16 Jun 2021 14:41:39 +1000
Message-ID: <87fsxiv2t8.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,
>> +       /* Don't touch the shadow memory if arch isn't ready */
>> +       if (!kasan_arch_is_ready())
>> +               return;
>> +
>
> What about kasan_poison_last_granule()? kasan_unpoison() currently
> seems to potentially trip on that.

Ah the perils of rebasing an old series! I'll re-audit the generic code
for functions that touch memory and make sure I have covered them all.

Thanks for the review.

Kind regards,
Daniel

>
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANpmjNN2%3DgdDBPzYQYsmOtLQVVjSz2qFcwcTMEqB%3Ds_ZWndJLg%40mail.gmail.com.
