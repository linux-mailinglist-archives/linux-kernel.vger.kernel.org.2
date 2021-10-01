Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E341F4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 20:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355928AbhJAS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355913AbhJAS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:29:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8B3C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 11:28:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y26so42349138lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZL3HiHYhk83htmEa9pfWci+RswEhtW10ZF70CFAsps=;
        b=eTEbfE49kta/JBr5TxSOXnOSkMsvgwFphSljrp1cZGTHkx9dcn8MxBzKsditpPBcGv
         ddgPWulvGNYBuYQUY27qxescZoEfA1J0QQdCiNAG0cahKTZuLbCiDa/hyDEBhRTzTZxS
         T8kYQUqND1kEZZ8fqvyZA113HdWMkU8cn8D/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZL3HiHYhk83htmEa9pfWci+RswEhtW10ZF70CFAsps=;
        b=1ABfJX7y6o0VE3NzYvmznsxmK+1X3zNqYanfoQEs0yi693CWrihVbYvo+XeRmNGyhl
         RMC0J0EaMrTA0Brmg9xQCAULRljqxGQ0pMTWjziJVpIm/qx+f2G0UFdymqTHxdmwR28M
         Mr2QGRu7wpukkuzNWZX72txlKZGfzO3YQb5L5ZM4OQnxwqewzX/BMqRXWwJD9x2YK2No
         req1843Cl98ZvFJajuNHIWKJSIn4DghIovVZfI1SrO6y9YKhoQDu98PTSC0nwMkvwyGH
         G0P880VnwvVPicS2HXEAyCBJDWyJ4U8GAOiz4wMBwtmLFPkiMycE1qtw7iN+puB2/YlM
         1urQ==
X-Gm-Message-State: AOAM532yjW2z5afOQsA0GO6zGgMjbNMk0J1sFnfWtHssDwspkhqglJHr
        uBq9JY+AIVvGlwNOVn6QTSvkATiTx9QDGL2VLLY=
X-Google-Smtp-Source: ABdhPJwWErbFs4DNpX8fK+ng6jr07VQS8n4QIwo2NzbYZli4PERX1zazY8IUO6irIZQYJkvh3Lk4VQ==
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr13135329ljj.61.1633112881644;
        Fri, 01 Oct 2021 11:28:01 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id b22sm812132lfs.27.2021.10.01.11.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:28:01 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y23so2821015lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 11:28:00 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr13249120ljc.249.1633112880766;
 Fri, 01 Oct 2021 11:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <11859976.O9o76ZdvQC@kreacher>
In-Reply-To: <11859976.O9o76ZdvQC@kreacher>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 1 Oct 2021 11:27:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUc1J_vf3VSin4Nw1dH95A=Li88kHzD=rhsWM3+fz0mA@mail.gmail.com>
Message-ID: <CAHk-=wiUc1J_vf3VSin4Nw1dH95A=Li88kHzD=rhsWM3+fz0mA@mail.gmail.com>
Subject: Re: [PATCH] thermal: Update information in MAINTAINERS
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 10:14 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Update the information in MAINTAINERS accordingly.

Applied,

                Linus
