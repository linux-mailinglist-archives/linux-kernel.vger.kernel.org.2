Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9340A2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhINBzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhINBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:55:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C802C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:53:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v123so10633152pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8R8uZ5D2TVyo2nitnNuAgsr6dl/BysOehMz47YEjYug=;
        b=iJ4GLwVshqcEz83D3hXgoL02tLfPL/Lyfjv/8yCWtWbngh5V0Jp74MTfwF1qcPwhuL
         hrJvw1mcFmXDPaK3MZt5kSvnJx0TDvt8z/6ySNKgI7loyXaVi8XZnFlcIGAnRt8pc8Dv
         Y3FSFGsJO6B2gbV0Dsqb9efogRor5hOANmNlbranmydHi1QXuLtkm4tpx1k1oAt+xA2x
         Rr0pWB619lVz8b8I5pvuYkALNsGGdKmix0TuJsGPzf2toIraAcpOSUXodFisZk4h3QSX
         7p14HndwmIgaPF7KIxzR3b5nkdcnDne8I0se1p50LrvRh2QEDtRQ0ipZdsTk4DvazNgP
         u+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8R8uZ5D2TVyo2nitnNuAgsr6dl/BysOehMz47YEjYug=;
        b=sN2RlrmckGIaUA+wBKtjlOxJr/5p0ExmNJyoNVooaXLEIcQ48jYsZdezg4nsmA7QfJ
         GiXrJxj9DdPRFXrrHsVfAw0XQ0+u0Mr17I7MhkAgkTpwEtWKMEZ5jfpgxvkf7d1izWSP
         Z8SXADfVH3RMMjDyrauCk95Rrlu5nEkvysfeqTQjGleiB8inJScRVn+xHQgHXL4mIjuv
         AM+8N0cDino4pmzo4roO8f+RxjEZLTp6Himuawh9TXAJtOiMwLTfigl67z8ik5fzIVQY
         YXaw0y9qWGnh47g1VhBgWMo/qSrToEUBEXrdGIFhPS7MY40j4+RvawHh+kh/unbYBisG
         HqOw==
X-Gm-Message-State: AOAM5338CMEkKxVnNQFe9J2qZNYihqvkfOQ70oGllhiytcQaQ1yzRt7m
        WhkvwxtoG1Kky3xvXQ5gAPC8AA==
X-Google-Smtp-Source: ABdhPJwXBPapl5IhJgWeH7CcTs8uYTChCxksoMIaMnx7hBB7Z+P+xGt0i9P8OntKX/LeXus5TZldDg==
X-Received: by 2002:a05:6a00:2188:b0:412:444e:f603 with SMTP id h8-20020a056a00218800b00412444ef603mr2282149pfi.86.1631584439080;
        Mon, 13 Sep 2021 18:53:59 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fh3sm8089088pjb.8.2021.09.13.18.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:53:58 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add compatible for QCM2290 smd-rpm
Date:   Tue, 14 Sep 2021 09:53:47 +0800
Message-Id: <20210914015349.29295-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds compatible for QCM2290 smd-rpm.

Shawn Guo (2):
  dt-bindings: soc: qcom: smd-rpm: Add QCM2290 compatible
  soc: qcom: smd-rpm: Add QCM2290 compatible

 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 drivers/soc/qcom/smd-rpm.c                                   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1

