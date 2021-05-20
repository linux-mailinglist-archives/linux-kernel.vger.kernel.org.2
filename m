Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9851B38B126
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbhETOKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbhETOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:10:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E46C061355
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:07:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 124so3917660qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytwyc2rd26HegdNA2IyeEVfQs5d/jjcm5L5OfWQMEn8=;
        b=T8mYpGc7SpzWbitRRqvnct/KPb7fwyDo84beqMY2effwHKpU2cjarPNyiA02jO5VoA
         139l0kQAHbeccNh3SOk+rgPDpMorLAyEn4ObCZelupUnP/rx/fYxeIGBzFTq9RHhULdS
         z22j+LJMF43YkDGXDa7gQ3aKZjbR5jSU/qHy6g+HrsFp0oD1ikHg5RFvX/1PSpKekopT
         LZEV22ndA9u8oCChTH1x7kwUizgvvdQvXQBTdftOsUn3wmjbv7onWA5SjI+2NvSyUUFn
         BH3qfs444NuuZuZsISXvY4qQ0kkkfnlHY+8aYefPcu7obkitnoS5sE3sCc8ILe1kNwSH
         ORnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytwyc2rd26HegdNA2IyeEVfQs5d/jjcm5L5OfWQMEn8=;
        b=oCRNg22wuXOYxuiA8Yt/FOZ4rxcMupuQFUqYEp2t3i7BVwfVk8k6eVCF6ZkDzZ5AgL
         OJ2p2Mf0vvoRzJdtljIgcfIaOAeyj0kTcZ0dcvJnV10vCBqpk7/gGfiz3UTljEsMhLb0
         88gECoem/7H7MFA5nMcCJlH8B3RcvqWq3wn+rq33GoWrxwNeQC4468two/huLFEJ0vIV
         QDW0PPCqhj0tRXWQ2ae1dsMLYnAPCIUcrKEzOSmWkUwjmKl7YPidhffSXYM1hONszzG8
         5aKNEirIKgcG/QG35ernPFUGZgYhGvXHceld1GyBDRTGTHv7A9K8B7TK5VaBmhUg7oRW
         PJZg==
X-Gm-Message-State: AOAM531oHua4QArEFDqtiaILEXNe38feneCMlG9bbXNa07AFpsDiN6xs
        LCRykCLhHxbR/53iJ33m8PRmlwNIIcq2Ju7iMD2Jiis1o38sow==
X-Google-Smtp-Source: ABdhPJyGvUjwwyny1TE05MUhwqeqp/dZ1srNSNit/9c9Y/6m22v8UX9ydbry0qV9MnfmZL6mkbhqxRCfmHfDONgfHbo=
X-Received: by 2002:a05:620a:14b9:: with SMTP id x25mr2960889qkj.460.1621519663865;
 Thu, 20 May 2021 07:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210520080646.24132-1-samirweng1979@163.com>
In-Reply-To: <20210520080646.24132-1-samirweng1979@163.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Thu, 20 May 2021 15:07:17 +0100
Message-ID: <CAM0jSHO1K_qrnPMAvoGst=_dRF7BjzSumLH8pVd-3k9Ejk_44w@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gt: fix typo issue
To:     samirweng1979 <samirweng1979@163.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        sudeep.holla@arm.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        wengjianfeng <wengjianfeng@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 at 09:23, samirweng1979 <samirweng1979@163.com> wrote:
>
> From: wengjianfeng <wengjianfeng@yulong.com>
>
> change 'freqency' to 'frequency'.
>
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>

Pushed to intel-gt-next. Thanks.
