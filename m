Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE9C363305
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbhDRB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhDRBzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:55:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F0C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:55:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u11so12339436pjr.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 18:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7GHsdqrlMVflwVFrBOZtxuiC9SiSpOvDXhaAOahe690=;
        b=CMVMP8Q/+Xb+6lLEo9IsIPV1yw0R8pfENjultUzDJgcn7Ad5M7Hl4kVykdVCG/AumT
         rJiYzWdP34nyTUUDLzKWoByJgT/l2GCb902Q0KBvGMfy2/NbN5wOLdUYgDR3n7Terytp
         8fYhe304sFweYIvO2Grxwq+8cTyHAilTH6LdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7GHsdqrlMVflwVFrBOZtxuiC9SiSpOvDXhaAOahe690=;
        b=Vxhil6Htbuqb3vn40+2TwMnM/eZng2M6ghKSRhyswGyOD8SM6fiPGoz1zyjolbYyES
         BC/40kzxRFP38qb/z4TS0CRW/PaiiL25C+Y2u+/TD3aI4fFZYnJO775wi3Fhm20mWoHI
         epE4cYCqqlIGmodmg5D4heqCFnnPw8OnmnPLMKVYHzPJUAHLUXxgtWmVKLn9jGJKIMFD
         +3mr5G8MBHYB/84SldUoGWaHTefIMl9klI8LX4IXcSXITTNi/x2VouMTNWm2Ap07NJ6x
         vKiQPZ3ZD6uzMGR3b3R8r9sB1R1nbbzXJV8NUUPY9yZKyA4bqolj8YaHjYEfgO4NzVSb
         76aA==
X-Gm-Message-State: AOAM532nobttklnxqroarZQsdR5YVT5P3tNkOnbqOr/U92X4t6UF9L5S
        A17UV8GNEmb+4On67BYmtwLTIGWW9UeUXA==
X-Google-Smtp-Source: ABdhPJySFT82Ji4WeOETkW1pVIcayA0AhD90jgCrrz36SWCnCOPXEJvmQAh7o2rYCibfHOIBRmEQFQ==
X-Received: by 2002:a17:90a:c281:: with SMTP id f1mr16948378pjt.58.1618710922403;
        Sat, 17 Apr 2021 18:55:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id gj13sm9990868pjb.57.2021.04.17.18.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 18:55:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618574638-5117-4-git-send-email-sibis@codeaurora.org>
References: <1618574638-5117-1-git-send-email-sibis@codeaurora.org> <1618574638-5117-4-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 03/12] dt-bindings: remoteproc: qcom: pas: Add QMP bindings
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Sat, 17 Apr 2021 18:55:19 -0700
Message-ID: <161871091962.46595.17643804074579935893@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-04-16 05:03:49)
> Add Qualcomm Mailbox Protocol (QMP) binding to replace the power domains
> exposed by the AOSS QMP node.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
