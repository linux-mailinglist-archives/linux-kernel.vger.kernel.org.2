Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7255733D993
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhCPQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhCPQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:38:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBBC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:38:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a8so10702782plp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0cc7JhkiLOxWuVUi1UPI+FxAcFJ60AAFW5ewV8BnPXI=;
        b=xeHMexJ1ku45FQSEVe6rCoecXA7hrL7Cq5YjnpB3e9h7c255lcDkkMfs2xsMPk8SPN
         A69SA9WHVoMouqd3krmbreqQCjSRj9zX4CwglEMK4NAX75pVQEvGMtbT1TJ1Nkdp81Aa
         6HVsNJfeeUu+XOYtMmbK1cVIKpuRIcvCYJ2OqYH2fndZ5kfS4vjNJUKd8nTtqPxPyxHt
         qAa/3L2wXcl5lBn7we9EFozjX+h9pdwX/o3jV9unuy9l13GJrvb98X+n4WBkbZaJfNSL
         Txu3P7FpEVT6F9KQxOU+MmQ72jnF54VdvikT7c40fFwcPtG2J0QfeBeLlOIpvZtqBWWq
         c6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cc7JhkiLOxWuVUi1UPI+FxAcFJ60AAFW5ewV8BnPXI=;
        b=P1af8Em1+SRCtsf1LfQF/vy1IzVuV2IimbH4bhhtg19Kk5Gga0AtEMl4A6zIHzxX5L
         Lh7IW8R5KYE0xx3GkyhWp28FOPi2r7pggKrbep4Tka+cI6rMmbNLIasmX3MR30N9pwMJ
         1arFvyjWcP0sBhqZQ1SgqGUpLK4WvYFXEojVgiTTOlfBf9+hW6HF7jC3QYLcRB3r0Or+
         u+dNeksLj0fLVCx0Yy5kIlVxVyzyMIpe6btR95wCWcsViYU4akaQgsVhMED+cXMgQ7FO
         b6+HIvJgkqRkiKINQMOJ6kp+bgyjWgfivSUsnuor79Y47lNoKLBTVlzMCj2+ouha0cqh
         m1Qg==
X-Gm-Message-State: AOAM531j5uqpAtMfORxRWbL/Rdb6NGQKlUV0j5elC1T9MZRyg2p8NS7r
        4AApMyVaiLZC/7J8mB6tA1h0
X-Google-Smtp-Source: ABdhPJwCBy3Z3oPy7BRTNAqMJedmHDAF04IayrAFqKGFJ/bTmVIy7gtClERs4qcew/blfzYpQiJSrg==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id bd6-20020a1709028306b02900e6125c1a3amr363428plb.65.1615912714934;
        Tue, 16 Mar 2021 09:38:34 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id q25sm16860923pfh.34.2021.03.16.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:38:34 -0700 (PDT)
Date:   Tue, 16 Mar 2021 22:08:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: ipa: QMI fixes
Message-ID: <20210316163828.GK1798@thinkpad>
References: <20210315152112.1907968-1-elder@linaro.org>
 <20210315163807.GA29414@work>
 <3e01bc57-8667-4c56-2806-2ba009887bd4@linaro.org>
 <20210316032557.GB29414@work>
 <54f8962c-6503-8d92-2a6c-875c112441a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f8962c-6503-8d92-2a6c-875c112441a4@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 11:00:37AM -0500, Alex Elder wrote:
> On 3/15/21 10:25 PM, Manivannan Sadhasivam wrote:
> > On Mon, Mar 15, 2021 at 11:50:15AM -0500, Alex Elder wrote:
> > > On 3/15/21 11:38 AM, Manivannan Sadhasivam wrote:
> > > > Hi Alex,
> > > > 
> > > > On Mon, Mar 15, 2021 at 10:21:09AM -0500, Alex Elder wrote:
> > > > > Mani Sadhasivam discovered some errors in the definitions of some
> > > > > QMI messages used for IPA.  This series addresses those errors,
> > > > > and extends the definition of one message type to include some
> > > > > newly-defined fields.
> > > > > 
> > > > 
> > > > Thanks for the patches. I guess you need to add Fixes tag for patches 1,2 and
> > > > they should be backported to stable.
> > > 
> > > I did not do that, intentionally.  The reason is that the
> > > existing code only supports IPA v3.5.1 and IPAv4.2.  And
> > > these bugs seem to cause no problems there.
> > > 
> > > There are some patches coming very soon that will add
> > > more formal support for IPA v4.5 (where I know you
> > > found these issues).  Those will not be back-ported.
> > > 
> > > So these fixes don't appear to be necessary for existing
> > > supported platforms.
> > > 
> > 
> > Hmm, okay. Then please mention this information in the commit description(s)
> > that the fix is only needed for IPA4.5.
> 
> Mani, you ACKed all three patches after you sent this.
> 
> Are you expecting me to send a new version of the code,
> or are you willing to accept the series as-is?
> 

Are you asking me the question? I can't accept IPA code.

Thanks,
Mani

> Thanks.
> 
> 					-Alex
> 
> > 
> > Thanks,
> > Mani
> > 
> > > If you still believe I should have these back-ported,
> > > I have no objection to re-posting for that.  But I
> > > wanted to explain my reasoning before doing it.
> > > 
> > > --> Do you still think I should have these back-ported?
> > > 
> > > Thanks.
> > > 
> > > 					-Alex
> > > 
> > > > 
> > > > Thanks,
> > > > Mani
> > > > 
> > > > > 					-Alex
> > > > > 
> > > > > Alex Elder (3):
> > > > >     net: ipa: fix a duplicated tlv_type value
> > > > >     net: ipa: fix another QMI message definition
> > > > >     net: ipa: extend the INDICATION_REGISTER request
> > > > > 
> > > > >    drivers/net/ipa/ipa_qmi_msg.c | 78 +++++++++++++++++++++++++++++++----
> > > > >    drivers/net/ipa/ipa_qmi_msg.h |  6 ++-
> > > > >    2 files changed, 74 insertions(+), 10 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.27.0
> > > > > 
> > > 
> 
