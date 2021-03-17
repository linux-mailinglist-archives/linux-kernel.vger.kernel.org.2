Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BD33E30A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 01:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhCQAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 20:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCQAym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 20:54:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:54:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4440473pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 17:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=cuIoZ4QXp8Z0h3RIlytaSjoGTGhigBw+9A7ospwe3Vg=;
        b=gfOJV1hiO3jT50yDma6Xk9HrilYAvCM+NI8Y+H/Q+S98Upn8J96yIm1c4xAlpKWOZM
         3RemXLeNvTLzPS/097OkzBjE7bes7SBi88eJMB9P0eoNRWxxTMgo7089G+PjTji2qQPd
         gAoD+z7rpnTkZ5AShq7Nv7N96qb43DZcwFogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=cuIoZ4QXp8Z0h3RIlytaSjoGTGhigBw+9A7ospwe3Vg=;
        b=Q4LUT8W0zftqeVbhCy42W1SwDroNKy4e1AiWDK+jy0TIWgpIICFilEPqxm/hYrpxrx
         eRZ3zNs4hvHziUj0GbOr6g3vg3sa83JXjm3j5P4Di7eyAKh7ruWgosAaWSJxw5s7TiVQ
         c/REZOSZs//V5xcJfcyZPoI9lDJNx+s453clrmlBc92Suh3mGlvVf9YDKjecREaT1xI3
         BvVAgH8eUF0reZ6zWVOMsARtH1Hhh6pytZ35AJ6jn2NFg937ffniM7l/Ok5kScKoFX2d
         O+LlQ29xDAZk2MgslGtRKqHTEyrC4s6kgp361p/ijrenXGIF5iSVj767DjyJVBfK8SJS
         N+xw==
X-Gm-Message-State: AOAM530AXjkIJTEqSLrIHsSfQzAydA9bYmdonKofNaXqKRfO/+jzgh4O
        3JeKmAPXNuZch0JDfkli5Kyn2H6pGWTn+w==
X-Google-Smtp-Source: ABdhPJzbcwVEljwSW5+/Wv1c6VeaGzC2QmTlaukqgzUT25tDbFpNnpSQ/SejRptjh+IUx4kDBv5LXA==
X-Received: by 2002:a17:902:fe07:b029:e6:6cba:d95a with SMTP id g7-20020a170902fe07b02900e66cbad95amr2039608plj.70.1615942481221;
        Tue, 16 Mar 2021 17:54:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e1e0:9aee:aecc:ef78])
        by smtp.gmail.com with ESMTPSA id t6sm503062pjs.26.2021.03.16.17.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 17:54:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615914761-12300-1-git-send-email-khsieh@codeaurora.org>
References: <1615914761-12300-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v3] phy: qcom-qmp: add hbr3_hbr2 voltage and premphasis swing table
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Date:   Tue, 16 Mar 2021 17:54:39 -0700
Message-ID: <161594247923.1478170.8971059871794226072@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-03-16 10:12:41)
> Add hbr3_hbr2 voltage and premphasis swing table to support
> HBR3 link rate.
>=20
> Changes in V2:
> -- replaced upper case with lower case at hbr3_hbr2 table
>=20
> Changes in v3:
> -- replace space with tab at hbr3_hbr2 table
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>=20
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo ph=
y")
