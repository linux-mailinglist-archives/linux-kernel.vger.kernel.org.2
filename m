Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C13C1803
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGHR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:26:21 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34005C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:23:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g4so6424127qkl.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6r9ahSEivquSNC+v6wy1zVJBcSXU9JsNZeAxAJzmVI=;
        b=0BgY3VwLusa6P/XifL4mLEtCi8DC/SXmSI+73TJNDBo7NorxpYQIgRCMphPEKGyxYq
         KGgh/OA8OllyvZHuhCUTCCP7Hwl8XXiAwDmqcaNO69Oivy43ykrXNcqtv7r8H1lR/0ZN
         G5Ay6IqhFLt2Jy1mUUxFrID8HYg+gOuDqvZhjkcUhGmDMRvvmGy9ZllrYgLgxkFMXfPk
         OdMKHocuVod+wU2l/NayVQNLTjLVIgte9OckgtN886hf0Xkf+/kTgfMl/asRKW9AVhGH
         bxZ2fTzAL+jwO5U9uJOS/m0RUlfabWoYqdZUGBmt7uben64BDUeAxLhtA0hd8FMo1QAL
         fhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A6r9ahSEivquSNC+v6wy1zVJBcSXU9JsNZeAxAJzmVI=;
        b=bRfKYcD+aH2RCVOPxGi8eLqEwkGgl2PfeaG5pK+dZl+setVRC5E0CBuQWPEgkvKDRa
         78pDljgIQdbAhXcl07Mkg0KEJTB10S/kUk1XiuJ350NB/I8j3P1SywONkiUJir8Rtgs5
         nBWwj16bBXTD9JYTPZmSIOMyekNSrARJfDwlOXBEvXGVBWb40ZdJJzI2IV/yUf0HAEW/
         3qIz75kl9pbp6CeFiJ7m46hl/lS+bZuUGk9mVuM53HRCe42Ozn7rG2WwCgCaR2cyEzWi
         EfdIN2khPGU43HNsc2vPhkM8VJxKdVC5KfigJ3UDkC2EjM7Rqys2fU4bQuFkk7GXauqO
         6kRg==
X-Gm-Message-State: AOAM532n+/Z6oq16WbFrVrDNpVyDIl7M+koR26qXMVbCH+cdnbdABEAC
        tAilag/3Mse+KBj+mTfiGZMduA==
X-Google-Smtp-Source: ABdhPJzrFr69iEOqgEgQjKYOgyMHMtcoM01m802eZv9zRtkGbxrg3mu6WCYSueHmcxd64Neey+x2gw==
X-Received: by 2002:a05:620a:38b:: with SMTP id q11mr1731323qkm.308.1625765018382;
        Thu, 08 Jul 2021 10:23:38 -0700 (PDT)
Received: from iron-maiden.localnet (50-200-151-121-static.hfc.comcastbusiness.net. [50.200.151.121])
        by smtp.gmail.com with ESMTPSA id y26sm1244658qkm.32.2021.07.08.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:23:38 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] drivers: atm: Follow the indentation coding standard on printks
Date:   Thu, 08 Jul 2021 13:23:37 -0400
Message-ID: <1764897.atdPhlSkOF@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <4121270.ejJDZkT8p0@iron-maiden>
References: <2784471.e9J7NaK4W3@iron-maiden> <YOceNJYQJiPh3qhc@lunn.ch> <4121270.ejJDZkT8p0@iron-maiden>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation of printks that start at the beginning of the line. Change this 
for the right number of space characters, or tabs if the file uses them. 

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
Changelog: 
- Replaced printk for DPRINTK on suni.c
- Directly removed the #if 0 printks.
---





