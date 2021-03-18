Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13006340556
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCRMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCRMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:16:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B946CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:16:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so3052408pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mDvN0SgAfdUxvP15FGjlUIyfQkEQU0VmBT3cvhyl4P8=;
        b=J0SCTpSl66AXYFrVZinWF1tdEH2O6BGxsFyMoRYdtxMpYlP0iLTy+DjI2rPZTfQIcU
         p5xmOgENJh77+3sPhSiRMqCzHkPZAS8peVP/IbpKySbcykwSepPjABdApEOXSX02Z4S3
         l4Ixeuc52rWSYU0kUkexKhpyhSRQ+xTSIqM6Gz5ptTsyQno+l9w7qgvgvWQdHQjCk6aD
         Ao+jEHr44f7LoaOWDh4EfambbLt6ePERFM49V9dWx86fx+DE5ekAjey5sa9rXyMRSDBd
         N47WBciaLHNJV1jdQ7ybbgXzHMux3nvRGU4MEy4G2kjjMANbg4zN6qVB7y4h5eZhXs1i
         WUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mDvN0SgAfdUxvP15FGjlUIyfQkEQU0VmBT3cvhyl4P8=;
        b=qB99RvLzak96B8ds+3reUBzx4VR+AwVJYcZDdBgEgqVOE7097RKgK/0lPT6MLlIQte
         IApzqbw9Bzi/DHVNXfseBe7mVLoEsIsGAe1CufvpVwWT//8qywSivOYRKK8bbAEHwIfB
         nvqMUiWTLgyhNs4y7vu4kyZmIveysyqEmvG3+hXhIFJmQNULzIX3+7IUHexMymsdkz0z
         q4GNHN1M5l2mN0MP41vVnQf4Wz5uA5Rl6RMQyxEgNeEZalyBRCucJ2RtGWYK6hjzBFjM
         kyu8SUqRMwSMuAeL4D2riTmQh9Z3ieXx3ho43xWmBVSj6zg46hoj04vWriaQpSCkObJI
         LDlQ==
X-Gm-Message-State: AOAM5319jIHjolvB5mKizDEBv9DALOKDiPrH2sTpbZnZ547fOmsmWRZC
        LIXgeL1c2nit0bhpJQM0Bc1g
X-Google-Smtp-Source: ABdhPJw8gFyVpDkplM9fABTLOzM0jYdB18ReJ2voNFd21l1TQUS6DAIi9n2ngbIujTbCX2OD6xslVQ==
X-Received: by 2002:a17:90a:5211:: with SMTP id v17mr4141106pjh.53.1616069769155;
        Thu, 18 Mar 2021 05:16:09 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d00:4737:af26:182c:a57e:1d9e])
        by smtp.gmail.com with ESMTPSA id i7sm2473080pfq.184.2021.03.18.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:16:08 -0700 (PDT)
Date:   Thu, 18 Mar 2021 17:46:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v5 0/3] Add support for secure regions in NAND
Message-ID: <20210318121601.GA21610@thinkpad>
References: <20210317122513.42369-1-manivannan.sadhasivam@linaro.org>
 <20210317155121.19cbb50c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317155121.19cbb50c@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Wed, Mar 17, 2021 at 03:51:21PM +0100, Miquel Raynal wrote:
> Hi Manivannan,
> 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Wed,
> 17 Mar 2021 17:55:10 +0530:
> 
> > On a typical end product, a vendor may choose to secure some regions in
> > the NAND memory which are supposed to stay intact between FW upgrades.
> > The access to those regions will be blocked by a secure element like
> > Trustzone. So the normal world software like Linux kernel should not
> > touch these regions (including reading).
> > 
> > So this series adds a property for declaring such secure regions in DT
> > so that the driver can skip touching them. While at it, the Qcom NANDc
> > DT binding is also converted to YAML format.
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v5:
> > 
> > * Switched to "uint64-matrix" as suggested by Rob
> > * Moved the whole logic from qcom driver to nand core as suggested by Boris
> 
> I'm really thinking about a nand-wide property now. Do you think it
> makes sense to move the helper to the NAND core (instead of the raw
> NAND core)? I'm fine only using it in the raw NAND core though.
> 

The reason why I didn't move the helper and checks to NAND core is I haven't
seen any secure implementations in other NAND interfaces except rawnand. This
change can be done in future if we start seeing implementations.

> Also, can I request a global s/sec/secure/ update? I find the "sec"
> abbreviation unclear and I think we have more than enough cryptic
> names :-)
> 

Sure.

Thanks,
Mani

> Thanks,
> Miquèl
