Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B872446AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhKEWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKEWc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:32:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1838C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:29:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m26so10117909pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=umVUW6jc/L8SVxjta1twBEy226Ben5a9qPYTSGUOHQA=;
        b=dJlzS6sY4+HtDIw6f1s3kJ0KeOiAeWWlln6JCDgngVIa3839Knws/mG0DVc7qaMedT
         REP+Nypm8lvDTgK6g9KZIOG5mYrFArYz4OiRrk3f1zzzYTTDv6kyImsuqkcKXR2R4q3n
         hiYUr55KDUksPwGXj0EAJjREK6nNQKjxLdUULWKoCY5qMqQ6Lo6RqTM+gT3TlFaBGqkw
         F5mQRde17ENKd4uR98zHYzGrfJ4q/ha+3ORHKaGu8JUhygetSgGT3kFcQZ1twLtEto+2
         uyHk/ZElwMZ5U5s2SpmGHz1YsqvDAyUtpuErJWU4xJgw6bHUnxaKScc8GrVbl6bDqeI3
         YBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=umVUW6jc/L8SVxjta1twBEy226Ben5a9qPYTSGUOHQA=;
        b=M/Sl3FOtnUh4Hui3hDsnrHnCefTJW2kFFk1qubsd/tI+SkMhQZDcXr0cTv+LsurmMb
         tv2uDmB2f4eJS9xYSdHh/spFCTbKdj/h7K/Mc3BbeJNfgoaHDpzb98ipDsGqAnbaxzdh
         mXkb5CMIAerbqtZC7izOXVvz08wIErawpEsZ3Hu6l4tua3NR7q/NYV+/q9E8aBDEEMz5
         tG6OWvr8qgYqrTJR2p9jSg3uHpviWXLxZWdg8FrAKPIyMunuttf3DzOZBB3eGwcSG4RG
         qTr0r7LzjSswQS85hyg2fDZlRpkB01q0wkW9st9gY8af7G2M/j7bzw4VnZ1uV+D6q4JB
         os+Q==
X-Gm-Message-State: AOAM5339AxO3UZ9mnWI8ZuPydjt9EONLhHDJ8EgRPEWjGokfV1RnM/8u
        zuMAMLl6G4BITeNqaiLeapOKhw==
X-Google-Smtp-Source: ABdhPJxnplEUbS84SESb3k6Dg9NUb8HTrlBZyfh15XDBc44zrPIdNCu6xmSv/bjrVPCAtJS+ZKUdBA==
X-Received: by 2002:a05:6a00:1892:b0:49f:a2af:5cc9 with SMTP id x18-20020a056a00189200b0049fa2af5cc9mr4940999pfh.9.1636151388065;
        Fri, 05 Nov 2021 15:29:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t11sm6664691pgi.73.2021.11.05.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:29:46 -0700 (PDT)
Date:   Fri, 5 Nov 2021 22:29:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
Message-ID: <YYWwVmRoF8PgohNE@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.408049586@infradead.org>
 <YYV1UeFeWUtnQ4jV@google.com>
 <20211105205805.GR174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105205805.GR174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 06:17:53PM +0000, Sean Christopherson wrote:
> A different option is something like the below; down side is that it
> increases the amount of text, while your version decreases the amount of
> useless text (the gunk between vmread and 3:, all of which should
> ideally live out-of-line).

Yeah :-/

> For now I'll stick with your patch.

No strong preference, I'll defer to Paolo.
