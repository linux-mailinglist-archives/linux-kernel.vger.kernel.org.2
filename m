Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F957363301
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhDRBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhDRBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:54:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C9C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:54:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so18424946pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=SbmkNJObxP9556wdW+xlQaE/Mp8r2OHG8tzhh7P27Xs=;
        b=LhKV87qH3gAOImsHtS8QBPR1qLMUI4TzeYbUJi0VIMueON/LYIs1FZtncqgfHHMYEN
         Wr4NoLqKLHgSEhbIHZK6XBXuuE4BMDE0QZxOfabkvABV0G9fZQ2Z8uEYd94VZpFThHbm
         uGH0PihCTwxkuhw2y+zXOMbtHEfPsP7RdaLNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=SbmkNJObxP9556wdW+xlQaE/Mp8r2OHG8tzhh7P27Xs=;
        b=UnHTZbgfwZKl3KNh5EJr5uxsE2R4CCTmlDIBdffhKY2X8Z3AEfbd+BoQdbCclI+EIE
         cr8HKZ+N8iyw4TtKeYWAoF6j1ZoB/dadjZrhAzRt/AvuofjNx45U4iywqnbC3JVzibC3
         BnHwKwCxPy5om259rfCGspPDU44pO+Yx7i8mK05x+8yx1XpKzwDe9RNQgO2aOiFB/aa6
         AjOpCmozhwxqyNJn0mZHXJ+sf5nCahlD4RC83plbcxBXi20BimuYiVJ+qArcOqbQMuXH
         Vzbzhv3XwrvyQEDSq6tDmORYKmqfvqUiUBb0fmfdK3IG1OB4EiU9AsxU52F1OjKq5faq
         Yq9g==
X-Gm-Message-State: AOAM531yqOFVlVVpJ2vi5qa2L+8IbqG4dveog1qYCnd0iw6Ji0wxZT8h
        avrTB8lj98RicjrV/gOJ8hTpnw==
X-Google-Smtp-Source: ABdhPJyemFBIhm9Dndl7HZBNNf1HHGiN+9UjdhBbcR/ZeXECMvMKe2/UdI9Wmi8AF9bqnYYeHjfsUA==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr17597498pjb.118.1618710871167;
        Sat, 17 Apr 2021 18:54:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id a16sm9039400pgl.12.2021.04.17.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 18:54:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618574638-5117-2-git-send-email-sibis@codeaurora.org>
References: <1618574638-5117-1-git-send-email-sibis@codeaurora.org> <1618574638-5117-2-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 01/12] dt-bindings: soc: qcom: aoss: Drop power-domain bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Sat, 17 Apr 2021 18:54:26 -0700
Message-ID: <161871086661.46595.17217922888505535304@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-04-16 05:03:47)
> Drop power-domain bindings exposed by AOSS QMP node.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
