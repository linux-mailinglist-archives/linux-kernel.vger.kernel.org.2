Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766C332BBDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358764AbhCCNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842902AbhCCIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:14:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965BC061793
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:14:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 201so15732646pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wUWoOU42RDaUQRgBnINOK3TjMzgm4jJFMlkGac7+hJM=;
        b=besseKDVD0/72X5vEHIyIQldUQrP21NI6g+K8EFhJsh+4l3gZ/0iFDZWOHmIGzw8Yz
         wmO648VkjuiQx5lubMTk6cLsoVFBHWDXviYg2U9Q99/fHI5CAgH6XjTAjd7EyI5iyxlg
         mYMzoeii/ThoPpW+OzhlMHUu7kGQhc98kPnI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wUWoOU42RDaUQRgBnINOK3TjMzgm4jJFMlkGac7+hJM=;
        b=iif1kNCHhsndKjCitXwSl0UnE4j6p8c+VC1Feo2/mA9fKl4puBcG2JQQ2fHksdSYsl
         u6DWcNkEohO4bvjN3LsK6Z7VwFQK045+OQUsW1NK5ffBGUEffXp4B2NfgvEXMGgtEFHa
         9pgMC/pbGydn2UClfkYJNWHlVufsSIKM9nu1pLoJnXzoa6AtWJcn4xe5/FoF7LPDyj7t
         EubC5P5MCv8szZKZ7ULd0Vr4qHB1KF0+zKGbQevfaUAeEAQ1kqHukbjm1B1cul0QmajP
         TeKPCl88gdBxObyEXY/KJGYWIgKJtYvhyBE3HEEaBe7kOf7NnlDrlX3oRVc8Hi+Jwlo0
         0OxA==
X-Gm-Message-State: AOAM531O3ytz8L6bjQ7oAB93bqLflKKQgXJl80bJ91m2Li0EwujfB2Bk
        uCrM78zavqHamxs2fElF+c1AOQ==
X-Google-Smtp-Source: ABdhPJwacCK6UzxWBwUK7UBjLx+1WJXa4U024sIxMGyTVhwIGytlidXCoHil9Qnw2mtpa3vQpxzvuA==
X-Received: by 2002:a05:6a00:1a44:b029:1d6:4170:ee0b with SMTP id h4-20020a056a001a44b02901d64170ee0bmr23592003pfv.57.1614759240448;
        Wed, 03 Mar 2021 00:14:00 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id mm12sm5518594pjb.49.2021.03.03.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:14:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.2.Id27e7e6f90c29bf623fa4880e18a14ba1dffd2d2@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.2.Id27e7e6f90c29bf623fa4880e18a14ba1dffd2d2@changeid>
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: Move sc7180 MI2S config to board files and make pulldown
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:13:58 -0800
Message-ID: <161475923860.1478170.14358924571540114935@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:26)
> In general pinconf belongs in board files, not SoC files.  Move it to
> the only current user (trogdor).  Also adjust the drive strengths and
> pulls.
>=20
> Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Tzung-Bi Shih <tzungbi@chromium.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
