Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C793CCC43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 04:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhGSCeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 22:34:13 -0400
Received: from mx.socionext.com ([202.248.49.38]:30034 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhGSCeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 22:34:12 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2021 11:31:12 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 5EB30205902A;
        Mon, 19 Jul 2021 11:31:12 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 19 Jul 2021 11:31:12 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 02757B631E;
        Mon, 19 Jul 2021 11:31:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] dt-bindings: Update nvmem and UniPhier eFuse bindings
Date:   Mon, 19 Jul 2021 11:31:02 +0900
Message-Id: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intend to convert UniPhier eFuse bindings to json-schema, and
extend expression of sub nodes to indicate bit position.

Changes in v1:
- Add patternProperties extension patch
- Remove "reg" and "bits" properties that exist in nvmem.yaml
- Replace "additionalProperties: false" with "unevaluatedProperties: false"

Kunihiko Hayashi (2):
  dt-bindings: nvmem: Extend patternProperties to optionally indicate
    bit position
  dt-bindings: nvmem: Convert UniPhier eFuse bindings to json-schema

 Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 +-
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 95 ++++++++++++++++++++++
 .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 -----------
 3 files changed, 96 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt

-- 
2.7.4

