Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B443EA87A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhHLQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHLQXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:23:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:22:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so16082051pjr.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+SoaWmY5HiaLZfPNIYOXjYhH2JlGFXeFO+klyMpf2eo=;
        b=IRw62K5TM6LB1N0TTJ5Kldi9LyBoBKWJbFxSVgLXGRqAKzkE19sQmwsJNHbZCPJln3
         ZGrxdRhwh5xhb8HNvwm92fAJUdug+S+aQni/EOqfPRdcdvji+eQh8HZvjBADOv0e4sSp
         qtdLuBLJNiqj9nhbPcT+0TzkPYkQwqFF1jU1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+SoaWmY5HiaLZfPNIYOXjYhH2JlGFXeFO+klyMpf2eo=;
        b=i4ZWTUcIr2Oz8wAii/xw7ULdzjv7BTaqhE0AFraCxNu5J9PHroPqqEWnb03eN/5RLy
         sARC2l3Rvau4ej0FzHjqV72iZJViPViskcCEvgS6YyDvU67Idci2KJ6rE1UqQNypa7Nl
         udeo7Q8JsMH/I9zlFXrp3GlhcM2cmk74FX/bzrtGiDLkobeR5RgZ+wxRr45Pr8uK47CS
         xfKh/j561VJmTJ8uRyz8KRevHu2vEQr6bh/Mp5eyD0/2/lWqUkyzD/kCDFMxleyjlGc2
         XewgwJJAdnPvlvclpgxkoa5vJ23QL/J1e+40vTSi9LMilq8+AwxbSe0NQd1fLDnnmspi
         AzMg==
X-Gm-Message-State: AOAM533W0XkcC31/L14EJ6cGEcPLiSN0DaxLPK3v1L5exEDTeMb+5U7B
        IGXaEuh/vp99MB19YAdHY05s+Q==
X-Google-Smtp-Source: ABdhPJwuvudA8aD0i3KortJevgnnespzG+N9CipcYX1YDChnc6LJBuJn1QL7lVDg9Wu6s465uHVfEw==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr5157016pjr.213.1628785354590;
        Thu, 12 Aug 2021 09:22:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6683:43e5:ba4c:d76c])
        by smtp.gmail.com with UTF8SMTPSA id n20sm3694942pfv.212.2021.08.12.09.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:22:34 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:22:32 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: Re: [PATCH V5 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
Message-ID: <YRVKyJmJgwQObwFQ@google.com>
References: <1628754078-29779-1-git-send-email-rajpat@codeaurora.org>
 <1628754078-29779-4-git-send-email-rajpat@codeaurora.org>
 <YRUsr6x9vqvaBB9i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRUsr6x9vqvaBB9i@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:14:07AM -0700, Matthias Kaehlcke wrote:
> On Thu, Aug 12, 2021 at 01:11:14PM +0530, Rajesh Patil wrote:

> >  			qup_uart5_default: qup-uart5-default {
> >  				pins = "gpio46", "gpio47";
> >  				function = "qup13";
> >  			};
> 
> Wait, why does uart5 use the pins of qup13? Is see this is
> 'fixed' by '[4/7] arm64: dts: sc7280: Update QUPv3 UART5 DT
> node' but I'm still surprised ...
> 
> Doesn't 'fixing' this break devices that are currently using
> 'uart5'? It seems those devices would need to change from
> 'uart5' to 'uart11'.

Apparently the above configuration is bogus. I checked the schematic
of the IDP which uses uart5, the debug UART is on pins 22 and 23, aka
qup05. It seems uart5 works in spite of the bogus pinconf because the
default for the pins is their QUP function.
