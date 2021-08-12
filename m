Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE76A3EAADC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhHLTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHLTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:23:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE94C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:22:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so8556863plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qb+FI0jSCsZyHH1Ia4kbzXwLXCw4sowjg/unRazGFOw=;
        b=j8cQMpokfQuLRgHm07RR5lcnPohAYewhPt1EspVbwh4WNHr7GGQvDm3kmECAFwxwW8
         jhbPlSAsren8SdoC+d8S8uO8TfchuQSUWI0bK9y+pjIJBSt5nSr77a9k+j+Tq1b1NGAS
         tTE9TMfvEPFduwrbXRQDM01A2S6J85S2QCkPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qb+FI0jSCsZyHH1Ia4kbzXwLXCw4sowjg/unRazGFOw=;
        b=no6TSw3zKnPX3yrjFCIdExLmNDHnVOwic1LcrcLUEBJypyuFMh6J7Jk/hvMBhTYM7P
         5DdWLzB6+HSi4lgz3fdq2QXOC0Cdl9cT6G9WPWdr+rcCtbkju47KPe5CHNT6wO8EHOKb
         //ECg1q9PG4pyNl787BWteoKAs0ky4LNkXl6A4MdCzn83CAlcJQvbFmcXyQP4q5hQ8qq
         8hBkl9s3WglwpsCeVo8hClkgGnq8Ksr24ERM8pF1rBhFSfb1NC/Jjlxra0JYhAHc7EHq
         jHKvaqEqoZkGWTmvaH1ZEEdHA1FzbGtdec25LdNr4s9gt5wVuYGjsDQiiaBP+Hjy/RXQ
         EQ2w==
X-Gm-Message-State: AOAM533Ag9f9Vrjk0zQfLALVgEGu5qZoAEG1LD/5fEqxlo7pC8aAp9I7
        c7JRU0NEIKItAMpw447xELPWPA==
X-Google-Smtp-Source: ABdhPJwPH80t5d7F/jYCYlTC6qaJ9oXn39f+IjkD6biu7WuSZq9ZoVowWfDG6IADtOsKsh6cCUYT5A==
X-Received: by 2002:a05:6a00:1c71:b029:3e0:4537:a1d4 with SMTP id s49-20020a056a001c71b02903e04537a1d4mr5590743pfw.1.1628796161176;
        Thu, 12 Aug 2021 12:22:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6683:43e5:ba4c:d76c])
        by smtp.gmail.com with UTF8SMTPSA id j22sm4434963pgb.62.2021.08.12.12.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:22:40 -0700 (PDT)
Date:   Thu, 12 Aug 2021 12:22:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Subject: Re: [PATCH V5 6/7] arm64: dts: sc7280: Configure uart7 to support
 bluetooth on sc7280-idp
Message-ID: <YRV0/8qtlMyVSDRI@google.com>
References: <1628754078-29779-1-git-send-email-rajpat@codeaurora.org>
 <1628754078-29779-7-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1628754078-29779-7-git-send-email-rajpat@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:11:17PM +0530, Rajesh Patil wrote:
> Add bluetooth uart pin configuration for sc7280-idp.
> 
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
