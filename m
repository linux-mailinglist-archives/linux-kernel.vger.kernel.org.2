Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB22F32570F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhBYTtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhBYTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:40:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2DC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:40:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w18so3758831plc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/8zsvP8ZD+BzhQTmjNZb0GRylgsz/jgQq6EA/tPElnY=;
        b=RUC5y47WmZ1tKvWDlNLUAtJpvYi/UDF6WEs5EROUyFlt/3tcvu0kV6ZKn2aTL2HCPV
         YJN5SI5CsmmzTArWdqhWOWNy9KhTqslDZf6+y6wgbWqXWa2kczwbxTPKdD3+MPeY2QoF
         WA8ozU+TnARg98N8NEAGEOlsdEnoswe6iSf48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/8zsvP8ZD+BzhQTmjNZb0GRylgsz/jgQq6EA/tPElnY=;
        b=glwMcvxxEHwKyL0jXlQlSPzdklGjWnUoMjaXtcdL4fkq/qASuAC5dFYiP2HhODQU91
         uEcyIMnOuC/Lujnm4ZTzLF+uQHJjxrTdMj72VUrxo8C6iryd8yiRq9fXsrH6yKDdsXw7
         HLbs+S7cBW/4E5tYtzEvswvyg3Uxs7ZRPPegvWfq9pyNbazQPyjyDODfURLtjI4GCJvw
         175nR0XQpYc4r20pxkYwY+nzwPxRtN8RpJejn7J1BeKwZYc0mHbKPcFiOn/+R44W/Jtn
         NGlQpew2BxXIL1NdKof5F27EB38pXDBlRGKyj8Wo25KoGm8Ueo35tm1htZuhCsBkCl1/
         58lQ==
X-Gm-Message-State: AOAM531UvSA/VeVE0w4198jv0fNGjEXbv/OFEcEUI1lCdt8RJqj1EDes
        bvM5cf19FqgcabzQlfNI/NX63Q==
X-Google-Smtp-Source: ABdhPJzKWL7GRHfC72BT6EovBap9fnhgpyQnR2tFTo3OvPxgNVpUkOH4PGhFEKLAHVYzLkttV3wQdA==
X-Received: by 2002:a17:90a:ba16:: with SMTP id s22mr12230pjr.88.1614282013595;
        Thu, 25 Feb 2021 11:40:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id m12sm6396684pjk.47.2021.02.25.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:40:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d311b75428da7d87638208490fa9a64b5ef15d6f.1614244789.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org> <d311b75428da7d87638208490fa9a64b5ef15d6f.1614244789.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 7/9] soc: qcom: aoss: Add AOSS QMP support for SC7280
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Thu, 25 Feb 2021 11:40:11 -0800
Message-ID: <161428201178.1254594.5790623991406122509@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-02-25 01:30:23)
> Add AOSS QMP support for SC7280 SoC.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
