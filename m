Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD732570D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhBYTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhBYTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:40:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13898C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:40:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so4474759pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Xlc72Bq4C31KK7HAlltVZZ4SzprVtZcbZ4JqykIN3gU=;
        b=j+Y3tNf5LrVjOConURBrWKda+5To1cbN7Dg4mhd/vRE/gY4E3hfOJNBD47Qw7cNZ/+
         VMmbVCTb6npvus2CIE/FrJx39ZATxUdcEGMPofQEPch3G1amt5aLDj41tfCltXMKVj+4
         y/a+KHDSBOGkCpSG/p5ZzpmBQ8XJM7mL/QMzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Xlc72Bq4C31KK7HAlltVZZ4SzprVtZcbZ4JqykIN3gU=;
        b=mMYdALPSMolHuF9VwzGrYYamXHAAIihBBufmA0nTRqIm4cGXgXx2asQXHuTqZuWq6A
         mIK0++uKrcd+AqMhd7ExCXja9ukC1qMuXxBvpJ8H8u7esXwf2VEnAv4NoSL17oWk4Krf
         z9dx3lK/pLOZQfohHcrd5u0RGfX687QHc+ji1ixNRLgCfoJoVXvoMod4ZEE/LrhZMJRf
         xD8yu9n90msnJYo+XiFi2igTPIJppkSnDk5E41En3eE6NlfMPoKbLNYsV4XyZqzYolVc
         Q/+3M6C13OJHiPqncwBsAt8ZnDJl/CWryqPj1QqXSDXBHiiDX9ccwXW6zEoBEyBMyz/p
         U5KQ==
X-Gm-Message-State: AOAM531fI8EmrnYfHEsQuJdd/ItovZOCQHbulzgom2AJD2w4uZRKeUTW
        iUGeXo2qgpkh3GSN/vpOYVLqgg==
X-Google-Smtp-Source: ABdhPJzBycZtoj23XOFDzOf16byYmakGGPp1UT2S1grK0XhmY8EB0jzOlnUqboMpa4jtaLuP03qI4Q==
X-Received: by 2002:aa7:8ad0:0:b029:1ed:fb30:e5d5 with SMTP id b16-20020aa78ad00000b02901edfb30e5d5mr4742491pfd.79.1614282004679;
        Thu, 25 Feb 2021 11:40:04 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id np7sm6421541pjb.10.2021.02.25.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:40:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8584e915f42405a7a4a799133a09d0d4aa65d2a8.1614244789.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org> <8584e915f42405a7a4a799133a09d0d4aa65d2a8.1614244789.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 6/9] dt-bindings: soc: qcom: aoss: Add SC7280 compatible
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Thu, 25 Feb 2021 11:40:02 -0800
Message-ID: <161428200290.1254594.10160876888521187549@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-02-25 01:30:22)
> Add SC7280 AOSS QMP compatible to the list of possible bindings.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
