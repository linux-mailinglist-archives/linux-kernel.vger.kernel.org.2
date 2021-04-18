Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF8363314
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 04:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhDRCCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 22:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhDRCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 22:02:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584DC061760
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:02:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u11so12344301pjr.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=6JZfpGN3qGmrk5Z58+AgVl4ZGK5/VcZIG69yaXXxkhY=;
        b=Rjew1y3WcsRimPk4idI1odoWNwW0hh9VFnmi34eya1uwbq3ioVSVcTgfbauU0nqKRX
         JUqIuRzSqLxpEgstqbJ1CVLQgBLIZAOWH/mKTjVrODVQKMKOE57Jx/kP5sN0R7ptul/X
         dJDn0OzCrgmmKqpejCIZfNhOZL9/C478Enju4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=6JZfpGN3qGmrk5Z58+AgVl4ZGK5/VcZIG69yaXXxkhY=;
        b=ub5v3/PL8aUOW6F4CN1kWl4CMFLGWJ7fuv81fPp98sfWA8EMz1V7XTWdwxTTPS55lq
         AChWfAjeGg2k7K3xL3oHYwewaqSCeaOptckmHb391qN78hYT1ilKaW8DHwnaaOde4c4N
         600qS/r7/SJ1shBm2vVfixN8eXjYg/E+zjQDOzwSKI9Iixinhej2NoRVS9WYcSXWF2KK
         qdiXSImaJH3duGz2CPTcrBr14haBvGt3bDq1BmTIa0SPmZtZFyadn54AJJdH4NeQxwNX
         RelZFpQx0WQLgzLuDIKtuAgqf5hRs9wZf5f5pcxZrL9txRBec9cj7L6Zm9EkHG5sYcbT
         mp+g==
X-Gm-Message-State: AOAM532Uv4WZBJ4XxTqLFSstYYnIyO2yCM/3RjcVTQDVobo7UasdGaLo
        ozx4a3NS7FhWpHdcMZtDlTUThw==
X-Google-Smtp-Source: ABdhPJxJzNEbY3jyPg8fEjGhjoecDC/1l6a2G599k+DxTSX+Z5Ru9ld2qBte3msY7sP8exeSMDmBwg==
X-Received: by 2002:a17:902:a5c1:b029:e7:3ee0:a1e9 with SMTP id t1-20020a170902a5c1b02900e73ee0a1e9mr16751801plq.82.1618711329769;
        Sat, 17 Apr 2021 19:02:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e47c:5232:82d9:6d3f])
        by smtp.gmail.com with ESMTPSA id n20sm3466371pjq.45.2021.04.17.19.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 19:02:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618574638-5117-7-git-send-email-sibis@codeaurora.org>
References: <1618574638-5117-1-git-send-email-sibis@codeaurora.org> <1618574638-5117-7-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 06/12] arm64: dts: qcom: sc7180: Use QMP binding to control load state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     rjw@rjwysocki.net, agross@kernel.org, ohad@wizery.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Sat, 17 Apr 2021 19:02:08 -0700
Message-ID: <161871132805.46595.8756191151169964527@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-04-16 05:03:52)
> Use the Qualcomm Mailbox Protocol (QMP) binding to control the load
> state resources on SC7180 SoCs and drop deprecated power-domains exposed
> by AOSS QMP node.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
