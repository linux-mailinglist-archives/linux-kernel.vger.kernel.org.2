Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B233687A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhDVUEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhDVUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:04:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211EC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:03:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v13so10498236ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfL45R5dBs0MS9kZn3ph77DF/daCg5TSX71XRehgnxk=;
        b=UjUpfOM/+EU+ODcUcs8lF11e3se8Yw8Lky6BSnX4yXUh+tH0bpE0cSc4yyI3n5B7pk
         pv8ltbRteNvl2R3roc9z2gnsO8vWps8U6LQsGpj3qY+cNNdAKS4TAI5H102o/aDYkmit
         DSgHAkITih3THSRWqGyqGn3H5/wg4Zzxk0AD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfL45R5dBs0MS9kZn3ph77DF/daCg5TSX71XRehgnxk=;
        b=s0Q8MBgKXkew0sd05Z1MdtLpGt8+A19N3+9gNl2V7CNw1qUE6YYjZb5fooQ++Yy7DC
         VZ5yn69pBwBPEgZuunMFzgng/9v7LTRt3CrLv3yF6jNyMT87DXCpLB9mCwwbKCNm+YLx
         srCNrXEaG0DIwe9e7S2v5XIhjG2sp7lvGeHAwclB1Lzt3faLydanW32Gg8QjYf/XRpSo
         5XPPNrXIw89eSXpAQDEwJBQp7VgYdJ1K/jkHDc/s/1YWLpYY1eWeRcYjf65Sw2snFmK1
         pB6r9ysymwsxprzSZCcdyy1Y2TyByRQ9ddCGztkxsJMoOpfKG6A2/ujEeWNh3WO0mbVL
         YvFw==
X-Gm-Message-State: AOAM533InTH5p1/pYxNehPyn6srxMNU+Smlg21xbdUVLrnNWanD0QGgm
        y0UpkjftdrvVFtvexk3JvUXgeg==
X-Google-Smtp-Source: ABdhPJza8gCfdaIX2zwXwIfrBz18VOBT1lbCrdWZuk0N4EoKlrwKK9Gt24lkIqjFphGcuVLpxWADDA==
X-Received: by 2002:a17:90a:d18a:: with SMTP id fu10mr444528pjb.233.1619121817858;
        Thu, 22 Apr 2021 13:03:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:acff:4f9f:d039:23ff])
        by smtp.gmail.com with UTF8SMTPSA id y13sm3044062pgs.93.2021.04.22.13.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:03:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:03:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <mdtipton@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: bcm-voter: add a missing
 of_node_put()
Message-ID: <YIHWmJPcoh4bFKNi@google.com>
References: <1619116570-13308-1-git-send-email-subbaram@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619116570-13308-1-git-send-email-subbaram@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:36:10AM -0700, Subbaraman Narayanamurthy wrote:
> Add a missing of_node_put() in of_bcm_voter_get() to avoid the
> reference leak.
> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Cc: stable@vger.kernel.org

nit: I think you would typically put tags like 'Cc' or 'Fixed' before
the 'Signed-off-by' tag.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
