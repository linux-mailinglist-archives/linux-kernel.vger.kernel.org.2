Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB0402E52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbhIGS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239182AbhIGS0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:26:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7A7361102;
        Tue,  7 Sep 2021 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631039131;
        bh=T9r99jJy9qqRYuAHlqVi3Yv+TYq9Jj1Ndmmxx0xcMpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u6KFZPre4Ue+oyeToLjtVODGFvk4+sEATe6832nfhxNBLj6wAxdZEy7DSodRAiWwU
         V5igKUkiDcwtm6Qbhcu66zoMG9nPfYd6+qcBXIaqcuOpJ9SdVQ06+JrTX4A2/g5dyG
         SWAx61ad4ypwV7JyNDg+hixd98Pa0E3CBEGIJ8TeO5l6/ruQombNpF5OUmHASmllLj
         nt6kgwqN7J7N9OfN7c8o8dnvJXUVU3Nz/TsJzBKJrfIFZr9thiTXewe4TDpN2nTMoc
         2yUxhw+fzh7GTWkl/gGZy89b9yiIBuYvAspdRTWPHwv4WCoTcxrS2JBbZ+x9D5CQkg
         Y4v0Iwx3PKWHg==
Received: by mail-ej1-f52.google.com with SMTP id t19so14172ejr.8;
        Tue, 07 Sep 2021 11:25:31 -0700 (PDT)
X-Gm-Message-State: AOAM532iWid2ZT1vmYvCzBbQQkG0g0ccfQDcG3/2uURQYaGXrJUQl0Em
        TwH2iB+FTs0aAJonaeH1+YSChmmLZeP/edS3Dg==
X-Google-Smtp-Source: ABdhPJzPfjmJuXmhf39xZm6Gb8q2o1mNVGrw3pykfcgYpGNgwRdlSKaVWs0KYTqG+194JBAH+24p39myD4ZB4cjbG2I=
X-Received: by 2002:a17:906:43d2:: with SMTP id j18mr661253ejn.363.1631039130587;
 Tue, 07 Sep 2021 11:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210812174209.1970-1-bbudiredla@marvell.com> <20210812174209.1970-3-bbudiredla@marvell.com>
 <1628856667.648308.3179071.nullmailer@robh.at.kernel.org> <CY4PR1801MB207047A1D761C136C9B18E76DEFE9@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB207047A1D761C136C9B18E76DEFE9@CY4PR1801MB2070.namprd18.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Sep 2021 13:25:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=hNU=XpQgkKtVBEikb2D6MP=vihqThZif76qOuyh_hg@mail.gmail.com>
Message-ID: <CAL_JsqJ=hNU=XpQgkKtVBEikb2D6MP=vihqThZif76qOuyh_hg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for
 Marvell CN10K LLC-TAD pmu bindings
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 4:11 AM Bhaskara Budiredla
<bbudiredla@marvell.com> wrote:
>
> Hi Rob,
>
> Thanks for the steps. I seeing minimum version error, though the dtschema is latest.
>
> $ make dt_binding_check
> sort: -:2: disorder: 0
> ERROR: dtschema minimum version is v2021.2.1
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'check_dtschema_version' failed
> make[1]: *** [check_dtschema_version] Error 1
> Makefile:1418: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> $ pip3 show dtschema
> Name: dtschema
> Version: 2021.7
> Summary: DeviceTree validation schema and tools
> Home-page: https://github.com/devicetree-org/dt-schema
> Author: Rob Herring
> Author-email: robh@kernel.org
> License: BSD

Check your PATH?

What does 'dt-doc-validate --version' give you?

Rob
