Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801253CAF51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhGOWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:45:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53562 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhGOWpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4I-0005t7-Bw; Fri, 16 Jul 2021 00:42:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: power: convert rockchip-io-domain.txt to YAML
Date:   Fri, 16 Jul 2021 00:42:53 +0200
Message-Id: <162638886252.651069.5910265386480251787.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210625111746.6269-1-jbx6244@gmail.com>
References: <20210625111746.6269-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 13:17:43 +0200, Johan Jonker wrote:
> Current dts files with 'io-domains' nodes are manually verified.
> In order to automate this process rockchip-io-domain.txt has to be
> converted to YAML.
> 
> Changed:
>   Add supply properties for:
>     rockchip,rk3328-io-voltage-domain
>     rockchip,rv1108-io-voltage-domain
>     rockchip,rv1108-pmu-io-voltage-domain

Applied, thanks!

[1/4] dt-bindings: power: convert rockchip-io-domain.txt to YAML
      commit: 742f62cb06720c12677f0bb05c64c9eeab34c8ec
[2/4] dt-bindings: soc: rockchip: add rockchip-io-domain.yaml object to grf.yaml
      commit: 959e131fb5c3a08293178e94a184b5bf28974bb4
[3/4] ARM: dts: rockchip: add io-domains node to rk3188.dtsi
      commit: 453da32aca12d91b096934a4870ec72e34d61447
[4/4] ARM: dts: rockchip: add io-domains nodes to rv1108.dtsi
      commit: c0728a2732f0fe2b5e7c57b8c0c170352ace6476

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
