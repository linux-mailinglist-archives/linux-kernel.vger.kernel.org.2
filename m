Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5E355739
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbhDFPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345405AbhDFPFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:05:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DF58613C4;
        Tue,  6 Apr 2021 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617721512;
        bh=7iQanJzKQUiAwokRah7xkgA0KA/RfUKHf9XCaEnQ3I0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tLpDgW3GH0HOTPKgFGtybRIQ7aUXXnmj7Xu80t4Jc5y/NQmmYJZ8Xyv2fsrhwV3Pp
         b2kJ+CmBVC8nkJxTbr/NI/vC43JrkkF//kP2EtTEKkmkWcFXpDCyDzr8Gl4TZ9iT2f
         i+jOzBf1dOcCZtvlBDgsEiQ4UVQ1m7EX1EB+ZuQevrVUwt3wxd43WN3U1aisS3x0Rs
         d0s0Y5ynNalJp/pw6IYnkSXuiy2g2YiFOPq5eZaPigKRkC7nAlzVDpzg7OrgE72mZM
         cpJuF5iL5BOzbvU6rR2xL3gZUVGDegLsuboXL5N53R6GOi495gp5LMJzhuWaebz0nc
         D5hC+6MzwkFDw==
Received: by mail-ed1-f42.google.com with SMTP id z1so16986935edb.8;
        Tue, 06 Apr 2021 08:05:12 -0700 (PDT)
X-Gm-Message-State: AOAM530ZmAy1u3zFyeo3vSJvuJFGCON6t0hAI/ZaHk7bkAa3o1cuYZKA
        WFHmt9OPApW0Vy118usVR5VaxwBnf3Rlo7XaKQ==
X-Google-Smtp-Source: ABdhPJy1oGbKaD5Eu/UpP1JvI7d/oPzMxONRy4B7sTEgebFMaVwAv+8uZ1k33axIYdoWmdnhcD93mzJGHFqyYUcVDDU=
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr39201278edd.258.1617721511023;
 Tue, 06 Apr 2021 08:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617279355.git.mchehab+huawei@kernel.org> <7cfddf303f1508d26f90d87546d3812faebfc5ba.1617279356.git.mchehab+huawei@kernel.org>
In-Reply-To: <7cfddf303f1508d26f90d87546d3812faebfc5ba.1617279356.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Apr 2021 10:04:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3kqzQi+7emMWkuhyh2aj8qLy6nLS--J2P57Bw_jOCvw@mail.gmail.com>
Message-ID: <CAL_Jsq+3kqzQi+7emMWkuhyh2aj8qLy6nLS--J2P57Bw_jOCvw@mail.gmail.com>
Subject: Re: [PATCH 29/32] docs: dt: update writing-schema.rst references
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 7:17 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Changeset b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
> renamed: Documentation/devicetree/writing-schema.rst
> to: Documentation/devicetree/bindings/writing-schema.rst.
>
> Update the cross-references accordingly.
>
> Fixes: b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>  scripts/checkpatch.pl                                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index ee4feb53f8d0..104fa8fb2c17 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -25,7 +25,7 @@ I. For patch submitters
>
>         make dt_binding_check
>
> -     See Documentation/devicetree/writing-schema.rst for more details about
> +     See Documentation/devicetree/bindings/writing-schema.rst for more details about

We should make this a rSt link instead.

>       schema and tools setup.
>
>    3) DT binding files should be dual licensed. The preferred license tag is
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4dbda85fd7e5..3870c8a01987 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3245,7 +3245,7 @@ sub process {
>                     ($line =~ /^new file mode\s*\d+\s*$/) &&
>                     ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
>                         WARN("DT_SCHEMA_BINDING_PATCH",
> -                            "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> +                            "DT bindings should be in DT schema format. See: Documentation/devicetree/bindings/writing-schema.rst\n");
>                 }
>
>  # Check for wrappage within a valid hunk of the file
> --
> 2.30.2
>
