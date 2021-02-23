Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E016632269C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhBWHrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhBWHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:47:18 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E97C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:46:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a24so9305649plm.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=j3eCkXkqKlqoQ++ZGh++P7MVpYE86ix5Trk8vJcs2Nw=;
        b=NAEySFx7o8WL26Dva9WVkkpcWevRnirrdlMOEvm57iEd7sl73mfzknEzfDS2k0XAOs
         8BZOT3z3TozNEn/VjsJRak/RWFEC3NcS3dwk8JESQ6+wPBs+L0+K7Z9aHdMAlB+Nhzpc
         C93VHeKKWSa+uEPZbqGJArpzQtpkXhC23Nwvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=j3eCkXkqKlqoQ++ZGh++P7MVpYE86ix5Trk8vJcs2Nw=;
        b=U/bzS/YgJEXbai/Wgy++hzTy+wkBek9ReSGzdJ00bQgb0V9/lRWdiTnflwMMRcjYqK
         q+NJ3zdKeNCbRTL82Tfhww+zERn8/9N55N4DqAofZ6HVAEDjc1skSw0kR6k75FtS/QHA
         qNKH1JvyMvE1cC366iDG4TD+IsDx7RRIzwYxx7FsuUfydVgHHJVoekZaBAz5gUWkH3cS
         WvUcGk9MVoDf1igovDaabi/dqNTVp6DYkba97JKPY7NLwd0ylIKqywk8wo9ae2jXVE9w
         kk9ZIsaMlPHawliHHZ9fjKgTX8VK7fRUM2d3QOBLNowbfWhHeB0wp500wC5QWWjS6O3m
         +O7w==
X-Gm-Message-State: AOAM530EreDkqf8Evu3jvuf48nioNu/uoZ73VPaYociO2BRHd0Otw34Z
        DCTbJfxIXy+MSSFNIhgW3m8wtQ==
X-Google-Smtp-Source: ABdhPJxhp7AXxGelBLg860BqurxdPqRCFqL0qeDB6+AsUk8aP7bgjraMqw3iWzX+zq2+HIyAT/0X9Q==
X-Received: by 2002:a17:903:228a:b029:da:d645:ab58 with SMTP id b10-20020a170903228ab02900dad645ab58mr26811871plh.25.1614066397987;
        Mon, 22 Feb 2021 23:46:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id g9sm1587913pfo.115.2021.02.22.23.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:46:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-12-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-12-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 11/13] arm64: dts: qcom: sc7280: Add APSS watchdog node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:46:36 -0800
Message-ID: <161406639631.1254594.4155617024316856398@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:48)
> From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>=20
> Add APSS (Application Processor Subsystem) watchdog
> DT node for SC7280 SoC.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
