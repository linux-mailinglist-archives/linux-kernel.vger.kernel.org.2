Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1A3A35AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFJVMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:12:36 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46624 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFJVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:12:22 -0400
Received: by mail-ed1-f41.google.com with SMTP id r11so34657814edt.13;
        Thu, 10 Jun 2021 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11NiKQLGgU910dPDPfb1c9WAfWTvG3ljb54t4LbTXHA=;
        b=nkp7a+aToV2WeJyNBWjj0ME0HtIjodt+wr6CUVqBq0aV+uWLKLSbtATX8gnt2zk+F+
         MiOC3oGrzUyV5FRIBrC3Kjd+FoJY5wCaRQn2m8Gh2X6zn3PkB0dTMgDwxDB7MeuAiwnA
         m0jHFhL1Z33+0OppM4SIrlDueqeRGSyRJWH6RESLqG+HDq0J2Aoxq/oKETmdp1843rCx
         s7kLVyHuY7lqbKeGrD9p7E0v74fTzaJO34Z6DSQseLBVwwnTYhnML9Ch7Gca+lGwkfQ1
         E7CPV9vZu5eTY7N2PwmojwyPcII+u77Z1g2+6ZpZQP42XpK4r60sKSQv+hoKEzlpWQRv
         amsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11NiKQLGgU910dPDPfb1c9WAfWTvG3ljb54t4LbTXHA=;
        b=Fj9dPPuO/aA4MkjEmQ7unCqIAOluVeTBzxXRXtWVEeJNZyXtCwAMJz4Fj8E5TlJ+qj
         BJrqqv/O9RfVpIauS6CLCYoKPgo068/lvXzSp9yXwRgFcvFTdtAr/c1m1likrVXOjKpV
         4EMD8T2xaYn1eo22wLIW6/jofQ3s5GS0WGrFefqiLe2WvLKbrveNV6AqjjeHsHb7LVj/
         3SJrt/5x/Nk8NeCxmdhyRXNlNrKhd++WoL5C4IoIzo7+b+6N7N/qnovY9O4yW4DWPZ0/
         nB7X52/Mbk2XuJoy+MBMaE62MMiCmhLTDtF+tqhXg1syLvCdm/w1K+NGlvLEDe048IdA
         7kVg==
X-Gm-Message-State: AOAM530R3zWgE+TcXinB5k8uJ3tiGsFCVLIMzFMYgPxASy4tb0waQYdq
        z58+QpuWWx5eVQs/lXvKiQk=
X-Google-Smtp-Source: ABdhPJzNSMrZw90gy+Z6YRKrkyIqZAYSF740fIKQXjHcSb8STQ6DBfbGutZX0kxb/R5uNn1daRPeGw==
X-Received: by 2002:a05:6402:8d4:: with SMTP id d20mr392027edz.117.1623359364835;
        Thu, 10 Jun 2021 14:09:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id c18sm1836294edt.97.2021.06.10.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:09:24 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Ethernet DTS for Actions Semi Owl S500 SoCs
Date:   Fri, 11 Jun 2021 00:09:20 +0300
Message-Id: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the required DTS changes for providing the ethernet
functionality on the Actions S500 SoCs family.

For the moment I have been able to test the Ethernet MAC on the RoseaplePi
SBC only.

Also, please note the patches depend on some clock changes that are
currently under review:
https://lore.kernel.org/lkml/cover.1623354574.git.cristian.ciocaltea@gmail.com/

Thanks,
Cristi

Cristian Ciocaltea (2):
  ARM: dts: owl-s500: Add ethernet support
  ARM: dts: owl-s500-roseapplepi: Add ethernet support

 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 56 ++++++++++++++++++++++
 arch/arm/boot/dts/owl-s500.dtsi            | 10 ++++
 2 files changed, 66 insertions(+)

-- 
2.32.0

