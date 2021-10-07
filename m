Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F642603F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhJGXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJGXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:13:17 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4453BC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:11:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z40so6301329qko.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qz/GvWMu4xNaZ0py+UnzwizlmTC8i/xol40n0Hfddl4=;
        b=VYoKjfZnghe7QWtefdjA6KHgMUHVwGftHAF+hX7vuLWGUPVrlAl30u/WJG4K0Q6IHl
         4MikPEHPLVT/DOWWdT6OF6X4oKmOTmGIU6p7s/CYOSu/1ici8BUyNzQ3o/U4KbGzjt3V
         5q9r6iTcGPEvNHW7I6EpCayQgSV6nVul3o1NbgGXwkbXrHU8q+Bmi/JJ9wi8glpux+QN
         emLuiMuSZ70b/ajJF7vcTuSIMNCNHkzAv00d/Z8KZcnPHjloycusAG70wDmOK4pD7JxO
         dm9NMinBiSFEF+pIyLlWMPa+izWqi5wbKoxKQEAh6LkjorSocoqPFKEIzANyd7CEQ02h
         cHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qz/GvWMu4xNaZ0py+UnzwizlmTC8i/xol40n0Hfddl4=;
        b=nlE7PlC+Itl6ghSrq0b/0e3YzCLPI9XIgvGZ/VDO/QH/wmpiLC14ZjkWyr8P1yPwXO
         pxKJSWZCTPV1uoM1Xh1iA4Y9YIs2q+L65V+2I75sE4wOLLc/RZCCW16h3x8n/5lmFzJQ
         4r9ZD0HVh7SbIJSRnQKf1Ixqu9SDKzTroVhg+IxTF0XjJlHfObz6glIEX+pSLkKUVmNZ
         os2AR9lXNWwaQ6Llp/tFUHjmcIQxfZRm1Smq5orM6nxDCme3JoSH2MuRbRUm1FNHKq63
         wSu9TlYx2T3YxdG2wkWH2hbhRkdvkSxfYIz22cE/Cx5A9CXIGYzBR41Zk1ChkFHDZpme
         aj5w==
X-Gm-Message-State: AOAM533xMnHnv4HVf35/3fwjZhbHbGFh7lKqTi+wA6UKtQ9FYhpf5i9Q
        imajoPiGLZS+HVF69lbJOFbXyfqyWw+XJmtp0D9R+7VqzQf1YhL0vg==
X-Google-Smtp-Source: ABdhPJwboMclGhRaE8gg38wr+IYZBo6e3aP+cQrlOMjGfMxPeewgQiTvxfB/BWc84kFMjxTFlR68fhZnELI/8DGFDYg=
X-Received: by 2002:a37:4116:: with SMTP id o22mr88515qka.496.1633648282330;
 Thu, 07 Oct 2021 16:11:22 -0700 (PDT)
MIME-Version: 1.0
From:   Ehsan Aghapour <aghapour.ehsan17@gmail.com>
Date:   Fri, 8 Oct 2021 02:41:11 +0330
Message-ID: <CAHjmVnroctx00OycHrbEjU51SntkSi9MkmaR9KZnnHkSvxkBHQ@mail.gmail.com>
Subject: Enable "PMU" counters for Khadas VIM3 in the Google AOSP kernel
To:     linux-amlogic@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am working on Google AOSP kernel and require to enable PMU. PMU is
working well in Khadas kernel for both A53 and A73 cores but it is not
enabled in Google AOSP kernel 5.4. I try adding arm_pmu definition in
device tree at /arch/arm64/boot/dts/amlogic/meson-g12b.dtsi as follow:
arm_pmu {
                compatible = "arm,armv8-pmuv3";
                clusterb-enabled;
                interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
                        <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
                reg = <0x0 0xff634680 0x0 0x4>,
                        <0x0 0xff6347c0 0x0 0x04>;
                cpumasks = <0x3 0x3C>;
                /* default 10ms */
                relax-timer-ns = <10000000>;
                /* default 10000us */
                max-wait-cnt = <10000>;
        };

However in this case I only see A53 performance counters in DS5
Streamline and performance counters of A73 cores are zero yet.

Would you please help me solve the problem? (If device tree need
change or kernel config to enable pmu counters for both CPUs).


This is related kernel log:
"[    1.965309] hw perfevents: no interrupt-affinity property for
/arm_pmu, guessing.
[    1.970821] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7
counters available
...
[    7.131341] ueventd: LoadWithAliases was unable to load
of:Narm_pmuT(null)Carm,armv8-pmuv3"


Best regards,
Ehsan
