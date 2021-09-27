Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF3741A0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhI0Uzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhI0Uzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:55:40 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CFC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:02 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so26178527otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jevnR5FH7bUpn4+kaXeGqfWRR85p0D3C8wYGwh5l7i4=;
        b=q864TxafQpqgmMUZQRry0erO9gNcAV39XKZUM/3hB/MRO2SQhgag/qSnlv/9tSXChq
         hp55959LiiUYpNgKBzYjBU9nn92+jwk6mQYrXrOkJPJOJmCK37amqccPlGFXvSa7JdBY
         jipL3iHfKj368C7yOaZyzj306Daal7hoJIwUf/QVbogIyD4/bQP4yAD5dmJJqnBrhlQ8
         mf8ebG+4Thb2PdLMt6sGJJccB2Oj3VVXH+s5pZYwBVf2SxXXQjQxUsMUu12jJGki9YPB
         GY4by0rMqmcf9Ik3yIz+r8d3tW766NxgUy7Q+4XC1xL/eWBZMev3/DPnwkjoD5rXqVJ1
         kuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jevnR5FH7bUpn4+kaXeGqfWRR85p0D3C8wYGwh5l7i4=;
        b=ELvAYP7Hn3GsYXM0KGyp0UJGaWMLUfudioXKY3RMj1vUpOJTCO+hHsArmiEQpfb10e
         bcwymG3dl7PGYnjiC/nx+InPjOyKxW7a/VOgtuN0DPQdTz2U98q2iMGMihqt5BQNb/OE
         6qArZh5WkCEK66VaowpmT7MlNcvkt1QdTjaqzqrZccknXVwj7VuJnGdSX1ccYwwsXVGJ
         qSZdNckk5f0zebMQ/AdlcY6VCv2sjVZSB0/YYvmajP+UAGVFuGmMDQ6IMgqUrGACfWqF
         xuJVanT0iw4DI+eh8LBcHYJB+j1dNoRdYGNYj3ZNMwPVJCETG/68/VAGNv9l61ExqW+h
         /n1w==
X-Gm-Message-State: AOAM532B1b2PFgun+mrO/TgiQKfvFy6twbWrkDqQluN4FrzTE1nxzrXF
        cr21ar4jclXIjlLh/U7MBNAYJA==
X-Google-Smtp-Source: ABdhPJxD9riS4UCPLtuBEXeCuHvE1abSdbZgUUjXBsjApnwi9B+v6g8ImWiJlnGWLNsSc3kycoRDiw==
X-Received: by 2002:a9d:313:: with SMTP id 19mr1823961otv.12.1632776041438;
        Mon, 27 Sep 2021 13:54:01 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z10sm4187275otq.64.2021.09.27.13.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:54:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mka@chromium.org, robh+dt@kernel.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, sidgup@codeaurora.org, dianders@chromium.org,
        linux-remoteproc@vger.kernel.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH v7 01/13] dt-bindings: soc: qcom: aoss: Drop the load state power-domain
Date:   Mon, 27 Sep 2021 15:53:51 -0500
Message-Id: <163277593825.1470888.10339811623270143910.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1631800770-371-2-git-send-email-sibis@codeaurora.org>
References: <1631800770-371-1-git-send-email-sibis@codeaurora.org> <1631800770-371-2-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 19:29:18 +0530, Sibi Sankar wrote:
> The power-domains exposed by AOSS QMP node are used to notify the Always
> on Subsystem (AOSS) that a particular co-processor is up/down. These
> co-processors enter low-power modes independent to that of the application
> processor and their states are expected to remain unaltered across system
> suspend/resume cycles. To achieve this behavior let's drop the load
> power-domain and replace them with generic qmp_send interface instead.
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: soc: qcom: aoss: Drop the load state power-domain
        commit: a4fe5159038f22604e9ef3a8c38b680db4456138

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
