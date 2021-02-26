Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DD325A82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBZADb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhBZAD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:03:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A33C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:02:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so4755824pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1Xau9fAA+oyzsKfmbUBtrhsYSTeSRGLtf1MZ+LRpR0=;
        b=DZw9d6dZ4dF3xXT6RmIl+a0Ro9P+0xvD2rgi9oON73SgRjq9xC8Tjo5WQVOKrAKEkf
         K93lamErepifoCjQ+4M0WFoxWwL33gnAR2YxezXNNYi54n14/RJQb5l94BXhwgEHQgA1
         rMrNr82bpeTGHC7qGqvIoZlAiZ4r1TP9swTEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1Xau9fAA+oyzsKfmbUBtrhsYSTeSRGLtf1MZ+LRpR0=;
        b=Wquh9x8HRSrvgtzFCFBRT3AuNlIGHNWl9DB8UZtDcgDRiCyRI/JVatfZZhj8WEQd8F
         b4LIQy8QatTgTIjAKZmhQilVbm9TqZZH5UyxgFdGvTvjQMW/ySi/JPvM6FXAKCMAqR3g
         oej/DK8u+RmzUFjypp1g0AN3HKlcCnI4URx3dLD+A+hRPhvPOJgGh6Txu898S7DDDoob
         uDZDYlY5tMCt1wBCuG8T8wjoXtfMIj7fy4xlGFumzR2u6pA06+Pcure/bw7PdA56uEY+
         in6yzNx06W5SUgelCUdzIN5MBlGbPb+RI9FUny+R0+1PbRkR/5nDPq5eju2QinxQup7w
         nqqg==
X-Gm-Message-State: AOAM533DWcJgbmdXOvG8ZbzVmYydaj0nYgpejOdBC6lpQHBci9S1w3st
        c/XwcmXIdNR+/S6r0pNi0vbvxg==
X-Google-Smtp-Source: ABdhPJz+xYeAGLx67OzoNPD6mZ2XdF3cVWL268Rop+nHNAENyKU1Kk3QYYIH5O8HNGslxXk4uci3Nw==
X-Received: by 2002:aa7:90d3:0:b029:1ed:7eec:b031 with SMTP id k19-20020aa790d30000b02901ed7eecb031mr428837pfk.58.1614297766588;
        Thu, 25 Feb 2021 16:02:46 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id b7sm7163743pgh.37.2021.02.25.16.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 16:02:45 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:02:44 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] arm64: dts: qcom: trogdor: Only wakeup from pen
 eject
Message-ID: <YDg6pK26XXDvRHgn@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.5.Ib9672bfbe639c96c85408d6f0217a2609eb0b70f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.5.Ib9672bfbe639c96c85408d6f0217a2609eb0b70f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:02PM -0800, Douglas Anderson wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Configure the pen to be a wakeup source only when the pen is ejected
> instead of both when the pen is ejected and inserted. This corresponds
> to wake source requirements.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
