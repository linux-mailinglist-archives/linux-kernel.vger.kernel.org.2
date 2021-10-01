Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FA41F335
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhJARjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:39:52 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]:45591 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhJARjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:39:51 -0400
Received: by mail-qv1-f49.google.com with SMTP id x9so6008982qvn.12;
        Fri, 01 Oct 2021 10:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2NaVOihKYDha1rS5ZJPe10csDtV7bota8qvu25P5G8=;
        b=gsbLCZIOPfs5HxNFWmLyBJh7MtaIkZErQsdvBn/z2pocr3SQnrRgdc04GdWXgC0lOe
         rDRCs7id8Y9EhNB+6UQ6u2gwlXBAcscD4zexLfpH+Mzs7esw/Eqh/nqVYMgRetabjp8w
         WJ+7wT2g6m86ZlxXPZ+9MXRiL7B6LN5EB/fLlSBJ24d47B0JCE4Gias3VH8xWVo50HKb
         vIw8tWbXyznmKGXO0sDEpr56Ky8fMmd8L0pz8UFQiFlKtxCKDgZ4xUYmdd9ghsVsijha
         OdRE0c9dJDcB0GJpzPMCUjPZIOi+S7cFqLmgNDQiR6mHG6HbFVEoQxd9D/cv+ZdpgRzr
         FHCw==
X-Gm-Message-State: AOAM532JPExv8V6hphgPHrNfeOGLkBFe2kpsqDyr/lTbzGiYYHt5cNg+
        v/7DC7utyL6sWt5Llp/hssODFhlWw7o=
X-Google-Smtp-Source: ABdhPJxS3cJzK6bcxiiyzmPpcLtXdf+O4n9j+f+AiWVpPGDFNLKquNdV/i5TnFwPxLKn0Oa9GjdbMQ==
X-Received: by 2002:a0c:f841:: with SMTP id g1mr5822720qvo.58.1633109886640;
        Fri, 01 Oct 2021 10:38:06 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id v23sm3256614qkj.76.2021.10.01.10.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 10:38:06 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id 138so9882912qko.10;
        Fri, 01 Oct 2021 10:38:05 -0700 (PDT)
X-Received: by 2002:a37:b842:: with SMTP id i63mr10892002qkf.262.1633109885690;
 Fri, 01 Oct 2021 10:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000417.15334-1-leoyang.li@nxp.com> <20211001000417.15334-3-leoyang.li@nxp.com>
 <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
In-Reply-To: <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 1 Oct 2021 12:37:54 -0500
X-Gmail-Original-Message-ID: <CADRPPNRhVuHTxTpU8RCBMMTVe2V23pjqt8Z5vV=5efepWk6yPg@mail.gmail.com>
Message-ID: <CADRPPNRhVuHTxTpU8RCBMMTVe2V23pjqt8Z5vV=5efepWk6yPg@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align
 with original txt binding
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 8:24 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 30, 2021 at 7:04 PM Li Yang <leoyang.li@nxp.com> wrote:
> >
> > When the binding was converted from txt to yaml, it actually added more
> > constrains than the original txt binding which was already used in many
> > in-tree DTSes.  Some of the newly added constrains are either not valid
> > or not neccessary.
>
> IMO, both of these should be fixed in the dts files.
>
> > Not all SoCs use ipg as the clock name for i2c.  There is no point in
> > having SoC integration information defined in i2c binding.  Remove the
> > clock name requirement in the schema.
>
> Any name you want is not fine. Your choices are remove clock-names,
> add all the names used, or change everyone to use 'ipg'.

I understand that the name should be important as clocks are
referenced by name.  But since the i2c controller only has one clock ,
the name is never referenced in the driver.

If we really want to define the name, IMO, it should be from the
perspective of the i2c controller like "clkin" or "i2c" instead of the
"ipg" from the perspective of SoC integration which could be changing
with a different integration.  I can list both "i2c" and "ipg" for now
as a workaround though.

>
> > The original txt binding didn't require the order of tx and rx for
> > dmas/dma-names.  Many in tree DTSes are already using the other order.
> > Both orders should just work fine.  Update the schema to allow both.
>
> Doesn't sound like a case where defining the order is challenging.

No, it is not challenging.  But as dma channel is only referenced by
name instead of index.  I don't see too much benefit in enforcing the
order other than easier to create the schema.

>
> Rob
