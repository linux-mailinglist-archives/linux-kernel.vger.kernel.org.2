Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0C386EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbhERBHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:07:10 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:47026 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhERBHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:07:09 -0400
Received: by mail-ot1-f42.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso7189107otb.13;
        Mon, 17 May 2021 18:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdoQ2d4Wdw3el+UXPWLy3KyXqIi1C4lomR6eF/WOzJ8=;
        b=NemxZPumMND3YZVSe0P+3/kquzb9n4+nfudMfggXhitXoEjHiQPwg4Cbr0jBJBObV/
         C2QLL8LscZM5LrDhDsVQALZ/ZBGCDTrw1IyLyPVepIxQ9tIhGBxEvxAN/ug942qaA8E9
         7lMia5aq8UuMKdR9LRLGSqcuiUVl9GAnFeEI9moTZCGkOC2f9PnE2Mnp/FiEAETRkcbv
         kkimpaGVHBxBtzwiGUba9JZowyNvxMv6rYUqMhTxwQ+38jnDv0+ZPWw5c46DsFp9P7TJ
         PelyFoUpWwwb+jtVB4QdCx7HKqZRwOJw0AeITBAcbbFTKaEiKu3F41eIIf6oW6s07Xkm
         9U2w==
X-Gm-Message-State: AOAM5336vzVTuMr6uNsdUllyy2VPMgQkJwGO3CiRgaSrUf1g5rOBKdcf
        /eUs2T22wYTmTvI1x+hHq+mOwox03w==
X-Google-Smtp-Source: ABdhPJxPw09p1yzDmzl+ayVgFGiPeaLzkeN7x8RkBEUXOUQrJOrXsZH15g0DDaY5w+WcqEeL1p7NrQ==
X-Received: by 2002:a9d:7997:: with SMTP id h23mr2047582otm.366.1621299951905;
        Mon, 17 May 2021 18:05:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9sm1004366oor.16.2021.05.17.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:05:51 -0700 (PDT)
Received: (nullmailer pid 3564673 invoked by uid 1000);
        Tue, 18 May 2021 01:05:50 -0000
Date:   Mon, 17 May 2021 20:05:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: remove stale property-units.txt, link to
 current schema
Message-ID: <20210518010550.GA3564621@robh.at.kernel.org>
References: <20210512152311.7399-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512152311.7399-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 17:23:11 +0200, Luca Ceresoli wrote:
> property-units.txt is not maintained anymore. New suffixes are now
> supported that have not been added here.
> 
> To avoid people incorrectly think a given suffix is not in the list remove
> the file entirely and point to the authoritative place where the
> recommended suffixes are maintained.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/property-units.txt    | 48 -------------------
>  .../devicetree/bindings/writing-bindings.rst  |  3 +-
>  2 files changed, 2 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/property-units.txt
> 

Applied, thanks!
