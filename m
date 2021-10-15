Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A442FA30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhJORZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhJORZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663EC0617AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:29 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so3213721ooh.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJaOC+igESCxHZ0vSXJ7r3WczPiGs7VUV72llPTS2Uk=;
        b=A+aVvtFyb8ZzRtWmDzfa0VG6m5m4ixVZqdZL3S7A65QKwyzPJw22PbxU3xVHazGm9R
         gSmmpldx8T7i8XJssZooB9Cg18uPB+UOETODn9SpBtw5rKCox7UYjbpOpOR8bWgYKznr
         qpSsYXnA5H/7MGyEbgczWuxqaXxbH8f9fRbIqc3Lf4sAyLySXIFpwo8kIqGShi7EWZ9d
         skqRN9I3HI6yuc2eIvOBLKXtw3cY7bNrnHXd6zJqZviQglX1A3iyLFX6+rUyJXRDzfqv
         m50wiFxiUxls3fnjiVZFeUJzJnCZ2UspX1y6s2B7/rvQks6+O2iM1G57dog9O6y0/VQz
         BDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJaOC+igESCxHZ0vSXJ7r3WczPiGs7VUV72llPTS2Uk=;
        b=Iik2hH79Jey7e0dwk0PmLgEHRMt6w3vF+L1l3P3VK2wyhR98xiBgQuUsjGww7rE06x
         p+F400PiEQlSrR8H3o5USG+OQfGvqWu/7pOSbYLhS5wqK1RiNKfGalhpmvSLpej7m7jn
         TkZySiqWljd56rNC98Mu0KRyaFpz/hRATglYxlkWUB66eqNV16tK8y/ZsiMGzvA2bLZM
         CKd/JH93kyKHAaYyFr+LvIZRbn3MdffyB8YAFsTbWQiooTRqE8IHYEpDvvE/X7bW6+mn
         dLHND0Q3KvNgA40WugHb2isyo+OQnlNF3ytR70WcLgE6Ue3P4zoyUgz5Z1HNGUw7ZczV
         DJMg==
X-Gm-Message-State: AOAM532c3S0m5s6fyjx1D2r+pHEIRjsu9W4sWJJeDwAyUhaSJOBNPqBV
        I0IguyEZCeuQuWh8/usXgAGTTg==
X-Google-Smtp-Source: ABdhPJzAgZdCsdlc8CdqRpH5laQZnFJ2Ly1chA6vVUc/nvd52UGsVuCVUlWZXSr1DTZCvOIMT6rQLw==
X-Received: by 2002:a4a:d5c8:: with SMTP id a8mr9422889oot.18.1634318548918;
        Fri, 15 Oct 2021 10:22:28 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mathieu.poirier@linaro.org, agross@kernel.org,
        zhaoxiao <long870912@gmail.com>, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] remoteproc: qcom_q6v5_mss: Use devm_platform_ioremap_resource_byname() to simplify code
Date:   Fri, 15 Oct 2021 12:22:19 -0500
Message-Id: <163431847249.251657.1271402903289939838.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906071147.9095-1-long870912@gmail.com>
References: <20210906071147.9095-1-long870912@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2021 15:11:47 +0800, zhaoxiao wrote:
> In this function, devm_platform_ioremap_resource_byname() should be
> suitable to simplify code.
> 
> 

Applied, thanks!

[1/1] remoteproc: qcom_q6v5_mss: Use devm_platform_ioremap_resource_byname() to simplify code
      commit: 9db9c738ac89fb1c408c4ec819633540856ea62f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
