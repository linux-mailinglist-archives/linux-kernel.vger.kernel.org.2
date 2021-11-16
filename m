Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DCF453CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhKPXxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:53:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51790 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhKPXxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:53:46 -0500
Received: from thelio.attlocal.net (107-203-255-60.lightspeed.sntcca.sbcglobal.net [107.203.255.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9585B20C5A74;
        Tue, 16 Nov 2021 15:50:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9585B20C5A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1637106648;
        bh=1kav/zBHA7FiqkPaBcUDQL/HgQa52sySa8iFFV8lzTA=;
        h=From:To:Cc:Subject:Date:From;
        b=fxj1SYVPLyqs47s7fC6iK5jpnfMjtkTTl/I6+Mura4YGNKa7CgIE3mTgBn0fVCp3r
         2I0qHds3VPgv0wszZx4nuK/oaYPnRgvl4JA5CJW6nwAChmcjMY3XpeU/DItWnTJzCo
         tmkVa0XFn/dzpDCttBZS+K7BnFDpXOQrqjylz+bY=
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: [RESEND PATCH 0/2] arm64: dts: sm8350: add support for Microsoft Surface Duo 2
Date:   Tue, 16 Nov 2021 15:50:43 -0800
Message-Id: <20211116235045.3748572-1-kaperez@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the Microsoft Surface Duo 2 based on the
sm8350-mtp DT.

Katherine Perez (2):
  arm64: dts: add minimal DTS for Microsoft Surface Duo2
  arm64: dts: sm8350: fix tlmm base address

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/sm8350-microsoft-surface-duo2.dts    | 363 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   4 +-
 3 files changed, 366 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts

--
2.31.1

