Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEF394751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhE1S5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:57:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45070 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhE1S5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:57:33 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmheH-0006hU-0y; Fri, 28 May 2021 20:55:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
        hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop_reg: add PX30 version info
Date:   Fri, 28 May 2021 20:55:54 +0200
Message-Id: <162222814866.2904787.9246855996238549886.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131125016.10837-1-jbx6244@gmail.com>
References: <20210131125016.10837-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jan 2021 13:50:16 +0100, Johan Jonker wrote:
> To reduce memory various Rockchip VOP versions share
> common reg structures. However more recent added SoCs not
> always have to same futures as the old ones.
> Add PX30 missing version info, so all VOP version checks
> work correct if needed in the future.

Applied, thanks!

[1/1] drm/rockchip: vop_reg: add PX30 version info
      commit: 872b68e9750eddd086b93a6004ebe82c64aef670

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
