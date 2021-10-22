Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADD437A76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhJVQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhJVQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:00:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F50C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:58:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g141so3315316wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oxg7wtYVb2I8ZNupHXd2gl7ipYhOJwG6Q/eeUjge9ic=;
        b=mObrmk3neCUnsocnuZ1ARAuQDBLO2Pv0jgshOruwD4Pp1dH5du/dxLfpPtLC/BK8EK
         gkrEHLoo32P5ycx9wBLj8bRKBIBLeexPKSM0epgdp1a/fcAmHkIltMNndDtKcvzGBPDL
         KPPAuyn+L/K5FiL6s/mWb6aA9hXCS/GVW7VwzuSyJp2M0aKTSy65rO1Z6tpQWZOe9vpm
         aGZ6hr96qqs3V+dcTjqezDAyQtuv4k/Vld1b/dbRObxiLYrFcsxNSiqw8dJMycqfnWpW
         skkg7umXzpJATMSqK2EPoHMaP+qFuwTniSJeCI5nF/6BLbXqVClv7sz3R2URE3Pv5wd7
         uNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oxg7wtYVb2I8ZNupHXd2gl7ipYhOJwG6Q/eeUjge9ic=;
        b=NL02SUcRAhB//YaSSyLJlhIgOhLmUhAS8A2HcyD0lmElU6liCFBODFaR+t0fVRGvkI
         1/8ye6YOuj57dYl8e2lK5BVU95bKo0edzhz42frnTugMExWzAAJO/uLBy4mPZHM0k4x3
         q0QnSkl6TWtNNzFFiKy0zx5J+Bk+LDAoNbw0552aQHaY3B9q+hHNvonXH66AFc9vVzUx
         WbBjMwEXsaA6eHGlD8ydhLg09Y4b4x3U7MAGELWPPmlXbxzYuezuUeFrT4tNfQXMwg6Y
         nKNlqS1KP4K/3DzI1ExT2Jss1pmK2nW9lEwJz7xcb2KYWPSmSM/47QQY9fSdWT+LuZgY
         bKtg==
X-Gm-Message-State: AOAM530Ho9d4VaZT5IcDkDrJ+9olKXcOKOZQHS35UTHtvAQzPcQfprkF
        ZC53psw+lgQVL19GjEXPdH0=
X-Google-Smtp-Source: ABdhPJyuX+UxDE43oOxLtTPF+QzO5lezSDRse91WnwSQJocAbTWj/Pta2ldHRGdH3fuIR8C0LSUAqw==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr587438wmb.37.1634918284369;
        Fri, 22 Oct 2021 08:58:04 -0700 (PDT)
Received: from ?IPv6:2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62? ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id k17sm8152897wrq.7.2021.10.22.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:58:04 -0700 (PDT)
Message-ID: <bf2a82e5a5f296ea66bda0cef84acbf78e88ffe3.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 5/5] staging: vt6655: Rename
 `byRFType` variable
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Praveen Kumar <kpraveen.lkml@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 16:58:02 +0100
In-Reply-To: <049d4b3e-ed32-9b48-0c2e-19f9af95ca37@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
         <f0b6818d2b15982081bebaf14f830f4646f61fe2.1634826774.git.karolinadrobnik@gmail.com>
         <049d4b3e-ed32-9b48-0c2e-19f9af95ca37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Praveen,

Thanks for taking a look at my patch.

On Fri, 2021-10-22 at 19:56 +0530, Praveen Kumar wrote:
> IMO, probably we can sync RFbSelectChannel as well with similar
> notation in another patch.
> 
> >  bool RFbInit(struct vnt_private *priv);
> > -bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char
> > byRFType, u16 channel);
> > +bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char
> > rf_type, u16 channel);
> >  bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16
> > uCH);
> >  bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
> >                     unsigned int rate);

That's a good idea. I plan to clean up `RFvWriteWakeProgSyn` completely
first and then I can move on to this one.


Thanks,
Karolina


