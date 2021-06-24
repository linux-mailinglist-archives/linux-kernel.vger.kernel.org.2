Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7223B3129
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFXOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFXOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:22:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:20:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so3580307pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eePxOylteKhPrwCmFLtrOPG3Jbi9jerQFSgyqSZqUn4=;
        b=vip/2UOViEktkOdwzuanBuKhWKbh4opOGgwV7tOKelwffEpwZ39caDyCkNsvuHBMAZ
         zjrhD5ieYH0K1VpyRGiux+2j2vR+wgMtQD/tibdAKs+X59WSDPR18rDvYixuqQSxBM+g
         yZWqsH1qOdEFthcBajmIZKGxcgRaeVEtyydjSf07uMbK9jqUKLG+bHLgF6lmc/A6Gyu4
         kUw2hLj12tMe537toJnbWLPx4DzlbGi9exqc4xNLwJ6niKpUW56Yt6XtsnAp/2pC+sUc
         DfKtTMSLR5GkljtQAbRl6WsU6JEwcURAOmx6qSmqV5oOBoUBxem/Abp0i1kDkYtTjz65
         5CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eePxOylteKhPrwCmFLtrOPG3Jbi9jerQFSgyqSZqUn4=;
        b=fL0Js07HFK3bQW/gx0OGrc3mESIWq/ELyX5kpO35xsszqUcGpNYq72MTTA+5Jf0Pf+
         XDpQ/eCXt5UUYnsIsOPVQGbTLt9v82MltzIsCw1i1zWO2GCI1zF69gmCV750DFaZCMpi
         4O7bnw2sF/iCqrVY0l3zRkS9wIq6OzifOLb9hsWy8o9ZljJpuFhdkRDolzZ+kok22BLt
         asPvD/GEVy5v64Q20ZHGKuZ/ia+tTcP/seuov07tHHuebOoedDkVN+UBVmvdl4RlROx/
         G2FBDPZ8mkm4C6yAkp1//2W5Wfv1RSYmtm5pJ71MKQt74JTA9Z5ENTHEmoxAtaldxvtO
         Vrtw==
X-Gm-Message-State: AOAM530aDyrz45nhLBA2kqq5lbvVVI1RM3fkkfvQ6GYxdyIyqURtvt9F
        OPCxM2RqwXj4zx8f4ynTERB6
X-Google-Smtp-Source: ABdhPJzmvSCIQnC6b5rEPQbivKrVRN6tDUkGdG/pNSc8ZqPka4XTF0mpoM4Bwu4fXtBcYeiMnNkvUA==
X-Received: by 2002:a17:902:f212:b029:123:78c0:84a6 with SMTP id m18-20020a170902f212b029012378c084a6mr4552099plc.31.1624544426931;
        Thu, 24 Jun 2021 07:20:26 -0700 (PDT)
Received: from workstation ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id u5sm3095087pfi.179.2021.06.24.07.20.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jun 2021 07:20:26 -0700 (PDT)
Date:   Thu, 24 Jun 2021 19:50:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 0/8] MHI patches for v5.14
Message-ID: <20210624142022.GA6108@workstation>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
 <YNSOq09BHPIPmmgF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSOq09BHPIPmmgF@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 03:54:51PM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 09:46:08PM +0530, Manivannan Sadhasivam wrote:
> > Hi Greg,
> > 
> > Here is the MHI patch series for v5.14.
> > 
> > Summary of the patches:
> 
> I took some of them :)
> 

Thanks! I'll send the left over ones after fixing the comments.

Thanks,
Mani
