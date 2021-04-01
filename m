Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA944351024
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhDAHe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDAHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:33:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA7C0613E6;
        Thu,  1 Apr 2021 00:33:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z2so775422wrl.5;
        Thu, 01 Apr 2021 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=M4Vn2x7LYFvskShVgkHnVYDSST8AZ5E8PRowpdD+Pys=;
        b=lSrU7eCkawm4nCmeM2S51RbGiglSJQ98+QDe42WUxlLGsBrYIYquS87IhyUcdQv/Vu
         YCENXL95Tr/OVrkJqEfDg+dbdlHRRII/uHs92Pjck858KHG/dH9eBtNE5P6nFG9MW4e3
         cjiYTZxhpwrWNWJzbfvTVJADYDGAa/I25IqnOOgtGft8hZKCXNdCV88f5sa/SMRe0VbY
         z5+Cbb+/EGrjv22rNzB11wye9hUkSIy0BK4D85dkS3Yx7viW1iYhDI0HFYD/oOvR4bq5
         YH/8lkhhp4Bgu+VAUmK360FvZpkJ0YjAduUzhrRcQOf7Jyvs1i+59Jwt65d+j2qDf8kF
         xzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=M4Vn2x7LYFvskShVgkHnVYDSST8AZ5E8PRowpdD+Pys=;
        b=CapSFZ+U7v7KcKtd0jBPBTZMsWtlnPIDoukj4RtXiSWzD1JOLDyplM4aLyRN3HUuBK
         PihpQY9X3ljiEkOjRZ43hN/W1g13rxhJnYitUV0FMTYBOwkA7K1lKpaG0rDzFzOG/Rs5
         Ne6fuRcdMy7uX1NX/mzqr0UmbQMg+zwQEp4mIXASvSU2GJEZo4thBF9zRhZYQQtlkv7V
         HzlIGJ3UKSkPU2l4fcgqu1DMo2JISzDQ4zv6fNYzZkCHmSk4brEKjYW8oxAeVGGWVmYw
         DRp6VWyhzCT022x3PSNbkYbl0FFYtdmKL9UapIyUfpDwwH7Xwa6Vj6JSoebU3VFRUrWN
         kplg==
X-Gm-Message-State: AOAM533AWFL+M/ZEN58+SEHNkMw2C517Ct11xMogDPp+AJHatvZ7BOzA
        Kiz5SygfL5aFTtKJ9j+Jv8I=
X-Google-Smtp-Source: ABdhPJwlEJpAlk8h3VfXuVCgX2VnNFUIeLlr6LQfCIxL2291eR/i95pLgC7UsFY8/1hjoqNueTZGTQ==
X-Received: by 2002:adf:f841:: with SMTP id d1mr7911879wrq.36.1617262431345;
        Thu, 01 Apr 2021 00:33:51 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id f126sm6899718wmf.17.2021.04.01.00.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:33:50 -0700 (PDT)
Message-ID: <943b92c6ac291726cf0e6bd92e88f2110c14b74c.camel@gmail.com>
Subject: [Discussion] Uninitialized variable in wiz_mode_select()
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Date:   Thu, 01 Apr 2021 12:33:46 +0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

`mode` remains uninitialized when `lane_phy_type` isn't PHY_TYPE_DP
or 
PHY_TYPE_QSGMII. I've checked the dtsi (k3-j721e-common-proc-
board.dts) 
and possible values of `lane_phy_type` are justPHY_TYPE_USB3 and 
PHY_TYPE_PCIE. If this is correct, the mode will remain uninitialized with
garbage value. `mode` should be initialized to what? It seems like it is highly 
implementation dependent.

/drivers/phy/ti/phy-j721e-wiz.c: 344 in wiz_mode_select()
338             for (i = 0; i < num_lanes; i++) {
339                     if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
340                             mode = LANE_MODE_GEN1;
341                     else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII)
342                             mode = LANE_MODE_GEN2;
343     
>>>     CID 1503592:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "mode" when calling "regmap_field_write".
344                     ret = regmap_field_write(wiz->p_standard_mode[i], mode);
345                     if (ret)
346                             return ret;
347             }
348     
349             return 0;

Thanks,
Usama

