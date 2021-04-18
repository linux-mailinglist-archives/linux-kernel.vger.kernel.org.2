Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64261363329
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 04:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhDRCD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 22:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbhDRCD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 22:03:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DCFC061761
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:03:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso16612481pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2UkCdcxCkeQ7ocXEI0Bytf+xWLtA0Qk4M5dxvPYcA7Y=;
        b=eICm1if6gp7Ae6efb8ncUSr6vByRuHeVXQFK+xnQ943WgFkJeGVGXu5H/b0HCyaFiH
         tX1CUeBM2OGDajDAJp6eZlavBXjpIpaJPRStW12cToGpbpdnX7U43ZdDQOtJj7k7cHWH
         TCOPbrDOY+JkNBPpORy64pBTk8WUaVY9+anNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2UkCdcxCkeQ7ocXEI0Bytf+xWLtA0Qk4M5dxvPYcA7Y=;
        b=gmumVgrhUgW4PdqX6kfPIGPuJevI0nlRVeNbBpiYmFNVogCoCq72xpCUq5S3j+dbwP
         QBmrMbeJtGVBpEbackqO30YRpZ1WcIFiXWu+9a1DNwGsP6BkNnP8pS1dsrCiua5Id1ay
         NSMoj4Z149PnfP4IsmE4Y9LxQmkLPoJxCUrB7UoUEQebN69aOY0sjiTpgygW7xVLYKGr
         9TJfI5sbzmqCAQ7D5JzmE7HSejvH3sGR2Bd2YBVZlDyGJHDM03AZKdwDevP8HITK81HD
         M9+0XjtAArWIOZOzQJ+BPOZL5sUhvV9JRnyxeJDOrheBYSmcSBGa4lqbdi8lhrAHsr0u
         wB/w==
X-Gm-Message-State: AOAM533YO7dbEmGqAsVeMXCZGNIBbFwrp/vl+oBB25eto8r2OO/fZ54P
        gk7I9pj7RttP3KAng6FNH+IHtg==
X-Google-Smtp-Source: ABdhPJz+BPS7QP/pDLIllhg2nCqaVJIg+JdtU7rsoYM0r9g7cwSIGnpk5QD+k3MGQX38WOYOrSrbKw==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr9637816pjv.99.1618711408774;
        Sat, 17 Apr 2021 19:03:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id q17sm9679712pfq.171.2021.04.17.19.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 19:03:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618574638-5117-12-git-send-email-sibis@codeaurora.org>
References: <1618574638-5117-1-git-send-email-sibis@codeaurora.org> <1618574638-5117-12-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 11/12] arm64: dts: qcom: sm8350: Use QMP binding to control load state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Sat, 17 Apr 2021 19:03:27 -0700
Message-ID: <161871140708.46595.7272450915110466257@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-04-16 05:03:57)
> Use the Qualcomm Mailbox Protocol (QMP) binding to control the load
> state resources on SM8350 SoCs and drop deprecated power-domains exposed
> by AOSS QMP node.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
