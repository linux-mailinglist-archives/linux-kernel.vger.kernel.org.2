Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DE3AD2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhFRTkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFRTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:40:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5343CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:38:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e33so8622645pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=efZiryzTZwErGPG9eUAqI8R5gBkZ9//XEzY7JmzlBZo=;
        b=meopqwHKty7urd9b/j/Syk7Hqvgj8LIJzopjpDceO3tXr+t/JjTvgpVzEIt8uur/bp
         O4eAQOwv1Q1O2tSsR1bL2LjV+gvhBtFhSw3AcI/BiX8JKjzOU3GC1ZuWT4jwQyqJVK4f
         YHl1xy78/znRIqh0soZANGYuQ6uuJDY5SBAjjNaDr76WhQ5Llt3HHGsI4xMurqsfEGAY
         Pl/UZYWtI5Wg54bCsMDFmO2P9hlwL39PbVIGynY/hkpfDDOsf9ngxppFwvwtu+VIa8Q/
         0Ey4CO7ebVOxUsJbDvwfIujUfnkmlELjGteOiDT/o4jZc+oSba1qBzqXmfOTQvjESqDP
         YNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=efZiryzTZwErGPG9eUAqI8R5gBkZ9//XEzY7JmzlBZo=;
        b=tv9wtcheJFSbcrUrfxwQ4OAiwMyYJukAOASZh9UySPHBxwYXAtKAgbP25EJrVv+PKn
         6WrQ87oLszq5FXQFgFo+pg1EVSfgEPBK2vVsK9NHCcu74mkW0+BRxFb519W814+BozHi
         TOVcL9C6Swhz5XSol6RMgc/In2o69FmggJzhZL+ibRG9amEPpZZLcS7pZQvQAnJwvUIm
         hcXEEh6xGJTRz1wGbbTAKZvzsbMvh2+jUyyUb+Re+YeoujhJOWynX/KQLgm6QLtXbPCP
         sjXiwTtTFA/OH965NH1/GLETWZgHbt0gEwZQnI1twRbopGw5RRyEncB203RDUBe/nOME
         qhuw==
X-Gm-Message-State: AOAM533SKPNIdJShq8Vxnhuquw4HA/CSf4615+Lay7dIKvC/qexLbUcy
        57IfD0m10HzdVU1RqUcxIPejiQ==
X-Google-Smtp-Source: ABdhPJyb+EHmf/mckTtVARAc0EwTJ/lWhcRvsPrRgfIRUTgj05qgMsJnlWiTPYcj59BEIaCMEFQgLw==
X-Received: by 2002:a62:be03:0:b029:2e9:fe8c:effe with SMTP id l3-20020a62be030000b02902e9fe8ceffemr6563096pff.34.1624045082626;
        Fri, 18 Jun 2021 12:38:02 -0700 (PDT)
Received: from [2620:15c:17:3:3a6:a5d0:1984:a150] ([2620:15c:17:3:3a6:a5d0:1984:a150])
        by smtp.gmail.com with ESMTPSA id y2sm8510157pfa.195.2021.06.18.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:38:01 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:38:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
cc:     vbabka@suse.cz, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, djakov@kernel.org
Subject: Re: [PATCH] mm/slub: Add taint after the errors are printed
In-Reply-To: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
Message-ID: <413080c2-bfd7-f386-709c-43718242ae87@google.com>
References: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021, Georgi Djakov wrote:

> When running the kernel with panic_on_taint, the usual slub debug error
> messages are not being printed when object corruption happens. That's
> because we panic in add_taint(), which is called before printing the
> additional information. This is a bit unfortunate as the error messages
> are actually very useful, especially before a panic. Let's fix this by
> moving add_taint() after the errors are printed on the console.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

Acked-by: David Rientjes <rientjes@google.com>
