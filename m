Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1F43F756
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhJ2GlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhJ2GlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:41:09 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B2C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:38:39 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id z11-20020a4a870b000000b002b883011c77so3033150ooh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lrxWSlaHCqYhum8bENEW5/SnCy2jiR0p2i+4IT353FU=;
        b=B+yUMrtmEan6908TWx8hiXU3bHm3jisSeFvHInIf1B1n5Q7J9IgleyQi90tMSUezsD
         38/8lBlsGCgXYFwIezakVmbBo5KDmDkmoqYGvruwfTDcnwyCkNfs4YES73cpt514c1V0
         kNrtOrWAn8tqnzTmogu03qpWuacbQJDCN/aUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lrxWSlaHCqYhum8bENEW5/SnCy2jiR0p2i+4IT353FU=;
        b=FOT9MtBM7+nfBCa/9EpfB1yy+E+lTFQOZwV4tqya/wJ7C5yrMwEECL/YDzQMIi0/F1
         0sh3qjLsIFllqcAxbfwT096BaO//PltQMjE0g/ZQ2gN/OALqawEs4bk4OiLzLJGvpvsN
         NnBvPbGwkA+CXtlDMYnsTYKKOy38r4aIorSD3gb6NiiNKnP47RxzV0JVbQFfuwBorRBB
         DqHzWIHdlJ1tpVurADAKrtReZR/BEKbnfktPo6qqxWn+p/suNUTN5NYE4WGM85STJ5cP
         GkehKvmz1xT/HUBOPLZtkalBYjofVjJpa0Vi3/8WmDrYo0jDzqbV/kniEFQH5p1wKwvB
         G3RQ==
X-Gm-Message-State: AOAM5332yMltMI2g9YTYee63WjhF87s6qc9o3IBIom/h4eF63FPKaFsY
        w1ArstMWgjuFjvjl19+rAuKkjtgEPx+EBIRNaXb/B2gifDo=
X-Google-Smtp-Source: ABdhPJytZQJN2ROOkPDTOyLMxax9ZDVghJLsWYJT0LYebDjaXf9Qn9W3wLTZ0I74Q3HnH7U6p/sFSXC9b3ZuCQJikwk=
X-Received: by 2002:a4a:4c90:: with SMTP id a138mr6349006oob.8.1635489518497;
 Thu, 28 Oct 2021 23:38:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 23:38:38 -0700
MIME-Version: 1.0
In-Reply-To: <20211028174015.v2.2.Ie56f55924f5c7706fe3194e710bbef6fdb8b5bc6@changeid>
References: <20211028174015.v2.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
 <20211028174015.v2.2.Ie56f55924f5c7706fe3194e710bbef6fdb8b5bc6@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 23:38:38 -0700
Message-ID: <CAE-0n51hyTyCxwoSfGZCZmRGVbdYBmyBPdkjqPgZ+4gn6T9WmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: sc7180: Support Lazor/Limozeen rev9
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-28 17:41:16)
> Support Lazor/Limozeen rev9 board where Parade ps8640 is added as the
> second source edp bridge.
>
> To support different edp bridge chips in different board revisions,
> now we move the #incldue line of the edp bridge dts fragment (e.g.
> sc7180-trogdor-ti-sn65dsi86.dtsi) from "sc7180-trogdor-lazor.dtsi" to
> per-board-rev dts files.
>
> Since the edp bridge dts fragment overrides 'dsi0_out', which is
> defined in "sc7180.dtsi", move the #incldue line of "sc7180.dtsi" from
> "sc7180-trogdor-lazor.dtsi" to per-board-rev dts files too, before
> the #include line of the edp bridge dts fragment.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
