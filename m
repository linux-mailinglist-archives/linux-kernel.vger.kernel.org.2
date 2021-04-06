Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4335574C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbhDFPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345465AbhDFPGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:06:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B1BA613CD;
        Tue,  6 Apr 2021 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617721562;
        bh=oKiK4ApC93CrUYa67wbve2zbWOPAYFHVj94zM59y+yQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aVshd5xxVxPYitoUYR9v9ig/rMRIKsxhG9scO2HkQvZSxqe7k9TWmpvZBZFP+PlOm
         Q6i6ghqzAQiZSY3QkacgL++PBoMOnRumNk+23sHS9yPK3o3HQ1Z8fp/nBhwOL3kHNr
         AMHM1TdiA/3m3wCPrLFfF0LSa7WQJ1AONtUx/1y821t5uhT3snuZYjGu/H7b1TUA7s
         lBi2VF1xmcj9qaIYudlFPUjjsO3LxI8xjo6FDlUpNlXaVhAQ4ncByOjGgv8G+0zh+S
         Mw26Ssg3BlccZTF88ndfAyygomisjQwXQiPzs6+QdKV3ryRVR20NPsQCKw552k8ale
         xFY+ZvvVRoI7Q==
Received: by mail-ej1-f49.google.com with SMTP id ap14so22549470ejc.0;
        Tue, 06 Apr 2021 08:06:02 -0700 (PDT)
X-Gm-Message-State: AOAM532P1e0Zi0Mr0ve9lQU75P4Pl8ptZ7Gkabzn3ZQMo5wqz1lg31Of
        GHW2bX1PXPdOsH2366OZmg/FuBdM/pYw/Ntssg==
X-Google-Smtp-Source: ABdhPJyxyDKARhPWHu4Jr+PfqF7dmXdHRhFbxyLKg+KVWqXlE18eXrf8KY6IuCJJBbg7kaluABfeLXvlp8S1qatvsx4=
X-Received: by 2002:a17:906:55c9:: with SMTP id z9mr6780057ejp.360.1617721560689;
 Tue, 06 Apr 2021 08:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617279355.git.mchehab+huawei@kernel.org> <22b7b53af1907f7cae27e26be725470c04b84725.1617279356.git.mchehab+huawei@kernel.org>
In-Reply-To: <22b7b53af1907f7cae27e26be725470c04b84725.1617279356.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Apr 2021 10:05:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+d9nU8r_1tvrU9Yk4rCN3fve6D29JMLFN59jJxLWjhrA@mail.gmail.com>
Message-ID: <CAL_Jsq+d9nU8r_1tvrU9Yk4rCN3fve6D29JMLFN59jJxLWjhrA@mail.gmail.com>
Subject: Re: [PATCH 27/32] dt-bindings: i3c: update i3c.yaml references
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        devicetree@vger.kernel.org, linux-i3c@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 7:17 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Changeset 5e4cdca887fd ("dt-bindings: i3c: Convert the bus description to yaml")
> renamed: Documentation/devicetree/bindings/i3c/i3c.txt
> to: Documentation/devicetree/bindings/i3c/i3c.yaml.
>
> Update the cross-references accordingly.
>
> Fixes: 5e4cdca887fd ("dt-bindings: i3c: Convert the bus description to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt   | 6 +++---
>  .../devicetree/bindings/i3c/snps,dw-i3c-master.txt          | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Ugg, I should have remembered this...

Acked-by: Rob Herring <robh@kernel.org>
