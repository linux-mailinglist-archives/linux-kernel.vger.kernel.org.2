Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104834241D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhJFPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJFPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:51:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817F7C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:50:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so10326355wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/raLXONhoyMcqmdvgLFY7c9w+ILEnXjibPjkVIP/tk=;
        b=aSwRIuSyA0ai3vC6CvcShvC/FH3Dnu4bRv/6hwRZxVYH23wFjHHdXJeKrULY/Ozm19
         lLsLbnl9NX1ERE5Sj1Ump+NDDn5Fgh8pHPXHQJaohUoxrBkNwBcK56DCijx4njZm68SY
         P/tonqvn9gJ28I4mnI/3Gq+TKgJth09zP6c+ZPDXs1WiQl+LtvYG6JuQG6UvPawCHua0
         IwkT6S1Y98aJK39iJQrEAgW76we8CS+09wetyy6tZI/XkwIp4Ek1KWi33xt9tcjoilAt
         8gLX8scwghe+VfDIKSMkH7woTwOKXUzUxjXX7giVhVd2b1vsNSnnKZaRyzeT+0Mfrzk/
         2gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d/raLXONhoyMcqmdvgLFY7c9w+ILEnXjibPjkVIP/tk=;
        b=t0/SGKBhfnRzvJuq0a78+JiJ0nLTyWBU/XeIkzvHfsFt1M0R1m0Pn0jjP+6SVblBnf
         TQyTEU/sbMtMjnWub/9or8IyKG7M3wSr+DXicRoqwMSFSY5TDdseAyC7ptBzQuYucd8u
         tleUpzJ3puGK3AtozF9XyX6hXWUbJ/tkhV3bfHO+AmV0eXC/jJen3yalr1/x/iu5liv0
         8kQf9uFdZEFwfLxKNErfaxLjx9kG45aN5uCWwFjcmexSPt8hMv/sDMqJromgUc1wEG2t
         TpB7M8qLBXwAF9cuGy5i+IAdCPoId8aMr0bPAQ1uuwNeiofBAS+gGjSea728EFZa83+5
         P8Kw==
X-Gm-Message-State: AOAM532fETi6a+Db4KFI13mA6uxO4O0O0pYqZNvgtH7dvWE+UehG0Ljp
        N76YZ9hRjPhiCftCYh++QCk=
X-Google-Smtp-Source: ABdhPJwMrBgtTVJiGXUTaHmWaRAmhg7dvVTqPx1sd1FvdhzAW5j+j02xdkgAp8cmWYFPxOPrgvPZkA==
X-Received: by 2002:a5d:59ad:: with SMTP id p13mr29594117wrr.253.1633535402147;
        Wed, 06 Oct 2021 08:50:02 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id o12sm2048929wrw.73.2021.10.06.08.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:50:01 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in testing/sysfs-bus-rapidio
Date:   Wed,  6 Oct 2021 17:49:58 +0200
Message-Id: <20211006154959.135487-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "that that owns"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rapidio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rapidio b/Documentation/ABI/testing/sysfs-bus-rapidio
index f8b6728dac10..9e8fbff99b75 100644
--- a/Documentation/ABI/testing/sysfs-bus-rapidio
+++ b/Documentation/ABI/testing/sysfs-bus-rapidio
@@ -95,7 +95,7 @@ Contact:	Matt Porter <mporter@kernel.crashing.org>,
 		Alexandre Bounine <alexandre.bounine@idt.com>
 Description:
 		(RO) returns name of previous device (switch) on the path to the
-		device that that owns this attribute
+		device that owns this attribute

 What:		/sys/bus/rapidio/devices/<nn>:<d>:<iiii>/modalias
 Date:		Jul, 2013
--
2.25.1

