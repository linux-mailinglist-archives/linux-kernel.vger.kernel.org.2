Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715BB40470B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhIIIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhIIIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:32:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA1C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 01:31:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id rj12-20020a17090b3e8c00b001991428ded8so697241pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 01:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ub19d/9p0ySiiQaHlUmOKCZwKftnHq4j+eAR938tmJw=;
        b=FLig8JEO2mMgwahgAmhqXZd6sw+AYxTW007E1Zzk7xYdDIaDq7J38KuxVznHxtTSoJ
         9sdPRutBU/oFrVKvdxryNt84btBwAO/qvuaP3lbamerMZQED4R5+16o6bJVSCp7SUGoW
         fqNOEGJexP7Si57m1TeSg2VH1P/stpXjcxiLe4CvZa1jTu0VWEtTCwqJhisEqgYhXcE7
         E+z4WOiyLynxzkRUjyvhRu6s7Rkt6pzS4Vrzj7H24W0GTDXzBCcyzcxIhKyeiMLjc9Ef
         b/Wr3s5otKZQaTFva5YPOvi6m9ThzlaBoyWmjhTA3EYqNFk+WsjPes8XlCvn1Gw/sB/2
         i5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Ub19d/9p0ySiiQaHlUmOKCZwKftnHq4j+eAR938tmJw=;
        b=H3hM2LEwp2xDKb82SgLajgIYyJlBwNjawXyrpoaMxQB6GKwS1mT7IEn8SJfUy6Nq0n
         O2BHLYS6k6teMugPRazcaMTvW3Z7PPjn+KS6r0H1+doALLSBvzq7XjjredHBijnrMoqq
         aww22hyFohz/Vc6eEGzpvfufnt9zL4xPEyXhmumzhHRImR7qAPvet4tTll6ETG2j+vyj
         iNpEINBgeDsLGw54xNzkRoib4tVbZZ+TmAYfGU2RMbdh58r5tqOb+FjNaPNreotJDZfd
         JWXM8v8M2RQQ0419lIzlbutMp+/7TrCcwXVUBHCRSJADzeJkrawAI5qDDQgaIxEPc2Tx
         7d3A==
X-Gm-Message-State: AOAM532l82XWrqbFFT2RJ6ugVh314q4+IiVRqFaNSmfP6DDEz7e7nANR
        hbkSVoP45RXeHiftSVP7waQ=
X-Google-Smtp-Source: ABdhPJy1cwy9BexKAcPbUujvep/KF1DZNeicUjTReZUr62XZTwLjUYRMylOXw5IMkMg0FkmpqzJF1g==
X-Received: by 2002:a17:90a:7d05:: with SMTP id g5mr2334947pjl.14.1631176267586;
        Thu, 09 Sep 2021 01:31:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g18sm1295958pfj.80.2021.09.09.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:31:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
        <20210907202400.330f4ea4@rorschach.local.home>
        <20210908094145.babedcd252d8e8caf0e2f2ad@kernel.org>
        <20210907204502.26f0e833@rorschach.local.home>
Date:   Thu, 09 Sep 2021 17:31:04 +0900
In-Reply-To: <20210907204502.26f0e833@rorschach.local.home> (Steven Rostedt's
        message of "Tue, 7 Sep 2021 20:45:02 -0400")
Message-ID: <87a6kmb16f.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Masami,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 8 Sep 2021 09:41:45 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>> Hi Steve,
>> 
>> I've investigated that why this happens here.
>> 
>> https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#m52f43f6deb874ee726b10ce25ba53e44697a275a
>> 
>> This seems a timing issue. I acked a "simplify" patch April, and
>> the I wrongly worked on the linus tree for "mixing a value and subkeys"
>> and send it to you June. At last, those 2 conflicted on your branch and
>> your merge script might just merge it.
>> Actually, what Punit and Julio did is reverting 
>> 
>> commit 30d103f2d460 ("tools/bootconfig: Simplify expression")
>
> Yep, I came up with the same conclusion ;-)

Thanks for the quick response and looking into the underlying
cause. Looks like it's all sorted now.

If only I could as quickly get to the bottom of the network issue that
triggered this [0]!

Thanks,
Punit

[0] https://lore.kernel.org/all/CAGb2v67Duk_56fOKVwZsYn2HKJ99o8WJ+d4jetD2UjDsAt9BcA@mail.gmail.com/
