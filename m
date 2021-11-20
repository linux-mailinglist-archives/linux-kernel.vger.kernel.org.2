Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBA458129
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhKTX7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhKTX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:58:59 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC55C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:55 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m6so29595702oim.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4VZXS1JYipWdfxz7aBEgnldhWEOliokBInzVaauV2U=;
        b=LWpMNnWLtF07m+hV2foqC5ZByUH8SHjFDkaKiTkVZlpkLkFE9zuNQa5UGTtRGrGKne
         FgNamNJ6S7DuHSS6rOIZl+3MSVaeVFTUB1CQZcciKwF2aAgvVjN5eCSuJ7C6mUqTTEZ2
         WKSLjfgwOYOlDe74eceED+oPIqm7dzrcUDKDMWS7Gh6JcERUwf5Gs2NZgl6iWOHscLPt
         xIcibSRSd2RvUAcVYpfOUJi4XFLLEk7nt2jdeJJoqECsTDOfGThIsUAr0L7Hz2OYJJ1h
         tHky4tH+SGjMsWez2Qj5/Fod3mK4g8CDk7MxpTGjQIbO9La0q4iDu746yAp3QhWwicHV
         42MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4VZXS1JYipWdfxz7aBEgnldhWEOliokBInzVaauV2U=;
        b=GtZtR7uwkch46jBmwyhyX8YiF6wnC7+lAnxuZ8At+8JwhqrvX4E0vfxCzCLt8aJqHc
         fHJtTOc7EYF1WpEj5rofv+IfQBY/7p5y5mjJLgC08jd0yf+34n1CuXFKnXEjZL2WyWMN
         zf/ylFmKDBsIdxbnxTVdUrQnTKWiq4W6id9KuRFhYWBiOUVjBom6tiiNWJ45uPyJzZ1v
         U55uZc7H0K+zU89wscalPr9PH4Eb7c0W6HxtCc7WWLtAVO5bplEG/o8xA4MPDEbuJl5i
         TPtNyxnSlSayNxi1MhOwrEvPr64Y6xtI1vANHgyU8CSwP5H4wiW1ykzZnP0lZ2BL+bjt
         nIRw==
X-Gm-Message-State: AOAM5327SriAyXygK6D1ypKQyRAvkpPrVIgCNAThBh9eLoQtJenXkSyP
        1ipQmQ51WlZPwfpYR1s9k5A904upvuxdhQ==
X-Google-Smtp-Source: ABdhPJxG/kDX9vOXIRxtHJC9OE1KrowBcQv2/edAhyq/2tjfHzmquX3exqFx2ji9hCg7JEuIkC/RKg==
X-Received: by 2002:aca:1b08:: with SMTP id b8mr10100307oib.148.1637452555104;
        Sat, 20 Nov 2021 15:55:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:54 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: (subset) [PATCH 1/3] soc: qcom: rpmpd: Drop unused res_name from struct rpmpd
Date:   Sat, 20 Nov 2021 17:55:30 -0600
Message-Id: <163745250542.1078332.12998070951734324678.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211108134442.30051-2-shawn.guo@linaro.org>
References: <20211108134442.30051-1-shawn.guo@linaro.org> <20211108134442.30051-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 21:44:40 +0800, Shawn Guo wrote:
> The res_name field in struct rpmpd is unused.  Drop it.
> 
> 

Applied, thanks!

[1/3] soc: qcom: rpmpd: Drop unused res_name from struct rpmpd
      commit: 7ba9dd0d04a8af868bc0785d79bde4ac0240328f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
