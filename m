Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0D35129D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhDAJof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhDAJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:44:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A39AC0613E6;
        Thu,  1 Apr 2021 02:44:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so1212568edb.8;
        Thu, 01 Apr 2021 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=adnUSnXkGhyIZzMG7EwucPUPj1d6brq/oY3Xv/WgG/o=;
        b=dCWvhKfw+ufMwDF2QLtiCXOYnUt/xGPd3fk5cKVwpUtbG3oTKcsxVm/8NZML4odtD5
         QHe/LQrhui1AA642NJAknA2TOgnrADhIBIHho8/R8KSv9LUxI6ltB7RSpQslvP7ZlAQ0
         Q1V09bPvWlu9UDKjzjHxLjb939LIi+aetYlrpyaORweQp1y039nQnu6CSjYsWL/dBhV6
         hkR0lOsESw6y9eVY3ruBwNaqZ7LQMa+XKBKBZ9Nzd9BtnI5h4SXKEn0ozqmfcNjyzfnJ
         wyyE3rk90ftL0qo3+NP8fo4y8TmRmc0mss/LNx/mTJLJJN9LvGHDjWWCznozFU48yDgH
         I6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=adnUSnXkGhyIZzMG7EwucPUPj1d6brq/oY3Xv/WgG/o=;
        b=q4JiHDOti8VCe+C2jgx1xhz4niRM30Y2uAVYKpR+Tt3hZPl3nclW5PoIJX7FgOFLcn
         VMPJWoQM0fFxGAOiJcRlm/OXR042ZajL125e1EmHGrfqpcgAgZSqbFNBtJHrrrv2lYOx
         ha7ZRkSECygakZYdzzd9I3AiJwPYxJvVJQ569i3nakYbPLyO7/m7DlVy1XOzkZOvjoN+
         xi545AWuV8UDXkzgX+TE5T2h8NteRX5Cjacg1bo6S6E8/6vs2kJB4dcqAsUfzSkwA6B5
         +yMhQKug1QuMdAlSKcksTMYcmtbSMO1kwBkJ0hskyO69/FfuJAjY00A0oLnw+FL/DDtG
         CT3Q==
X-Gm-Message-State: AOAM531WYCs6i28HM3Fnd/y1/3Z4wLmTmQWYC15HC5jEcA5fifO1PlY8
        ZT7usDksJSfMOTroyHwwJdU=
X-Google-Smtp-Source: ABdhPJxcjFmVyEpGaKjDuo6wOZr5ovFMRh1gxEf0iur6u3hST84OMkjq7RajW4DsmsJjzIyRTrxHoQ==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr8775200edv.333.1617270257903;
        Thu, 01 Apr 2021 02:44:17 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id q10sm3179468eds.67.2021.04.01.02.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:44:17 -0700 (PDT)
Date:   Thu, 1 Apr 2021 12:44:15 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm: dts: owl-s500-roseapplepi: Add ATC2603C PMIC
Message-ID: <20210401094415.GB1993499@BV030612LT>
References: <2e0a2931ae3757f016948e7c78e8e54afa325ae0.1615538629.git.cristian.ciocaltea@gmail.com>
 <20210401052929.GC14052@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401052929.GC14052@work>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:59:29AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 12, 2021 at 11:49:27AM +0200, Cristian Ciocaltea wrote:
> > Add device tree node for ATC2603C PMIC and remove the 'fixed-3.1V'
> > dummy regulator used for the uSD supply.
> > 
> > Additionally, add 'SYSPWR' fixed regulator and provide cpu0 supply.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks for reviewing,
Cristi

> Thanks,
> Mani

[...]
