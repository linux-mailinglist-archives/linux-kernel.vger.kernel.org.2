Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96980358CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhDHSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:52:41 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:52:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q10so2053712pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CZf8sPVZ+0I2vUscjWdRwf5Bfg9qGLak8uFDmbZvW9E=;
        b=ahiXY6eqamIXbBo+89EfDIqq9JqghMj/fxBFlxuG6KwwxP/uhYpYkwBDSVr1rseK0L
         XLQL7T2HOmyf8/90DHgIfoeJXtHS8RODtWxV/Swou4GciUlFjuZ1NVNEv/K20Le2eO9S
         ZjD70Vcu9G6Ssz2Le5/+Wu+bN7FNw0PyEiasw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CZf8sPVZ+0I2vUscjWdRwf5Bfg9qGLak8uFDmbZvW9E=;
        b=MhmHmZhSsqZO8qIlFeY6gR6z37dtZod6MUgUZnhOMKONyuslwJfXhz4vYDu4nfAKEI
         T20gksZ5NuYPPbP9ZVIXHHRzBBYHS8Fp+g2ZceiZYWOuRgeiDLzXMgYFjzEb0GcOpNts
         RaAk2WmVC7V5gG1x6SN7Fpqu9ECuxswTH9t48TsXD0RUAtnf2TXDP9GWxQ6P20OKHF7g
         r1BVZugtmdWsKsntapmsNi8h+RIK0TMhaNNUcaXGUENBELaqvGHm71bdQFnQ7Kg/6laG
         nx6FunXCKLBRUtQFZAR7G+vfPwGMeY32Qgq8bHCv1nJMGWpBnPwGrj+reyHZIl+vGnA1
         cGEQ==
X-Gm-Message-State: AOAM532NcM+K9w6/5LOJb+MdTMUOWC6M0FFjconr7PxBpO3j7D5iU0gg
        jX5lhFIAEtt5+nlp9+/s6382yg==
X-Google-Smtp-Source: ABdhPJzYvMTEACu7w6EwSE8btPWJ1lLiilG0yrtJetj3m5x++FVBGuW4g5FYVhv6+HwnRkaqQjSJFQ==
X-Received: by 2002:aa7:8d44:0:b029:244:a363:dd57 with SMTP id s4-20020aa78d440000b0290244a363dd57mr3793728pfe.8.1617907949351;
        Thu, 08 Apr 2021 11:52:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id g80sm180788pfb.181.2021.04.08.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 11:52:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG7xjbIEmrCco14F@gunter>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-3-swboyd@chromium.org> <YG7xjbIEmrCco14F@gunter>
Subject: Re: [PATCH v3 02/12] buildid: Stash away kernels build ID on init
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
To:     Jessica Yu <jeyu@kernel.org>
Date:   Thu, 08 Apr 2021 11:52:27 -0700
Message-ID: <161790794728.3790633.1727402698174847953@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jessica Yu (2021-04-08 05:05:33)
> +++ Stephen Boyd [30/03/21 20:05 -0700]:
> >+/**
> >+ * init_vmlinux_build_id - Get the running kernel's build ID
> >+ *
> >+ * Return: Running kernel's build ID
> >+ */
>=20
> Hm, init_vmlinux_build_id() doesn't return anything, so this comment is
> not accurate - maybe "Get the running kernel's build ID and store it in
> vmlinux_build_id"?
>=20
> >+void __init init_vmlinux_build_id(void)

Thanks! I've fixed it for the next round.
