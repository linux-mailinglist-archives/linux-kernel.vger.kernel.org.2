Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978CF325A78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 00:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhBYX7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 18:59:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:58:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t9so4556002pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 15:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgBcyKTrhWhBSDxd2pfjpBmd0inPEN16qGxTuTl1gKs=;
        b=jD6mILYvID7wcz7/JVIoIPt4ZCjT8HfIU4oNBk9w/Sk/+cuLUbLfmwPRGpPB5+/sEO
         YHLIpOUsl2CiyBsQZWc1q5WWOxQtN454hiL/sadVELadhN0N5HHmSflnPtSK+ZFWDtNR
         N+piymA7D7yMk0iPW0LXemHRXmB1dWGnuB/1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgBcyKTrhWhBSDxd2pfjpBmd0inPEN16qGxTuTl1gKs=;
        b=mrq2irfTaFFvzHf77PPKejdgl7xmpNFixp873XD9MN1dNyLlVyyqZpBKFO7OfTJ19o
         LTd+G1NaYEfXsvyCAGiyEUP2w2JflrWUuUIZ3hcwGdIHhiNy5xUE23hMe2NObjMgwPm+
         fIfKeNkanez9YoWm2ywJB4umIGH/iSOHlMw9n+Y44ji4i1Um8Gc2RBV6jjvzUFJFYua1
         CTQA1Ma668kJzJNn2++BdpjEslsIktk3A/lp+iYMxqPR7Xlw7OQrHikIZtvrUVt2Z1Ko
         e/QLk8vfIZ29TkwDsg7LGFGQd/KZq4xnHctrPUUnz+Zg2MBSZJifZESobUrCDavMnHiU
         qJIg==
X-Gm-Message-State: AOAM533IyqDfNiEaX45XzvVgMpnjke5rRu53bfhEn1yzNgVkfTRrJnwy
        /qopPOKvkLkUlpY3ij9iJhhurA==
X-Google-Smtp-Source: ABdhPJwfh2CP2/MqqEsSPEFdK2Ukd9rSzolqDzF9Onfxbe/Sl6cLWt12ziMOu5tatkEIMbtzB9S/+A==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr420027pju.206.1614297516053;
        Thu, 25 Feb 2021 15:58:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:1d8:8d0c:f75e:edd8])
        by smtp.gmail.com with UTF8SMTPSA id i2sm7031528pgs.82.2021.02.25.15.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 15:58:35 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:58:34 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] arm64: dts: qcom: Unify the sc7180-trogdor panel
 nodes
Message-ID: <YDg5qkFvEMtu+XUw@google.com>
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.4.I1483fac4c5ae4b2d7660290ff85d69945292618f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225141022.4.I1483fac4c5ae4b2d7660290ff85d69945292618f@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 02:13:01PM -0800, Douglas Anderson wrote:
> Let's avoid a bit of duplication by pushing this up to the trogdor.dtsi
> file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
